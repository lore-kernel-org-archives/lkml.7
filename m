Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC95C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881272171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428670;
	bh=fU3UnuMBjDgUm7hIGIcuYB2m6R+nbC4p4CIJ7XixsRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uvBJzJjCIJtqy0fl00UEkJv5aWYYgRQ4R/eqZRpLfVMszczUW0LVydO2sASRcEsPI
	 S5enzcHzHRidn3h05muaYHkiki4KAXD/aumHUvs3C4PHqJefMXmY/jfYSmB3t8zywz
	 TlSDzLzgZbDOlE/PGssGWjru9YVTOGFJTZHzQ9bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfG2TbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387892AbfG2Ta6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:30:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD8621655;
        Mon, 29 Jul 2019 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428657;
        bh=fU3UnuMBjDgUm7hIGIcuYB2m6R+nbC4p4CIJ7XixsRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GE0zLtLtHpjhyz4y8vwLkqABmBMjlq1Z9LRyi7wiCVLXU1bJgh7nHunStdke62a3H
         FEfy9RubqS8F24vOYLL73VMFcXBdb/VD7jjecqWwN71lJp8fAIz12/rW1K3SOBZ8jb
         d5dJE4cN6T2ie6471cOpHAson8bnSbXareBZ1iO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 105/293] net: mvmdio: defer probe of orion-mdio if a clock is not ready
Date:   Mon, 29 Jul 2019 21:19:56 +0200
Message-Id: <20190729190832.698874728@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 433a06d7d74e677c40b1148c70c48677ff62fb6b ]

Defer probing of the orion-mdio interface when getting a clock returns
EPROBE_DEFER. This avoids locking up the Armada 8k SoC when mdio is used
before all clocks have been enabled.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvmdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 0495487f7b42..c8e3c1119313 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -321,6 +321,10 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
 		dev->clk[i] = of_clk_get(pdev->dev.of_node, i);
+		if (PTR_ERR(dev->clk[i]) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_clk;
+		}
 		if (IS_ERR(dev->clk[i]))
 			break;
 		clk_prepare_enable(dev->clk[i]);
@@ -365,6 +369,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	if (dev->err_interrupt > 0)
 		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 
+out_clk:
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
 		if (IS_ERR(dev->clk[i]))
 			break;
-- 
2.20.1



