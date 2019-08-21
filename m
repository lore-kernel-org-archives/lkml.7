Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B7C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4304E22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389744;
	bh=iRbZEaOdhaldfBActaaeMYj7hwVlyKuyYPrYYFZCXA0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=e8nbqa41xY28PCflAq36nO21kwwQ0zR8XZUDsSXT4+t24tcp1YNrbFhsIJX+ygIhA
	 JHuCCf3HDzlbB4jTVz3+8NIyCJomQIAhQvyPnbT08fOcaMgPogWSQBY/78lnJv1ZVU
	 cNhTgJAq0pFqXLMrk8OQMXCAT6z7AWkz6/Sk4CNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfHUMPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:15:43 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:46830 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHUMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:15:35 -0400
Received: by mail-ed1-f97.google.com with SMTP id z51so2640501edz.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=or+cvsSg6ceM9i70D6UPLNnCbWB/HWcr9PNQOtNGKXI=;
        b=J8Vf8pLsZ4EiGqXNKHuT7l8WwEEvDNmqhGTj/bu+qrCZ2/A2X6ov8HYmd0h0Zw0SMF
         brPw7UtG5Z7oSK8TBrUN3zYjC7EIFNkNIItU6Izhy+GRSq7qEcneH61LC5eAgi08kv2X
         9tHMRmEykQljdjVN3MjlvVnTm4a0dGq4wQ358ljknS1em9da42Bvz/9ngYah8mvnBRXM
         R6BJVXrjLsd7A0RmHWy+fubhVWThIMXtgT5Uw6PgizUJuVCbpiqWiV5NUm3B8NLbmpoi
         w42zRQPAQTgMdqJnVUTjdMW9LdiX/I4SNvUtRi+vDJ8Wfh7mtIybl9TPJ35C7BK3TS5M
         GG0A==
X-Gm-Message-State: APjAAAVb47FlOP+s6/GVzlTz/KPo+ciLnxIwEj5uZx6PJoH6OCLNWBYX
        tGnXesFkFFGH5Lt1jB4QWWgtHztb2iScHijK7ns4CXQu2fB7CQUUZRSma34gClk2CA==
X-Google-Smtp-Source: APXvYqwnL6a2+Wqqe4N5q5Qp5yJbqPQ85mdzWn2tird1yFrGVdQAYor3bqrwIaYpo5lJWM5SLTNhALLptlV9
X-Received: by 2002:a17:906:6c90:: with SMTP id s16mr31271826ejr.62.1566389733773;
        Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id n20sm115894ejr.72.2019.08.21.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0PWX-00077D-F7; Wed, 21 Aug 2019 12:15:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B2DC62742FCD; Wed, 21 Aug 2019 13:15:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        nicoleotsuka@gmail.com, perex@perex.cz, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, viorel.suman@nxp.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: dt-bindings: Introduce compatible string for imx8qm" to the asoc tree
In-Reply-To: <20190814082911.665-3-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190821121532.B2DC62742FCD@ypsilon.sirena.org.uk>
Date:   Wed, 21 Aug 2019 13:15:32 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: Introduce compatible string for imx8qm

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

From c1fe93581ae9d85c3a783b5fad21912bb88a0f34 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 14 Aug 2019 11:29:11 +0300
Subject: [PATCH] ASoC: dt-bindings: Introduce compatible string for imx8qm

Register map for i.MX8QM is similar with i.MX6 series. Integration
of SAI IP into i.MX8QM SOC features a FIFO size of 64 X 32 bits samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190814082911.665-3-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index e61c0dc1fc0b..0dc83cc4a236 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -9,7 +9,8 @@ Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
 			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
-			  "fsl,imx7ulp-sai" or "fsl,imx8mq-sai".
+			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai" or
+			  "fsl,imx8qm-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1

