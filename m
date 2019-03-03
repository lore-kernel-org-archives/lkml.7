Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B52C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796EE20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HKhi7+99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCCOfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:35:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40421 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCCOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:35:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so2575682qta.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5NbvNfJToKI97SMZiN9QdAzd4EhUgf9odViGuw587JQ=;
        b=HKhi7+99O+yc6vVHVm4LATpUOUxSPVMVc3vLLhlr2XFo7qQZO/ek8xV6GCGmsNqHae
         Okj37VxqmaosKPQGslqEfvidj8RFee/gZshtG0QSPLV9cQwHLfK4lEvmEckNbuoJlKv4
         c9Q8z8FkZgY4AoyWEtveIsJ9zrWdn5+oN2mZO/VPCfvT4BNldc8EZ8OGYVTZ4oi+OzxX
         WK+uQSJFf1yY+RKQlF4eBUAjbbXFqFl9nog+R1/jrCIOgkR3euqD4qyhdNGkio47URkP
         spzKRq2Q+6N36PaKVSn3mBu7/iiv7rMoLi1YSCGV2UQJT6ErPR6B6xiNmqY6a/u1uHId
         9PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5NbvNfJToKI97SMZiN9QdAzd4EhUgf9odViGuw587JQ=;
        b=LqzuaotuCt9i8E/ILDpZR9FrmeDXx5Qru8N63ZUwV8htJI7vu0qfoY60eff0xkED8F
         6L4y84ugMCGLKRWojq5nYeu7rmtM2GyechmCm4LMqQGNAT//uAT14HWv1FeXqYv8J6ii
         3zKockg732GF97kA13AA26JzaYAUvsQX4lNVmEd7HxcJdeP83n9+nYJcPCXX7BpJYrYP
         vi5A8qccLn6PP7Ko+jzmYRb+yeDvyVgkidai+zjfphqsP+E8vVRfT6DS2aF/rWUsrw7l
         FzK94L8sNcipzgUtFwaCc0CkgWMy1h8TWVsRf+3UX2Vtuk+tHHIviG2hfgzC08YSoG2H
         K6LA==
X-Gm-Message-State: APjAAAVZ+E4bh45t2CULObIRVnRaAc/jHYOu2VzeqlIX2LRzgin/poqH
        KM2AOvHnipot9ptUcQHbzQqt7Q==
X-Google-Smtp-Source: APXvYqwB4jIDQJef2I9Bj74ovOq4TFCrRHTGOZx86ludmRQSNUuFGtrLm5NdSDnJ9ZQmm0qLd3i+cw==
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr11517372qtj.349.1551623703267;
        Sun, 03 Mar 2019 06:35:03 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 132sm2156373qke.0.2019.03.03.06.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:35:02 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        bvanassche@acm.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] workqueue: fix a memory leak in wq->lock_name
Date:   Sun,  3 Mar 2019 09:34:52 -0500
Message-Id: <20190303143452.11629-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit 669de8bda87b ("kernel/workqueue: Use dynamic
lockdep keys for workqueues") introduced a memory leak as
wq_free_lockdep() calls kfree(wq->lock_name) but wq_init_lockdep() does
not point wq->lock_name to the newly allocated slab object. This can be
reproduced by running LTP fallocate04 followed by oom01 tests.

unreferenced object 0xc0000005876384d8 (size 64):
  comm "fallocate04", pid 26972, jiffies 4297139141 (age 40370.480s)
  hex dump (first 32 bytes):
    28 77 71 5f 63 6f 6d 70 6c 65 74 69 6f 6e 29 65  (wq_completion)e
    78 74 34 2d 72 73 76 2d 63 6f 6e 76 65 72 73 69  xt4-rsv-conversi
  backtrace:
    [<00000000cb452883>] kvasprintf+0x6c/0xe0
    [<000000004654ddac>] kasprintf+0x34/0x60
    [<000000001c68f311>] alloc_workqueue+0x1f8/0x6ac
    [<0000000003c2ad83>] ext4_fill_super+0x23d4/0x3c80 [ext4]
    [<0000000006610538>] mount_bdev+0x25c/0x290
    [<00000000bcf955ec>] ext4_mount+0x28/0x50 [ext4]
    [<0000000016e08fd3>] legacy_get_tree+0x4c/0xb0
    [<0000000042b6a5fc>] vfs_get_tree+0x6c/0x190
    [<00000000268ab022>] do_mount+0xb9c/0x1100
    [<00000000698e6898>] ksys_mount+0x158/0x180
    [<0000000064e391fd>] sys_mount+0x20/0x30
    [<00000000ba378f12>] system_call+0x5c/0x70

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 497900263dbc..e780bf73eced 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3445,6 +3445,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 	lock_name = kasprintf(GFP_KERNEL, "%s%s", "(wq_completion)", wq->name);
 	if (!lock_name)
 		lock_name = wq->name;
+
+	wq->lock_name = lock_name;
 	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
 }
 
-- 
2.17.2 (Apple Git-113)

