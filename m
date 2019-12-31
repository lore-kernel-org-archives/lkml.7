Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7855D206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZhEl5l4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLaPQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2069509wmf.2;
        Tue, 31 Dec 2019 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OTaEoscjST+wQG0z7k1CEnJk1jN/Aw24bHq6v/U/FoM=;
        b=CZhEl5l4YqRlUQcPt7001CCV41zm2DCqktS7u9BCCHE5DTVhuSgO4L33rj1OfiG6Bn
         3V/kmAlZPw+kyBsr2L45PcvokmvUAPEYv8M6EBuNSY2no3rb/uN9Qgew/ksmpbwilZZi
         GUQk5UlJAl7Nl6WU07GTM94iOWgnp6ndNBMUCldvojEKISZP2UEQf9Gvo73F1uOWKBGL
         Hw64buyrrg86bUTGkORUs2CI2kQw5ekYOuIl76Txz4WQwUfWygk79jiFy8rE11AV16kN
         MjsBeJOwAnIZJYSroKOiHeiR6VvBobSNrqFWJV3qttC2vZY55mzJ/6EydnTWguGBTver
         7OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OTaEoscjST+wQG0z7k1CEnJk1jN/Aw24bHq6v/U/FoM=;
        b=D2VlTaFxS6GXvFZss6qlzeGfwwpE6ZMXQSuP4kquPDWJZNF37QTmoLIWZZijpbA04r
         7eqKsZXm4Xn9hiKxM/01xWbl+SMayXA1kqTqI6Ldj0KPadz3OpV+yz1OHvXUhf4ew5jZ
         8wKY5uhuaJ+YYZwPtcw6qo/JY3whO5iMSpLN7G4Do08Diu3mZ+XYwUIEpV3IX3yo/uuH
         bGWCsT8u60jYwGxZdptqw8v6rz7gvNaB13yNz1qPA1VW1AKA/3N5IKut++3LEqsLU9lD
         0lkvoGCgY6YOUAckHE+JWLR5jK88FZn94p/j8XUSedF/gncirMc0HcbmnI2A86g9Nvlg
         BQPA==
X-Gm-Message-State: APjAAAUTLL17OgpUwWy/tL8vh3AvOOkvbEjed+cJX133K3otoIZakTyo
        LSuCskGplWF6OqGmovpKa1Q=
X-Google-Smtp-Source: APXvYqzYjuLNbRfE2I/6LIoj8sh+lezHVsGaApwkb0RbZRpOhw4+gqGGBOvuY/9vh3ryJvXqNi53ug==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr4671480wml.138.1577805360815;
        Tue, 31 Dec 2019 07:16:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:00 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/7] doc/RCU/Design: Remove remaining HTML tags in ReST files
Date:   Tue, 31 Dec 2019 16:15:43 +0100
Message-Id: <20191231151549.12797-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit ccc9971e2147 ("docs: rcu: convert some articles from html to
ReST") has converted a few of html RCU docs into ReST files, but a few
of html tags which not supported on rst is remaining.  This commit
converts those to ReST appropriate alternatives.

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

