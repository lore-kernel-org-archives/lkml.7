Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE92D214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfDXW4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:56:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33674 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDXW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:56:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hJQok-0005Ws-2B; Wed, 24 Apr 2019 22:56:42 +0000
Date:   Wed, 24 Apr 2019 23:56:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Message-ID: <20190424225641.GQ2217@ZenIV.linux.org.uk>
References: <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
 <20190423110611.GL2217@ZenIV.linux.org.uk>
 <5614f04f-827d-1668-9ed0-60d93e110b8e@codeaurora.org>
 <20190424130711.GP2217@ZenIV.linux.org.uk>
 <5b02ac1e-df3e-d9cd-ecf3-fe60cda2cece@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b02ac1e-df3e-d9cd-ecf3-fe60cda2cece@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:39:03PM +0530, Mukesh Ojha wrote:

> This was my simple program no multithreading just to understand f_counting
> 
> int main()
> {
>         int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
>         ioctl(fd, UI_SET_EVBIT, EV_KEY);
>         close(fd);
>         return 0;
> }
> 
>            uinput-532   [002] ....    45.312044: SYSC_ioctl: 2   <= f_count

Er...  So how does it manage to hit ioctl(2) before open(2)?  Confused...

> >    <After fdget()
>           uinput-532   [002] ....    45.312055: SYSC_ioctl: 2           
> <After fdput()
>           uinput-532   [004] ....    45.313766: uinput_open: uinput: 1   /*
> This is from the uinput driver uinput_open()*/
> 
>   =>>>>                         /* All the above calls happened for the
> open() in userspace*/
> 
>           uinput-532   [004] ....    45.313783: SYSC_ioctl: 1 /* This print
> is for the trace, i put after fdget */
>           uinput-532   [004] ....    45.313788: uinput_ioctl_handler:
> uinput: uinput_ioctl_handler, 1 /* This print is from the uinput_ioctl
> driver */
> 
>           uinput-532   [004] ....    45.313835: SYSC_ioctl: 1 /* This print
> is for the trace, i put after fdput*/
>           uinput-532   [004] ....    45.313843: uinput_release: uinput:  0
> /* And this is from the close()  */
> 
> 
> Should fdget not suppose to increment the f_count here, as it is coming 1 ?
> This f_count to one is done at the open, but i have no idea how this  below
> f_count 2 came before open() for
> this simple program.

If descriptor table is not shared, fdget() will simply return you the reference
from there, without bothering to bump the refcount.  _And_ having it marked
"don't drop refcount" in struct fd.

Rationale: since it's not shared, nobody other than our process can modify
it.  So unless we remove (and drop) the reference from it ourselves (which
we certainly have no business doing in ->ioctl() and do not do anywhere
in drivers/input), it will remain there until we return from syscall.

Nobody is allowed to modify descriptor table other than their own.
And if it's not shared, no other owners can appear while the only
existing one is in the middle of syscall other than clone() (with
CLONE_FILES in flags, at that).

For shared descriptor table fdget() bumps file refcount, since there
the reference in descriptor table itself could be removed and dropped
by another thread.

And fdget() marks whether fput() is needed in fd.flags, so that
fdput() does the right thing.
