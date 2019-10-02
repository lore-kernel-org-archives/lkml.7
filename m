Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1487ECE587
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815CD20815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVYaH6PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfJBAUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:20:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41925 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfJBAUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:20:38 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so24292427ioj.8;
        Tue, 01 Oct 2019 17:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7akn3KWbgNnmMpTo3GpAawa2GrmFKU67ai1nYZy4h8=;
        b=vVYaH6PIsoBnaTSkvwT3ZG7wmp0QKNo6rURPIizeJWFyDei1P9wMgw1pcI3+7vuHzb
         nksWAGyzFTeycPPA9/a+MzP3GWY6YaHd7Rxv9yamE4lKlRuag/8UegaaoHNI3PQkocjw
         bP1dqvPT1zQ4aRcKw7po7jMEoBMGNIiTVvyn3R8QjDYVdnmLSrmqMKmAprIqT1JoWi7c
         8NmIn7lKfA9/mcb7o/vFqdeviLlbWCAR7QU/wBvTv/4i9KQRp8Gudmn/+oTq8SW1YQ3k
         nyACI8XyRf8BdU9+7+frK/bLclPcdQQ692+wdauZgeETgfgrG+i3t2zN3JIDsgy36aiQ
         QOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E7akn3KWbgNnmMpTo3GpAawa2GrmFKU67ai1nYZy4h8=;
        b=E00nM8cAlfxQw4OZlWzjGF65z5K1a5FfO7CpbiYoDAfZ8V1eMX49oH2KHBUyLKDjpg
         eJATxSdH69Y9lzLa+rJoXTxQvAwonk2XsZKifUll5Yr6W+1/KikNK4PvtKSEGCnDHee2
         gx2fC58Ihg6YIQIBhVXZhD9LA/IxIJ292d+3pPHytdsVtjVqqYYH0WhIJ7FS1zJLe4dA
         0WR2cPgps4bfzsTRXQqpySSJzrk/0ScO0mGnS3OiEjs3gq2DDZFqCD6CPbp+H1o4CzJX
         S7M4AKSAqWMfnrq7MiV2WnRQky0VFvM9CNal2dBOahmutIoQbreYNUFOdspVWg3SauOp
         BEiw==
X-Gm-Message-State: APjAAAUfCge5On4Rs2ToK1uEtI30MJ1xIGKmIExtKaAlo6xkqBQmZRSS
        f+FE8Xzne9g/FfEA5pR0EF0=
X-Google-Smtp-Source: APXvYqzwrXn2xZhvP3Fk1t/4f5vCLzNLkyNLHZOCf4L6LjiMIR08b3vcNTz9Q3aZneXGKJ6lt60hlw==
X-Received: by 2002:a02:1785:: with SMTP id 127mr1133317jah.15.1569975636729;
        Tue, 01 Oct 2019 17:20:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id i13sm6703646ils.16.2019.10.01.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:20:36 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6q-logicpd: Re-Enable SNVS power key
Date:   Tue,  1 Oct 2019 19:20:29 -0500
Message-Id: <20191002002029.19189-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002002029.19189-1-aford173@gmail.com>
References: <20191002002029.19189-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch disabled the SNVS power key by default which
breaks the ability for the imx6q-logicpd board to wake from sleep.
This patch re-enables this feature for this board.

Fixes: 770856f0da5d ("ARM: dts: imx6qdl: Enable SNVS power key according to board design")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
index 7ceae3573248..547fb141ec0c 100644
--- a/arch/arm/boot/dts/imx6-logicpd-som.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
@@ -207,6 +207,10 @@
 	vin-supply = <&sw1c_reg>;
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.17.1

