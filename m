Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2733EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F4D20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383821;
	bh=qGQ9HN8LkKwm6Kshzu4NmFigna+xkzLDeB9AZNaGBU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N21OQtklNOXEs2qeU23c0ACDPfV9XSOiJY/V836GvEbFdI7ucYpagUUPydGUcdnBc
	 X4q4+Zx3DA6/JbWRZcIihtCGFMrb8bQ8xw4wv72lLLeXGHVlTcXiByRD6D6jYKyLgg
	 YnNGcof4csJb0Jp1MstQwCEu73V64s6qL8teQrhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfJFRnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbfJFRnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:43:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F5B20862;
        Sun,  6 Oct 2019 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383816;
        bh=qGQ9HN8LkKwm6Kshzu4NmFigna+xkzLDeB9AZNaGBU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8ewF68drxDrLtZk0DOM9XqRjDRnf6paDaaoHXU0UyBGeKpR14g6AiXCMZjtocDCk
         93amsvzqgEk0HmgKPdcy7/bT+e8ZKiLMAosZckSKhog7pkPQWCkk3+mQ5aleceX+uV
         oatqw1ogRTNz2ax7S1lbytaPaAPu/GbfjqmMNckg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 106/166] PCI: histb: Propagate errors for optional regulators
Date:   Sun,  6 Oct 2019 19:21:12 +0200
Message-Id: <20191006171222.407845245@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 954bc2b74bbcd..811b5c6d62eae 100644
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



