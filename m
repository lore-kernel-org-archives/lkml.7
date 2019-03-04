Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1541FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D731120836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688242;
	bh=xLLfwL/JRyLWV74Ty0se4q674jPUBq2rrKsLt/cODsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUu2f2iUsGvLgRINIxCOCIyWr4X33v/HvKf8odOzlombjPZRHB4qtC6mz8eaTN9m6
	 bQGx88n0qVx6MwmMVz64RlAE3QBdyzb3hdMym4b67wMxBTRC93j5ZOxk0TbYdA6ihS
	 p5ZjarPi8NOsDmFbQDsi8jYJ3y9iKZ5Q9I1EEEZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCDIal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfCDIai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A5A920823;
        Mon,  4 Mar 2019 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688237;
        bh=xLLfwL/JRyLWV74Ty0se4q674jPUBq2rrKsLt/cODsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fhem8l5r5iAzTRKwQC9M2DVY57/dD43YRBakxHa6CV/Z7bMCIEmigUDvFdXLtUMzz
         3F8h6qwZed4l11l5/CrLVNWSSTM5iugRwnG7zoIPEv1qi8ZbDIRZWXKu8VUdGMuI08
         8SkHnxpdyMckGiINCuf5SdPxuHR2ZNdKEeWCRX/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/78] phy: ath79-usb: Fix the power on error path
Date:   Mon,  4 Mar 2019 09:22:08 +0100
Message-Id: <20190304081626.632499835@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



