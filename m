Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9A0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E30218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mK9Rsz2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfLPVQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:16:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38909 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLPVQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:16:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so6305335pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntIgBb0h13t3tiR4TtlPN2L5O6wmrHO06lZ+oHUf8jg=;
        b=mK9Rsz2FG+xHhtlleO+mSKzlJaUzEhUpfDP+f8RpwE8RGJj8s36XnKe2YV/pJ4dMlg
         TtJCOA4sp7pApewLPjig+hXm66+TlZ4njx0f6CMDhiP11IzlPni3VhRXwIiOLwcynNc6
         uSQs5ZI0f2A7hLAkrD1u7FtzNhB+7CNDncNw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntIgBb0h13t3tiR4TtlPN2L5O6wmrHO06lZ+oHUf8jg=;
        b=dxkXGLZJs944nXO0hktSodTQUVTgiRN1EpmPWw4PA/InXqj46SslNBjEXJ40sbJP9n
         mzlqFJAd16fDc8O4gTSh5W8V4eDBS59mG41gGudcBObkxkZ7PbjsJbnltFmsEjj+Bzcl
         tFBBctAziptRC6oMCA+NzfbTZgkVlGIN+U0rQuVv3EcLJpcZjvBUF7W1MJeJqcEWbSJ/
         dhxeS32IAQNYYSMdl2c1tQu4IjpCxrpa+ECtrlpKaKnynm43r7rtd0d6Y8D4+nuu0SBy
         5IHCZZ313AcHTi0PKhWnw9FlHlSg/supLTnhbbIKcmIF/vFNiX+jnrigNOrmSgWNK3LG
         suUQ==
X-Gm-Message-State: APjAAAUotenuyi3M/W6b4pmtrsyPssqu1JqvwGu71UcPSsK7l8f2atEG
        r+dD0t5mB8dO49UcCS/3oBJgdA==
X-Google-Smtp-Source: APXvYqzLTVkJMbv7KH10k65m6pZQ57AvlakAYffc8EeqPonvZK2AHxjNlhqFhI8Tiyyz3hEaVF+UuQ==
X-Received: by 2002:a63:1908:: with SMTP id z8mr20937416pgl.350.1576530974281;
        Mon, 16 Dec 2019 13:16:14 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 81sm23402797pfx.73.2019.12.16.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:16:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sdm845-cheza: Add cr50 spi node
Date:   Mon, 16 Dec 2019 13:16:13 -0800
Message-Id: <20191216211613.131275-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cr50 device to the spi controller it is attached to. This
enables /dev/tpm0 and some login things on Cheza.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 9a4ff57fc877..f6683460dc82 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -651,6 +651,20 @@ &spi0 {
 	status = "okay";
 };
 
+&spi5 {
+	status = "okay";
+
+	cr50@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&h1_ap_int_odl>;
+		spi-max-frequency = <800000>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <129 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
 &spi10 {
 	status = "okay";
 
-- 
Sent by a computer, using git, on the internet

