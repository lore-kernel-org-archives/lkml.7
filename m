Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57120C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204C222527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077489;
	bh=uTVJWRqB+hrVmymygwybQVOn/weF1+2ifA1NVusuY64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nuzIMC04jNrPQdTksprK4SoC3w3RjU9kAdxpJ+I24KrpBtzju/hver5h5/KnQpssX
	 SYdAffOWPsl6BJWvQ7gR+yUiVYAs5w/LDGN7HPqsN4IGUDdV3J8kO7EmIszRbB5oyz
	 5tsEEz72f4mCwafvZ0E2x5hLvmQ1SLXnmahZt9Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfLKPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732086AbfLKPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:18:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E2324671;
        Wed, 11 Dec 2019 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077482;
        bh=uTVJWRqB+hrVmymygwybQVOn/weF1+2ifA1NVusuY64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcwP1ahfOOLXV47aFHnphkQ641G1NMR1Sbm2HSkuW+Ds3OyzKGj+s+svPdFCRiolK
         cCSwPlzxhdjzYgkDzedmQFxwWtxb3y3dMcv7Nm9cI+oPF5UKMYUZ0hfSngeKKliloI
         Vi//fo9XrJ+2CSsGCD6lo0uq4hEzvF0k38FfWTQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/243] drivers: soc: Allow building the amlogic drivers without ARCH_MESON
Date:   Wed, 11 Dec 2019 16:03:37 +0100
Message-Id: <20191211150342.820041861@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

[ Upstream commit 41bb5769b7f4b7a85e4b92c37429228279b4f569 ]

The current condition makes it difficult to compile the amlogic/
drivers with COMPILE_TEST, or without ARCH_MESON in general.

Fixes kbuild errors with patch series that depend on drivers in that
directory, for instance the meson video decoder.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 113e884697fd8..f0d46b16e08c4 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
-obj-$(CONFIG_ARCH_MESON)	+= amlogic/
+obj-y				+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
-- 
2.20.1



