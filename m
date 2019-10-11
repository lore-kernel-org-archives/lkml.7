Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD0C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C6D214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFlQ0vsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfJKLXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:23:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40838 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:23:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so5622119pgl.7;
        Fri, 11 Oct 2019 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=FI82U63M+SgbahHSF1eO73vV08QgE3AQDZfaeuoWBb8=;
        b=lFlQ0vsTQoH/B6jts5uXJD1fECl6EcI1ln6InB6KiGxqt3Mh2rwSi8g8TTKUZFk0Ax
         i1MdkREyuNzKrz7FUNZIp202e44C2zPTd5Cix+ZziiW7L90U0ua0q4ba8Yaf8aXgqRLf
         aN9S1MJNU9pDMFwjk0HJyRaGiowttaSVFrb4F5ydzJNIFxiueTRb2RIiFfV0zy6uL9wk
         M7cmjeNa/h7jXsFkE39PZ5oSm+r4zobuXzqQJNfzcFLa68jZg60jRNnFiFj2oqrJW5c8
         gttcg9jFc3khksSnuptanXV42wRbYMys3sEp5sDPBVeft1p0Og0MTmCtZ1zWoJWdexKY
         YrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FI82U63M+SgbahHSF1eO73vV08QgE3AQDZfaeuoWBb8=;
        b=ezS52G02AMJYLfgOO0lGkU661A3IGpWyuXgslD9GcAUI9rIglYz+BE2lTjLW+kVcw0
         S4lfdg3AaKtypFayFdZ2TBdoKhGXvE9lk9rTRmPDj+pynRxEPgn6o/T8YNA6aGkPG7EL
         5eaTtEdCK2+mQNEn9cVtMXniV+OIy8gy4N1O4+cJjv0LMSBhHm8waz9W6axuIQa6Pcs7
         Q0jcCX+nsLRRUuo32eJh3bBvycGJWZZ2avzBhL83VVKUljjfrCMKhFA3pqoOrloWfZuh
         K2J4hpt5Yz/oXTkN9C5yAQwpTLGJEatuYWAQF6H6obnkbLgmxlthnny672S+y/d40TPw
         Cvcg==
X-Gm-Message-State: APjAAAUtZDrJroaF/niIeYXAqvp+MM7qrvJEViacGMt6erVh335/PvZX
        o5aR5Co8CiMcuEBWHPtUzgUJpILax6ZlMA==
X-Google-Smtp-Source: APXvYqw3WshAK+s47EREjFdEAJ5D0swM8kSL34uq2bh9In2yaJzvobYTo46GBPsycSfvKz59J/nZ7Q==
X-Received: by 2002:a63:4622:: with SMTP id t34mr16734453pga.0.1570793002922;
        Fri, 11 Oct 2019 04:23:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:139e:d60:aa0c:2692:c558:75f5])
        by smtp.gmail.com with ESMTPSA id u4sm8749841pfu.177.2019.10.11.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:23:22 -0700 (PDT)
Message-ID: <b8b1e4fef9f3ece63909c38b3302621d76770caa.camel@gmail.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>,
        glider@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        usb-storage@lists.one-eyed-alien.net
Date:   Fri, 11 Oct 2019 16:53:15 +0530
In-Reply-To: <0000000000007d25ff059457342d@google.com>
References: <0000000000007d25ff059457342d@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 12:39 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1e76a3e5 kmsan: replace __GFP_NO_KMSAN_SHADOW with
> kmsan_i..
> git tree:       https://github.com/google/kmsan.git master
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=1204cc63600000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=e7d46eb426883fb97efd
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=123c860d600000
> C reproducer:   
> https://syzkaller.appspot.com/x/repro.c?x=110631b7600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the
> commit:
> Reported-by: syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in alauda_transport+0x462/0x57f0  
> drivers/usb/storage/alauda.c:1137
> CPU: 0 PID: 12279 Comm: usb-storage Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
>   __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
>   alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
>   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
>   usb_stor_invoke_transport+0xf5/0x27e0
> drivers/usb/storage/transport.c:606
>   usb_stor_transparent_scsi_command+0x5d/0x70  
> drivers/usb/storage/protocol.c:108
>   usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
> 
> Local variable description: ----status@alauda_check_media
> Variable was created at:
>   alauda_check_media+0x8e/0x3310 drivers/usb/storage/alauda.c:454
>   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
> =====================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 12279 Comm: usb-storage Tainted:
> G    B             5.3.0-rc7+  
> #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   panic+0x3c9/0xc1e kernel/panic.c:219
>   kmsan_report+0x2a2/0x2b0 mm/kmsan/kmsan_report.c:131
>   __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
>   alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
>   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
>   usb_stor_invoke_transport+0xf5/0x27e0
> drivers/usb/storage/transport.c:606
>   usb_stor_transparent_scsi_command+0x5d/0x70  
> drivers/usb/storage/protocol.c:108
>   usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz test: https://github.com/google/kmsan.git 1e76a3e5

diff --git a/drivers/usb/storage/alauda.c
b/drivers/usb/storage/alauda.c
index ddab2cd3d2e7..bb309b9ad65b 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -452,7 +452,7 @@ static int alauda_init_media(struct us_data *us)
 static int alauda_check_media(struct us_data *us)
 {
 	struct alauda_info *info = (struct alauda_info *) us->extra;
-	unsigned char status[2];
+	unsigned char *status = us->iobuf;
 	int rc;
 
 	rc = alauda_get_media_status(us, status);

