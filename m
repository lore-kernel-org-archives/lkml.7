Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAFDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C220882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiAKSKLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393179AbfITI5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:57:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40687 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfITI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:57:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so3447524pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f16ki7Qprxq2/NTF9pMKzE4bJvr1ytkOp3tyS/yQdVM=;
        b=LiAKSKLXLXhIc96xil6DvVoAkxPbosQZMhn5rZByCak0CL861RmoadQ5xb9ASV37fx
         FJ+UbGofyvCWAUNy+d8hOo0zrNdFTiwcuJRK1+Awh47G8pUKwsmTXFKi6wdMD++cXfOR
         y7Lb3Wwt6m9QOE5cgRHtPZTj/eMLrK2Y7e81+6kGkDRRsShfl1AvkUnVjdW6hryL0nqq
         G8xAk/n1SX2ag5HHKXglYxoiTzGUI0gKnwiaHqwfKRJl2lCqbE/RR3AcwcfjYIvCjlFi
         FKhfoaNy+Cp4fxVLeOHcUI5b1gqtayi7zRuX/NSVbrg0p7aUu+cME/mTmYOvLVY8KsOV
         IcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f16ki7Qprxq2/NTF9pMKzE4bJvr1ytkOp3tyS/yQdVM=;
        b=isZZ91OCxj79mMPtBIo3UL38xjx8JlY92LMn1usx68iHdksYzfcOnwJ//zwui3JV/x
         ltmaGVfESmRSE0xQksRnXOVnte6/kQdncLwmnedZmLMX43YUY852H7lQ5d6T/BRGF4Kp
         qieihRLEo/FazFZEqbU6Y7DFfC36arB+ZV47W9k8HH323AMYJDohdmpQswnYl33sniRI
         DbgZE2qFtyDd837sIe0u/xYNaUnNB3tf6E1IGdqxFe8qEmo/ncvhC8P1lHddTmk8Kw7r
         kOnI5GR8/mh6UauNjgeqSFdnQjiweQbMV8D3OlQBUzAPTJ6Xd/o/oY4sMWvV9ej7gp5w
         SE2A==
X-Gm-Message-State: APjAAAXK0YwgYrfWp8cxwV4dfZy0+uv9M8rtElPqlnCqj91ThtWwBT41
        Ebk4U3OjX1DUoNBh+fBOaZE=
X-Google-Smtp-Source: APXvYqz1mX40Cyt/T+qTgGFoX7yuHqVNyyHFeYCIMgYRgAyiTt9mlvfwCm9uzk1hvJwwomxxFIqoww==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr3447542pju.85.1568969853039;
        Fri, 20 Sep 2019 01:57:33 -0700 (PDT)
Received: from hqjagain.localdomain ([47.56.172.21])
        by smtp.gmail.com with ESMTPSA id u18sm3869743pgb.83.2019.09.20.01.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:57:32 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, mpatocka@redhat.com,
        ghalat@redhat.com, linux-kernel@vger.kernel.org, hqjagain@gmail.com
Subject: [PATCH] tty/vt: Touch NMI watchdog in vt_console_print
Date:   Fri, 20 Sep 2019 16:57:26 +0800
Message-Id: <1568969846-1800-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vt_console_print could trigger NMI watchdog in case writing slow:

[2858736.789664] NMI watchdog: Watchdog detected hard LOCKUP on cpu 23
...
[2858736.790194] CPU: 23 PID: 32504 Comm: tensorflow_mode Not tainted 4.4.131-1.el7.elrepo.x86_64 #1
[2858736.790206] Hardware name: Huawei RH2288 V3/BC11HGSB0, BIOS 3.57 02/26/2017
[2858736.790222] task: ffff881e0a191640 ti: ffff881fd73a8000 task.ti: ffff881fd73a8000
[2858736.790358] RIP: 0010:[<ffffffff810cc06e>]  [<ffffffff810cc06e>] native_queued_spin_lock_slowpath+0x15e/0x170
[2858736.790363] RSP: 0018:ffff88203f043db0  EFLAGS: 00000002
[2858736.790365] RAX: 00000000005c0101 RBX: 0000000000000246 RCX: 0000000000000001
...
[2858736.790452] Call Trace:
[2858736.790521]  <IRQ>
[2858736.790521]  [<ffffffff8118ab28>] queued_spin_lock_slowpath+0xb/0xf
[2858736.790552]  [<ffffffff8170eca7>] _raw_spin_lock_irqsave+0x37/0x40
[2858736.790653]  [<ffffffff814c80a4>] scsi_end_request+0x104/0x1d0
[2858736.790656]  [<ffffffff814c9e13>] scsi_io_completion+0x153/0x650
[2858736.790671]  [<ffffffff814c1092>] scsi_finish_command+0xd2/0x120
[2858736.790673]  [<ffffffff814c9607>] scsi_softirq_done+0x127/0x150
[2858736.790749]  [<ffffffff8131973e>] blk_done_softirq+0x8e/0xc0
[2858736.790811]  [<ffffffff810857db>] __do_softirq+0xeb/0x2f0
[2858736.790813]  [<ffffffff81085c85>] irq_exit+0xf5/0x100
[2858736.790867]  [<ffffffff81051819>] smp_call_function_single_interrupt+0x39/0x40
[2858736.790890]  [<ffffffff8171055b>] call_function_single_interrupt+0x9b/0xa0
[2858736.790973]  <EOI>
...

PID: 1793   TASK: ffff88103445c2c0  CPU: 32  COMMAND: "java"
 #0 [ffff88103fe88e38] crash_nmi_callback at ffffffff810504d7
 #1 [ffff88103fe88e48] nmi_handle at ffffffff8101c1f7
 #2 [ffff88103fe88ea0] default_do_nmi at ffffffff8101c7d0
 #3 [ffff88103fe88ec0] do_nmi at ffffffff8101c901
 #4 [ffff88103fe88ee8] end_repeat_nmi at ffffffff8171176a
    [exception RIP: cfb_imageblit+1167]
    RIP: ffffffff813bdf8f  RSP: ffff880006823380  RFLAGS: 00000046
    RAX: 0000000000000001  RBX: 0000000000000000  RCX: 0000000000000005
    RDX: 000000000000024d  RSI: 00000000ff000000  RDI: 0000000000000001
    RBP: ffff8800068233f0   R8: ffffffff81785e80   R9: ffffc9000c843168
    R10: 0000000000000001  R11: 0000000000000000  R12: ffff882037a831ba
    R13: ffff882037a831af  R14: ffffc9000c84316c  R15: ffffc9000c843000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffff880006823380] cfb_imageblit at ffffffff813bdf8f
 #6 [ffff880006823398] bit_putcs at ffffffff813b2307
 #7 [ffff8800068234d0] bit_cursor at ffffffff813b1fc8
 #8 [ffff8800068235f0] fbcon_scroll at ffffffff813aebda
 #9 [ffff880006823650] scrup at ffffffff81442600
...

the cpu23 wait for the same blk queue_lock

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d..cd32d66 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -105,6 +105,7 @@
 #include <linux/ctype.h>
 #include <linux/bsearch.h>
 #include <linux/gcd.h>
+#include <linux/nmi.h>
 
 #define MAX_NR_CON_DRIVER 16
 
@@ -2978,6 +2979,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 			vc->vc_pos += 2;
 			vc->vc_x++;
 		}
+		touch_nmi_watchdog();
 	}
 	if (cnt && con_is_visible(vc))
 		vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
-- 
1.9.1

