Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D78C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C711205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL/oX+/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFSqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36160 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLFSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so2330689pfb.3;
        Fri, 06 Dec 2019 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9o4ISVa2P6pOeqYh0Ll8+Jro095934ZjUwAjarWJmTU=;
        b=tL/oX+/6yHqXUXzX9ilD1PgPWLPOMzVBR1dBoaFG2pmRikiMDiyU+BORtPIIQ6mf8D
         OQc3zUnXJcQzagrDQaMl3ClK5KSxERD9s+mXw9QC9+2Wg28S3XYQlnQB4ljlWWNdVrON
         6shAspe+xql4Eg8kvEPE+mOHEiiUzLowdIwR1KAvBfQAE+p+aVwFBvEKjlH13drSkXlc
         wo7NXXihiKBxGIbakXeBTuTAPrj/st4djtnmIRwKYyZ+q6pZl7144sHhRa2QGqLHjAm9
         phfcrSs4dftiLzBrHwImqxI2shC3/QYSJ6L4vyH6YLhXaeSsvYI8N/O6ATkUhmiDWx78
         CnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9o4ISVa2P6pOeqYh0Ll8+Jro095934ZjUwAjarWJmTU=;
        b=rIGrtftlhmN2PNDe+HzjvRNewd4YIMUmDAtBnE8/qic++oXYa19PWqGhaT8slEOtFm
         mPJQtx7vfT0iTLUmlFYsE9EMmOjoXFM7wtlsBFI6QRg/8OCw+Awhh1l2LIeBli5V0iiZ
         bBmTsnw/AyK+vmm0C87clRhW2VItYL82Bh06HYyauaj5yv3OQ22b28K6yODawEv2QVeb
         mq96W+nSKhjjuDPfuowo9VDd1pkj/DL2ywGTkQH+sf6jfxQ7mfojR7IB3aGdfA+s6k4/
         B2kH7lE4Hnvl2lBQBJVehO5sEoyvtvPeOCV5vGFRBZNtaEMxKN2JWRk6Xix8zIzL7zpp
         lY3w==
X-Gm-Message-State: APjAAAXmWu1ROVHHygT/1w2x1duzk7oAhCvbMIufS6SSZj15Ieyb5S9I
        ZMogFKizFezRNF+oly1xhxE=
X-Google-Smtp-Source: APXvYqykwrefj/zfHpIuihall3bC06p3CtkdcyZnCXMvVfTYduRK+b1RSF6fUPRmcgOs39GO5I/Qcg==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr4984722pgl.409.1575657995416;
        Fri, 06 Dec 2019 10:46:35 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:35 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 5/8] mfd: rk808: cleanup unused function pointer
Date:   Fri,  6 Dec 2019 18:45:33 +0000
Message-Id: <20191206184536.2507-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup unused pm_poweroff_fn and pm_pwroff_prep_fn function,
drop the unused rockchip,system-power-controller dts binding.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mfd/rk808.c       | 28 ++--------------------------
 include/linux/mfd/rk808.h |  2 --
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 4b3b90dad4f8..9a7be379946a 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -521,7 +521,7 @@ static int rk808_probe(struct i2c_client *client,
 	const struct mfd_cell *cells;
 	int nr_pre_init_regs;
 	int nr_cells;
-	int pm_off = 0, msb, lsb;
+	int msb, lsb;
 	unsigned char pmic_id_msb, pmic_id_lsb;
 	int ret;
 	int i;
@@ -641,18 +641,8 @@ static int rk808_probe(struct i2c_client *client,
 		goto err_irq;
 	}
 
-	pm_off = of_property_read_bool(np,
-				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
+	if (!rk808_i2c_client)
 		rk808_i2c_client = client;
-		pm_power_off = rk808->pm_pwroff_fn;
-	}
-
-	if (pm_off && !pm_power_off_prepare) {
-		if (!rk808_i2c_client)
-			rk808_i2c_client = client;
-		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
-	}
 
 	return 0;
 
@@ -667,20 +657,6 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 
-	/**
-	 * pm_power_off may points to a function from another module.
-	 * Check if the pointer is set by us and only then overwrite it.
-	 */
-	if (rk808->pm_pwroff_fn && pm_power_off == rk808->pm_pwroff_fn)
-		pm_power_off = NULL;
-
-	/**
-	 * As above, check if the pointer is set by us before overwrite.
-	 */
-	if (rk808->pm_pwroff_prep_fn &&
-	    pm_power_off_prepare == rk808->pm_pwroff_prep_fn)
-		pm_power_off_prepare = NULL;
-
 	return 0;
 }
 
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index a59bf323f713..e07f6e61cd38 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -620,7 +620,5 @@ struct rk808 {
 	long				variant;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
-	void				(*pm_pwroff_fn)(void);
-	void				(*pm_pwroff_prep_fn)(void);
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.24.0

