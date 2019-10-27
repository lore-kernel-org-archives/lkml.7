Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9855B208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210981;
	bh=3iJ3qKVbyTkIAzRYUW0YRonG/XHJgsleQiyTF+dZR08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j9igArytRSBeiX2D5W19nlm1H76gLhzSZQbr/j/NlzAvm8qVzyvTeQmV9t0vUI/Ut
	 W39WBndkuVkDvXFmpjo89AbeydzotM7pE8W+K5dBH/5s/0iW3o9EMnOn6wM/NpIFFL
	 FmTn6vY4w7p5M5o4l4GnknltXtlcdpxyfACE/GA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfJ0VQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbfJ0VQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:16:15 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D9B21783;
        Sun, 27 Oct 2019 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210975;
        bh=3iJ3qKVbyTkIAzRYUW0YRonG/XHJgsleQiyTF+dZR08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gORjVdwfPOqd/yJsWmH+mmvg2A/W8H/gMAinWQpa6Pz/vSTPy2tg4TZoyrzYcPLps
         oySJPsC9IjKS9ZiPExFnpynCWRhM7W+kTdzkK8x4tG1P6cdJ0Q0sVQEQVcG7odATCK
         4082dRGFYLhZDq9cu1Q81hy/xk3O+sDbBW4SzSWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 28/93] net: bcmgenet: Fix RGMII_MODE_EN value for GENET v1/2/3
Date:   Sun, 27 Oct 2019 22:00:40 +0100
Message-Id: <20191027203256.762646938@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit efb86fede98cdc70b674692ff617b1162f642c49 ]

The RGMII_MODE_EN bit value was 0 for GENET versions 1 through 3, and
became 6 for GENET v4 and above, account for that difference.

Fixes: aa09677cba42 ("net: bcmgenet: add MDIO routines")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |    1 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c   |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -369,6 +369,7 @@ struct bcmgenet_mib_counters {
 #define  EXT_PWR_DOWN_PHY_EN		(1 << 20)
 
 #define EXT_RGMII_OOB_CTRL		0x0C
+#define  RGMII_MODE_EN_V123		(1 << 0)
 #define  RGMII_LINK			(1 << 4)
 #define  OOB_DISABLE			(1 << 5)
 #define  RGMII_MODE_EN			(1 << 6)
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -261,7 +261,11 @@ int bcmgenet_mii_config(struct net_devic
 	 */
 	if (priv->ext_phy) {
 		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
-		reg |= RGMII_MODE_EN | id_mode_dis;
+		reg |= id_mode_dis;
+		if (GENET_IS_V1(priv) || GENET_IS_V2(priv) || GENET_IS_V3(priv))
+			reg |= RGMII_MODE_EN_V123;
+		else
+			reg |= RGMII_MODE_EN;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 	}
 


