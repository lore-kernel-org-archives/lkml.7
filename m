Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441FEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE732173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfEVVud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:50:33 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44733 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfEVVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:50:32 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTZ82-0006en-KY; Wed, 22 May 2019 15:50:30 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTZ7s-0002cm-1j; Wed, 22 May 2019 15:50:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1905221459170.1410-100000@iolanthe.rowland.org>
Date:   Wed, 22 May 2019 16:50:11 -0500
In-Reply-To: <Pine.LNX.4.44L0.1905221459170.1410-100000@iolanthe.rowland.org>
        (Alan Stern's message of "Wed, 22 May 2019 15:02:29 -0400 (EDT)")
Message-ID: <87o93ujh0s.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTZ7s-0002cm-1j;;;mid=<87o93ujh0s.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/KkZFIzOai1UbCldXVDvTfkpuB43MLQLU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 21 May 2019, Eric W. Biederman wrote:
>
>> The usb support for asyncio encoded one of it's values in the wrong
>> field.  It should have used si_value but instead used si_addr which is
>> not present in the _rt union member of struct siginfo.
>> 
>> The practical result of this is that on a 64bit big endian kernel
>> when delivering a signal to a 32bit process the si_addr field
>> is set to NULL, instead of the expected pointer value.
>> 
>> This issue can not be fixed in copy_siginfo_to_user32 as the usb
>> usage of the the _sigfault (aka si_addr) member of the siginfo
>> union when SI_ASYNCIO is set is incompatible with the POSIX and
>> glibc usage of the _rt member of the siginfo union.
>> 
>> Therefore replace kill_pid_info_as_cred with kill_pid_usb_asyncio a
>> dedicated function for this one specific case.  There are no other
>> users of kill_pid_info_as_cred so this specialization should have no
>> impact on the amount of code in the kernel.  Have kill_pid_usb_asyncio
>> take instead of a siginfo_t which is difficult and error prone, 3
>> arguments, a signal number, an errno value, and an address enconded as
>> a sigval_t.  The encoding of the address as a sigval_t allows the
>> code that reads the userspace request for a signal to handle this
>> compat issue along with all of the other compat issues.
>> 
>> Add BUILD_BUG_ONs in kernel/signal.c to ensure that we can now place
>> the pointer value at the in si_pid (instead of si_addr).  That is the
>> code now verifies that si_pid and si_addr always occur at the same
>> location.  Further the code veries that for native structures a value
>> placed in si_pid and spilling into si_uid will appear in userspace in
>> si_addr (on a byte by byte copy of siginfo or a field by field copy of
>> siginfo).  The code also verifies that for a 64bit kernel and a 32bit
>> userspace the 32bit pointer will fit in si_pid.
>
> Okay, I have gone through this.  Although I still don't really
> understand the detailed issues concerning the layout of the data fields
> (probably hopeless without seeing a diagram), the USB portions of the
> patch look good and do what the patch description says.
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> Alan Stern

Thanks.

Perhaps this will work as a diagram.  I don't know if there is a better
way to say it in my patch description.  In struct siginfo there are 3
fields in fixed positions:

   int si_signo;
   int si_errno;
   int si_code;

After that there is a union.  The si_signo and si_code fields are
examined to see which union member is valid (see siginfo_layout).
In every other case a si_code of SI_ASYNCIO corresponds to
the the _rt union member which has the fields:

   int si_pid;
   int si_uid;
   sigval_t si_sigval;

However when usb started using SI_ASYNCIO the _sigfault union member
that (except for special exceptions) only has the field:

   void __user *si_addr;

Or in short the relevant piece of the union looks like:

         0   1  2   3    4   5   6  7
       +---+---+---+---+---+---+---+---+
       |    si_pid     |   si_uid      |
       +---+---+---+---+---+---+---+---+
       |             si_addr           | (64bit)
       +---+---+---+---+---+---+---+---+
       |     si_addr   | (32bit)
       +---+---+---+---+

Which means if siginfo is copied field by field on 32bit everything
works because si_pid and si_addr are in the same location.

Similarly if siginfo is copied field by field on 64bit everything
works because there is no padding between si_pid and si_uid. So
copying both of those fields results in the entire si_addr being
copied.

It is the compat case that gets tricky.  Half of the bits are
zero.  If those zero bits show up in bytes 4-7 and the data
shows up in bytes 0-3 (aka little endian) everything works.
If those zero bits show in in bytes 0-3 (aka big endian) userspace sees
a NULL pointer instead of the value it passed.



Fixing this while maintaining some modicum of sanity is the tricky bit.
The interface is made to kill_pid_usb_asyncio is made a sigval_t so the
standard signal compat tricks can be used.  sigval_t is a union of:

        int sival_int;
        void __user *sival_ptr;

         0   1  2   3    4   5   6  7
       +---+---+---+---+---+---+---+---+
       |            sival_ptr          | (64bit)
       +---+---+---+---+---+---+---+---+ 
       |    sival_ptr  | (32bit)
       +---+---+---+---+
       |    sival_int  |
       +---+---+---+---+

The signal code solves the compat issues for sigval_t by storing the
32bit pointers in sival_int.  So they meaningful bits are guaranteed to
be in the low 32bits, just like the 32bit sival_ptr.

After a bunch of build BUG_ONs to verify my reasonable assumptions
of but the siginfo layout are actually true, the code that generates
the siginfo just copies a sigval_t to si_pid.  And assumes the code
in the usb stack placed the pointer in the proper part of the sigval_t
when it read the information from userspace.

I don't know if that helps make it easy to understand but I figured I
would give it a shot.

Eric
