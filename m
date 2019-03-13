Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA286C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08BE2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504777;
	bh=af5tWbbNvSjBU2S81oIv2A33coCEY00LZJ0PN5Q+Iak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A++Ko85VJk6FeYBiNY274REmxojMsMJwTpQqLE7K5PWRUx8d1BArR9nWUiyr6EZL4
	 /YiO3DmBfuFPHa49pn7SoUVz7Gi3Q5AYqAU5z+Vdyo9ofltRVHQ7opIKuYc4AInl+N
	 WXNJ3s03T9xefEnXDFWnojwCDzoYePzOz1r7K1M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfCMTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbfCMTTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:19:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9A62184E;
        Wed, 13 Mar 2019 19:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504740;
        bh=af5tWbbNvSjBU2S81oIv2A33coCEY00LZJ0PN5Q+Iak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBoD1SkqTI+Woxxk0uxFs8W/kwEc0sjRGpDThX4VCjkKg0YOjsMt4D7EzG1beVQAL
         ZoFt99ZtvCBoqflfl2PY+ZfKXgNkM/cKb1bJ4iKAYoJFZHX8OHeLvCuLOAEjbB5Wr7
         WRBlBD8FITOyRt3cHrGfK9j1OYKI5t26mUBqnVQ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 05/10] net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()
Date:   Wed, 13 Mar 2019 15:18:41 -0400
Message-Id: <20190313191847.160801-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191847.160801-1-sashal@kernel.org>
References: <20190313191847.160801-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit e928b5d6b75e239feb9c6d5488974b6646a0ebc8 ]

If mv643xx_eth_shared_of_probe() fails, mv643xx_eth_shared_probe()
leaves clk enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index d44560d1d268..5fcf026d3528 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2814,7 +2814,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 
 	ret = mv643xx_eth_shared_of_probe(pdev);
 	if (ret)
-		return ret;
+		goto err_put_clk;
 	pd = dev_get_platdata(&pdev->dev);
 
 	msp->tx_csum_limit = (pd != NULL && pd->tx_csum_limit) ?
@@ -2822,6 +2822,11 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	infer_hw_params(msp);
 
 	return 0;
+
+err_put_clk:
+	if (!IS_ERR(msp->clk))
+		clk_disable_unprepare(msp->clk);
+	return ret;
 }
 
 static int mv643xx_eth_shared_remove(struct platform_device *pdev)
-- 
2.19.1

