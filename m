Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78A227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQL19xGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfLSMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:20:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45619 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfLSMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:20:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so5734060wrj.12;
        Thu, 19 Dec 2019 04:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aNzr7uADzXwgMWgQOC3rwaap/EsCtVbWxu1DV9lbYTI=;
        b=AQL19xGMDNf8Su966j6w9GZkLDtN0SklpROZhSdWqJfzPIyEYM2Ay5BVpI/Bb7SxFc
         HoEofmHrKU9MxPo+feUmp3iulC6Fz2Kevlg4GEt1lUjpF1VZvnLx9stP6WC8tEEm5WTK
         AWfpIRnMZt50mCdM4J2DSNL7P9vD+6tImOat8RkpHJcaC1Ad4FU1DhR7/+KZd6c8aasA
         LPmYguFz/URpNAOL3AC0Z4oaUZrbSv5os/aXWmxlLhWxOOAQ5tIZg8obquNKuDm8mACJ
         kzlMVrBInvbEevv+j0/Q9q0YQVXbGBPiX+SIBbKpF5Hm7wfXvkus4Ap/2Imx1ySA0XrA
         d9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aNzr7uADzXwgMWgQOC3rwaap/EsCtVbWxu1DV9lbYTI=;
        b=L87q68KXlXy2t1kOR3/VIvPGmmO+yx1pMJERpU7jboZ/QhydJpJjnGyKraFURmjOT8
         KN0XAINJZ76aXBz18WgqXuakRDej1xtxX3VaOJUOix8F322B/2c3bXyezUHhs2vOB0xU
         1RyvSVFxtEG2MjJzPxeQwwx7CjdVCREl/i0KMVf+a8S/Hm2JyTutEsb+E82vo+z5F4vd
         DbhRGFX2RXi4FinRLjAoCPSvlF5fL+Ys7SYkI82xBASNKDqQXkdz1LTfC4EPs8HuxWjP
         DxyN7aSrRme3IQZGEYym3shqHRz6wrYr0cRJuKwZhMba7dL9wVUJU5N0061X/7u+Sa+Q
         UNcw==
X-Gm-Message-State: APjAAAWIYkwxyT6rJkYGu27yr58XXWv0s4u69f/pJurxH3FLjcGdec5f
        QLQP1MssxRI2u9+1h7YEuWE=
X-Google-Smtp-Source: APXvYqyM3rObdh2zrtMyax+r4jGia6vz+7rratVPDgZ7CSMUV9HDNGUZ1rDlGNQBSxwCcM7wyW8/zw==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr9111224wro.128.1576758002289;
        Thu, 19 Dec 2019 04:20:02 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t8sm6237738wrp.69.2019.12.19.04.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:20:01 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove disable-wp from rk3308-roc-cc emmc node
Date:   Thu, 19 Dec 2019 13:19:54 +0100
Message-Id: <20191219121954.2450-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc-controller.yaml didn't explicitly say disable-wp is
for SD card slot only, but that is what it was designed for
in the first place.
Remove all disable-wp from emmc or sdio controllers.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index aa256350b..23527daa7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -125,7 +125,6 @@
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-	disable-wp;
 	mmc-hs200-1_8v;
 	non-removable;
 	status = "okay";
-- 
2.11.0

