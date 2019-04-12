Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6852077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUOaUBQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDLRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:25:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46415 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLRZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:25:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so12880659wrw.13;
        Fri, 12 Apr 2019 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+XyBAec1IZYURNjo7Paci4kN3iS4hKPrUQv66Ew8HwE=;
        b=EUOaUBQLqLRTo0ysDGff/5pgXZiPkBdKVLN9uP25A51+7/+2w/xoeVoRow8lF/yegl
         BOYQ59ZXGyw2tCgBC3xWCkk/SjM1j/Lm+wLlA/7rNO0Kwr5+5ikkueYCps1mhgn8sh8t
         GakCo5A84kQzWfTjImTD9TK5BR/e76nmDjz9AhrWe12gieySAjAGsB0MXC9xAXBo62U4
         XFE+fkk4EUtrVaufkCpydEJmrzG3Sxz2qsrcHf64RdVZ6U4rO/RAUHmoBWkV7wMWghsn
         yM7yjXVi0HJhUj+uh+CwYGzbjlk1E17294XsO94D8WK3UuvAw2hn8iBtID7xLtOsWjCt
         2A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+XyBAec1IZYURNjo7Paci4kN3iS4hKPrUQv66Ew8HwE=;
        b=koQftluoyuhwjeOlkGLMYYcVdNMQMvLL3o5cGIsiTfsJ+R1MK4yragI4Otf9YAK0SJ
         LPSVVFW0wwBdXbpQpucm49KFR38zY3d+yP2rVMlfiX9wXD/NrsELgVbLdH6PQIG/ey5d
         ysTKFyPhz4fu9bhxN3CHKB6dwDI0oNLxuZfFbTc++bepTXHztJtwCIpB+PC2vsvGOpXx
         ZHw4mHhtrmk/uAPdMdBp9FSoDk3YeKSB+Yij3hdptiEVHDMVI6tiflaHpxFMb7lEj4Zf
         V6Jz5m/KhWv3u1nAtCOld+fpJKtMpAS0O8OOsu337HzFQ2I8hZqyRd27i/05EWbBJfWt
         1BXQ==
X-Gm-Message-State: APjAAAVuxzo5mOHn9jZ7SLIPAV7sTVW7kWZ35LO1fWZL3S9J3ECqYDUF
        UDjaq2lxDqyCBIirHFsk1ok=
X-Google-Smtp-Source: APXvYqzQirGmrnpatvN66mQFnSP3C/FYoDJ3JPyX58CAEBrf3henBR4m9bpE/wSPL5QIb9MMbH0gIA==
X-Received: by 2002:adf:f088:: with SMTP id n8mr37996419wro.112.1555089947642;
        Fri, 12 Apr 2019 10:25:47 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id g8sm68134975wro.77.2019.04.12.10.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 10:25:47 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:25:46 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
Message-ID: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree entries for PMU of ARM CCI-400.

$ sudo ./perf stat -a -C 0 -e CCI_400/config=0xff,name=cycles/ sleep 1

 Performance counter stats for 'system wide':

       420,303,619      cycles

       1.019058775 seconds time elapsed

Tested on Odroid-xu3 and 4.

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff15880761..be58650aca35 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -158,7 +158,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x10d20000 0x1000>;
-			ranges = <0x0 0x10d20000 0x6000>;
+			ranges = <0x0 0x10d20000 0x10000>;
 
 			cci_control0: slave-if@4000 {
 				compatible = "arm,cci-400-ctrl-if";
@@ -170,6 +170,16 @@
 				interface-type = "ace";
 				reg = <0x5000 0x1000>;
 			};
+
+			pmu@9000 {
+				compatible = "arm,cci-400-pmu,r0";
+				reg = <0x9000 0x5000>;
+				interrupts = <0 105 4>,
+					     <0 101 4>,
+					     <0 102 4>,
+					     <0 103 4>,
+					     <0 104 4>;
+			};
 		};
 
 		clock: clock-controller@10010000 {
-- 
2.11.0

