Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F76C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668820679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfJKOI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:08:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41596 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728068AbfJKOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:08:28 -0400
Received: (qmail 1736 invoked by uid 2102); 11 Oct 2019 10:08:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Oct 2019 10:08:27 -0400
Date:   Fri, 11 Oct 2019 10:08:27 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
cc:     syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>,
        <glider@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>,
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: KMSAN: uninit-value in alauda_check_media
In-Reply-To: <b8b1e4fef9f3ece63909c38b3302621d76770caa.camel@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1910111003100.1529-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019, Jaskaran Singh wrote:

> On Mon, 2019-10-07 at 12:39 -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    1e76a3e5 kmsan: replace __GFP_NO_KMSAN_SHADOW with
> > kmsan_i..
> > git tree:       https://github.com/google/kmsan.git master
> > console output: 
> > https://syzkaller.appspot.com/x/log.txt?x=1204cc63600000
> > kernel config:  
> > https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> > dashboard link: 
> > https://syzkaller.appspot.com/bug?extid=e7d46eb426883fb97efd
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:      
> > https://syzkaller.appspot.com/x/repro.syz?x=123c860d600000
> > C reproducer:   
> > https://syzkaller.appspot.com/x/repro.c?x=110631b7600000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the
> > commit:
> > Reported-by: syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com
> > 
> > =====================================================
> > BUG: KMSAN: uninit-value in alauda_transport+0x462/0x57f0  
> > drivers/usb/storage/alauda.c:1137
> > CPU: 0 PID: 12279 Comm: usb-storage Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS  
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
> >   kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
> >   __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
> >   alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
> >   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
> >   usb_stor_invoke_transport+0xf5/0x27e0
> > drivers/usb/storage/transport.c:606
> >   usb_stor_transparent_scsi_command+0x5d/0x70  
> > drivers/usb/storage/protocol.c:108
> >   usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
> >   kthread+0x4b5/0x4f0 kernel/kthread.c:256
> >   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355


> #syz test: https://github.com/google/kmsan.git 1e76a3e5
> 
> diff --git a/drivers/usb/storage/alauda.c
> b/drivers/usb/storage/alauda.c
> index ddab2cd3d2e7..bb309b9ad65b 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -452,7 +452,7 @@ static int alauda_init_media(struct us_data *us)
>  static int alauda_check_media(struct us_data *us)
>  {
>  	struct alauda_info *info = (struct alauda_info *) us->extra;
> -	unsigned char status[2];
> +	unsigned char *status = us->iobuf;
>  	int rc;
>  
>  	rc = alauda_get_media_status(us, status);

That is absolutely not the correct fix.

The problem is that after this call, the code does not check rc to see 
if an error occurred.  If there was an error, the value of status is 
meaningless so there's no point examining it at all.

Now yes, it's true that defining status as an array on the stack is 
also a bug, since USB transfer buffers are not allowed to be stack 
variables.  And the change you made _is_ the right way to fix that bug.  
But that is a separate bug, not the one that syzbot found.

Alan Stern

