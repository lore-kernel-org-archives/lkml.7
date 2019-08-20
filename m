Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33113C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F9822DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566305704;
	bh=wwFTwkmMgZNZ7X+z2DMWr6bq7Fcv+C0bKSzKo6ZnjMg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CgjVwsRfvS9LBMmciTkEheMrvSPFArkLAYJZHypgQnqT81ZN6fW3CZ8Wp19BoNXlB
	 yOfNQ4cfUzl/oQ7w4dKOHhH+Tqt1HqOvLzjpyUXhPeKAmyFkyokBtAHixtkDG4mfVM
	 sHV3FHtEPkvwWdaTeoMND66Af5VgodDnzHWn5WKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfHTMzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:55:03 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:51599 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:55:02 -0400
Received: by mail-wm1-f97.google.com with SMTP id k1so2247580wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=BdZ3c/necGDxLfFb1+nhbPyR5/R0A9R2K/u32/exq+M=;
        b=D1QGV2y+om0r5UJlj9616HWsX9i5aJcT5TUf+fkBJsGirIAAg2dP11II2Ucv2Lzi0H
         ldIWD1wYCZ9d+fLxep7V2Pro9ZFh4mE7TUgR1ruN04/MwRlpkSG66U0G2MIOO7jgwQFj
         oaBscFNs3bPuX+O9Zcbrx0kZSRDe45e7xB2v5ftrEITLCdVGxQVHyuM+li1aCGsb7yXp
         s+fQAFBUJrNJGUs5MIAepnGXyAZbOsVMc8oSagUkNuoF7fHraWv3CCg7hXMHi2r+fHjQ
         t7wcMNGQ1fEvFOsJsEKYug+hktv3E20jSrENsQ5nW25EEewMmnHfmvwfryhdl7ys6ERN
         mOkg==
X-Gm-Message-State: APjAAAXiOHmAeoHx+gR4rBWDweJeFX06SByk7QWkGLzExsUBVSxIx863
        BD0XsP+Iii8DuiAYQkBf3PUPUGBqrlV1kctAGV4+kaWVcMgwglyjWQU6q9imJdgXyg==
X-Google-Smtp-Source: APXvYqzhTrD/hOszChMAnJxemDv/II1NLndmIl1OVvzu7rnCD4ezxJI9ITOEKuVAdn3XK8uTlXbJnhgKzeti
X-Received: by 2002:a1c:7914:: with SMTP id l20mr26443271wme.130.1566305700532;
        Tue, 20 Aug 2019 05:55:00 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id b17sm276029wru.15.2019.08.20.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:55:00 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03fA-0002Dp-8k; Tue, 20 Aug 2019 12:55:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 867A42742ABD; Tue, 20 Aug 2019 13:54:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org
Subject: Applied "spi: Fix the number of CS lines documented as an example" to the spi tree
In-Reply-To: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190820125459.867A42742ABD@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 13:54:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Fix the number of CS lines documented as an example

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 7f01494fd85f3ac40635bc2a7bf005b607084c96 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 20 Aug 2019 17:20:00 +0530
Subject: [PATCH] spi: Fix the number of CS lines documented as an example

The number of CS lines is mentioned as 2 in the spi-controller binding
but however in the example, 4 cs-gpios are used. Hence fix that to
mention 4.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20190820115000.32041-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index a02e2fe2bfb2..732339275848 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -31,7 +31,7 @@ properties:
       If that property is used, the number of chip selects will be
       increased automatically with max(cs-gpios, hardware chip selects).
 
-      So if, for example, the controller has 2 CS lines, and the
+      So if, for example, the controller has 4 CS lines, and the
       cs-gpios looks like this
         cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
 
-- 
2.20.1

