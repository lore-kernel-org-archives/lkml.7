Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8397BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBFB2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6lX2Zno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfKGD0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:26:22 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41267 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbfKGD0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:26:22 -0500
Received: by mail-yw1-f67.google.com with SMTP id j190so137932ywf.8;
        Wed, 06 Nov 2019 19:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i7lPlVFXCwaRBfgllPbIuG84TNHexMw3eUuR2CC5D+w=;
        b=U6lX2ZnoRL0dPtyIBg3cnH1/TPonJFZeawdSmmx8HafU1R9vc8NgDfKIfFiRn1DLsT
         xuzIT/EJZS/g4PBS1rE64BaSe5ZDXrD3YgnbYpWrufF4vn/g2cLk9zO16yVgO9zMuNJu
         vQ5IfyhA3YWuHgaVKkpvSEY87oe8f20BHwHbJDcj0TO11Q4js0ygOY+3LcyAQcOW2507
         ifBM+jSUcs64gAI/WoP5N21XWSc4xrNHBdCETj9EsIlg7z3VePG/OYhCFJqaO5sUdxcf
         NTuhabHP7O0Uid3IhdC1uJ2rahOIjp2VPcct7nCtxq8imj5R569nxmL/6wHlgmsAhgEw
         Ss2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i7lPlVFXCwaRBfgllPbIuG84TNHexMw3eUuR2CC5D+w=;
        b=PS/NYarti70Qs6/jlwl/L9vQhUH2do03hJbJfLqJ1vSt26ggmOf2ag1agP0xBbCbyu
         OVxh4u3q3JPsQDpLfNYQuIfWCPg4n/tH+0cXZp/rdNzEOUIcg24m1eNSenaui+B5BOyW
         PuXcviUp3DsbkO+TQZ0pr/LxGtR4jVonmqA/WmgxRePk3z00Pd1PPJEAnroesh/nFLL8
         UAYZyzpdNJKhnpMRxR6HbeHKYK4qx/pby26H/zq4J/cyKx3rPZtwNaxZDnfA/zqJHpfH
         qnGqTJqSfPf4YOx/IPXicBlytGHWdL7lp6Dzi611ChgWFmf/bgR+W85dalekLgBpRa8K
         Fecg==
X-Gm-Message-State: APjAAAXHciP5CkONK79/HF1w4oassPdQEVqkSMkiccy+d3j1hpFc0Q3g
        zTxG2qrFUKZmCEzG3Yt5M7DnAbI/Ln0=
X-Google-Smtp-Source: APXvYqyJOCLE9yWoKCkwp3e2oMQizGGDkRRmRKHTNw5uMIY3Ox14NoxGHm1ZbXsi7B7vTUS69flPjQ==
X-Received: by 2002:a0d:ddc3:: with SMTP id g186mr721122ywe.201.1573097178953;
        Wed, 06 Nov 2019 19:26:18 -0800 (PST)
Received: from localhost.localdomain (cpe-76-177-112-180.natcky.res.rr.com. [76.177.112.180])
        by smtp.gmail.com with ESMTPSA id i190sm276826ywg.1.2019.11.06.19.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Nov 2019 19:26:17 -0800 (PST)
From:   Bradley Bolen <bradleybolen@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, avri.altman@wdc.com,
        wsa+renesas@sang-engineering.com, yinbo.zhu@nxp.com,
        hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org,
        Bradley Bolen <bradleybolen@gmail.com>
Subject: [PATCH v2] mmc: core: Fix size overflow for mmc partitions
Date:   Wed,  6 Nov 2019 22:25:59 -0500
Message-Id: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
X-Mailer: git-send-email 2.7.4
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
 drivers/mmc/core/mmc.c   | 6 +++---
 include/linux/mmc/card.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c880489..fc02124 100644
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
@@ -362,7 +362,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0, idx;
-	unsigned int part_size;
+	u64 part_size;
 	struct device_node *np;
 	bool broken_hpi = false;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9b6336a..b59d35b 100644
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
2.7.4

