Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A85CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A220830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7+usZpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfJ2RPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:15:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42422 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfJ2RPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:15:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 21so10015333pfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPvOmc0/9TpQb/8Qxi0JQ5la+jao1khGxB6lKFFKzew=;
        b=R7+usZpBcWpVXE+FLlVBsTM9NuG0BoC1IIax/WUN+gFKQeqLG1uQKUczFVE/9qDH8o
         ACd1hNgjCpebJHt0uh2su5/iCVyoHoTJZTJciPwRzxrwbfU6MAd45umkzfetCrcfpfQa
         VeCjcXaoKY2k5CRrDv58zVmykx0Dbj4fS2okoW257p9GbITirHjYuNFJ9+XNIcKyKArA
         fDSKC0stgRsH8I9w5CjsPh+hlXMQywP31glkq89/yjMS2EPtJsLK0nBYlMGe9Jd/NzlK
         ad9PyLFTjXxVmGk09IRLRq9tjD2IqqKpj3rmQ4+qAOKOaD7OwXbDqEvfJnwSMg2UsmPe
         +ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPvOmc0/9TpQb/8Qxi0JQ5la+jao1khGxB6lKFFKzew=;
        b=dRuh9BUVKbEQYne4PRQ1FpcYO76H5d3HJAZjNfw7X+d8SBaMsXUWrM+PY38kjcCPJJ
         +oxM4vSf0zuN7Bd69vM+UG2eGJyWMOhKUaHp3uBZnvdmPLsrsVLI0Xq/YpyaPN2lSF7l
         JW+S9dHExMg0IAosGhWHw7YmBwHEhw/jWOQjgBjwm94PoDeofRlV+r4Cwjjin476iHVQ
         osXfsi0b1dQMacjfdho5wBuBTipJ7Jvctsu3RlegXA9tWcYKwNaKbhbOdt+GoudHKm8h
         lwYc58uIGGpQy1SBpg0TlQwUfyf3OCjFLI5XZNlEd2F+ZVwztX4JL9NOaJKyfLqheeS/
         wcFg==
X-Gm-Message-State: APjAAAV/uI3mqY7Wb3AjV59NqujPhuZwopA4F0QoYjBYCyNt5vqBhAkw
        N1tPtzpPjVy17Ku2EkpxFtMC8Q==
X-Google-Smtp-Source: APXvYqwcArvskwTt/briK2R0NWofQWUQRavqOKZNfIuUedWTw3VXeZ3Jg7wUlLPyePGdTau9dKnA4A==
X-Received: by 2002:aa7:8287:: with SMTP id s7mr28672910pfm.82.1572369343750;
        Tue, 29 Oct 2019 10:15:43 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a5sm6449894pfk.172.2019.10.29.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:15:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] arm64: cpufeature: Enable Qualcomm Falkor/Kryo errata 1003
Date:   Tue, 29 Oct 2019 10:15:39 -0700
Message-Id: <20191029171539.1374553-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of 'cce360b54ce6 ("arm64: capabilities: Filter the
entries based on a given mask")' the Qualcomm Falkor/Kryo errata 1003 is
no long applied.

The result of not applying errata 1003 is that MSM8996 runs into various
RCU stalls and fails to boot most of the times.

Give 1003 a "type" to ensure they are not filtered out in
update_cpu_capabilities().

Fixes: cce360b54ce6 ("arm64: capabilities: Filter the entries based on a given mask")
Cc: stable@vger.kernel.org
Reported-by: Mark Brown <broonie@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- s/ARM64_CPUCAP_SCOPE_LOCAL_CPU/ARM64_CPUCAP_LOCAL_CPU_ERRATUM/
- Dropped 1009 "fix" as it already had a type from ERRATA_MIDR_RANGE_LIST()

 arch/arm64/kernel/cpu_errata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index df9465120e2f..3facd5ca52ed 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -780,6 +780,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Falkor/Kryo erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = cpucap_multi_entry_cap_matches,
 		.match_list = qcom_erratum_1003_list,
 	},
-- 
2.23.0

