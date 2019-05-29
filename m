Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47EA240D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TuRLwggT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE2THF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:07:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41745 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfE2THE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:07:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id s57so3993332qte.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2eusIL/nzSK2s9R9uc1xL5ZfmWg5RxkuxNc2ZFp/bBI=;
        b=TuRLwggTqjMk7XmDlvWEFh9TFVyhGFcP7cAa/rG7hovF99AkCIp+gida+yKpx6zNRb
         yxMzh2uQwoBuEv6qaVnjzfEhTgU7ZWKvASfjQabJ2eezbDEMvEagbhBL+Qqcv1GGVGTm
         XxJ6fOaxTePIzwvUt0QyNMExAEKu6tLSeGZKX3InC/0HeGHLFG1Zkyf2cz7iWzgr50X4
         tE0B31jOexY9fX8m7TLidU7CneRK3ddym1jAOkJOxpxRFiBvSWhwz+TtseXerHWOpYtQ
         zzzyu61XjgMWMYkDQxCGgosvaoNbqOV4I80TH2d4+q+jsewB63jnJKbKK6duJswnTZZT
         WUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2eusIL/nzSK2s9R9uc1xL5ZfmWg5RxkuxNc2ZFp/bBI=;
        b=bxOwnaipenvnxMshBKQsUtaLtIx+Wx7jYLvdfWEdJAQHeZdZ4bgHSTaN+FIzRkUQeK
         rDlvD3nn7O5LIOrs/8l5L/D65msiYaQCjNm4QMztMADHm+w+QpC5UPwvDjuv7BPY+eDn
         gPQJmxfo22o0bqvRyzMBIwsvBKagQHpIMk8UQjlGa61rTjEzHwat+uxikafgrQd2TMzd
         T5E1sb1s7yR0GMeVxxp4rC0HcxrtjG47txr067r1ygoLfyJGmW8t62lx1MR3FQU72O80
         wKGPdRDnY3oC3550HFI30pGTHNoPpaqQgcvjQEzd/xFKBcfTQi1enViEw7xqtyNXhkYz
         eeuQ==
X-Gm-Message-State: APjAAAUw7Zg2bjit9k8UcsMtqpsHymW7wg3l8chozeD1XOejrQO733lj
        vJCXfxBfVRetKYZ0IxQVbNSDJg==
X-Google-Smtp-Source: APXvYqxChkKR1X4fRnQAKSVqrxHnQmFnpt86QUnpPveJVHSvTdcVeXPOSAggtkZ1iv79Bum90D+Wgw==
X-Received: by 2002:ac8:1608:: with SMTP id p8mr58204451qtj.81.1559156823359;
        Wed, 29 May 2019 12:07:03 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g124sm168098qkf.55.2019.05.29.12.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:07:02 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     axboe@kernel.dk, hch@lst.de, peterz@infradead.org, oleg@redhat.com,
        gkohli@codeaurora.org, mingo@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_io: fix a crash in do_task_dead()
Date:   Wed, 29 May 2019 15:06:53 -0400
Message-Id: <1559156813-30681-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 0619317ff8ba ("block: add polled wakeup task helper")
replaced wake_up_process() with blk_wake_io_task() in
end_swap_bio_read() which triggers a crash when running heavy swapping
workloads.

[T114538] kernel BUG at kernel/sched/core.c:3462!
[T114538] Process oom01 (pid: 114538, stack limit = 0x000000004f40e0c1)
[T114538] Call trace:
[T114538]  do_task_dead+0xf0/0xf8
[T114538]  do_exit+0xd5c/0x10fc
[T114538]  do_group_exit+0xf4/0x110
[T114538]  get_signal+0x280/0xdd8
[T114538]  do_notify_resume+0x720/0x968
[T114538]  work_pending+0x8/0x10

This is because shortly after set_special_state(TASK_DEAD),
end_swap_bio_read() is called from an interrupt handler that revive the
task state to TASK_RUNNING causes __schedule() to return and trip the
BUG() later.

[  C206] Call trace:
[  C206]  dump_backtrace+0x0/0x268
[  C206]  show_stack+0x20/0x2c
[  C206]  dump_stack+0xb4/0x108
[  C206]  blk_wake_io_task+0x7c/0x80
[  C206]  end_swap_bio_read+0x22c/0x31c
[  C206]  bio_endio+0x3d8/0x414
[  C206]  dec_pending+0x280/0x378 [dm_mod]
[  C206]  clone_endio+0x128/0x2ac [dm_mod]
[  C206]  bio_endio+0x3d8/0x414
[  C206]  blk_update_request+0x3ac/0x924
[  C206]  scsi_end_request+0x54/0x350
[  C206]  scsi_io_completion+0xf0/0x6f4
[  C206]  scsi_finish_command+0x214/0x228
[  C206]  scsi_softirq_done+0x170/0x1a4
[  C206]  blk_done_softirq+0x100/0x194
[  C206]  __do_softirq+0x350/0x790
[  C206]  irq_exit+0x200/0x26c
[  C206]  handle_IPI+0x2e8/0x514
[  C206]  gic_handle_irq+0x224/0x228
[  C206]  el1_irq+0xb8/0x140
[  C206]  _raw_spin_unlock_irqrestore+0x3c/0x74
[  C206]  do_task_dead+0x88/0xf8
[  C206]  do_exit+0xd5c/0x10fc
[  C206]  do_group_exit+0xf4/0x110
[  C206]  get_signal+0x280/0xdd8
[  C206]  do_notify_resume+0x720/0x968
[  C206]  work_pending+0x8/0x10

Before the offensive commit, wake_up_process() will prevent this from
happening by taking the pi_lock and bail out immediately if TASK_DEAD is
set.

if (!(p->state & TASK_NORMAL))
	goto out;

Fixes: 0619317ff8ba ("block: add polled wakeup task helper")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d0e048..dc2d3e037ccf 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -140,7 +140,8 @@ static void end_swap_bio_read(struct bio *bio)
 	unlock_page(page);
 	WRITE_ONCE(bio->bi_private, NULL);
 	bio_put(bio);
-	blk_wake_io_task(waiter);
+	/* end_swap_bio_read() could be called from an interrupt handler. */
+	wake_up_process(waiter);
 	put_task_struct(waiter);
 }
 
-- 
1.8.3.1

