Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEABC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2822067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947392;
	bh=xzhvNgPOnKLO2KBOGOD9nwNjAXRdz3y0dUwmmtZ1gOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdeXaECr6nZOPNLuyS0zm+3vXwxQ+jvqG3X80wX8cMbIJ6iIpJbrRvVfDeTp9nN+w
	 +Leh+t72IdXLFfn+gp0x3CQaadlfE4DhkAz+EZyuxU7gxoFNi/A9jon6TNR6Klvrf5
	 cD0FfIyb2RkKIFeTmKl4WNkLpSOE+wXwMRdDFGGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfIHM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731537AbfIHMtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6668218AF;
        Sun,  8 Sep 2019 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946972;
        bh=xzhvNgPOnKLO2KBOGOD9nwNjAXRdz3y0dUwmmtZ1gOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I26IUVBOHVSCMwZzyu8HtdeTMJ7rRXjo6l3gnEK696AAc6mRXxeTIf9ggtEfIA3Ob
         mkYv9zDSfkOlnBa24q2qTjglYAVnFgck9qP37hL8hl1yEVZoeGg4hyDL7VYi5RjSXd
         VqNP5OArYOzatL0dW+zRpdaGiF8mxh76ifRod53E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 05/94] net: stmmac: dwmac-rk: Dont fail if phy regulator is absent
Date:   Sun,  8 Sep 2019 13:41:01 +0100
Message-Id: <20190908121150.585264776@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 3b25528e1e355c803e73aa326ce657b5606cda73 ]

The devicetree binding lists the phy phy as optional. As such, the
driver should not bail out if it can't find a regulator. Instead it
should just skip the remaining regulator related code and continue
on normally.

Skip the remainder of phy_power_on() if a regulator supply isn't
available. This also gets rid of the bogus return code.

Fixes: 2e12f536635f ("net: stmmac: dwmac-rk: Use standard devicetree property for phy regulator")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1194,10 +1194,8 @@ static int phy_power_on(struct rk_priv_d
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo) {
-		dev_err(dev, "no regulator found\n");
-		return -1;
-	}
+	if (!ldo)
+		return 0;
 
 	if (enable) {
 		ret = regulator_enable(ldo);


