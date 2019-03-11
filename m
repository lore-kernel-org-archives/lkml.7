Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE0F2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bTZUoHA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCKPD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:03:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38878 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfCKPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:03:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id n125so3896768pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=339cuj1SwivCqfuHe+ww4z/In8uNdl0g0CZZZUchuN0=;
        b=bTZUoHA46lNvvnCfHGEY+l+GowjdEGMVPri71RA2jlWOlOCVAc0ew+V/enPHzTVkvN
         NU11krMrkzcKxL6MMR9prDFF6+0MI/LAxtbyGAF9/KIEjCf+BlHceT/CrYc9Cghgxt98
         HNpgEWWgJkCu2N9NZMJxty2jfSxj3JLgFMfqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=339cuj1SwivCqfuHe+ww4z/In8uNdl0g0CZZZUchuN0=;
        b=mvVJjg71nvztXJxM2jyNOWel/RVvj8FGv4ToZ9IpB+8fSNYNOxSbOrBTyo0o/OWHH5
         lNGciPvebSdZKMx2l776eRkI3i6VcJ0VYiHgz7BlrV6ASctHkmVt6N5z8RDTK5f9vScO
         1UaQ6OHBgqi7KFWJA+vA+v1WsJh1q56T4yWRT4+HehyHlPDA0nae87fr99tDXBzJDIKB
         U9X1Y2oLolrFK0toLjZKsiWBv82UvlcCAujhUeyaYmWLqjhNsvlt3Yr0TmnplvZAnVCi
         2S7mzpi8OBkR63BU1XCqa1T4m5s54LiwkvXQoE5CiObZ9JMoCtRrEXjNGAwBeuLCBDaE
         /B1Q==
X-Gm-Message-State: APjAAAVR2y7j+QwjvokHR6BmVIIlPQgE2UjpBMaI7q7YMZOFhdSnB4MQ
        JBOmQHmcO5puzH4nWTfhcLf7dQ==
X-Google-Smtp-Source: APXvYqwxCKHgNRv1edO14Zth/h4eCdfBnVoBpfLgSv9pLwN+kjvmNmQT79kAIxOgajCOh1ziyShLdQ==
X-Received: by 2002:a62:bd09:: with SMTP id a9mr33092507pff.61.1552316637043;
        Mon, 11 Mar 2019 08:03:57 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id x5sm7594531pgp.68.2019.03.11.08.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 08:03:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Akash Gajjar <akash@openedev.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: rk3399: rock960: Add missing GPIO for vcc5v0_host
Date:   Mon, 11 Mar 2019 20:33:32 +0530
Message-Id: <20190311150332.19492-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190311150332.19492-1-jagan@amarulasolutions.com>
References: <20190311150332.19492-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vcc5v0_host on rock960 is bound to have GPIO4_PD1.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 68ca3bf9ea2f..c3d3343d6dde 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -68,6 +68,7 @@
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
+		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc5v0_host";
-- 
2.18.0.321.gffc6fa0e3

