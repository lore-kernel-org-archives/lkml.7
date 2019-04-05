Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B976C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6604920651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/r0bq9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfDERaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46425 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbfDERaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:30:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so3628036pfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLy6bb/4LPYJhbuV9KqdWRy/+VxxWR7wsVRqrK6RQHw=;
        b=s/r0bq9+O6p06TN5dWhrKIdhGzQNy3Tfm6G/oOt0yAkL32JWohbyBdnY2pIBcPVKmW
         9kE78tWP18+tIKOYoHkgQB1ujCbKXk29LvPpVLHH3TA2NG6Sjo6WfH5ldBRiKtS9n5yl
         jbR9hwohbWGSwrwP5fuFumhEFe3xbog0RP+RFTQIRHNRkp5F/dRaxONdiwb68v6Yi154
         y7K41fTT3le2yJXovGobCNDARKDoJzCNCvtPjBcD1OnN4s8Dg4htCZM1RgIwzjoupiHU
         PG8afltHkD3xUX7asQyoTuUyqyVD/Rt1igVVhCr/O2bMxj4jdGAcegy4/8KUZTsqUFIZ
         PL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLy6bb/4LPYJhbuV9KqdWRy/+VxxWR7wsVRqrK6RQHw=;
        b=WBgC10+4zbGYdfVIKUvhsLL8dklHaGH0DUgGvRdjsiGdETfocKU6cf92mxsVQC+Y+G
         Tltk3WJBMwjW2tmghvPTPs5l/d1nhk87E0Mm/5sakOgXKpFPGKgTfV3iucYADiW+x89u
         75sRe/+ZlGgP2vXnZtmWS3jTg49PHrw45wPx53JoXte+mf+rcpnmIS7zoFLGIAKSLWwH
         +e7PMgR7Eu8OawDDd6HQZrWWlZOHi67cAdZkO4iYQtsZ2xVvN2bYjWc7PLtV6YWKodtx
         PkUgDiw4BbiexY1vA7rZMFjlYJUVgogd2rDMEhYIMhWZ5pm+uiZStNLOfyOm9IWgLfyU
         EK1w==
X-Gm-Message-State: APjAAAWxh4qzuy/ROyj6Xgz03JdhSFPsjX6Fg8CW8DjrjVC/UMZxvXkO
        +JlWvsVDtIdrzwJsHXC7f+Y=
X-Google-Smtp-Source: APXvYqwJV7+rwBBRHSOPzYTFZ5bXTd6c3UrkclGAmvCbmPuzORdTAfVzh8h2ebXwXo4BT8V/ZArhSA==
X-Received: by 2002:a65:4302:: with SMTP id j2mr12681558pgq.291.1554485417591;
        Fri, 05 Apr 2019 10:30:17 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 17sm49206730pfw.65.2019.04.05.10.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:30:16 -0700 (PDT)
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
Subject: [PATCH v5 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date:   Fri,  5 Apr 2019 10:30:00 -0700
Message-Id: <20190405173004.13277-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405173004.13277-1-andrew.smirnov@gmail.com>
References: <20190405173004.13277-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index feb195984997..3de390777af1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -404,7 +404,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1

