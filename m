Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D532192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256073;
	bh=rT1r8LfW3buq1qfmBIu93k11doxeuFIb102aWU4Xwr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yv9jXbivXhFKqSSmItM/5y68I74s59MGz1C5N9zqYmE+JG/6dogjrGygXwdzJgXt
	 ZFzGSp3Ys9/+nFVczEhdpwbaUvMMExulB9I54cmbT1D41QOLrWnduIN04xbZkd95bp
	 3dS5iYVE4Fq6ov3QaGQyIqFbj/VxaDrfL3jM5hPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfCVMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732861AbfCVMBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757ED204FD;
        Fri, 22 Mar 2019 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256069;
        bh=rT1r8LfW3buq1qfmBIu93k11doxeuFIb102aWU4Xwr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF6Q34MiuzRi9LQTAeP26jDDRCs2DT0kpMNcJdqAgNYsWi2jKg+gVOubq3GlyFY6t
         A0WqNZjjS+0xj87WHPcrrTiAFXo75HPOx2eD6VYeS/q8HAYfU7mzxidNkYC86nTJ8b
         999FOfL0ab7MDCombRFVKkNoR3gvSFJhmusNoHUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/280] net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()
Date:   Fri, 22 Mar 2019 12:13:56 +0100
Message-Id: <20190322111311.054694642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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
index 62f204f32316..59007d6cd36d 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2886,7 +2886,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 
 	ret = mv643xx_eth_shared_of_probe(pdev);
 	if (ret)
-		return ret;
+		goto err_put_clk;
 	pd = dev_get_platdata(&pdev->dev);
 
 	msp->tx_csum_limit = (pd != NULL && pd->tx_csum_limit) ?
@@ -2894,6 +2894,11 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
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



