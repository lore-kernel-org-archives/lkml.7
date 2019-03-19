Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B6D20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="beNJ3vJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCSMLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:11:20 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:55240 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:11:20 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190319121117epoutp04d6a5be4a433727ec6bc7563d4d256fe2~NWvoubFgH1577715777epoutp04Y;
        Tue, 19 Mar 2019 12:11:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190319121117epoutp04d6a5be4a433727ec6bc7563d4d256fe2~NWvoubFgH1577715777epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552997477;
        bh=II4P59RQTZgpl1RsKuRm+besj1F+DmR9vAvZP+KyAd4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=beNJ3vJnoUuUtBhWXs3B45OpV04xXzMk1JP/LGPOVlR1ZKAyBMezpX/c/qH5FpJNA
         FXtKeet14N+JEs88lUlybi/rEaskNgeo+AI9wlaJsvOYs/mploeoUImnGZgbSa/mhR
         782CALAz/YdNWxeS8xF7qJPqXgLLDnlIWDIvQqcc=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190319121116epcas2p2b310ef1e2e8e616586d21d2e4ccfc75a~NWvoc52Ub2230622306epcas2p2V;
        Tue, 19 Mar 2019 12:11:16 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.04.04206.46CD09C5; Tue, 19 Mar 2019 21:11:16 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190319121116epcas2p24125f5163744c01c0c2b6b25ca4878b8~NWvoOhCFH1425814258epcas2p2N;
        Tue, 19 Mar 2019 12:11:16 +0000 (GMT)
X-AuditID: b6c32a47-14bff7000000106e-98-5c90dc64c87f
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.F7.03620.46CD09C5; Tue, 19 Mar 2019 21:11:16 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0POM000VR4IGHC90@mmp1.samsung.com>; Tue, 19 Mar 2019
        21:11:16 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     sbkim73@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: i2s: Don't use register read to determine
 slave/master mode
Date:   Tue, 19 Mar 2019 13:11:02 +0100
Message-id: <20190319121102.28069-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCmuW7KnQkxBh3zdSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ9x/xFjQLVTSu3MzYwHiUr4uRg0NC
        wERi8naNLkYuDiGBHYwS997fYYdwvjNK7N65ha2LkROs6PO/tUwQid2MEpMvzGcCSQgJ/GKU
        OPVEDMRmEzCU6D3axwhiiwhoS8y52cEG0sAs8JZRYt6zXawg64QFYiV2H80DqWERUJV4tfk4
        K4jNK2At0XL9HBPEMnmJ1RsOMIP0Sgj0sEn0n+9ihki4SOxomMwCYUtLPFu1kRGiqJlRomf3
        bXYIZwKjxP3jCxghqqwlDh+/CLaCWYBPouPwX3aIp3klOtqEIEo8JK53X2KH+CZW4tm0BYwT
        GMUXMDKsYhRLLSjOTU8tNiow1itOzC0uzUvXS87P3cQIjjQt9x2M2875HGIU4GBU4uENmNYf
        I8SaWFZcmXuIUYKDWUmE12b7hBgh3pTEyqrUovz4otKc1OJDjNIcLErivA+l50YLCaQnlqRm
        p6YWpBbBZJk4OKUaGAP6X+ydHrAz5dSEny4qgYoTJk+eK5d+7d1iI0dfk6luiT3yidOi9Pdc
        aUnhPuJXc2v+wf99YvoG4VOchHLfKdfymnLy3MkslYnkPsXS4XG4Zdm68HsSUe+fGPilpy46
        HpD9Jmu/e/CFvVM0177p5C469fzxs2s/ls2q6gzbsqyA6fPlnPs3jZVYijMSDbWYi4oTAfnH
        m4GwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xgG7KnQkxBgdPSFlcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy7j/iLWgWqmhcuZmxgfEoXxcjJ4eE
        gInE539rmboYuTiEBHYySjT/OsoEkhAS+MUo8fVxFYjNJmAo0Xu0jxHEFhHQlphzs4MNpIFZ
        4C2jRMOZNiCHg0NYIFZi99E8kBoWAVWJV5uPs4LYvALWEi3XzzFBLJOXWL3hAPMERq4FjAyr
        GCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECA2bbYa3+HYyPl8QfYhTgYFTi4U1Y0h8j
        xJpYVlyZe4hRgoNZSYTXZvuEGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8/PnHIoUE0hNLUrNT
        UwtSi2CyTBycUg2Ma/7p7jKpmb/hbnzdO8P9cx+cfWv9Nsj8VtP5zxNFNzwPf3n6nFXblQVa
        X/k3boq5vXfx/ZbzWl2v+uZqeD0ONXc5+rOHZUa59AeVQCGrRZLrtwfW33vo/dVi3ZrCVWEp
        1fZ9qzKbHivst5/NWfJDzOplvv1F5+j8Ul0LxSudi7crLmA9V6qso8RSnJFoqMVcVJwIAADk
        YsEUAgAA
X-CMS-MailID: 20190319121116epcas2p24125f5163744c01c0c2b6b25ca4878b8
CMS-TYPE: 102P
X-CMS-RootMailID: 20190319121116epcas2p24125f5163744c01c0c2b6b25ca4878b8
References: <CGME20190319121116epcas2p24125f5163744c01c0c2b6b25ca4878b8@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify the code by caching the CPU DAI master/slave
information rather than reading previously set register bit.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ab471d550d17..9722940da6a4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -88,12 +88,6 @@ struct samsung_i2s_priv {
 	struct platform_device *pdev;
 	struct platform_device *pdev_sec;
 
-	/* Memory mapped SFR region */
-	void __iomem *addr;
-
-	/* Spinlock protecting access to the device's registers */
-	spinlock_t lock;
-
 	/* Lock for cross interface checks */
 	spinlock_t pcm_lock;
 
@@ -122,6 +116,15 @@ struct samsung_i2s_priv {
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
+
+	/* Spinlock protecting member fields below */
+	spinlock_t lock;
+
+	/* Memory mapped SFR region */
+	void __iomem *addr;
+
+	/* A flag indicating the I2S slave mode operation */
+	bool slave_mode;
 };
 
 /* Returns true if this is the 'overlay' stereo DAI */
@@ -130,15 +133,6 @@ static inline bool is_secondary(struct i2s_dai *i2s)
 	return i2s->drv->id == SAMSUNG_I2S_ID_SECONDARY;
 }
 
-/* If operating in SoC-Slave mode */
-static inline bool is_slave(struct i2s_dai *i2s)
-{
-	struct samsung_i2s_priv *priv = i2s->priv;
-
-	u32 mod = readl(priv->addr + I2SMOD);
-	return (mod & (1 << priv->variant_regs->mss_off)) ? true : false;
-}
-
 /* If this interface of the controller is transmitting data */
 static inline bool tx_active(struct i2s_dai *i2s)
 {
@@ -715,6 +709,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
 	writel(mod, priv->addr + I2SMOD);
+	priv->slave_mode = (mod & mod_slave);
 	spin_unlock_irqrestore(&priv->lock, flags);
 	pm_runtime_put(dai->dev);
 
@@ -917,7 +912,7 @@ static int config_setup(struct i2s_dai *i2s)
 	set_rfs(i2s, rfs);
 
 	/* Don't bother with PSR in Slave mode */
-	if (is_slave(i2s))
+	if (priv->slave_mode)
 		return 0;
 
 	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
-- 
2.17.1

