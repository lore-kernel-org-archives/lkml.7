Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15885C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1392253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ7IVTGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfLMFRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:17:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41796 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfLMFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:17:24 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so688862pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 21:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dqy/QJc+oAc3Pxm6PYdZfNowES2QjcoSqMXPASTC9bA=;
        b=fQ7IVTGGzOAEHEHDike9EbOXDYgyyH8SgqW8MpEv4RvmXds7m5DItzvv90k1mA4AWU
         r0B99PPCANcjubVxR2JlNYr5ZVZp4vStws8TElJuPAvjd+WnaPjr0dkaaY7cn00j+gqJ
         wAZQhF8azeNbXTv67uYl1GWU8uaGgve3/lqC9FzGZz9Xz2/3mkJ2BG++W4qBGsAHtdNE
         hb4QoCCe0pvpf4/wIvEsrEhQRDLtmbonK1QpB1Kr4ekgAmlwqFR8+NUaqj0MtM/dHkx4
         L1k5QYPsj5zarkYoHe4J7UvE+YXDfAeLfbzO7ceU+HlSoOslqyqxTqG7TJrxjSKyaAdB
         lSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dqy/QJc+oAc3Pxm6PYdZfNowES2QjcoSqMXPASTC9bA=;
        b=MWF97O07WV9rFJo4RMZaF5Xu/Di/k8z8jmGm+ZJ+Mbgt+KdRoCQbv7eimQR3ZZCiN9
         ZATzoYHvCdLTSJVdc+p8exUTWik+aknjrPr9F1KrZlX2ijRi6Kv7jTlD+drNxq1MI3Gm
         qAfFu4miD2tJ2Q36N9+TdWTgyyiJ32ZAMKEmHE8bKZteVyGkiqqm2xxIe3ohpsSoH6BX
         oWkS/CBMInZz9kIi1E8Tkiy+hiHOzknOyjMLiI9wMAgZnP+XiPGgKXFFAWEgonhH0e+7
         vzNqIz8DuClrUmrzMWcikY86Fk+55og42hQZTYCVBUxWcGFdmuIqTk6S8xVwAFbuD7Jj
         eivw==
X-Gm-Message-State: APjAAAVqp1zgDEabd/VmbBFDPxejnqw04b2doyE8M++JuAw4PIVwhi2K
        9TaYg42PPiJF+BqZ5dMYQwiz9g==
X-Google-Smtp-Source: APXvYqw0GCGyKVbRAws7+exdzFyQp9oKPWroXC4euAviWcWLLtamSORnI4MfqTWy17WmSxdzhWGTFg==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr14596181pjb.62.1576214243274;
        Thu, 12 Dec 2019 21:17:23 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g9sm9862109pfm.150.2019.12.12.21.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 21:17:22 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: msm8974: castor: Define pm8841 regulators
Date:   Thu, 12 Dec 2019 21:17:19 -0800
Message-Id: <20191213051719.3688771-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the pm8841 regulators under SMD/RPM, to allow the modem
remoteproc to set the voltage during boot of the remote processor.

Entries are just copied from the Honami dts.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../dts/qcom-msm8974-sony-xperia-castor.dts   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
index 701b396719c7..4655e7941232 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
@@ -56,6 +56,28 @@
 	smd {
 		rpm {
 			rpm_requests {
+				pm8841-regulators {
+					s1 {
+						regulator-min-microvolt = <675000>;
+						regulator-max-microvolt = <1050000>;
+					};
+
+					s2 {
+						regulator-min-microvolt = <500000>;
+						regulator-max-microvolt = <1050000>;
+					};
+
+					s3 {
+						regulator-min-microvolt = <500000>;
+						regulator-max-microvolt = <1050000>;
+					};
+
+					s4 {
+						regulator-min-microvolt = <500000>;
+						regulator-max-microvolt = <1050000>;
+					};
+				};
+
 				pm8941-regulators {
 					vdd_l1_l3-supply = <&pm8941_s1>;
 					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-- 
2.23.0

