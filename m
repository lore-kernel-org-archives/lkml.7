Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E72DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C22133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEzUwYCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfDASTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:19:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40747 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfDASTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:19:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so448541wmi.5;
        Mon, 01 Apr 2019 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWRNFvdzR7jDiIT2oYZIFzK8jYDZLuJ0sBRZxtB4YxY=;
        b=tEzUwYCuS8uIZZNlgV4lnDKQNisl8dgfXFS7zYDCaCsyH/WcrVcg1Pq2ZvjCYXikeO
         7q8aAwJonlPzarUye6caYFZWeALhy0i0lZsDGjjgp+uaprcbb79QeTIjFkzaz7G2kOiS
         ThBjA+VdeOaoWdxkXOQ+0MqzAUzzHTlxILyN3LcvT32VB+qK++FxN+fFtCB+YErEmiCV
         IepHI+O76qE+1rhf09UuR7HuquuidKStd1jdHoqYwyyFMkM+VhnSnT0JSzl+or/wdG4P
         su8FLUFjyzlaG2uqTUYAVWj+1I//4QMV4SJ0O5+OQXG6+WqLvGhdpggQb3eHOv5kjRZe
         0Qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWRNFvdzR7jDiIT2oYZIFzK8jYDZLuJ0sBRZxtB4YxY=;
        b=fxT88j1up2g8iQTWBhbGnVpKLyfWdNjM5+ZX/Dx8pBHbSPXpRfyq/IFTBlFNCUke1i
         eIZCTOIoL8QMjNb4o1BWMBvfuHwTeyzpMaD5yOimJ9BYi4Mr/4LuXsDAroql4/G5Gjzn
         gq4xou0wgvrcytqw0uq3DGreU4pVUSAikIeshLRkEvLM5Q9UUPSqvFoERz7DQJToKbmy
         TjnMsYj4CJL2PxCq8+TgcKrG6arJbrszO8vz6kmYEx6ppoNeFV7EBKIcDUl9tWPNTkEx
         gcMHTUYWndKIpCNuMaUBKW9RqOpesGAwNtJNKHPJeBE6bs34/bq+vTKmKR8kJxepiQba
         4uIg==
X-Gm-Message-State: APjAAAWq+X48mEvNxx4sn5VMgObHeMTtA9nYLnCbw3lmV3ujxNzVySEg
        vWFD9uLPGo8qQnV6z7up+uQ=
X-Google-Smtp-Source: APXvYqwmPPda028Rtjix9L9ptrWnnsTLQOL1dbrEgs1B3+9qwPZW/P0csJHRUpUD6HKXgxNOPeaL1Q==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr633929wmg.114.1554142772066;
        Mon, 01 Apr 2019 11:19:32 -0700 (PDT)
Received: from X555LD.home ([2a02:85f:510:b900:c095:2934:58ba:cfa6])
        by smtp.gmail.com with ESMTPSA id c20sm17876240wre.28.2019.04.01.11.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:19:31 -0700 (PDT)
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX offload for rockchip devices
Date:   Mon,  1 Apr 2019 21:18:40 +0300
Message-Id: <20190401181840.31255-1-papadakospan@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>

Some rockchip boards exhibit an issue where tx checksumming does not work with
packets larger than 1498.

This is bad for network stability.

The previous approach was using force_thresh_dma_mode in the board dts, which
does more than we need.

Signed-off-by: Leonidas P. Papadakos <papadakospan@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 ++
 include/linux/stmmac.h                                | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6a2e1031a..4552147e9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3660,6 +3660,10 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
 		features &= ~NETIF_F_CSUM_MASK;
 
+	/* Including very small MTUs of 1498 for Rockchip devices */
+	if (priv->plat->bugged_tx_coe && (dev->mtu > ETH_DATA_LEN - 2))
+		features &= ~NETIF_F_CSUM_MASK;
+
 	/* Disable tso if asked by ethtool */
 	if ((priv->plat->tso_en) && (priv->dma_cap.tsoen)) {
 		if (features & NETIF_F_TSO)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3031f2bf1..807cf5826 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -519,6 +519,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 		pr_warn("force_sf_dma_mode is ignored if force_thresh_dma_mode is set.");
 	}
 
+	plat->bugged_tx_coe = of_property_read_bool(np, "rockchip,bugged_tx_coe");
+
 	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
 
 	plat->axi = stmmac_axi_setup(pdev);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4335bd771..60c411f43 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -162,6 +162,7 @@ struct plat_stmmacenet_data {
 	int pmt;
 	int force_sf_dma_mode;
 	int force_thresh_dma_mode;
+	int bugged_tx_coe;
 	int riwt_off;
 	int max_speed;
 	int maxmtu;
-- 
2.21.0

