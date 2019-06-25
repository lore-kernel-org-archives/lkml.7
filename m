Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73866C4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AB2212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="GddzZNJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfFYB3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:29:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33200 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfFYB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:29:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so7443168pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=474r08//8FJD1v658qJyBzGmPp2fJuSEfEyv/CnfdVs=;
        b=GddzZNJiE8VR1oUVTCDcUwothRMS8GdIrqGZA1bhLUbXycYK2xN9RIbjH8YCOTSAYQ
         saRT2rQ4LDwQP145yX1vzp/HYY9g4e50B/iLZqmaC3A7bISPwArS/6QvJyJS7LUpYeT1
         vXFwA9PHyCR0WDOHQhQ6Q+ofajSRgvi8iHZgmIlewqRpomawiGBELrlJMSeTWx0hCBNB
         dJfyq/cijVNTn8eWCORJ87dqZ0Sqb/CjNMZQm7KoGKr5ljD8Y1qhrWNG4Z/rxcuwBIcL
         KLZ4vCDWxVAH+emsRNAP0c/AY+OfIs27AvQ21bZkm4Z3y/gL+c96Ji5FGgqzINK3ikw1
         REnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=474r08//8FJD1v658qJyBzGmPp2fJuSEfEyv/CnfdVs=;
        b=a0UERLERZMO2NqdxnbQeEaUV1gvQjr5jEGZSHX7fho2bHPAdGKUSnSuOualYMI+5Uq
         DqIAWg2hhwPpVfQuRxVBeazeeln9TPyGeDh/Wot/llg4obVL+JoV0o2p5YqeNUBDvFmM
         6d5LBQsxQQwle50wLouJrmljaCmI5lXqwns1sBKlkFqyx5egKnSLmQSLE8Aw5Dgc5+sN
         +Gk83mHY9wSZ83k22wTyyEmAlH+xZqUEr/ejslWwC6K5qNU/KFD79WQH6dLPz2ZClkLa
         f+Ehh47V9iKoSQz/rD6p4UqRbypXmEoR+rIydRSigHoG+RXSVNIXeX/aikwHyfJqVeAO
         +7xA==
X-Gm-Message-State: APjAAAUBiEB8MLtKxqLodw4p6l4prbf8eW6aEYLsmgcKn8w9qc+nLa3G
        5t0ZWxABgdV2Ql/62301qxSeMA==
X-Google-Smtp-Source: APXvYqwt2ciSE2R7MdI/FGbilpaBKdXho6qyh0pcZyLNooQc3vNygFVrD9E4thCiKI1f6zIHNGEmpQ==
X-Received: by 2002:a63:d415:: with SMTP id a21mr34816748pgh.229.1561426161626;
        Mon, 24 Jun 2019 18:29:21 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id e188sm2959716pfh.99.2019.06.24.18.29.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 18:29:20 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] tracing/snapshot: resize spare buffer if size changed
Date:   Tue, 25 Jun 2019 10:29:10 +0900
Message-Id: <20190625012910.13109-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current snapshot implementation swaps two ring_buffers even though their
sizes are different from each other, that can cause an inconsistency
between the contents of buffer_size_kb file and the current buffer size.

For example:

  # cat buffer_size_kb
  7 (expanded: 1408)
  # echo 1 > events/enable
  # grep bytes per_cpu/cpu0/stats
  bytes: 1441020
  # echo 1 > snapshot             // current:1408, spare:1408
  # echo 123 > buffer_size_kb     // current:123,  spare:1408
  # echo 1 > snapshot             // current:1408, spare:123
  # grep bytes per_cpu/cpu0/stats
  bytes: 1443700
  # cat buffer_size_kb
  123                             // != current:1408

And also, a similar per-cpu case hits the following WARNING:

Reproducer:

  # echo 1 > per_cpu/cpu0/snapshot
  # echo 123 > buffer_size_kb
  # echo 1 > per_cpu/cpu0/snapshot

WARNING:

  WARNING: CPU: 0 PID: 1946 at kernel/trace/trace.c:1607 update_max_tr_single.part.0+0x2b8/0x380
  Modules linked in:
  CPU: 0 PID: 1946 Comm: bash Not tainted 5.2.0-rc6 #20
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  RIP: 0010:update_max_tr_single.part.0+0x2b8/0x380
  Code: ff e8 dc da f9 ff 0f 0b e9 88 fe ff ff e8 d0 da f9 ff 44 89 ee bf f5 ff ff ff e8 33 dc f9 ff 41 83 fd f5 74 96 e8 b8 da f9 ff <0f> 0b eb 8d e8 af da f9 ff 0f 0b e9 bf fd ff ff e8 a3 da f9 ff 48
  RSP: 0018:ffff888063e4fca0 EFLAGS: 00010093
  RAX: ffff888066214380 RBX: ffffffff99850fe0 RCX: ffffffff964298a8
  RDX: 0000000000000000 RSI: 00000000fffffff5 RDI: 0000000000000005
  RBP: 1ffff1100c7c9f96 R08: ffff888066214380 R09: ffffed100c7c9f9b
  R10: ffffed100c7c9f9a R11: 0000000000000003 R12: 0000000000000000
  R13: 00000000ffffffea R14: ffff888066214380 R15: ffffffff99851060
  FS:  00007f9f8173c700(0000) GS:ffff88806d000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000714dc0 CR3: 0000000066fa6000 CR4: 00000000000006f0
  Call Trace:
   ? trace_array_printk_buf+0x140/0x140
   ? __mutex_lock_slowpath+0x10/0x10
   tracing_snapshot_write+0x4c8/0x7f0
   ? trace_printk_init_buffers+0x60/0x60
   ? selinux_file_permission+0x3b/0x540
   ? tracer_preempt_off+0x38/0x506
   ? trace_printk_init_buffers+0x60/0x60
   __vfs_write+0x81/0x100
   vfs_write+0x1e1/0x560
   ksys_write+0x126/0x250
   ? __ia32_sys_read+0xb0/0xb0
   ? do_syscall_64+0x1f/0x390
   do_syscall_64+0xc1/0x390
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

This patch adds resize_buffer_duplicate_size() to check if there is a
difference between current/spare buffer sizes and resize a spare buffer
if necessary.

Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/trace/trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..3edd4c1b96be 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6719,11 +6719,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			break;
 		}
 #endif
-		if (!tr->allocated_snapshot) {
+		if (tr->allocated_snapshot)
+			ret = resize_buffer_duplicate_size(&tr->max_buffer,
+					&tr->trace_buffer, iter->cpu_file);
+		else
 			ret = tracing_alloc_snapshot_instance(tr);
-			if (ret < 0)
-				break;
-		}
+		if (ret < 0)
+			break;
 		local_irq_disable();
 		/* Now, we're going to swap */
 		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
-- 
2.21.0

