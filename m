Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18891214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413899;
	bh=N8phW9uRuWNzNstu14eZkXH4bE3oClTHRGDjLZC56uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qw+c9hU/oikh14WVjCxffQGieUa9T6ds7QZzgiW558fJAme5kqDi0dP314DZsSxCC
	 NAKhFzsh9L/V4ZqkeGNw2sf/tiJzOwRnX71DKZifKY/l0qhPL5CUCS2z/9vdS0rjjM
	 EeXgRgUbzBwV0x0NlL076DQYhRCEyBki07kLWoIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfCLSEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfCLRMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:44 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8868206DF;
        Tue, 12 Mar 2019 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410763;
        bh=N8phW9uRuWNzNstu14eZkXH4bE3oClTHRGDjLZC56uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywc9Lly1LNYGgyHj8kaf3WLu2wwac0mg6rV/tcJ9szQIaxRKSv0OFgQqiR3HXXWIH
         yO/uutj9tpN6Gt3yJiU9RaexpLpW32wwpGXV7jvuP+0GjGMc4YAAliWcR5LjuGmntQ
         f7NZ9FjvYnLk1Dx9xlxS40ekfSUSQ6FeS1KdmbhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 097/171] usb: dwc3: exynos: Fix error handling of clk_prepare_enable
Date:   Tue, 12 Mar 2019 10:07:57 -0700
Message-Id: <20190312170356.346424616@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index cb7fcd7c0ad8..c1e9ea621f41 100644
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



