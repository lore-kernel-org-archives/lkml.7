Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CC0208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq/smi/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfF1JRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35584 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfF1JRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so2914602plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tl73hYl5gKy5NVWCsPlgxExT56GrT/ZBXkBZb3kkx+8=;
        b=eq/smi/E4EJ5mcJyPN8BL67wvWv1GW9zKa8SbsyBdaist7qPlUkGBRpm9Mt44vqX1c
         czo0GytdQQefimo9rdmROBaIK8tbBv3Lg6evlx0gcHp8t/kD7JO55WOcU2nswCyyeWjs
         Ah7Ik3z/C/6RLxfdH9ZPG5eoV6u2jneNtx+AmrJ37LL/TexAxY1I8dlw8HogoS/dqe/u
         sUSf9NEVLeeFY+QxjcTI/FJYtg0aLITDwR/Q9ZZlS6bQTds8oIKzZd0uXQFdGA7Ja1h7
         Dxx3hGBHrtfmxsFq33mViMaRwlST83gQf13j3agr5UwClsnSXG1xcel5ha9MeI3gEXXn
         1FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tl73hYl5gKy5NVWCsPlgxExT56GrT/ZBXkBZb3kkx+8=;
        b=NYHQUyVjNx/swbQPK8srmiJmNQwLPDUMuUuGRskslNqeGRkeKSVtA2G7h2mSaqc/gP
         /AqNRsV+X2BWnU0MPsZWgsidOfQDnGryH/REOWuXQP2zweP/iOQ74KRf8ztlevx6f5e8
         KGoDpIM1lfNcpailr7WFmuRBZ5QzYPX9BTCv5hHBS2yGi25wQbE08xImUmwnu//gZV/B
         uh6wjH/xUj1fC0tR5LGMi9e6om7daZEhcMkXhHv6D6r6Zl2EV+TkReGI8SwKgLYX9k/E
         C8RtWph7FPk/Vyl4PK6eoxeZawDr2S4JwTr9BxpeY9+cMlhG/54+0xxCiVEsUqEOT2w9
         Rzzw==
X-Gm-Message-State: APjAAAXBXbxVyTFwcnTm0huycFbvplBOl8p2dGC1+grY059gFl9APgO4
        bw3paqU9edUGpMFXHZDn4xQ=
X-Google-Smtp-Source: APXvYqx5NURtyDLy4YbsY3fAAopEXlVgZGlizbr4tN7DNdsRYJmZ0G933o++gTARYMTzT6qrYyE5+g==
X-Received: by 2002:a17:902:d897:: with SMTP id b23mr9877110plz.250.1561713458613;
        Fri, 28 Jun 2019 02:17:38 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:38 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 26/30] locking/lockdep: Add lock exclusiveness table
Date:   Fri, 28 Jun 2019 17:15:24 +0800
Message-Id: <20190628091528.17059-27-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock exclusiveness table gathers the information about whether two lock
acquisitions for the same lock instance can be granted concurrently.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cb3a1d3..e11ffab 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -894,6 +894,36 @@ static bool class_lock_list_valid(struct lock_class *c, int forward)
 #ifdef CONFIG_PROVE_LOCKING
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
+
+/*
+ * Lock exclusiveness table.
+ *
+ * With lock X.A and X.B (X.A is on top and X.B is on bottom):
+ *
+ *   T1        TB                        T1        TB
+ *   --        --                        --        --
+ *
+ *   X.A                   or                      X.A
+ *             X.B                       X.B
+ *
+ * in the table Yes means the two locks are exclusive and No otherwise.
+ *
+ * +---------------------+------------+-----------+---------------------+
+ * |     X.A vs. X.B     | Write lock | Read lock | Recursive-read lock |
+ * +---------------------+------------+-----------+---------------------+
+ * |      Write lock     |     Yes    |    Yes    |         Yes         |
+ * +---------------------+------------+-----------+---------------------+
+ * |      Read lock      |     Yes    |    Yes    |         No          |
+ * +---------------------+------------+-----------+---------------------+
+ * | Recursive-read lock |     Yes    |    Yes    |         No          |
+ * +---------------------+------------+-----------+---------------------+
+ *
+ */
+static int lock_excl_table[3][3] = {
+	{1, 1, 1},	/* Write lock vs. X.B */
+	{1, 1, 0},	/* Read lock vs. X.B */
+	{1, 1, 0},	/* Recursive-read lock vs. X.B */
+};
 #endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
-- 
1.8.3.1

