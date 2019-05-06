Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBD920C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWImtB0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfEFIUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43879 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so6081127pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NOZJz06iIRCGXlLr9ImLU7uuiwcKbj8jLWAPPlt+y4=;
        b=eWImtB0j069euBvCqWu+aRcqNqJzAGEaKoWhHutpsD7SVNtaVeMveRZWUfV3U/bk4f
         DoslaQYBQpiYVbu1stoyymxASqdjPEKef73uAqxYlB1HHL6vs9ues+3O0ZCSOIcp4xSR
         vr5bhqiEYImJvL5DbVOVNdPSaCXt73xA6qC/am98OU9Rbrgkcl/91Mt5H9+6k45P3Qbu
         sqO5A79ivIhNvR4Y9+X5FbEvMrc5NAOn1EjRYGt3hr7v5WmR/ckvXBf1XgywE/IaTido
         rZo/Omg7lYejOtFswvglAF62YOfp9FpYR5e1S4CHyNk6XOHYP5TQAYY7e50Nv8LaEwvw
         1I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NOZJz06iIRCGXlLr9ImLU7uuiwcKbj8jLWAPPlt+y4=;
        b=bHPtrwigQ1dizf/CwlSF5+AoKFcyOu0ItH9C0wt1aLSMRmyGOtaqX6L0IquoPvaTp5
         UFu/fCpYuA3dfdFOXkIwXLZuwDnHwN/4BqNPt3J4PPvcTnwSdVx+9ZA1vmef6+D6k722
         OqjTCXcOsM5/WtTGk0AVM9ZuA979fF6yGrHwMUOFPSfEHpMV3lAA8oN4kFIDTh7e2m7i
         UbONlY68MK5t34qo5SKy4nziOHU0dIQEfF5OB2l11LCKdMrgORwGJkYIPcOmYm4NcXww
         EUtvumEOe1MygtdVqIYPfYl+5wqevLcty5CiGxbKeu4Trl1mhwNfHa/iQxTId5i5D9ab
         xBBg==
X-Gm-Message-State: APjAAAUmlJWtT31/0yWYBMw3mx+X/pHz2s8rymBw9THrjyUDqlc1L0HF
        LL4tmDV8297sAvX8vAnjxk4=
X-Google-Smtp-Source: APXvYqzgDtatMOzp/bbniA7LAbisxRD6kx2cZKshptsapwFVqxhn2Z6+c7RfFTKZVkCmwm14jOvNPA==
X-Received: by 2002:a62:2b43:: with SMTP id r64mr31538455pfr.210.1557130805355;
        Mon, 06 May 2019 01:20:05 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:04 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 05/23] locking/lockdep: Print the right depth for chain key colission
Date:   Mon,  6 May 2019 16:19:21 +0800
Message-Id: <20190506081939.74287-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since chains are separated by irq context, so when printing a chain the
depth should be consistent with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a0837a0..222ee91 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2514,10 +2514,11 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 	struct held_lock *hlock;
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
-	int i;
+	int i = get_first_held_lock(curr, hlock_next);
 
-	printk("depth: %u\n", depth + 1);
-	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
-- 
1.8.3.1

