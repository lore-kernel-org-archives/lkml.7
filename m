Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9271EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732AE206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfJKPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:42:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36712 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJKPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:42:02 -0400
Received: by mail-io1-f72.google.com with SMTP id g126so15275806iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 08:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kFsPfbIuVLLP06mBsnv++deRNxJoBeYlYpS0DCBKJRY=;
        b=C6suu0TGyqce7a2MqUkf6PmVfi6gQ9lFBqD1xH0Aoj/qD8JaylAzDEZdw/JBaT+5Cx
         tLbGnUJE3P1ErU+3wwVDym2NjTCWyVr81KGukm5XDjRjHj2br6EQ/jiEyelzcLcSuQjQ
         DQPKsrHionx8fht6jy+8lKIec5A/cYqTwcLaaONXVyB5M1c2/xtlCtCVQ0ku2XJUMpxQ
         KJ/rk725T/w+deQZ1TrIgnLWgfWOUm4noyDUIkRvLA4Wf4o9ziEkFNIHgOv/QZEdj0+R
         U8T3ayGxXnEk1/EKw0eztJ9gIrnJsdePaZZMg6bNxRVQuOz3v1l/f3AFq5MUbWyTHZlx
         0DIw==
X-Gm-Message-State: APjAAAVKW/Joqhh88I+AIObzQ6inadH5Anw90IIsLJA0BRMd6Zdc6on5
        Kqo2xLUUtkZQ5+rMST9h+kMq92ALkh5jSuCgwETteNn5t/Sj
X-Google-Smtp-Source: APXvYqxXLVkmWggCu+Lv+8QrqPqjahv/fK5bYpGS0bKVyVgxGg2uLnvbq0VxIpHqkH2HZnuRzFPxtwoZNQtlC05V5hfbsFmrBVIb
MIME-Version: 1.0
X-Received: by 2002:a5e:9b04:: with SMTP id j4mr106545iok.45.1570808521184;
 Fri, 11 Oct 2019 08:42:01 -0700 (PDT)
Date:   Fri, 11 Oct 2019 08:42:01 -0700
In-Reply-To: <CAG_fn=WsN0d8VO6=4jtDP9rHqBMp0zBvJQ7qrvQhZkkaj6NNsg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea5bf90594a45b81@google.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
From:   syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        jaskaransingh7654321@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
KMSAN: uninit-value in alauda_check_media

=====================================================
BUG: KMSAN: uninit-value in alauda_transport+0x462/0x57f0  
drivers/usb/storage/alauda.c:1138
CPU: 1 PID: 11015 Comm: usb-storage Not tainted 5.4.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x14c/0x2c0 mm/kmsan/kmsan_report.c:110
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
  alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:461
  alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1138
  usb_stor_invoke_transport+0xf5/0x27e0 drivers/usb/storage/transport.c:606
  usb_stor_transparent_scsi_command+0x5d/0x70  
drivers/usb/storage/protocol.c:108
  usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----status@alauda_check_media
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 11015 Comm: usb-storage Tainted: G    B             5.4.0-rc2+  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  panic+0x3c9/0xc1e kernel/panic.c:220
  kmsan_report+0x2b4/0x2c0 mm/kmsan/kmsan_report.c:133
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
  alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:461
  alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1138
  usb_stor_invoke_transport+0xf5/0x27e0 drivers/usb/storage/transport.c:606
  usb_stor_transparent_scsi_command+0x5d/0x70  
drivers/usb/storage/protocol.c:108
  usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         c40e5c97 kmsan: drop some dead code in kmsan_shadow.c
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=153ba453600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49548798e87d32d7
dashboard link: https://syzkaller.appspot.com/bug?extid=e7d46eb426883fb97efd
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

