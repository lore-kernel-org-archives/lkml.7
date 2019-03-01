Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB8D20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kdNvZIqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbfCARLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:11:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36423 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388635AbfCARLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:11:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so11715881pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JAzuulP94w5bpQ36/S8koiSOdc5JDbS6it/hml2MUc=;
        b=kdNvZIqoj7tNVlXEGAQKuOguxI0q0XIWYYSt2s+D1xLhPyQB8LzOgKskFla2QeWkxY
         z4G0FqeBx0hzoMdTQa9mEkzz+v7U/7QEPt71kqLb4roKwI/QmG2odlGBYJyPDJFWDNrB
         aPudh1lGSjzh1alfACMyzK5aE5MqsVosWWAUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JAzuulP94w5bpQ36/S8koiSOdc5JDbS6it/hml2MUc=;
        b=r402tEB2w6G2ITEWFQSBMN7ualKog/teJdwVmjSxx+XR6G5gsKcveLi1HPPOyqLXd1
         kjm60hgpCFemiTXNOwGZTcgCtbNz133SxyLGNBFrfSfIkVVKB4RI2hVILI3VxRbRWSSs
         ASStYweEh7GLM3zHHzkZq7oTgp7K4b5/0jGsxyM81s9/igSenDgilsLp8y0Of+Q+g4Nx
         sGNA3rt/W0hQA3/LdB9l67C59UJwiC4adBHOzxQxau/tDO5sikSL3G/vk2bm6eT5MABl
         MBY7Z8e8fsUPKbJhrroaX91P8KtoyhHT6Mw7fLH1NEsUq0CLxHvTe57ZiLOu3SUtx8mT
         RtLg==
X-Gm-Message-State: APjAAAWy1/uJE6wMIKVsUFu9UexDBT6Y/jG/1wKI2AW7/q4U32/reGgH
        ySl/SXdoLc96lzr5Wj5NBHl+CQ==
X-Google-Smtp-Source: AHgI3Ib67s64vDX63ITkjLuh986GCDbegyEpdhaNrfol2IGctPL28D804lSisKsOI4h5TvXhZJL5GA==
X-Received: by 2002:a62:b502:: with SMTP id y2mr6522629pfe.212.1551460264931;
        Fri, 01 Mar 2019 09:11:04 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id 23sm44802456pft.187.2019.03.01.09.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:11:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2] arm64: dts: allwinner: a64-amarula-relic: Add STLM75 sensor
Date:   Fri,  1 Mar 2019 22:40:51 +0530
Message-Id: <20190301171051.6964-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amarula A64 Relic has STLM75 sensor for digital temperature
and thermal watchdog.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- change node name from temp to sensor 
- compatible patches applied in linux-next,
  fyi:
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=985e225142cf0cb826401f5448763f13ee712b3a 

 .../dts/allwinner/sun50i-a64-amarula-relic.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..3575db216016 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -34,6 +34,21 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	sensor@48 {
+		compatible = "st,stlm75";
+		reg = <0x48>;
+	};
+};
+
+&i2c0_pins {
+	bias-pull-up;
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-- 
2.18.0.321.gffc6fa0e3

