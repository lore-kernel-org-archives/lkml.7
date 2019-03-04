Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472B2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688377;
	bh=AcM+52PJ8LpebDmnd133vidvAdk0oCCVsQvB4zWvtF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gkEuT1h0DWh29geVhmufnQSxJHiduVtUc0Zq182n+KapsWMTmldmuuxRW8MSG1DgL
	 JhwYLj4LNoV1cXLpJjKdgIm8AZr0eTqynB2bxdMJVwdiAv7RGi9eg7W0bbHm3VuGum
	 rYc5UgMAk4x9hcV81k7mZ5YT63MuWxHkan7m/G1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCDIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfCDIcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 173A121019;
        Mon,  4 Mar 2019 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688372;
        bh=AcM+52PJ8LpebDmnd133vidvAdk0oCCVsQvB4zWvtF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csRDxwGzRUCzd2gurtarogRNsZmUPZCg3ZW1EMilsUlGsrihH3yvrZF1aN7rir8jQ
         vRSrFT0J5TEIY4nsAV6PAbV1qbVEWvuFW7FVhb/aYusatkSy9PA6Oceq1ROuNK4GxI
         rMO1S+U+bjGv9zbEP4ol9KiUQKS+gge4lPzNRhSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 25/88] phy: ath79-usb: Fix the power on error path
Date:   Mon,  4 Mar 2019 09:22:08 +0100
Message-Id: <20190304081631.605406155@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

[ Upstream commit 009808154c69c48d5b41fc8cf5ad5ab5704efd8f ]

In the power on function the error path doesn't return the suspend
override to its proper state. It should should deassert this reset
line to enable the suspend override.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-ath79-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-ath79-usb.c b/drivers/phy/qualcomm/phy-ath79-usb.c
index 6fd6e07ab345f..f7d64f3910b4d 100644
--- a/drivers/phy/qualcomm/phy-ath79-usb.c
+++ b/drivers/phy/qualcomm/phy-ath79-usb.c
@@ -31,7 +31,7 @@ static int ath79_usb_phy_power_on(struct phy *phy)
 
 	err = reset_control_deassert(priv->reset);
 	if (err && priv->no_suspend_override)
-		reset_control_assert(priv->no_suspend_override);
+		reset_control_deassert(priv->no_suspend_override);
 
 	return err;
 }
-- 
2.19.1



