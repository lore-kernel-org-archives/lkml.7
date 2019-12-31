Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58969C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C68206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPoYQr6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLaTMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:12:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaTMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:12:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so35810629wre.10;
        Tue, 31 Dec 2019 11:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ugkmn+9FfNrqX0nLEPxcXHS7THYr0ykg5MLCv/1z8zQ=;
        b=hPoYQr6hMewVT8HtmuJwWQC8WdcrMBGE/UrhU2h5c5RnmqBdO49jlqYz8Y9MkJTNs9
         k1WVy2CyUSgJyQmeko3i8bczYU7u1ATfoFn+nRmG0luUfq6PfNHNgE1dsaxNOMCWDqNz
         xatqT2VOpXN/e0Oy8UVoJ3fo4Gk+LthmCCENPLQOQridmr7QnkY49h9mqPo9i4wEYPJn
         kH7YsFPZwsQlu1tHi0hk/U5I9FazLr7NeAWxvuiCDPVCvmQXrmaAckzKEqM5NFRsP6Z7
         IJOIiwNvOAK3vfOfgXyaTZCPLWSZ5H1a1v8nB8H/UveDGaN+72Gc9utfRL4E3RfFMK7Z
         KuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ugkmn+9FfNrqX0nLEPxcXHS7THYr0ykg5MLCv/1z8zQ=;
        b=fLQHtfM/enq7gpTKuOK12fmToXVkVUkYjnLqqmzrPlLLU68Euy9IVJX1DGE2WimO9L
         Vl+Lq1wmR+fmnOMfzhdTdSkSjNY8dptVkeYl5f6DQ4i9iBD3D3/bE8MQUsv8/aopUsJH
         rYeDHQ7djq0GOl2p7zseUZHF2NLwkdFuIi2i+Bmg43KPdwZvU5cnHCi/M9YIL00EU4cq
         0JUEWZ2wIEK6lSbkhul8brwraEQ23nQUezZ6+2ba/bxE7Gb8fI/8wOzqV0Mr9eQ6JWCD
         FRipnPBOjI1Lk1jEqQXFRDYcOqEj5scS1+n8LOZhOU7CHja3+NKbkDFwfLN9l0JQMYsr
         bEjQ==
X-Gm-Message-State: APjAAAWmpfnMWT6woOQgo6LlCsJ/odDCV5nYf0ALZvqWV5RCf9X33guc
        /8FSYzdd42u9xosW7EI9I/g=
X-Google-Smtp-Source: APXvYqyF0D0ikIVwTiFMzj6mqfRpTZsJr/v++9vO8XHr7OjNm2eCLMU36XEndCzwnyitR0Cm69XkjA==
X-Received: by 2002:adf:d183:: with SMTP id v3mr43483613wrc.180.1577819520818;
        Tue, 31 Dec 2019 11:12:00 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q6sm53695403wrx.72.2019.12.31.11.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 11:12:00 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399-firefly: remove num-slots from &sdio0 node
Date:   Tue, 31 Dec 2019 20:11:54 +0100
Message-Id: <20191231191154.5587-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option "num-slots" was deprecated long time ago, so remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 92de83dd4..7584351a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -660,7 +660,6 @@
 	keep-power-in-suspend;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
-	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
-- 
2.11.0

