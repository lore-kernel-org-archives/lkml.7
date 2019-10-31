Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7141ACA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FA7208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNStKP8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfJaVsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:48:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40199 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfJaVsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:48:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so7855849wro.7;
        Thu, 31 Oct 2019 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xzqhDZ3wBxWeTejy3g7Yk7R2thWi6tiuxZkbkCpQdv8=;
        b=KNStKP8npRtkIO8qLPh43FI9wktn0op3EbYXp5lMuIhlNkWDwzamhQgW9AS9RCFKt8
         6cjrkEfdhyKQAnuwquyQnBOyFSwkiYTcf8uN3/j5x5qUlP934np96J3lnRba8LiQjSK9
         vlGf4rcnr0YZJO0gTpIszvrGWqWq/6vOscT+ty6Gp9O/HOWW6SuaeHtC56AXGegkpuGx
         QT1DgBKLRYxxn+Xd6XSjO0WF8NhsWjLFMGwLCbOdcUU5T/cwTMaJnwesnJvmdTr3K56w
         PWcX9pRqaYMsxLF9wcj+YYfCu1OIUt2cPARzU5Ms7b0j+vYFxf8xnobB8aentQaEbcEe
         eICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xzqhDZ3wBxWeTejy3g7Yk7R2thWi6tiuxZkbkCpQdv8=;
        b=ZBQtTp9uxdAnGZCM98rmGHX7KSqA+XNVhyf4p8cOq7fd6VFg6E69jJgJo7xmhRjf+m
         539pWPeZWXb2wwRJwSJm9h/as44A8onbyygTKsSoUMkEb5UtqttspOaXQ3wsxGCmD/Ro
         virQGKbwtYbRHckDnnRZzYTMiDJYTEv702BzZmOq8yYvBsG0UeUTNdXVRJg87/aOr6p9
         qv/aUURYGDhAaP+xu39g6VrfkTmXzl3KhHDYXd2Dl5kUZl0LZO6oo1PN7uUTeakL7qzF
         PZ6/Ikzp2RyMDTgh7OzJZqU4i/ZWlO8stFAW2ihvc8170DD/9E9dZSzZwOd07qSX9uOG
         PDLA==
X-Gm-Message-State: APjAAAUby7OzgcjFuDXJlOBCDOhNqF5SPxV0tUW41qLRBXO9b95cwiLW
        mDYPgv6QGQpypAhJAThFnKE=
X-Google-Smtp-Source: APXvYqyehPSBK5AunHvntGf/xcrNSCthFM4C0ew1ZSHWlfDcf/mbogmbMsms2/rj5H3IMD22imLnZA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr7680925wrq.381.1572558508280;
        Thu, 31 Oct 2019 14:48:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g184sm5813674wma.8.2019.10.31.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 14:48:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Doug Berger <opendmb@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>, Qian Cai <cai@lca.pw>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Marc Zyngier <maz@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] arm64: apply ARM64_ERRATUM_843419 workaround for Brahma-B53 core
Date:   Thu, 31 Oct 2019 14:47:25 -0700
Message-Id: <20191031214725.1491-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031214725.1491-1-f.fainelli@gmail.com>
References: <20191031214725.1491-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom Brahma-B53 core is susceptible to the issue described by
ARM64_ERRATUM_843419 so this commit enables the workaround to be applied
when executing on that core.

Since there are now multiple entries to match, we must convert the
existing ARM64_ERRATUM_843419 into an erratum list and use
cpucap_multi_entry_cap_matches to match our entries.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 57757c73ead1..7b9afffac3a7 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -93,6 +93,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
+| Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_843419        |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX ITS    | #22375,24313    | CAVIUM_ERRATUM_22375        |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9b1ba1f489ac..64e0f7810fba 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -749,6 +749,23 @@ static const struct midr_range erratum_845719_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_ERRATUM_843419
+static const struct arm64_cpu_capabilities erratum_843419_list[] = {
+	{
+		/* Cortex-A53 r0p[01234] */
+		.matches = is_affected_midr_range,
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
+		MIDR_FIXED(0x4, BIT(8)),
+	},
+	{
+		/* Brahma-B53 r0p[0] */
+		.matches = is_affected_midr_range,
+		ERRATA_MIDR_REV(MIDR_BRAHMA_B53, 0, 0),
+	},
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -780,11 +797,11 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_843419
 	{
-	/* Cortex-A53 r0p[01234] */
 		.desc = "ARM erratum 843419",
 		.capability = ARM64_WORKAROUND_843419,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
-		MIDR_FIXED(0x4, BIT(8)),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = cpucap_multi_entry_cap_matches,
+		.match_list = erratum_843419_list,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
-- 
2.17.1

