Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E931C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403F220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367960;
	bh=QsesaWgoOeFN4HurJ2gWE+mKWQxKhEthzNyFeKttoe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lMs3AbK/waY6EC+5ryJHw6jeouzrvnmSDu8Og28nweZ9PzSOloCS5eXD1qgVP+CPe
	 BnMQsjQmdUCRqp1oEt4inSVbXQ9X9v6sXZXiOG9hAEumfTcpyoKKLzUfGz2u3GnyZX
	 kx0CbLQvA5k+/aylf1N+e1kOLoFnnu0zL+CvdNSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfB1Pci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbfB1PI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B47218D8;
        Thu, 28 Feb 2019 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366537;
        bh=QsesaWgoOeFN4HurJ2gWE+mKWQxKhEthzNyFeKttoe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpQu9/UpRxGqsnKl43Nl0ETAG6Q4C9cFnohyfU95OT8Bfbl48Cl1DHBORBF+u+Yfp
         slGH+1An32d0z2GMCKvM+Y18ldLBphRQFLx5BiDhDgVE7c2Eal+rEKXOc4msATDq8K
         bjisqvozdlzZMEjo+XLwnCEfutXz2KlP9pLy0Z5w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 27/81] usb: dwc3: exynos: Fix error handling of clk_prepare_enable
Date:   Thu, 28 Feb 2019 10:07:19 -0500
Message-Id: <20190228150813.10256-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 512e6fb589bc18f9321457632e89b95017447db9 ]

If clk_prepare_enable() fails in dwc3_exynos_probe() or in
dwc3_exynos_resume(), exynos->clks[0] is left undisabled
because of usage preincrement in while condition.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 9f2168367a0a ("usb: dwc3: exynos: Rework clock handling and prepare for new variants")
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index cb7fcd7c0ad84..c1e9ea621f413 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -78,7 +78,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (i-- > 0)
 				clk_disable_unprepare(exynos->clks[i]);
 			return ret;
 		}
@@ -223,7 +223,7 @@ static int dwc3_exynos_resume(struct device *dev)
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (i-- > 0)
 				clk_disable_unprepare(exynos->clks[i]);
 			return ret;
 		}
-- 
2.19.1

