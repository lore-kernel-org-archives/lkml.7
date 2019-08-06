Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E3B218B6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565076952;
	bh=fZBRJKmjxvcp/mQzzUacJDHRPt54CTE5Q/sgx3Ed5sE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1d1TmO+ias3q46+GTifZDxMU4bgj6lt20ZsVYzCJJ+paalw6d+I5TxZxehqk0GsOZ
	 Fpkr6rE6oDzNKWjZE3mX6Nhr50OUakyUmi6Kudm+epEdG69+M/TLAUsk6ZH7KRNx01
	 ToBnpUPG8Y/0O2a29XVxwD0H3hAx/KkN2kCVE+H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfHFHfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbfHFHfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:35:50 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2728A2189F;
        Tue,  6 Aug 2019 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565076949;
        bh=fZBRJKmjxvcp/mQzzUacJDHRPt54CTE5Q/sgx3Ed5sE=;
        h=From:To:Cc:Subject:Date:From;
        b=ot83vAf2vvFym5JdA92jT4XYOtvT3mNdwKTE4UHLl+TBHcisvQfnag0/rr1tjZmSr
         fcHLl5FoV8+r7lDIFeOhmJq791dM697zoERPimM4agMxjV1/RnQM7rWbfjTN5Ctiyk
         0AMAtFqd2tla77qIXU0E+tTpNfSjicIZsRRKtLfA=
Received: by wens.tw (Postfix, from userid 1000)
        id 5FACD5FC97; Tue,  6 Aug 2019 15:35:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: sun4i-emac: Support phy-handle property for finding PHYs
Date:   Tue,  6 Aug 2019 15:35:39 +0800
Message-Id: <20190806073539.32519-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The sun4i-emac uses the "phy" property to find the PHY it's supposed to
use. This property was deprecated in favor of "phy-handle" in commit
8c5b09447625 ("dt-bindings: net: sun4i-emac: Convert the binding to a
schemas").

Add support for this new property name, and fall back to the old one in
case the device tree hasn't been updated.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

The aforementioned commit is in v5.3-rc1. It would be nice to have the
driver fix in the same release. In addition, an update for the device
tree has been queued up for v5.4, which made us realize the driver needs
an update.

---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 3434730a7699..0537df06a9b5 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -860,7 +860,9 @@ static int emac_probe(struct platform_device *pdev)
 		goto out_clk_disable_unprepare;
 	}
 
-	db->phy_node = of_parse_phandle(np, "phy", 0);
+	db->phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (!db->phy_node)
+		db->phy_node = of_parse_phandle(np, "phy", 0);
 	if (!db->phy_node) {
 		dev_err(&pdev->dev, "no associated PHY\n");
 		ret = -ENODEV;
-- 
2.20.1

