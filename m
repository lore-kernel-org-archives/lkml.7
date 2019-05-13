Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63782C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3208120989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvczDE4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfEMJNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34158 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfEMJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so6873542pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rp13RuRgS/joBmmO7IdXoXGX87CdLveBL2noqB/wsSo=;
        b=NvczDE4SkBK+La/gZ7IllQcuv5TpwSqpSVbXqQ4fwZdPA0tFiFv0uPmUjmYMwz/7pl
         DtiB1cGDc/Zsxs/PyN09UJAXJxJuTQ0eSa+BEhE5jy/VV9g4yjmb0h7upNfrgKHZocbG
         u22muNm4OtY7Xb3jr4cgOLLfn3AeTiJ+D4uYbIiRfKeaKJulPKTjovNc8k2/41KRy4zY
         04IQjTzjgQPfow0nNyXtJR5adkfsF1rWqNE7doODwO4tMH/gO9ss8tk2OUPul0gjZwSn
         sNijZpdbPD2YShwE1OvfRTMZ4wTAJnw0/+TUN4AwfRdYNx7ZdoLHWbTCY67Ml/LJk+ir
         WP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rp13RuRgS/joBmmO7IdXoXGX87CdLveBL2noqB/wsSo=;
        b=thWNaB6XUkA+mdRZCNPmRCTaQ3bRp4EhwXzMn5dNBFamIecA5J+J+gcvNtG9Ii+0jT
         anXtjGw4D640bD91JGTW57C5PGsE5pQfdOeLNSGSBN9Ph88OxrpJTvlTMGiVQoHaNoiW
         l2k5dNn3+Xj51unMRpRg47An4kkpcXRni0D+QTF2DXNhPMKp16U6FtQuIZlMdAr/abVY
         gHDo2LOFVx1eyNKtbDpzxQLLrMWL82M+sQdhoMzeUnSoKd+pLErkG+5kAasALcqCJsPM
         oWWolXSXD1WAciYkPtMIT3O/vgJQRx9ix0eUMRcjqxm8jCun0KD0YcdckkNvRTGhc9di
         OfXg==
X-Gm-Message-State: APjAAAUIE2DFXtcWXZuI1/dGuZ7rE2yVd88bCmjP4UbYx33LlcsH80rc
        s/Bc7TOS7G9U/D5M+bFAqiNdBWOTwh1IEg==
X-Google-Smtp-Source: APXvYqylVZqBQ/k16A/w4r//7ckco+EFoB1IB3k4Mskw3iBjm+NCoUaJuOV3b0giDJJcEaDOG5x90A==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr30142708pgc.140.1557738823854;
        Mon, 13 May 2019 02:13:43 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:43 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 08/17] locking/lockdep: Introduce chain_hlocks_type for held lock's read-write type
Date:   Mon, 13 May 2019 17:11:54 +0800
Message-Id: <20190513091203.7299-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock chain needs to include information about the read-write lock type. To
that end, introduce:

	chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS]

in addition to:

	chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS]

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a2d5148..0456f75 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -861,6 +861,7 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 
 #ifdef CONFIG_PROVE_LOCKING
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 #endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
@@ -2668,6 +2669,7 @@ static inline void inc_chains(void)
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2872,9 +2874,12 @@ static inline int add_chain_cache(struct task_struct *curr,
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
 			int lock_id = curr->held_locks[i].class_idx;
+			int lock_type = curr->held_locks[i].read;
 			chain_hlocks[chain->base + j] = lock_id;
+			chain_hlocks_type[chain->base + j] = lock_type;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
+		chain_hlocks_type[chain->base + j] = hlock->read;
 		nr_chain_hlocks += chain->depth;
 	} else {
 		if (!debug_locks_off_graph_unlock())
@@ -4824,6 +4829,9 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
 				(chain->base + chain->depth - i) *
 				sizeof(chain_hlocks[0]));
+			memmove(&chain_hlocks_type[i], &chain_hlocks_type[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks_type[0]));
 		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
@@ -5268,6 +5276,7 @@ void __init lockdep_init(void)
 		+ sizeof(lock_chains)
 		+ sizeof(lock_chains_in_use)
 		+ sizeof(chain_hlocks)
+		+ sizeof(chain_hlocks_type)
 #endif
 		) / 1024
 		);
-- 
1.8.3.1

