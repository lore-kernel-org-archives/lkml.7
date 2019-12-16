Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E008FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B146224682
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qxjn5BB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLPXmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:42:06 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44938 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:42:06 -0500
Received: by mail-pj1-f67.google.com with SMTP id w5so3695867pjh.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDyvDIqdNyLcx4V2i25mbpZbeEe915JVgGFlXA+zH5w=;
        b=Qxjn5BB1mSPYMopx67Uuhuoi0ZWzpj0NjW4kRVI1JYR7xPEVyUJRT5Z9+ZSc6i6pCC
         o1ln1pemHpWjnEqecBhD4oxZHcstblycd6kE7vhOeLvXFEVh1i5JWrxz9oQ5yjscp0e3
         XONLp1TfVHKlCjlzm7dEbPkQNsKdPrlFZKpMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDyvDIqdNyLcx4V2i25mbpZbeEe915JVgGFlXA+zH5w=;
        b=nobVdKv1eJc6go6su3bRxVBdmFxEOXHOq54Sg7P+p+Ov2t2NcAChPeilPAis1D74p1
         DwPM1MZIkHAoVEulHhqLVkEz/OrLCOXgKxKBtwuezW9eoQcbzrD3YS+OV1Lq2pH7AXgC
         Dbh2FaJ4UJAe1T7LCQVlhi4MKCF8tP/qxzs3iqglPTzIwl18Eq3iqm+w+lxcohVF3FBz
         XmYUQuhxEOKjYL0rqP/4CYqmrfy0eTcrPJYhr/YNeHY/zuOOEmAdw+9M2FX6AidYLqlh
         7EilUo6bYLtvJaV6Ruz4mUEBzkHRcSwkTMg+yFTPKFMDyJz87ciVkBTsuThNW2BcfZ5V
         pE+w==
X-Gm-Message-State: APjAAAUBskTYH1L8fJ6mj86gsdBxhYbeBEBXquANuyhxUSkYaGI7OV2r
        nu686cWSjL5GQ4/t+/ol9upvD3pAIDKSxw==
X-Google-Smtp-Source: APXvYqw4HPLBvMTotNyMS2JzWt5rQ1xusHqkl5mTKG6mEBNNKIFYcvOkQLR+jEb6RZr3hDfNq4X76g==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr18686496pld.293.1576539725616;
        Mon, 16 Dec 2019 15:42:05 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cu22sm632053pjb.13.2019.12.16.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:42:04 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: sdm845-cheza: Add cr50 spi node
Date:   Mon, 16 Dec 2019 15:42:04 -0800
Message-Id: <20191216234204.190769-1-swboyd@chromium.org>
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

Changes from v1:

 - Fixed node name to be tpm

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 9a4ff57fc877..b59cfd73616f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -651,6 +651,20 @@ &spi0 {
 	status = "okay";
 };
 
+&spi5 {
+	status = "okay";
+
+	tpm@0 {
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

