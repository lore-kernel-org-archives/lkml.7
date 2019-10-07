Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C172C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDB42133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TtaIHK/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfJGRJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:09:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49730 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfJGRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:09:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97H9HFp077194;
        Mon, 7 Oct 2019 12:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570468157;
        bh=oVMcBS9B51Vlj09LuDSqLmxgOK3U5xBBbOwYpJ+/9WQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TtaIHK/S8FEUT4UAj+g5dz/o5t5xQhmZEwiYlCHINILdBtQ2yg1T7WyjgwHQv8vXE
         CRmWx+br6Kwxh3hAK/50nN29sE2hajNdaK4If9DRwBxWgAGRQs0tFemFUdv/kcj6BJ
         kgyewPBVsncxsJXjAqhmWRu6IbUcQaXBf8Fo7TrU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97H9HNg055073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 12:09:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 12:09:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 12:09:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97H9GEF026321;
        Mon, 7 Oct 2019 12:09:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <shifu0704@thundersoft.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <navada@ti.com>, <perex@perex.cz>,
        <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/3] ASoC: tas2770: Remove unneeded read of the TDM_CFG3 register
Date:   Mon, 7 Oct 2019 12:11:56 -0500
Message-ID: <20191007171157.17813-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20191007171157.17813-1-dmurphy@ti.com>
References: <20191007171157.17813-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unneeded and incorrect read of the TDM_CFG3 register.
The read is done but the value is never used.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - New patch no v1

 sound/soc/codecs/tas2770.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 361d0bba72b3..c1e28dd0b73e 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -386,7 +386,6 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	u8 tdm_rx_start_slot = 0, asi_cfg_1 = 0;
 	int ret;
-	int value = 0;
 	struct snd_soc_component *component = dai->component;
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
@@ -442,8 +441,6 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
-	value = snd_soc_component_read32(component, TAS2770_TDM_CFG_REG3);
-
 	tas2770->asi_format = fmt;
 
 	return 0;
-- 
2.22.0.214.g8dca754b1e

