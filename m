Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB49CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5217A21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sg0u4cvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfJ2X1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:27:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33847 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfJ2X1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:27:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so73322pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACl3OaVOTym+qDwRiwEDHteytsmPG8qRkDZ/xp8Jsfs=;
        b=Sg0u4cvybiJKNJ2yk93E2dB2T47O85yhZ0eGiygp5ebFLX8FXezKujJzdiva88wV/8
         Zg9GPLhEFk4fP51MbMbYuBFfk6V505AMJniXLB0aL//ZQrrk086ByYlv/uYxl4s+qdgI
         YptgAvtlYL2Tr2cRDl2DMTc8kyJJhDQjpsSbrYX9iIr7Q2hQxkAvCt1dhy8714CcAqIC
         zJuJavMzQeTIiyzRXrqcd4kFFnwpPvnWveIOHNon8Y4R7o9fBbUm+7J/JTzYcf3fI3lr
         ISkDKmeM2glo/AHCqjlFq2Ra55NGniPP1aj+IXTdznBwbGZfMf6oisKYkVulczJnXkV9
         izPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACl3OaVOTym+qDwRiwEDHteytsmPG8qRkDZ/xp8Jsfs=;
        b=pDi6+jAZdegQHLtI5UjESXUWBosySyJHTJ3HKRKpWOpGYqdgATUenBuIbMM3ygO7Pl
         lZ7L5m5XE/9TuVtZQkHC3DQCSmw/l2XPhL0s73or+S7ItH6GoWcCHuK6cXVdaBoehosH
         xFOwcg23+stRigukp256KNUwOr1rG/zKr4hTIUrSxwMocujoYaJi3UK6yyauUqk+iFr4
         W4r3gbKbAEDiWhckY+Yh4g2Q4X5S/w00mQVP00I6clj+5yOFPvbvVYCQ515vrAi7SYUj
         m4s1B9gNRik8ETWojAFFXV08y033RN1wxw8RBMpvMSq/kPnqvLTOHiPbCkXZPJC7Dgj+
         9AWQ==
X-Gm-Message-State: APjAAAV0KOJ92BMi3zvuGoLaGy0giXvkbhOr6uWxvKhJP3rnqc2dnv+T
        F2zXRNgrrUfsCJvkMJ7BxfwsowdMv7k=
X-Google-Smtp-Source: APXvYqxOTPAX0Pab8uisqVInBDEc0929OSy+5xrNgVs1Q/j1JgZT6U0hX+J++tV2P0onHll9jWcFpw==
X-Received: by 2002:a17:902:b116:: with SMTP id q22mr1259148plr.201.1572391662476;
        Tue, 29 Oct 2019 16:27:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v19sm211050pff.46.2019.10.29.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:27:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] arm64: cpufeature: Enable Qualcomm Falkor errata 1009 for Kryo
Date:   Tue, 29 Oct 2019 16:27:38 -0700
Message-Id: <20191029232738.1483923-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kryo cores share errata 1009 with Falkor, so add their model
definitions and enable it for them as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Use is_kryo_midr(), rather than listing each individual model.

 arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 3facd5ca52ed..613075817abe 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -623,17 +623,23 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 #endif
 
 #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
-
-static const struct midr_range arm64_repeat_tlbi_cpus[] = {
+static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
-	MIDR_RANGE(MIDR_QCOM_FALKOR_V1, 0, 0, 0, 0),
+	{
+		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0)
+	},
+	{
+		.midr_range.model = MIDR_QCOM_KRYO,
+		.matches = is_kryo_midr,
+	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1286807
-	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
+	{
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
+	},
 #endif
 	{},
 };
-
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
@@ -789,7 +795,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm erratum 1009, ARM erratum 1286807",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
-		ERRATA_MIDR_RANGE_LIST(arm64_repeat_tlbi_cpus),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = cpucap_multi_entry_cap_matches,
+		.match_list = arm64_repeat_tlbi_list,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
-- 
2.23.0

