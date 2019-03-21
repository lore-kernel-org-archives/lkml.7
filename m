Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6FA218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="p6YLh11W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCUWQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:16:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42556 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUWQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:16:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so414773qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=if1sNoy1mfi3YtgVv5HkU4CwZTmtdZQjl4UklTZ2rEU=;
        b=p6YLh11WSgnnDd4ZAr7VdS8XJiY7RLPj1Sm1VREGS4INfI8cJyqzuX+UKMRUKFyR4g
         Yda6v1GXizL5yF+oLDo6ybsevnVXp0d5k7z/Jieav0pDBhGRbOA9fDuQPVevNSrxVHPV
         NC1eMgJij3YFlsWLvqTpO0W+Ks9u5q/yS1wefY9tQfbcMK1Zyc3Uzc3xHwXiEvY8S9pz
         ZQr0ttFZZLwJVndWTjzaz7yJtDOKYtewik2wU1aUmK13wD43PDCpVE0NfE3QhV3Oh9LI
         Grrx3kB/DSHq2v53d9SAQq1N8n/hkZd95ONzADUHqXqGTPIDuUhDRBjWBHX1/sFLC4K/
         4aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=if1sNoy1mfi3YtgVv5HkU4CwZTmtdZQjl4UklTZ2rEU=;
        b=G/rB5LugjnkGSHl4Z+2+ITSUKgPchpC9X9lrY2FXB9AeV10PAzfGg0lQ0cBQ3gsik6
         aqVKTtYKagapQWau5hrVAshjSQs49hCWSQbHARJGvLLGMDAH/uu0y5/cEPjjve3OPU84
         XgZGwgIZ83odiYUpcaVZ+c2sNaqRJMfYAgpw90tWzPdJL7FTnAuKljmxgjBlwbVcyjgo
         +DdpV0aID3NSGABkXJL60EjQISmfztKGaoq8Z4q+ymoSQLtTqRxX6a7kwLkIaj7qS2dA
         tGqyzbuyu4s/Su3bNiJT8tPlC5sDge6GYC89t8x0cskhiSP3IfxyQU+dLXWCNZ4ggagn
         sM2g==
X-Gm-Message-State: APjAAAVosw/U20VVcwWk4qwRKI1kSXaHHESDvVQbqQ97IUD1N9EEwVb/
        bu6RBftpJaFxVZm+Kr5Js+uuhg==
X-Google-Smtp-Source: APXvYqx3exho2Mefhgr+2F7yBgcEOmqHXx0WKmrrDrMiNge8oUsnTjSVKnm4bO3njHK08Pt58jRipw==
X-Received: by 2002:a0c:8b63:: with SMTP id d35mr5155881qvc.148.1553206561958;
        Thu, 21 Mar 2019 15:16:01 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:16:01 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] ASoC: tlv320aic26: Fix module autoload
Date:   Thu, 21 Mar 2019 18:15:46 -0400
Message-Id: <20190321221549.13765-5-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing MODULE_DEVICE_TABLE() for OF and SPI to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519
https://lkml.org/lkml/2014/9/11/458

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 5c9b320b918c..db1d1704ae5c 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -368,6 +368,12 @@ static int aic26_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct spi_device_id tlv320aic26_id_table[] = {
+	{ "tlv320aic26" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, tlv320aic26_id_table);
+
 static const struct of_device_id tlv320aic26_of_match[] = {
 	{ .compatible = "ti,tlv320aic26", },
 	{},
@@ -380,6 +386,7 @@ static struct spi_driver aic26_spi = {
 		.of_match_table = of_match_ptr(tlv320aic26_of_match),
 	},
 	.probe = aic26_spi_probe,
+	.id_table = tlv320aic26_id_table,
 };
 
 module_spi_driver(aic26_spi);
-- 
2.21.0

