Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93884C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615B620872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfs4cUC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfDACYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:24:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45790 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbfDACYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:24:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so3734532pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dp+KAOig4MbV+uJnwASkViJP+U3MnsD8F6PLsh9jNDk=;
        b=Cfs4cUC57AzT6qfOgV5uyJwIhzXkHn1HpUJZ2oYsCNL0IxnDJ5CcvarcEQLoHG0iZ9
         fxzocSPX+87tFRwgXIbL4f2LSPHXnsFBb8DDm9qgm+G8pGMAq8+fN47CwSlCp44SWObT
         aeHpjhUTC0IL5TucCvDhJ5gNi9OfxMHQYjzJEMOq02BFIvmXzAYNgCv4Ynlpgy6SgHit
         bT0wn/eBz03l8DOEBcMBsQbATVW/jeY8r2WTi6oSBhXc8D4Bf5HmNG+HtNX5hCd5yCqx
         5xcKgvN4g/dE3ZpxT69ewdtE7JhgopVte9tgNDZzqg5cja9bMuO+Wu7qxO7C1pNWhq8U
         6p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dp+KAOig4MbV+uJnwASkViJP+U3MnsD8F6PLsh9jNDk=;
        b=VXVauOFrstrjqQxktF2A9SpUrV6eU1JZiscsGQQ5xvAGbzgSLljj5rXtsqQlL2gb+0
         G/gDK1tT4Tw70zuoMCK6PLpZWMXO+4E8ddBR5GdZlYpFHZz+Bsy3QBhDGC9087ndMWd0
         w8h3GNjQ2IY15WqJMNe0LsOqbCcG1TPnpv0ulHmjnSvHx6V8SxmUmfyEhk9p4I4RC79h
         tsbpp7i6qaxYczTDp9VeQPUxSDbly5VuOsYi8jgqH3zoXVujWlqBaturQrHpxZ/2V0Sj
         fqu2yU2TjOTHDZvTd7V1ksMlMNVjmNG6aLMpilHyG6In7XYhERVH978izTu1Q8mvr2/V
         WWhg==
X-Gm-Message-State: APjAAAU6bJ4IiRoXbkGYf1sjBqOQqdGkmhxV8dtNqwt8H9ByZ6MgHSRz
        fSVkfzx4XsEwyUn3WFgpZZY=
X-Google-Smtp-Source: APXvYqx/gJOTqXTew+v5QYd4wK3uMpnMTTNnjlDP9Tjx5sIrztjRYlPDjTBGwI9HS3ygaFEz/G6ikw==
X-Received: by 2002:a63:945:: with SMTP id 66mr25690827pgj.128.1554085472375;
        Sun, 31 Mar 2019 19:24:32 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n82sm13597289pfi.63.2019.03.31.19.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 19:24:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date:   Sun, 31 Mar 2019 19:24:11 -0700
Message-Id: <20190401022413.6682-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401022413.6682-1-andrew.smirnov@gmail.com>
References: <20190401022413.6682-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to NXP's FAE feedback and a comment in ATF firmware, PCIE1
and PCIE2 power domains can't really be used independently. Due to
shared reset line both power domains have to be turned on at the same
time. Account for that quirk by combining PCIE power domains into a
single 'pgc_pcie' power domain.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 656f7cb97703..d7b564501fa4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -472,9 +472,25 @@
 						reg = <IMX8M_POWER_DOMAIN_MIPI>;
 					};
 
-					pgc_pcie1: power-domain@1 {
+					/*
+					 * As per comment in ATF source code:
+					 *
+					 * PCIE1 and PCIE2 share the
+					 * same reset signal, if we
+					 * power down PCIE2, PCIE1
+					 * will be held in reset too.
+					 *
+					 * So instead of creating two
+					 * separate power domains for
+					 * PCIE1 and PCIE2 we create a
+					 * link between both and use
+					 * it as a shared PCIE power
+					 * domain.
+					 */
+					pgc_pcie: power-domain@1 {
 						#power-domain-cells = <0>;
 						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+						power-domains = <&pgc_pcie2>;
 					};
 
 					pgc_otg1: power-domain@2 {
-- 
2.20.1

