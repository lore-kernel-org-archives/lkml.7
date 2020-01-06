Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D1C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC6C207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA6IdBet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAFUI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37428 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAFUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so16694826wmf.2;
        Mon, 06 Jan 2020 12:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMlKp3ev1x2XPXq9CetuB6Y7JBfofMSKvZYLO3FiZ5E=;
        b=jA6IdBet6s7DXM+jYBraigJskXYhijxZ8PfnfbVznbo1WuULBtNsetuhIbFdmjRBRW
         hB7nO4XeCG/fV+vhTqMuNLVxivKSo8ZgfLJFww7IEcJVlJ757bwcMpr3/OMxjMTYuvat
         rP/aa4KnVwYPcZnG3XLUPuQ1t6HVwJ5u9cLFIQFxphEYlZIZzH88cY/MzvGuyr2NJH9f
         yvWuG7XWW50Y/DNfwTWLjwTpickorHpB2+E0ODdlDPPkln9dVhVq6LN4KV8BSf+C+LtE
         RpSDpJRdwygXCZbwTxQ2hHnOwsLJ6Oiusxv9DeZrZnJsc9q+L3wvlt33eFfWl0e8w3xL
         rvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMlKp3ev1x2XPXq9CetuB6Y7JBfofMSKvZYLO3FiZ5E=;
        b=IRILw6ObJkOD7TxBIaheRdNwGRWqrjHVvc9uciAdwqpUDUnk3f8LaRcpxTZZCCjrew
         vHRhtLSME3xqRAowqwbN6baBO/ziWOmKQ/G5/o23BBTyShGcpirDWY3nwaITW+/oUSm+
         IpF6yviqOFjZIFVTYdcORsPMc2jdDhL2XYavCNkbWNre/qIV1L1VMnm5D8YxChWsiz2E
         KflCjrHS56Q28v2HKi9L7zuxziM7TQUBDv7D9cMiu/eoBof16um9/TzIvcEtProhEhjc
         1JxAh26NuFCZZKzWZbMgdpHS3G/NUsCyozvnAccp7md8bf7lleulInP3mSu91pvTxOpO
         eC7Q==
X-Gm-Message-State: APjAAAWS1VUi/E61DMTmxOoJ26naDUA2nyNeqJyDqM2Aa//rQJhPE7UI
        wSciIaUItYkWDU3diEhlW3SG6PAN
X-Google-Smtp-Source: APXvYqz6VrmhOPo6/TRiqQQ+vWsQy6RvuDmgv2pD1zNUwWIP3Bld5CMqeOl5yJLCLBDXXX9tkgdvmw==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr37439837wmk.116.1578341304605;
        Mon, 06 Jan 2020 12:08:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:24 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 1/7] doc/RCU/Design: Remove remaining HTML tags in ReST files
Date:   Mon,  6 Jan 2020 21:07:56 +0100
Message-Id: <20200106200802.26994-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
References: <20200106200802.26994-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit ccc9971e2147 ("docs: rcu: convert some articles from html to
ReST") has converted a few of html RCU docs into ReST files, but a few
of html tags which not supported on rst is remaining.  This commit
converts those to ReST appropriate alternatives.

Reviewed-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 1a8b129cfc04..83ae3b79a643 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -4,7 +4,7 @@ A Tour Through TREE_RCU's Grace-Period Memory Ordering
 
 August 8, 2017
 
-This article was contributed by Paul E.&nbsp;McKenney
+This article was contributed by Paul E. McKenney
 
 Introduction
 ============
@@ -48,7 +48,7 @@ Tree RCU Grace Period Memory Ordering Building Blocks
 
 The workhorse for RCU's grace-period memory ordering is the
 critical section for the ``rcu_node`` structure's
-``-&gt;lock``. These critical sections use helper functions for lock
+``->lock``. These critical sections use helper functions for lock
 acquisition, including ``raw_spin_lock_rcu_node()``,
 ``raw_spin_lock_irq_rcu_node()``, and ``raw_spin_lock_irqsave_rcu_node()``.
 Their lock-release counterparts are ``raw_spin_unlock_rcu_node()``,
@@ -102,9 +102,9 @@ lock-acquisition and lock-release functions::
    23   r3 = READ_ONCE(x);
    24 }
    25
-   26 WARN_ON(r1 == 0 &amp;&amp; r2 == 0 &amp;&amp; r3 == 0);
+   26 WARN_ON(r1 == 0 && r2 == 0 && r3 == 0);
 
-The ``WARN_ON()`` is evaluated at &ldquo;the end of time&rdquo;,
+The ``WARN_ON()`` is evaluated at "the end of time",
 after all changes have propagated throughout the system.
 Without the ``smp_mb__after_unlock_lock()`` provided by the
 acquisition functions, this ``WARN_ON()`` could trigger, for example
-- 
2.17.1

