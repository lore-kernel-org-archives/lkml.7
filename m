Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AD4206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuPDQ31J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfLaPQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33635 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLaPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so1954385wmd.0;
        Tue, 31 Dec 2019 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQMSEdRQ4ekpdJKwbIsHv9YNIyDhx2awGDRf3GaLUoA=;
        b=MuPDQ31JAsnaUbWu33M5qr81ER4QFiw8/4Mukj7bEgn1qiImA316a/iR2mH02cV6bU
         Mu8BaaHO5CZVQAJpP3PcUhu36H+yL4ai65XuD0Q1aVU5J0k3t8GOiPzi7P+xuRvpPiyH
         MTBCccF4MSHKcbDSFzxU0JVu8YmXx83fO3UQEtn2L1GYICZUy5cdWbmArwpzFxodwW8q
         3Am37j6iixnIdQpx903s0yoGEQyVd3OWvNeH7KNS1dZpAGXjywZcJO4CEJ+EaDmOUCsR
         kcR9Mq9FaHKIuYAfWbDYO5sP5EeLKfFlFZS23DAKYMcn0wuQAkKYSkB8MqG19as9ZAeS
         Bt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TQMSEdRQ4ekpdJKwbIsHv9YNIyDhx2awGDRf3GaLUoA=;
        b=H3RAxkxrWzFXX1yyPHkMsnSq1CIDocF3nzu0Xkrs/g16pcjiC3BOdBp7WzTfCVMvdw
         LRX8mT2twwc5BczYfz7uaAbT3aWu+ixJdEcYy4Fen5pd/9jo9eoTNqPuNIe5oVy92MSS
         WQgPPb5fqRCYHBzEjr58qZSoAAs1y0f1hxILCgR4ZuZibSSHGam05v+y/TV0N4RH17hx
         pcH2k5bmKHTK2IN2ttbrPqgeKR7H8qjuAX05wO2sDwQqgVEXccAMtYfj3eiiIY26x3wn
         +a926cLIDe5h38j7jeOwLpVcTHZTxunS6+fV6quTuwfws0PkEuftddzf6wuCQfWSBQf/
         Nzpw==
X-Gm-Message-State: APjAAAXo/yB5eq8Ee5wtod77+cSOXPi8Abr16wI0Nb2mbGXITpIHXFTJ
        7vishgAioTR7Ey/qTwdREXY=
X-Google-Smtp-Source: APXvYqwzosLGiFO8h5oGTKEN3V9jiDhs5PrmLw3JN1QdbUc2cga+BAGy/PJs8U5iBzBam6xXgWVPNg==
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr4770427wmc.63.1577805368677;
        Tue, 31 Dec 2019 07:16:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:08 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 7/7] rcu: Fix typos in beginning comments
Date:   Tue, 31 Dec 2019 16:15:49 +0100
Message-Id: <20191231151549.12797-8-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 kernel/rcu/srcutree.c | 2 +-
 kernel/rcu/tree.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 119a37319e67..a0892a9e2bf7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -5,7 +5,7 @@
  * Copyright (C) IBM Corporation, 2006
  * Copyright (C) Fujitsu, 2012
  *
- * Author: Paul McKenney <paulmck@linux.ibm.com>
+ * Authors: Paul McKenney <paulmck@linux.ibm.com>
  *	   Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * For detailed explanation of Read-Copy Update mechanism see -
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48fba2257748..ab7cbe71f57b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Read-Copy Update mechanism for mutual exclusion
+ * Read-Copy Update mechanism for mutual exclusion (tree-based version)
  *
  * Copyright IBM Corporation, 2008
  *
  * Authors: Dipankar Sarma <dipankar@in.ibm.com>
  *	    Manfred Spraul <manfred@colorfullife.com>
- *	    Paul E. McKenney <paulmck@linux.ibm.com> Hierarchical version
+ *	    Paul E. McKenney <paulmck@linux.ibm.com>
  *
  * Based on the original work by Paul McKenney <paulmck@linux.ibm.com>
  * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
-- 
2.17.1

