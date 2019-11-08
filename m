Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740AF20650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240427;
	bh=IpiSE2O0Qb0OJ2zh6eh0U9SBp/2HJbtPHFeAUgw+Whc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C20igWWR1XLD3s/PA0+L0QPVopToHlTQxYc/tlZf9cTjBBPwGRCi8LiJR7nuObZVk
	 yKTnHZe8uvAXsfN8BBBG+Cnz3xwiQ6lfGk+/27QsgTh8/s4QxW/BEQt4dBKFMitUM/
	 0D9TmP3Sv8nyqFLJOA2wXRCh01M3axgyyltWsDbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbfKHTNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:13:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbfKHTHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E0A2087E;
        Fri,  8 Nov 2019 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240031;
        bh=IpiSE2O0Qb0OJ2zh6eh0U9SBp/2HJbtPHFeAUgw+Whc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wNiJPyjytdMadfwE6GyNmou/itSDkx9F9x6Wj4Nfv8tALy87GiG5hiW9A28Pis4pB
         /ScnY9/q9LKdVc85FyIZkCUwDdj4cAwtl4FnK3d5iHv3whsiIBc5ajGJDCo6Q+Rb3W
         OSs8VAxlBtTtQ0ofeui5HjGzBfvvL6lQh5YL5LOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 028/140] pinctrl: stmfx: fix null pointer on remove
Date:   Fri,  8 Nov 2019 19:49:16 +0100
Message-Id: <20191108174905.323786238@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

[ Upstream commit 2fd215b8fdbe4d3a609adbe3a323696393cb1e53 ]

dev_get_platdata(&pdev->dev) returns a pointer on struct stmfx_pinctrl,
not on struct stmfx (platform_set_drvdata(pdev, pctl); in probe).
Pointer on struct stmfx is stored in driver data of pdev parent (in probe:
struct stmfx *stmfx = dev_get_drvdata(pdev->dev.parent);).

Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Link: https://lore.kernel.org/r/20191004122342.22018-1-amelie.delaunay@st.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 31b6e511670fc..b7c7f24699c96 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -697,7 +697,7 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 
 static int stmfx_pinctrl_remove(struct platform_device *pdev)
 {
-	struct stmfx *stmfx = dev_get_platdata(&pdev->dev);
+	struct stmfx *stmfx = dev_get_drvdata(pdev->dev.parent);
 
 	return stmfx_function_disable(stmfx,
 				      STMFX_FUNC_GPIO |
-- 
2.20.1



