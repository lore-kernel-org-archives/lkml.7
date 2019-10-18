Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62965CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A12B21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcbPssRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407026AbfJRF6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:58:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45542 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbfJRF6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:58:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so2719389pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kf8Wl/hDIqlCih1Sj7ch2+u/J8zBMzyn3cjl/QZrjFA=;
        b=VcbPssRYtYFfLq3BlQOzi3O3UfsrFx3ywu4mfvNFSYE5JuX7HMOJy6QKGeSqjiJzB/
         Ow2LRoeZPXI/6sQV6wua4F9IpDMXhMPInzYZ6dGBeG8c2TjwRPUbAXHtMbGt6VaSlciF
         7C9O2WTfDLMBAmRFTdhCIxi8/pHvXovHwhFsNpFdurGvz7XFlDOLsDS2+2VXfrbcv0Pd
         JmLpQSKXWbvq9Ei5zpuLtSoBW4AVkWzI3soVpOw6j8+NQxhe1FvEhabvHK3YH//Fw/jo
         WpTcCDyiFMYvtxMSssdXOnUBJwBpiBRCOYB9MttDmXOxjUzPnUytmdCTiPzVrpBOLWO2
         kHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kf8Wl/hDIqlCih1Sj7ch2+u/J8zBMzyn3cjl/QZrjFA=;
        b=qaoUOT9PJ5Ao9nerI2lonKSoGDUdhzEXs7iEQLG8hiWPyU4Ia9ylGyolH1WTWwYkXT
         NFgaA51b6PFE1mGizP+CtdqY2Pohw0xd7MJCygXrW47ZYebVpLS1/ixdaPI2D1+MNRuC
         hbK39Pas6MLUQq468lcDsy2HhbSy/IegxwHUV5jvOAgs75VZ127lGYK3aJmqOxRpkh/7
         8t/YOqzQcVcFjB93wqaKCK7Rdn8SWgyo7Ztb5ZtoBCzfNd4ddcssIc+0V6cvIrDyoyu7
         446x/16AxX3HZ8Dczbzvhv8y+SQrosEC1RcxR19B9xhHRPIWNOhkjYPmsdlK0V3m7Aaj
         +ThQ==
X-Gm-Message-State: APjAAAUG8DMXO7hsCxOw1ZFkcW8oDOIW6JUj7ciPqZnaN0MiWRN9PJd+
        yRHy/wjVSaWlel+koKdBKEaKZQ==
X-Google-Smtp-Source: APXvYqxGwnRoQLug4jtB3dhzUdDRkIJWOtWJl2b/CkR0ciyZuyOcTWg05+6pXxb0NwOwdDmBW1K28w==
X-Received: by 2002:a63:160a:: with SMTP id w10mr8499180pgl.212.1571378325034;
        Thu, 17 Oct 2019 22:58:45 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p66sm5727799pfg.127.2019.10.17.22.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:58:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: Add WiFi node
Date:   Thu, 17 Oct 2019 22:58:41 -0700
Message-Id: <20191018055841.3729591-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify regulators and enable the &wifi node. The firmware uses the 8
bit version of the host capability message, so specify this quirk.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 01709951fdb6..53d4d40dfe43 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -461,3 +461,14 @@
 	vdda-phy-supply = <&vdda_usb2_ss_1p2>;
 	vdda-pll-supply = <&vdda_usb2_ss_core>;
 };
+
+&wifi {
+	status = "okay";
+
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	qcom,snoc-host-cap-8bit-quirk;
+};
-- 
2.23.0

