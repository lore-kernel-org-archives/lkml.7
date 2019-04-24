Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CA32175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETNqxi47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfDXKVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40104 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfDXKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so9165473pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdQQqD+D5SVNRXrIoNn1Xj9jq/lMLPa5FtY9TZa9L2k=;
        b=ETNqxi47ZUZmJRnKK9t6vb+3QWKME4t1iuVeal4DrxOcREiT6dcFbs0+2XtHF0Kik3
         Y+diHWzsUuHsk5407qHFFhbsQWiHGAJsr/k8aY0ZG5CgLamOmCpk9+U9BDvKUs1trHqK
         f74RXqf4z6Hmr9Kd9K+U4StyL9eejJZ5iwR/tMzwaU6qbwHjZeozggexUwnujeo6QLAY
         3A1TbB1pHPV3q+2+w8gfEIDmbojmPSpDHMTFvgrAUxZYBN/jOubXExp8DDFCE30j3Oux
         XgdOMK9Q9coYjU/zBoaGvxZRVtb05x0Anuz53/vmCaXJ4WKFzZUWabV2oi18X9Q9YljB
         nq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdQQqD+D5SVNRXrIoNn1Xj9jq/lMLPa5FtY9TZa9L2k=;
        b=GtusQZRZMHm6ankBB7xvBtrXKzXCriG4bEVtUjgIhgvl3NBU5275GLLTipiMB8KGCq
         IJvA9HGQCdEahslaFY+QZGF8ii9PieXZ6hWvl+FAK1J5kaGaelIvPn3/QaVVuE4/hVij
         pFL1YzyLMrt4X43mbF1XPL6zU1Tb9JSBgzR2MiZgKIHdLS99PaGd0lR1l1YLBn8+ZKDR
         ErVrkK8lRt6jmzHsCeKftSU42WZXzlAxkiGNXqrXi9Aj24RZyBC5CmoUb6122Lg94nKX
         QgHc7hEQ/gp1/Pxr76jkV3OjVRjk3WdxAb4Fwfu2JQERkBjvNLz0FGKOv2vfndF9plDk
         abLQ==
X-Gm-Message-State: APjAAAV11q1ISxx/r9N6dNdTHw7PJ2tSGWcl2IQSHqh+x3m3+zCZ2pqh
        Kx2wSzM41G/6oBE3QoQZqghyAh/fdhc6gg==
X-Google-Smtp-Source: APXvYqx1SlcW0YrIqO6GOmG9alzcLu0o2wlNytDUhDhGFHqwJt9YuOEoS0vCzPnCfF4VDJH5Ypqx5A==
X-Received: by 2002:a65:6546:: with SMTP id a6mr6049907pgw.5.1556101276860;
        Wed, 24 Apr 2019 03:21:16 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:16 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 16/28] locking/lockdep: Add explanation to lock usage rules in lockdep design doc
Date:   Wed, 24 Apr 2019 18:19:22 +0800
Message-Id: <20190424101934.51535-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq usage and lock dependency rules that if violated a deacklock may
happen are explained in more detail.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index d5062fc..e1187d8 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -103,14 +103,24 @@ Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 Single-lock state rules:
 ------------------------
 
+A lock is irq-safe means it was ever used in an irq context, while a lock
+is irq-unsafe means it was ever acquired with irq enabled.
+
 A softirq-unsafe lock-class is automatically hardirq-unsafe as well. The
-following states are exclusive, and only one of them is allowed to be
-set for any lock-class:
+following states must be exclusive: only one of them is allowed to be set
+for any lock-class based on its usage:
+
+ <hardirq-safe> or <hardirq-unsafe>
+ <softirq-safe> or <softirq-unsafe>
 
- <hardirq-safe> and <hardirq-unsafe>
- <softirq-safe> and <softirq-unsafe>
+This is because if a lock can be used in irq context (irq-safe) then it
+cannot be ever acquired with irq enabled (irq-unsafe). Otherwise, a
+deadlock may happen. For example, in the scenario that after this lock
+was acquired but before released, if the context is interrupted this
+lock will be attempted to acquire twice, which creates a deadlock,
+referred to as lock recursion deadlock.
 
-The validator detects and reports lock usage that violate these
+The validator detects and reports lock usage that violates these
 single-lock state rules.
 
 Multi-lock dependency rules:
@@ -119,15 +129,18 @@ Multi-lock dependency rules:
 The same lock-class must not be acquired twice, because this could lead
 to lock recursion deadlocks.
 
-Furthermore, two locks may not be taken in different order:
+Furthermore, two locks can not be taken in inverse order:
 
  <L1> -> <L2>
  <L2> -> <L1>
 
-because this could lead to lock inversion deadlocks. (The validator
-finds such dependencies in arbitrary complexity, i.e. there can be any
-other locking sequence between the acquire-lock operations, the
-validator will still track all dependencies between locks.)
+because this could lead to a deadlock - referred to as lock inversion
+deadlock - as attempts to acquire the two locks form a circle which
+could lead to the two contexts waiting for each other permanently.  The
+validator will find such dependency circle in arbitrary complexity,
+i.e., there can be any other locking sequence between the acquire-lock
+operations; the validator will still find whether these locks can be
+acquired in a circular fashion.
 
 Furthermore, the following usage based lock dependencies are not allowed
 between any two lock-classes:
-- 
1.8.3.1

