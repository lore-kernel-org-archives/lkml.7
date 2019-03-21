Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B398AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3221925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="NoXUUu0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfCUWQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:16:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41585 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfCUWQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:16:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so92379qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgAvtv5h8mLo/7zpwvPverPSWmp65KreRmC/KtHsw54=;
        b=NoXUUu0ROSxjxKw/Wp2icwPJfx4953Mm7ApZKMY0LPJgzi0ubyayIwtA/rhMaS9e7e
         iSmlAhCCaDzzDBVpNEeW8LL1d600EAGf25h46Nhzpm3sLN+S+AbkaC9DUCNAgWBWjQLw
         gCV+cJnB/WopWGu/qk+M0XJ59Qxy+Zr9YWMWZ5fKvFV+4kKalnUkCk9jMqIrYUsY07MU
         xqQnE0Ip2jIITdGo8bXnZGdbph27quzQI2h1CkxHF0pm227jSigI2ayMYElcN432w57/
         fU8kidvejw/xFpMr0wTFSo3xv/+Lr4tZdVRnsoHYWhI4QvH94y7vkQve9lRv8QjR7S5v
         U9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgAvtv5h8mLo/7zpwvPverPSWmp65KreRmC/KtHsw54=;
        b=XbfqOEKK61I/IG2w5FZ4VxpgLgrKU24mHnZBGXGrM2YLPaETNAXma2+M9en3kd8giw
         IAhm9bwGgdBCcC+ZPPX8X0x8YeV5op+5zFEsuZ56zSiwQOGsAuf05gFATkn/9TQ2DivT
         I/5mKTcjAZk6WCtl6yLyOi+B0p7qEDD8zFFQIuTSXXuy09+b8haTanRKDstZmO4TPl+Y
         zwZW1Y/HSRHygatlNIBB/mX98Ulqp7Uq29X6Zi/aAnH6Gs83UW7b1zoG1rVxlOo9nxW1
         ksphvnwPvCcQnyc6tCsJajGcfDWHiAU3pQhk16j+lNNs0GtD2Qm3FAURd19oThTjm1F/
         bYXA==
X-Gm-Message-State: APjAAAXbnfBp5fYSc1yizWE/G/tJuyxSBLl4LZ8tIgJBMzf+I5IYevRx
        KxRkOt9qolokuS0y0XLW8H49hA==
X-Google-Smtp-Source: APXvYqzHgQn38wTdfG19fCvlPvSLZcSB9BSJDw9bLMf6c+OB/p5YHx9w6R3MSmBYaCTFIL1yxN7+eQ==
X-Received: by 2002:a37:d685:: with SMTP id p5mr4774807qkl.329.1553206560498;
        Thu, 21 Mar 2019 15:16:00 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:15:59 -0700 (PDT)
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
Subject: [PATCH v2 3/7] ASoC: tlv320aic26: Add device tree binding
Date:   Thu, 21 Mar 2019 18:15:45 -0400
Message-Id: <20190321221549.13765-4-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TI tlv320aic26 sound codec

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index b91b8d5f1ba3..5c9b320b918c 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -368,9 +368,16 @@ static int aic26_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct of_device_id tlv320aic26_of_match[] = {
+	{ .compatible = "ti,tlv320aic26", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tlv320aic26_of_match);
+
 static struct spi_driver aic26_spi = {
 	.driver = {
 		.name = "tlv320aic26-codec",
+		.of_match_table = of_match_ptr(tlv320aic26_of_match),
 	},
 	.probe = aic26_spi_probe,
 };
-- 
2.21.0

