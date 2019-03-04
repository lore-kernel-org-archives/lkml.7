Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36567C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CF3208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688380;
	bh=TWnESuYNSwv+mx5WWScK5MwCBxYS15jdX4RqBP3tmuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+MqE01i+wUfwFyN9wiQKouSkcUIrPuKJx1dIQQ8tdioM6xM3uY7ijwPv7LWMUYE0
	 GZqpIX14iA+NMbt1iLiTa/maEkZYNv53FiujwK/VU2ls3BzNaq4Q514PbMgo5YdGsm
	 GfeFIVbTGb5OJGCIDurEMH6dcslGfm6gFV6wV0Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCDIc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfCDIc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E051208E4;
        Mon,  4 Mar 2019 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688376;
        bh=TWnESuYNSwv+mx5WWScK5MwCBxYS15jdX4RqBP3tmuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nS/XPSWM24VKW3BfVU8pGopGCgqj2vEQhkkbGVqJ7fmBkiNSxeMge9mTd4KDT/+Cp
         XzcHrxdhUbnWdOtPpQc7bhJoJGvzoZv1SDlQCBW3rmIksIYPdmZsXWm9Dhzs1Zpw1L
         J1ai6qCk+PPI3DdvSr6DZwxSeTiB+Rgqm69QTZdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 26/88] phy: ath79-usb: Fix the main reset name to match the DT binding
Date:   Mon,  4 Mar 2019 09:22:09 +0100
Message-Id: <20190304081631.643752471@linuxfoundation.org>
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

[ Upstream commit 827cb0323928952c0db9515aba9d534fb1285b3f ]

I submitted this driver several times before it got accepted. The
first series hasn't been accepted but the DTS binding did made it.
I then made a second series that added generic reset support to the
PHY core, this in turn required a change to the DT binding. This
second series seemed to have been ignored, so I did a third one
without the change to the PHY core and the DT binding update, and this
last attempt finally made it.

But two months later the DT binding update from the second series has
been integrated too. So now the driver doesn't match the binding and
the only DTS using it. This patch fix the driver to match the new
binding.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-ath79-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-ath79-usb.c b/drivers/phy/qualcomm/phy-ath79-usb.c
index f7d64f3910b4d..09a77e556eceb 100644
--- a/drivers/phy/qualcomm/phy-ath79-usb.c
+++ b/drivers/phy/qualcomm/phy-ath79-usb.c
@@ -69,7 +69,7 @@ static int ath79_usb_phy_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->reset = devm_reset_control_get(&pdev->dev, "usb-phy");
+	priv->reset = devm_reset_control_get(&pdev->dev, "phy");
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
 
-- 
2.19.1



