Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7283BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390C021773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnaGdy5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfDERaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44767 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbfDERaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:30:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so3631619pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvy4jiablMjkp3jrIwKlN9pmB9uILJowYkcpvqR6Ge0=;
        b=FnaGdy5R3VV/GFNcZACrWfBJO5pnLKzOp8KUbE+TeqLXeBqNZlxTOVeVvedIwX29T9
         0G/NrRVzyzReABdtBxY8dfCrjUgLjjuE9B7CTJuWRwPpaqRhrCPU3qZk9lNzh+XKRlzb
         3chlGebyUbXcCD2XRKcB8XuwdVauUHJJP1Ugiubs/M2gYMh/gdv1sqmLagwWyjyjoy7j
         zEhUfzmsd1R7Jha7PKO43XsA3RBTNy14rsi5mKRJ8FhhNUWPCazaG+nuNOjE2Cv5cUVu
         r2ffGlHrYlnvuOyWe13snTK9jRXmcVznKyR/2dTpHwB4xyY0EApvpW7tT+0/FQIYyknK
         sqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvy4jiablMjkp3jrIwKlN9pmB9uILJowYkcpvqR6Ge0=;
        b=N3hcH2aH/LdNWJ/M53OFVFNRABlysT85JIfEg4uILDYxlEZdx0GGNGpyKE8c04kn7W
         qhBh9cPFBaBSyMJS9hTZIGHi9gzZsvooQpt6g3JW7cODNPbsX+Gj6ad59ZeA20skG2ae
         aY4Z0avjzUJPTba9VelcJ6Ca8d5PflntxG8q4nMiVcfMQrLA1txBBQhaRXwfg2HZyNhr
         PkIqUCIGWUYW1lyieXnivKKUPjMY6yuIjtYLzU51ZeOB7B7VtyDhe7JgOtBeSAn1RTtQ
         Bqyij34BpfKcYs2hzVb4I1IDqvK168rqEKtyGufKoHKqfyzwjpREG8VxLN6gPKKFzKNo
         WP4A==
X-Gm-Message-State: APjAAAUh9WrTjIguP4pyUg876q9yDO++hx2yd6rOsQObe1SRWzxjAo6Y
        1EGNMWsbmyAjLAlYKpSKqyU=
X-Google-Smtp-Source: APXvYqyU7DwtNszH+EIFUDBLC3RRQ+Vz7GITfp657KrI6kmfyZM7umbUiiKzSrFaABF9f8MR8gUUIg==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr12913947pgk.387.1554485421609;
        Fri, 05 Apr 2019 10:30:21 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 17sm49206730pfw.65.2019.04.05.10.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:30:20 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date:   Fri,  5 Apr 2019 10:30:02 -0700
Message-Id: <20190405173004.13277-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405173004.13277-1-andrew.smirnov@gmail.com>
References: <20190405173004.13277-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
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
index 83d023aaa048..a85c3bef66c2 100644
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

