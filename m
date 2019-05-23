Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C1CC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D2621019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfEWSM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:12:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:34504 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731275AbfEWSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:12:58 -0400
Received: (qmail 24557 invoked by uid 2102); 23 May 2019 14:12:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 May 2019 14:12:57 -0400
Date:   Thu, 23 May 2019 14:12:57 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
In-Reply-To: <87o93ujh0s.fsf@xmission.com>
Message-ID: <Pine.LNX.4.44L0.1905231352200.1553-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Eric W. Biederman wrote:

> Perhaps this will work as a diagram.  I don't know if there is a better
> way to say it in my patch description.  In struct siginfo there are 3
> fields in fixed positions:
> 
>    int si_signo;
>    int si_errno;
>    int si_code;
> 
> After that there is a union.  The si_signo and si_code fields are
> examined to see which union member is valid (see siginfo_layout).
> In every other case a si_code of SI_ASYNCIO corresponds to
> the the _rt union member which has the fields:
> 
>    int si_pid;
>    int si_uid;
>    sigval_t si_sigval;

Yuu mean it's actually a union of structures containing these fields,
not a union of these fields, right?

> However when usb started using SI_ASYNCIO the _sigfault union member
> that (except for special exceptions) only has the field:
> 
>    void __user *si_addr;
> 
> Or in short the relevant piece of the union looks like:
> 
>          0   1  2   3    4   5   6  7
>        +---+---+---+---+---+---+---+---+
>        |    si_pid     |   si_uid      |
>        +---+---+---+---+---+---+---+---+
>        |             si_addr           | (64bit)
>        +---+---+---+---+---+---+---+---+
>        |     si_addr   | (32bit)
>        +---+---+---+---+
> 
> Which means if siginfo is copied field by field on 32bit everything
> works because si_pid and si_addr are in the same location.

When you say "copied field by field", you mean that the si_pid, 
si_uid, and si_sigval values are copied individually?

> Similarly if siginfo is copied field by field on 64bit everything
> works because there is no padding between si_pid and si_uid. So
> copying both of those fields results in the entire si_addr being
> copied.
> 
> It is the compat case that gets tricky.  Half of the bits are
> zero.  If those zero bits show up in bytes 4-7 and the data
> shows up in bytes 0-3 (aka little endian) everything works.
> If those zero bits show in in bytes 0-3 (aka big endian) userspace sees
> a NULL pointer instead of the value it passed.

The problem is that the compat translation layer copies si_pid and 
si_uid from the 64-bit kernel structure to the 32-bit user structure.  
And since the system is big-endian, the 64-bit si_addr value 
has zeros in bytes 0-3.  But those zeros are what userspace ends up 
seeing in its 32-bit version of si_addr.

So the solution is to store the address in the si_sigval part instead.  
Wouldn't it have been easier to have a compat routine somewhere just 
do something like:

	sinfo->si_pid = (u32) sinfo->si_addr;  /* Compensate for USB */

That would work regardless of the endianness, wouldn't it?

> Fixing this while maintaining some modicum of sanity is the tricky bit.
> The interface is made to kill_pid_usb_asyncio is made a sigval_t so the
> standard signal compat tricks can be used.  sigval_t is a union of:
> 
>         int sival_int;
>         void __user *sival_ptr;
> 
>          0   1  2   3    4   5   6  7
>        +---+---+---+---+---+---+---+---+
>        |            sival_ptr          | (64bit)
>        +---+---+---+---+---+---+---+---+ 
>        |    sival_ptr  | (32bit)
>        +---+---+---+---+
>        |    sival_int  |
>        +---+---+---+---+
> 
> The signal code solves the compat issues for sigval_t by storing the
> 32bit pointers in sival_int.  So they meaningful bits are guaranteed to
> be in the low 32bits, just like the 32bit sival_ptr.
> 
> After a bunch of build BUG_ONs to verify my reasonable assumptions
> of but the siginfo layout are actually true, the code that generates
> the siginfo just copies a sigval_t to si_pid.  And assumes the code
> in the usb stack placed the pointer in the proper part of the sigval_t
> when it read the information from userspace.
> 
> I don't know if that helps make it easy to understand but I figured I
> would give it a shot.

I think I understand now.  Thanks.

Alan

