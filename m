Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB919C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B120721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421041;
	bh=NouXRorkRrtpgDixB7XImri5OC4Rykp1q93l1bDDyYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ay3PMuMHfcEhdP82wCeK/vbPf8vZ8U9FGQiC94gbVkrkiSSmiVlUl6cgq30X0My0I
	 JHnu6mMDa5/Kt0jzYCbzD3hWrSHwbsKb79Zu/Hk6s0l+ihmIz7NWSCBme/Ba/Zjly8
	 C4U9uhawRzyhRrvQAwhtM9jZg9V4KjfXN425WOl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfKVLCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbfKVLBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B1662075B;
        Fri, 22 Nov 2019 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420513;
        bh=NouXRorkRrtpgDixB7XImri5OC4Rykp1q93l1bDDyYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLzhQjLLAt00qdlhhvWjWMB7H4w/LpnzIvnEWXRNmxOYOhXVZaQv2ajCp600zYBSH
         QSN1/jWHaKshpxXCwNUKvMD/7EUgH3RTycrI1dDIgbqUFx2EcpXUzpYga+PPykouFx
         EqzZY4WSYFYInEhX68gvZ78zADDtvfLln/YbIg1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 133/220] soc: fsl: bman_portals: defer probe after bmans probe
Date:   Fri, 22 Nov 2019 11:28:18 +0100
Message-Id: <20191122100922.385676732@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit e0940b34c40e95d1879691d2474d182c57aae0de ]

A crash in bman portal probing could not be triggered (as is the case
with qman portals) but it does make calls [1] into the bman driver so
lets make sure the bman portal probing happens after bman's.

[1]  bman_p_irqsource_add() (in bman) called by:
       init_pcfg() called by:
         bman_portal_probe()

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/bman_portal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 2f71f7df3465a..f9edd28894fda 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -91,7 +91,15 @@ static int bman_portal_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct bm_portal_config *pcfg;
 	struct resource *addr_phys[2];
-	int irq, cpu;
+	int irq, cpu, err;
+
+	err = bman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to bman probe error\n");
+		return -ENODEV;
+	}
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
 	if (!pcfg)
-- 
2.20.1



