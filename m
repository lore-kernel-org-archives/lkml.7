Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A80621BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sabiP0ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfHGMmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:42:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33454 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbfHGMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:42:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so91348160wru.0;
        Wed, 07 Aug 2019 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f84KIsdaJQ9CPJzDHYp5jwwgYBPwNj7/ee/65YueU+Y=;
        b=sabiP0yeVf1UJuKhrWV76NTcVIeg3G1hy4lcORSSNvAo5IcbwP4+v1xx0AljGv5QFu
         whPlMulkqpBJPb4k0W/KkuNms8MYqgDk10yj50rwHjBBZbYrEnhbYCOChvduxiZrZfAs
         ER4oNFJanjAiNilmJGIW8/YCKQe8dOO3LNjGYauz2/pZAnE6eLfTsoiB316JalKVcXgj
         yD66Kc1MeWa3JoPNP1izcj8/JpI4dDDjkDyKiW7FIECG7ud2a+tNprH8aG/RtypGZIPj
         LA4hVsROnNzcqWzbOKJXm2AoA5Q+7s/lrzJmqiJizh6JKiusIe+hmqp79lazlFC3f2zb
         SakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f84KIsdaJQ9CPJzDHYp5jwwgYBPwNj7/ee/65YueU+Y=;
        b=fHOR4XT9uTO9h0aet6SKg9VPohYpOEGdKo/OYLlkp2H9mlL685R6dRbKZhvIsWXUcF
         /DTwYbCFgMIFCY/mMmeE6ji4f2ce9wnTE2Nvdw3HpJ+Z5UFwte9abHGXBM4HcM1kXV+P
         ww496IwjccTAfhGu0ppvEfpSJ3fyhGhGv7yrUlUYMMt9l3C18/bvp46C+GP4k4gpFewd
         /Kt7+6vjU3yHIvfQzP6y3ZBv3Gp3XFOPUZZ1XwIz16FIheD3Ai7pLRvXKaIerXxiI48n
         pDnLtPloxImq42+HIx0tCswE5KkTVB544fGQxds9M+AmyVwFzWt9+YER7ywOkHdFQvQW
         MIZg==
X-Gm-Message-State: APjAAAUqLtBJah7mCoFJhCuzXlakUGC2kVNBtgtxxAIzJOn2MLDofg67
        7LjWV0K0OVcziMtiEVe0xJo=
X-Google-Smtp-Source: APXvYqz9dC7RKAOlqFDZMeGfKlNjJXmRRsx9AY9x/8J/G5S482nwbvIwwIGYOYLQ0ZUUl6azgsxVog==
X-Received: by 2002:a5d:5507:: with SMTP id b7mr10649444wrv.35.1565181762489;
        Wed, 07 Aug 2019 05:42:42 -0700 (PDT)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id q20sm9490692wrc.79.2019.08.07.05.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 05:42:41 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     aisheng.dong@nxp.com
Cc:     oliver.graute@kococonnector.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv1] arm64: dts: imx8qm: add compatible string for usdhc3
Date:   Wed,  7 Aug 2019 14:09:25 +0200
Message-Id: <20190807120932.29850-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add compatible string for usdhc3
---
This Patch is on top of 10/15 of this series:

https://patchwork.kernel.org/patch/11046343/

[v2,10/15] arm64: dts: imx8qm: add conn ss support

---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index 00ae820d5175..8c33edf0744f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -19,3 +19,7 @@
 &usdhc2 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
 };
+
+&usdhc3 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
+};
-- 
2.17.1

