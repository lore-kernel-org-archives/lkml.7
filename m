Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B21C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F1C23401
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389738;
	bh=O1TTt4Gv+D3orSPgd/eOC5epZzq5iJlWoztGIlXI8xE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=auESSdJyh2sbnhGEt3MVJZQi+J/7IqNtmy9owJEtX9zAgkM8Koz4hgn330O7XtbKC
	 XCB2ELrPda9eOEEyI7Gsi8zrX5Ol8n3KC2Q3z08dfrMquvtugx6U729mmO/JFGfMUy
	 TX5qxMbUtfd4Agm7FqrHLmDwipkvMHsf0YgtH7vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfHUMPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:15:37 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:45963 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfHUMPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:15:36 -0400
Received: by mail-wr1-f98.google.com with SMTP id q12so1788399wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=nP0rewb3IBXjR8ah44Y3B+/Ww8/H0gkDfZYTICHG0rc=;
        b=Ckc23aRgyvKEVQTIyUmujC43slUrN1KfuOU+M8xkmalcbSe/dXvjKEQEsxQmTpOqpN
         YsZ/Z5uo7X6NsE/wODQ0cxIUcA/W7tIHmT7caElaSZHRlOju2WA/jBY5me4UlPMsP4yP
         PPWI/mYB9XYkjT/6J61refZmuhdvLmyxZ8adRItzW09313wjTKmK7cgQ5jwFNnV8iNvi
         Tgf3DN3yysssBJpexEmc88Coe7CtP71q9oNggUUBJJ/Qf6TJSQ5MMJtFzgfaePxuCb2L
         1j+WTZcG991Fzs6RvA614why5nChMdDtfNZuSkw5RRg+yYnwrjFrUZKDJ/Qhi9dJWn2x
         REpQ==
X-Gm-Message-State: APjAAAWsul/gZifav7LzJdaFAFkHTnycgJkhHCIGvrRuJyXWffnntWo1
        Zhy/XEQxVZnZr8ffkIdrlbxtXkrLh7tDyfYUTS7WymD70m3O/4V2MC7PjwnzHi8cvQ==
X-Google-Smtp-Source: APXvYqyQSDa3qh0AJjqQXicye2RW0x9sVjyglot1pi4YsrC8rjE3vs+Ee79jSQBkTwqgRv3Hei+tz7XSNock
X-Received: by 2002:a5d:408c:: with SMTP id o12mr38199196wrp.176.1566389733984;
        Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id q3sm406651wrs.61.2019.08.21.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0PWX-00077F-Lt; Wed, 21 Aug 2019 12:15:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E3E7D2742BAE; Wed, 21 Aug 2019 13:15:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        nicoleotsuka@gmail.com, perex@perex.cz, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, viorel.suman@nxp.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_sai: Add support for imx8qm" to the asoc tree
In-Reply-To: <20190814082911.665-2-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190821121532.E3E7D2742BAE@ypsilon.sirena.org.uk>
Date:   Wed, 21 Aug 2019 13:15:32 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: Add support for imx8qm

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6eeb60be5ebb73b2e5911e26fb1aed02940b7d09 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 14 Aug 2019 11:29:10 +0300
Subject: [PATCH] ASoC: fsl_sai: Add support for imx8qm

SAI module on imx8qm features a register map similar with imx6 series
(it doesn't have VERID and PARAM registers at the beginning
of address spece).

Also, it has one FIFO which can help up to 64 * 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190814082911.665-2-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4a346fcb5630..728307acab90 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1031,12 +1031,19 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.reg_offset = 8,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 64,
+	.reg_offset = 0,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
 	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
+	{ .compatible = "fsl,imx8qm-sai", .data = &fsl_sai_imx8qm_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.20.1

