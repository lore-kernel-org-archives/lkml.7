Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F02206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZBHrl+eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfCGA1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:27:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46095 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGA1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:27:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id z25so15162603qti.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4Au+lFueim3ZVP9bj8nxR5vnEo5/ieItGMPR4cvSOOM=;
        b=ZBHrl+eCiI94gPc8UW+WxFlIeHe2Rj2jZ885NU9OB6drGNQT5eqV9QEcZUGzObA2Sr
         AzjU48cZNflMuqkZviiIdJO888jk0+uZ0Cu2fPiCWJo9IUuCcwXqkc0j5OtIrg6P9oWB
         6s3UbzLJUK9Yo+/s2ggeocb8FTEM2nalLkVV8+RAaBeUNz7f8bKAiP4GCOh8lQ9Nq4Qc
         zy5g+vqn8T6ekkXe2xiYV31+uC0iirRbmfuMg9MS9I1ApJvEXVrAddljUHZRlwldao4o
         ISVVBbf5n2LiS+CBtGF++qyH926xYFrQGsJH0cm7ibw6rmBJov8E8a9xqm2N1yDzcsQe
         aOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Au+lFueim3ZVP9bj8nxR5vnEo5/ieItGMPR4cvSOOM=;
        b=NRYPfbk5e1gaXguAyXXj7gsHAH3zd4DQirMUkaFXfG6ihaUi4tVu4m4frhMKtoLk1O
         5BUNs7FV+6MGizVGnYvOUEbu0cdKWx+cQPgc2enFZSXIHtd1dLPRkSjT5sBmjyPE0T54
         YzNbcinlRoVK2IkaomL2yymwSEOFlPbJqzqjV16BHcFFjiOZ0H+51C7834sSsqi8J3S3
         lhlpBDTy7vkwMAgBmJ/ijBsfZ+FmYesLupFBiXXDLf95zGgrYV4VsmJ+Q32LpdUKs6WZ
         NymcRa6A29h5QSBn2teQ2a3KUhtg7jZ8GawJIJXimmnSqK8tLqecG/OGuat+0pztuATS
         xM2g==
X-Gm-Message-State: APjAAAVmoTDU/p7RFet9GxkFAWxI1Pl3lIzu7uOod8OgEApYRNATgfYH
        e9NkR1kJD7QKfClLr24HdC7YGg==
X-Google-Smtp-Source: APXvYqxZzUWYmeyGTOdNHNdQqyfh/0yNWQhXvLJcfGWRP0OmNV80jIDw6gnY21f2aWVRkmZN/Mr+iA==
X-Received: by 2002:ac8:2e16:: with SMTP id r22mr8103513qta.384.1551918462926;
        Wed, 06 Mar 2019 16:27:42 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y125sm1818592qkd.49.2019.03.06.16.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:27:42 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        bvanassche@acm.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] workqueue: fix a memory leak in wq->lock_name
Date:   Wed,  6 Mar 2019 19:27:31 -0500
Message-Id: <20190307002731.47371-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for
workqueues") introduced a memory leak as wq_free_lockdep() calls
kfree(wq->lock_name) but wq_init_lockdep() does not point wq->lock_name
to the newly allocated slab object. This can be reproduced by running
LTP fallocate04 followed by oom01 tests.

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

Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e163e7a7f5e5..ade0d47ec086 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3348,6 +3348,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 	lock_name = kasprintf(GFP_KERNEL, "%s%s", "(wq_completion)", wq->name);
 	if (!lock_name)
 		lock_name = wq->name;
+
+	wq->lock_name = lock_name;
 	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
 }
 
-- 
2.17.2 (Apple Git-113)

