Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC60C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D721BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778784;
	bh=r0VppsRO05cODlZfjJkNWNlLDib6ImkdtE/4yky8mDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=md/zY6d6m3/qQdPgfY6IeXm1UXwnzIQjtoi516CjgU0IvuUktqdyK0zuCuf9LQzLw
	 lmGxVn2Id6VEeQcVkC83OBJdEgtSbp4V9+5SE4yS8byGEgWxhxdlzU3jJ0sgtGNw4w
	 GKJgU57Bii7Lf76vS8eshZEcB766nkUR3BOSmod0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfI2RfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfI2Re6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:34:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1DF121928;
        Sun, 29 Sep 2019 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778497;
        bh=r0VppsRO05cODlZfjJkNWNlLDib6ImkdtE/4yky8mDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQCaLksqjj/pmSI1vAnYIuh2OYPxG9CpN+7b7BWacJHcc/cICoe2gpQtNNNJnbCzZ
         4+QEU03V+Ec6ZorLyxZSnuONAEXMXKgwIwqCh1jiYbLrPrg82f9g6GjTDmT/Bmmq+9
         jtSZrq6i6LV6E/9SA/Fe9S8vhPB+qEbw3t+dk6Ck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/33] PCI: histb: Propagate errors for optional regulators
Date:   Sun, 29 Sep 2019 13:34:06 -0400
Message-Id: <20190929173424.9361-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173424.9361-1-sashal@kernel.org>
References: <20190929173424.9361-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 8f9e1641ba445437095411d9fda2324121110d5d ]

regulator_get_optional() can fail for a number of reasons besides probe
deferral. It can for example return -ENOMEM if it runs out of memory as
it tries to allocate data structures. Propagating only -EPROBE_DEFER is
problematic because it results in these legitimately fatal errors being
treated as "regulator not specified in DT".

What we really want is to ignore the optional regulators only if they
have not been specified in DT. regulator_get_optional() returns -ENODEV
in this case, so that's the special case that we need to handle. So we
propagate all errors, except -ENODEV, so that real failures will still
cause the driver to fail probe.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-histb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 7b32e619b959c..a3489839a8fc3 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -340,8 +340,8 @@ static int histb_pcie_probe(struct platform_device *pdev)
 
 	hipcie->vpcie = devm_regulator_get_optional(dev, "vpcie");
 	if (IS_ERR(hipcie->vpcie)) {
-		if (PTR_ERR(hipcie->vpcie) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(hipcie->vpcie) != -ENODEV)
+			return PTR_ERR(hipcie->vpcie);
 		hipcie->vpcie = NULL;
 	}
 
-- 
2.20.1

