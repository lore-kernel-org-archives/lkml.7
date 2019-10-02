Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E761C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C336207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUCtj95v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfJBTOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:14:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46192 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbfJBTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so11003918pfg.13;
        Wed, 02 Oct 2019 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/qPlGqzwiHfUgsEEnoPvPDRChosCodooY7FGNhUIqb4=;
        b=oUCtj95vawtZ6VFMXXreO5ecMCUqNCDEHkjPFiP71I/EyVK0idhjd08I5YpAGbN+fR
         cO32ZA9ZTIeqPm9l+7EjnuAzT6YnCeeAJNEgO3eNMG4HRIVECN1N1Ave9D0q3ksJRnqo
         /3/bJBnfjU2OLdWbH8u1XT5bPtJB2mwjfAH47vLd8t4yW7rzSgvCHH+0MOWhIimBsVV0
         dxS5DZdbgVTZ8/YsueQzWUpeCIc9iJN1yK3SRDseJfgy2FI8SPHmyRNKzaAyvOHOjAiT
         G8bhMflOWCsdt23kKEpKkfPlSn5ulIHTIu4Tnf74hbkBE/nVW7S+I61zQJ7Tk/V47TBe
         DbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/qPlGqzwiHfUgsEEnoPvPDRChosCodooY7FGNhUIqb4=;
        b=Od2Ch1dQTyM/R4d0siTNhYcczOw99W1LeXd5kTBswoqi3yURhj6pESFwgXJCIBd1mB
         wKspvc3acLITz1GodRCB17/OSvMuLzykfpKjpeKYOkSRkIRFCG/dtRclfs8ToKPXyUbz
         dhkCt4zE7cq/xjQEgdhN+a+6/PISK4SLv1bKdbvCglAGtIJBGVgJgwbiOrgQZt1RGDLs
         lRmr4SHTlHx0FMZHaVUclA4jy6I+wJLlULvlNI21FPONgU8ApxQF+Uy3eP22sgGF3GcW
         z0zolR2R5xr5Hyz0LPUShT9pQg6X2qne3q/ln320Co8x4jPFxXBVTYySYOgNAqsaaxC6
         hKlg==
X-Gm-Message-State: APjAAAXvZxXhLCXWba3CE5EKhFbGZd7x5vxEZUYCnmhEliRrks4HYqgX
        BlPM4cEShvVs2Wd0lJoMzbI=
X-Google-Smtp-Source: APXvYqyTZ7B8Y/f4lgkbP9JaZCOCcMf3vbwZbJ2Sblih9aO8xyZ5ufr75PLeX8FT5IShKnQT9fGn7g==
X-Received: by 2002:a17:90a:e38b:: with SMTP id b11mr5866664pjz.138.1570043287656;
        Wed, 02 Oct 2019 12:08:07 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id s17sm153974pgg.77.2019.10.02.12.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 12:08:07 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8998-clamshell: Remove retention idle state
Date:   Wed,  2 Oct 2019 12:07:56 -0700
Message-Id: <20191002190756.26895-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The retention idle state does not appear to be supported by the firmware
present on the msm8998 laptops since the state is advertised as disabled
in ACPI, and attempting to enable the state in DT is observed to result
in boot hangs.  Therefore, remove the state from use to address the
observed issues.

Fixes: 2c6d2d3a580a (arm64: dts: qcom: Add Lenovo Miix 630)
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 9682d4dd7496..1bae90705746 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -23,6 +23,43 @@
 	};
 };
 
+/*
+ * The laptop FW does not appear to support the retention state as it is
+ * not advertised as enabled in ACPI, and enabling it in DT can cause boot
+ * hangs.
+ */
+&CPU0 {
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+};
+
+&CPU1 {
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+};
+
+&CPU2 {
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+};
+
+&CPU3 {
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+};
+
+&CPU4 {
+	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+};
+
+&CPU5 {
+	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+};
+
+&CPU6 {
+	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+};
+
+&CPU7 {
+	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+};
+
 &qusb2phy {
 	status = "okay";
 
-- 
2.17.1

