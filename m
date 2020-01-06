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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21AFC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C33207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9B1fpNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAFTTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37359 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgAFTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so38386504wru.4;
        Mon, 06 Jan 2020 11:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MutBRahz4Dk9dzENPsGVB9OQYLb4xC1rOEUgBqJ0GEk=;
        b=d9B1fpNkqJq5+eUoMZtQhrP3MSZAUGsSMxEeMySudr72P2UjGJPMCt8bx6oioKgQA1
         9LC7VcRZgoFcWM1da6Nn+7y7NlvTIx7ZFdC+tZj5tLQujvP+AfRmBCCyk5uXXUG7ZX/X
         M31W17IzRWtr5moeABKKPlsRe48ibYlPPtM/r+PcTI2pmhHWaKttTKT8f17+nj9PW5i8
         J46cQnhRu7qJCosGqzvCgqH22974/SZ31MUgKSQWMgZW/r2xXCxRMgTU4Hq28bcpZwRL
         tYT/apNptWRRUNN9KsOPMtVhZafHwsvIpAdwNkfEUBTJl7DOApbF8zbPBlbh87cCXwll
         jVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MutBRahz4Dk9dzENPsGVB9OQYLb4xC1rOEUgBqJ0GEk=;
        b=WH4LW/7g8zxirIRLveWmEDZeAdxlmk1UxQzo7exTXil4OVfQ6aQCJh7LXUPe2KMNmi
         yyrmBL13kNuxtdQ/bV8u7jIaptJwiNO0vIlOGRpGR2cPeMDSEAxkX8SMx/3RawuulDPM
         QvdZeGdobjFqzMEnTSduL1WXZQmf1+2RIdeSZBzdQrYhxQ8kQXjeZJpeAQRHCp3Vnheb
         RayaUMf12jY5n9lr3A2DgeZFWgADQ7GIW+dv1pUIVidlN8puZJKtu6DZ52PkvghDHzsg
         Yy6q4+i7cacXo09Tza9ezTcGprRZLcJO3ocphBPeQP0bbCaKUNfEt8roVzBIbpJoRJkt
         Nmsw==
X-Gm-Message-State: APjAAAW5dnE7x3yAgckM45SYj9+BQytFvBxsf7dFFgulOraI9+cJyq8/
        Kprl7iHCWqAmC24BTC2KhBw=
X-Google-Smtp-Source: APXvYqwlZ5zzi84esvG8qBqF310Lr4/splfRmNW7i3N+ELPuNB2m5ny4t5g4mswIDVD3sy/DlYT7Rw==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr104492337wrt.254.1578338351427;
        Mon, 06 Jan 2020 11:19:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:10 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 1/7] doc/RCU/Design: Remove remaining HTML tags in ReST files
Date:   Mon,  6 Jan 2020 20:18:46 +0100
Message-Id: <20200106191852.22973-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

