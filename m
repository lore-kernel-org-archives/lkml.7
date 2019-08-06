Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44826C0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9F920717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="haLVWJVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfHFDFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:05:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44975 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfHFDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:05:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so52090472qtg.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 20:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyvuAycN0W7JrDx3dUfXKO7/FDDYlxGkKJhnNFbl+Qo=;
        b=haLVWJVZHX58MY+5/AxQGIuz/IAD+SOxcyhpUofD684Gyjqc+/Zk+t4Vz9XImOm7Qf
         nwAXh/JpsapL6n55M0UPxAjiS+Zar79YScfY+eGLRiRAzNUB+EkjIPlC4d/gfLLP7Pyr
         OldecaVOr2KbtJWvGOLoxk1CfEUWb+0Aj7KvTH+AuWcNkCPq8wZKeXnkbQKkTmCbmwjC
         YA3I3gedGvZjINpM7OqFTbn/FmWHBY2VwuxQ634E9FnI7xOVl7f+7j8QBMyFywIfqpju
         ppLvfIy3HTrL1NVP43XfLMqmOkIWf0jZUV1mNbiT1fygm/PKqF6UBpEwnq3p802grxZW
         grBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyvuAycN0W7JrDx3dUfXKO7/FDDYlxGkKJhnNFbl+Qo=;
        b=U71i5InFhYdCFMGOzAFRNP0Mg6W1YFoBHv2cbOekdpT+RidIzFIZ414ttwSu2rPbwB
         RtQMuIPSeiUJMcsjdg+Mt9zem8CxylAFeHsw+3jeylSyhZ/UXjEL2h/rw30CY0XTp2mE
         nEcMDaf3HqL2smzwiRIxsail1iqQnfvMMIZ3VctxUnjHrWWIVGRgwDkYPAqbrFtDTDJJ
         C4lYaRIVuxSisxt7R3WatnbsldTeBE05XFuMDCSVHfmZQdkgGo9r3Qmkx456c8EUxv/p
         RVkNiUemOXZ58UXYcTjZe6rYDXy+aDJqknXdxTF9FozQtF5FfDcVaDrCy96mNDehOfZM
         h3TA==
X-Gm-Message-State: APjAAAWTvj8KlWC0BBPixkoshD1EdQwR4MJEKtN0YAZ5w3l5j1wGJDk8
        BD1axUngmhuJGjl/5fPlyxM+2w==
X-Google-Smtp-Source: APXvYqyQHY2lzxrxYaWxWvSLlKXKRgWIivDNAfo/0lKfpW9wImOssr3JY3nj/MOZ1d63fldC9mJqbA==
X-Received: by 2002:aed:39e7:: with SMTP id m94mr1223027qte.0.1565060716457;
        Mon, 05 Aug 2019 20:05:16 -0700 (PDT)
Received: from ovpn-120-115.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u4sm37185800qkb.16.2019.08.05.20.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 20:05:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     rrichter@cavium.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] arm64/prefetch: fix a -Wtype-limits warning
Date:   Mon,  5 Aug 2019 23:05:03 -0400
Message-Id: <20190806030503.1178-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d5370f754875 ("arm64: prefetch: add alternative pattern for
CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to be
used in has_no_hw_prefetch() with rv_min=0 which generates a compilation
warning from GCC,

In file included from ./arch/arm64/include/asm/cache.h:8,
               from ./include/linux/cache.h:6,
               from ./include/linux/printk.h:9,
               from ./include/linux/kernel.h:15,
               from ./include/linux/cpumask.h:10,
               from arch/arm64/kernel/cpufeature.c:11:
arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
unsigned expression >= 0 is always true [-Wtype-limits]
_model == (model) && rv >= (rv_min) && rv <= (rv_max);  \
                        ^~
arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
'MIDR_IS_CPU_MODEL_RANGE'
return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
       ^~~~~~~~~~~~~~~~~~~~~~~

Fix it by converting MIDR_IS_CPU_MODEL_RANGE to a static inline
function.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Convert MIDR_IS_CPU_MODEL_RANGE to a static inline function.
v2: Use "s32" for "rv", so "variant 0/revision 0" can be covered.

 arch/arm64/include/asm/cputype.h | 21 +++++++++++----------
 arch/arm64/kernel/cpufeature.c   |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index e7d46631cc42..b1454d117cd2 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -51,14 +51,6 @@
 #define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
 			     MIDR_ARCHITECTURE_MASK)
 
-#define MIDR_IS_CPU_MODEL_RANGE(midr, model, rv_min, rv_max)		\
-({									\
-	u32 _model = (midr) & MIDR_CPU_MODEL_MASK;			\
-	u32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
-									\
-	_model == (model) && rv >= (rv_min) && rv <= (rv_max);		\
- })
-
 #define ARM_CPU_IMP_ARM			0x41
 #define ARM_CPU_IMP_APM			0x50
 #define ARM_CPU_IMP_CAVIUM		0x43
@@ -159,10 +151,19 @@ struct midr_range {
 #define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
 #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
 
+static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
+					   u32 rv_max)
+{
+	u32 _model = midr & MIDR_CPU_MODEL_MASK;
+	u32 rv = midr & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);
+
+	return _model == model && rv >= rv_min && rv <= rv_max;
+}
+
 static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
 {
-	return MIDR_IS_CPU_MODEL_RANGE(midr, range->model,
-				 range->rv_min, range->rv_max);
+	return midr_is_cpu_model_range(midr, range->model,
+				       range->rv_min, range->rv_max);
 }
 
 static inline bool
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d19d14ba9ae4..95201e5ff5e1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -886,7 +886,7 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int _
 	u32 midr = read_cpuid_id();
 
 	/* Cavium ThunderX pass 1.x and 2.x */
-	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
+	return midr_is_cpu_model_range(midr, MIDR_THUNDERX,
 		MIDR_CPU_VAR_REV(0, 0),
 		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
 }
-- 
2.20.1 (Apple Git-117)

