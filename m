Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A02C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 01:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85C2206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 01:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvuOjV9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKQBAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 20:00:55 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35577 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfKQBAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 20:00:54 -0500
Received: by mail-yb1-f194.google.com with SMTP id h23so5672416ybg.2;
        Sat, 16 Nov 2019 17:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1KZD/D+ITfpzGjs6DVMtpV8mRW5uG0idJZBpcTB84Go=;
        b=BvuOjV9V+dVpP0IQAE3P/Eb6Rrk8j9j+nDkewdjuy4DViDZ9VKm0fpLRlGfEaw13cN
         Fkj46mSmLwexhT+VKQQ/H4sqKhrXjmGfFo/xh1M0u9S4cT4wW4YFxFnGljRE5gZ6nEQ1
         IS3Ft+b5JXDeznJOWFkSQKhB+zrWWbfLQFlJZlD5m/jj5rRrFRgyUvzwyA9/QtaUMdEd
         msCwOsAJjx9kCjq/5xprJL6Gq2G4EMNPmWL/RR7MlTy0vmhB2yBwo2pDrO5jTky39mMO
         B2lwTjQrBS7cm0UDHpCHLL4ED0+/tJ5So2S9VZ57qzxQszYFH7TxlsX93Ju+PANDxb1L
         ayGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1KZD/D+ITfpzGjs6DVMtpV8mRW5uG0idJZBpcTB84Go=;
        b=ReW7qUrRO8C5H/Tj3/azpymFCxtg6Uxz/ui1dDmmx7/wHUqwCElyRcl3Jkl04nU9UV
         X2oN9KL/TSCv0e8Z0Vb2NNngHiCZDKCYdbW4qljl1in9RphyIb1FdD/k8k0dqUKjlwLr
         Haia+5+agiJrrJpEIQfXBjbWr0sM5jjyJQHe9G2YidlZ0fCASGaI1DqM7op+ZsSXR+jA
         ZE1WtFlX55RGvmXyurbhPOQtfYf2FT3lAOfosfzMhY7oPWRWzyQ3xW4aX+uYk+STS/fW
         qhnWslbidtjWqYGr68IZXYwpBw+DELkbyb7l7FhRSlkadAjTaOz8sODavVCNWBi3DcCd
         +7Gw==
X-Gm-Message-State: APjAAAX7+c0UErZiz+SD/gjyjZOHsMw2Qz7oDxNDyoQ3Rpn1abLTx6Mg
        yeEnUFEeMLcwIhReGAJVD2wrRdCulio=
X-Google-Smtp-Source: APXvYqxZ80SmwZHAhq0UXG3+UE6Rc3pCkQyQI4MEJmcJ5bDoCp7m7yejyfbJgHZDKicPsp+Sg7D/9A==
X-Received: by 2002:a5b:78d:: with SMTP id b13mr17221605ybq.157.1573952453404;
        Sat, 16 Nov 2019 17:00:53 -0800 (PST)
Received: from bonecrusher.natcky.rr.com ([2605:a000:1707:c42b:7331:4754:500a:5064])
        by smtp.gmail.com with ESMTPSA id j188sm6386386ywd.50.2019.11.16.17.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 17:00:52 -0800 (PST)
From:   Bradley Bolen <bradleybolen@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de, info@metux.net,
        hongjiefang@asrmicro.com, avri.altman@wdc.com,
        wsa+renesas@sang-engineering.com, yinbo.zhu@nxp.com,
        Bradley Bolen <bradleybolen@gmail.com>
Subject: [PATCH v3] mmc: core: Fix size overflow for mmc partitions
Date:   Sat, 16 Nov 2019 20:00:45 -0500
Message-Id: <20191117010045.4902-1-bradleybolen@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With large eMMC cards, it is possible to create general purpose
partitions that are bigger than 4GB.  The size member of the mmc_part
struct is only an unsigned int which overflows for gp partitions larger
than 4GB.  Change this to a u64 to handle the overflow.

Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
---
 drivers/mmc/core/mmc.c   | 9 ++++-----
 include/linux/mmc/card.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8804895595f..f6912ded652d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_csd)
 	}
 }
 
-static void mmc_part_add(struct mmc_card *card, unsigned int size,
+static void mmc_part_add(struct mmc_card *card, u64 size,
 			 unsigned int part_cfg, char *name, int idx, bool ro,
 			 int area_type)
 {
@@ -313,7 +313,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 {
 	int idx;
 	u8 hc_erase_grp_sz, hc_wp_grp_sz;
-	unsigned int part_size;
+	u64 part_size;
 
 	/*
 	 * General purpose partition feature support --
@@ -343,8 +343,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 				(ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
 				<< 8) +
 				ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
-			part_size *= (size_t)(hc_erase_grp_sz *
-				hc_wp_grp_sz);
+			part_size *= (hc_erase_grp_sz * hc_wp_grp_sz);
 			mmc_part_add(card, part_size << 19,
 				EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
 				"gp%d", idx, false,
@@ -362,7 +361,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0, idx;
-	unsigned int part_size;
+	u64 part_size;
 	struct device_node *np;
 	bool broken_hpi = false;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9b6336ad3266..b59d35bb50ba 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -226,7 +226,7 @@ struct mmc_queue_req;
  * MMC Physical partitions
  */
 struct mmc_part {
-	unsigned int	size;	/* partition size (in bytes) */
+	u64		size;	/* partition size (in bytes) */
 	unsigned int	part_cfg;	/* partition type */
 	char	name[MAX_MMC_PART_NAME_LEN];
 	bool	force_ro;	/* to make boot parts RO by default */
-- 
2.17.1

