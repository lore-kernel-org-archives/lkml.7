Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96682C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6550720665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfG3Jho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:37:44 -0400
Received: from foss.arm.com ([217.140.110.172]:58224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbfG3Jho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:37:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC528344;
        Tue, 30 Jul 2019 02:37:42 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 35E163F575;
        Tue, 30 Jul 2019 02:37:42 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 2/5] [UPDATED] coresight: Convert pr_warn to dev_warn for obsolete bindings
Date:   Tue, 30 Jul 2019 10:37:33 +0100
Message-Id: <20190730093733.31861-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729170035.GB26214@xps15>
References: <20190729170035.GB26214@xps15>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We warn the users of obsolete bindings in the DT for coresight replicator
and funnel drivers. However we use pr_warn_once() which doesn't give a clue
about which device it is bound to. Let us use dev_warn_once() to give the
context.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Changes since previous version:
 - Update replicator driver too.
---
 drivers/hwtracing/coresight/coresight-funnel.c     | 2 +-
 drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index fa97cb9ab4f9..84ca30f4e5ec 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -192,7 +192,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 
 	if (is_of_node(dev_fwnode(dev)) &&
 	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
-		pr_warn_once("Uses OBSOLETE CoreSight funnel binding\n");
+		dev_warn_once(dev, "Uses OBSOLETE CoreSight funnel binding\n");
 
 	desc.name = coresight_alloc_device_name(&funnel_devs, dev);
 	if (!desc.name)
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b7d6d59d56db..b29ba640eb25 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -184,7 +184,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
 
 	if (is_of_node(dev_fwnode(dev)) &&
 	    of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
-		pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
+		dev_warn_once(dev,
+			      "Uses OBSOLETE CoreSight replicator binding\n");
 
 	desc.name = coresight_alloc_device_name(&replicator_devs, dev);
 	if (!desc.name)
-- 
2.21.0

