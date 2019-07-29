Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F71C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5834206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429223;
	bh=H5VIOUyEePA3e7YILjunOmQC973IRxnSoT1mO4GezMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3NFhT78czTj4sXmms8Z/yDScHODfga/jUqpw+tLw/Yjs1sm6U3F149Iz3BH3lWiA
	 U04h88d8HQzZO/xWX/40E3X1FFf1IsayMKEx4VHSt8dHgE8bx85PRiCCvYeQZTWycD
	 0J361mEWTnPk3+IVuzUzYQB/USZ4+I96pJLkz2cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfG2TkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389133AbfG2TkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:40:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A621F21773;
        Mon, 29 Jul 2019 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429218;
        bh=H5VIOUyEePA3e7YILjunOmQC973IRxnSoT1mO4GezMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os29/b+1DlTp0uhJxn8q325B1bemEUbye6BuWHPwxZfLKLtnAQBMDHOY/kfjopKVA
         1e+xFaqfETviaPnAM/BzS6QACpvRkEUHvQBRVFWIIcFFdhEAinOVgruay6//pMMHXz
         E4JaDjgYjaU2ev7a2PW2KO7RsInVKtmeg8ujWF94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/113] phy: renesas: rcar-gen2: Fix memory leak at error paths
Date:   Mon, 29 Jul 2019 21:21:55 +0200
Message-Id: <20190729190702.607476799@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d4a36e82924d3305a17ac987a510f3902df5a4b2 ]

This patch fixes memory leak at error paths of the probe function.
In for_each_child_of_node, if the loop returns, the driver should
call of_put_node() before returns.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: 1233f59f745b237 ("phy: Renesas R-Car Gen2 PHY driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
index 97d4dd6ea924..aa02b19b7e0e 100644
--- a/drivers/phy/renesas/phy-rcar-gen2.c
+++ b/drivers/phy/renesas/phy-rcar-gen2.c
@@ -288,6 +288,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 		error = of_property_read_u32(np, "reg", &channel_num);
 		if (error || channel_num > 2) {
 			dev_err(dev, "Invalid \"reg\" property\n");
+			of_node_put(np);
 			return error;
 		}
 		channel->select_mask = select_mask[channel_num];
@@ -303,6 +304,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 						   &rcar_gen2_phy_ops);
 			if (IS_ERR(phy->phy)) {
 				dev_err(dev, "Failed to create PHY\n");
+				of_node_put(np);
 				return PTR_ERR(phy->phy);
 			}
 			phy_set_drvdata(phy->phy, phy);
-- 
2.20.1



