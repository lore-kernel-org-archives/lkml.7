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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D386CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50DE2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnAhf9Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfJaVs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:48:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfJaVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:48:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so7860750wra.6;
        Thu, 31 Oct 2019 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5uFgNaQscOS3J7biXheGbSey4ELRTdn8KbZYbK8731c=;
        b=rnAhf9IcenrlT0/sCny2Wmq3Q1I6xcfKIik4VJKor84zfXkeZjV0i2cQzbgX9xp/lX
         CE64cnZZ6V8n727mevZS5B6H2sRRXpDnpmJu5LPMbrE35VJF+HM+NutngIBYea/EJI8y
         eGlaWecSbuylY0J6MuCeW6MJTuXWcCnzFkfbpm/pktfBZWtTbGLQmtaFu/jQANr1iwW2
         i7TIVQuudGtoPIhsoDNTcZb507LWTsjkmZyLBkFGVe+je3F9Es9usI7PUo/Zm8a3flmE
         KoZux/Pla/dAoI73HB6I9g/mlBrJbBBYOawUenvcbgWYV+2MIQ9aIq6+xQFS9KVFUit6
         yE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5uFgNaQscOS3J7biXheGbSey4ELRTdn8KbZYbK8731c=;
        b=KrDCJQPBPlfoSPDFbC4oC65zIlwUW/qf1QTbKd5OK5h9RfRoOkaKnNoqs9l8Ys5Z9K
         tHNw3VPlQJnQmwokIZpi37zTEn+kMjRBAVns5FS9BpVUTgrWy9Bd833lHapWiqg5MFYl
         nfcBQu/DCuu+dWOAIjZG55jY6aNasKiVbLrmNi6U2x0dTgfYuw1p8BGs8xI/QBmpAj9R
         M0XwjD6J6KLEc+d10BkUp1nP2h6+7bn1Q8c0AI9vyvaJFMjmw8AyA7EOf9/0oD//4BXB
         EZo+W5dZ/v93hejlxaNd56aSffqbZkgXg5A+sHM675B0yGkWtb4Jkshv5zvyi+ecQltP
         j58w==
X-Gm-Message-State: APjAAAVAc18E1J8tCVGEf9AtYlQOdXjY5Yww/OeIDtJKxQ8nomf6NdBy
        FpIQutwRvmmyF6Uy2djilFQ=
X-Google-Smtp-Source: APXvYqzWe3btYgsNeCFwdVrMe+UNfJD/nil/R+ovtC1wJ4uWr3FiXtG/rUUVnAmwO3Nl76ZJ/Gx24w==
X-Received: by 2002:adf:e64f:: with SMTP id b15mr7212951wrn.372.1572558504419;
        Thu, 31 Oct 2019 14:48:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g184sm5813674wma.8.2019.10.31.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 14:48:23 -0700 (PDT)
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
Subject: [PATCH v2 2/3] arm64: Brahma-B53 is SSB and spectre v2 safe
Date:   Thu, 31 Oct 2019 14:47:24 -0700
Message-Id: <20191031214725.1491-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031214725.1491-1-f.fainelli@gmail.com>
References: <20191031214725.1491-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Brahma-B53 CPU (all versions) to the whitelists of CPUs for the
SSB and spectre v2 mitigations.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/cpu_errata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c065dd48d661..9b1ba1f489ac 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -489,6 +489,7 @@ static const struct midr_range arm64_ssb_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
 	{},
 };
 
@@ -573,6 +574,7 @@ static const struct midr_range spectre_v2_safe_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

