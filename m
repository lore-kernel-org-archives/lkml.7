Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E3ACA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA15020873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpQOyDa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJaBOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:14:18 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44963 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJaBOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:14:18 -0400
Received: by mail-yw1-f67.google.com with SMTP id a83so145481ywe.11;
        Wed, 30 Oct 2019 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9gOTfm/fqN69jLezboMAT7AVfOH/fnngwAwVO06MzXU=;
        b=JpQOyDa4z9dU46y8UssyEOiJob2MWs088zQveiYW4osYaAXDq8p0nhzYOjeKGl4J7h
         fvyAW/IfL49aZ7UY8seCBUODcpZBCcsaF9D/n0KAQ8UvP5GAIrNZlysS/dBnuUAExBIS
         G3CWgHKy8aqXCqAu4TLkCTP8HK2C2hObVRGzK0RwbHJ8+yXahN12sAG+rSy3J7RaedEX
         rAoc2zFPaNuD3y0JeXIGoMQzPXjxTSCWfb7kmvFJB/099JBBfI+WobX3bmjGzv9ZQA1+
         MyGBqDqKaX4zdFqDRxKu/f2Is0OJjKsroww+Fquf6YQZz5wavR9r95XtER9SAxujWpAt
         p5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9gOTfm/fqN69jLezboMAT7AVfOH/fnngwAwVO06MzXU=;
        b=flPK/Vb0l4ga1NeV4yt6qcARfUtig91vqBH9Krw3oD7q5PrLEC2fDd7e7OqDv/lVQM
         /jRQTReIBMQpf4fN+25eiEFyIl9xLxUl6deuucwcZPC/y7eZ4pA38ay57FhLV/39CvlP
         58Fryz98yGowNqXKhvWAfsswacIkFdi2ZLMEyDg4HSj8pZgM/1ZjGZQqQyqIoXkjzar1
         Gue0SLHxkail5tpZXAJu0tShM9qhmDtJ7hCWeavwZvI6J5FHC6WH7kevgQp7pZ10HvwV
         E63jntIL+pdj1dT9cOcFMlVS/XbXCU8/NN6bpXpRgLQMBUL0DS4TsyOALGBgaOfIptNh
         wCkg==
X-Gm-Message-State: APjAAAUGcX2tlplkGDe04fN8I3AC5fMortXK7i7GN2yQseU1R7bFqY+N
        f41mHvpzlgpsNAd29qCTsTeUGTJ0fmY=
X-Google-Smtp-Source: APXvYqycGVowZbnUXFgGHT4+/+qcVoESG0s1Cp8pSJH9so7dltr3kCV8hXwue/Ce/o3ShmCfgmo/BA==
X-Received: by 2002:a0d:ddcc:: with SMTP id g195mr1904839ywe.447.1572484457249;
        Wed, 30 Oct 2019 18:14:17 -0700 (PDT)
Received: from bonecrusher.localdomain (cpe-76-177-112-180.natcky.res.rr.com. [76.177.112.180])
        by smtp.gmail.com with ESMTPSA id p137sm1559284ywe.20.2019.10.30.18.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 18:14:16 -0700 (PDT)
From:   Bradley Bolen <bradleybolen@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de, info@metux.net,
        hongjiefang@asrmicro.com, avri.altman@wdc.com,
        wsa+renesas@sang-engineering.com, yinbo.zhu@nxp.com,
        Bradley Bolen <bradleybolen@gmail.com>
Subject: [PATCH] mmc: core: Fix size overflow for mmc partitions
Date:   Wed, 30 Oct 2019 21:11:32 -0400
Message-Id: <20191031011132.5947-1-bradleybolen@gmail.com>
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
 drivers/mmc/core/mmc.c   | 4 ++--
 include/linux/mmc/card.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8804895595f..4e89cf6524a1 100644
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
@@ -345,7 +345,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 				ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
 			part_size *= (size_t)(hc_erase_grp_sz *
 				hc_wp_grp_sz);
-			mmc_part_add(card, part_size << 19,
+			mmc_part_add(card, (u64)part_size << 19,
 				EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
 				"gp%d", idx, false,
 				MMC_BLK_DATA_AREA_GP);
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

