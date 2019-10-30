Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D396BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40E820856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irgkbFd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJ3Vu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:50:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45998 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfJ3Vu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:50:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so2772357lfa.12;
        Wed, 30 Oct 2019 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iIhirnFklLn1OL2q/K6q4x2b2P+v7Ve0tVmAkHn4AI=;
        b=irgkbFd6a3srova/l+xljO/RpVvu+yEQNZWWcWhWcPT0GW4R97Namyzs4zcJWjddGN
         wdqSoIVmv2JsXf19ghZ1Caqod39AEWEdcvw6CUjQFEE7FrPYiYy8e61nZNASPP9bn3xY
         AtO8uN8KFvQiGjhKAaJ3uQa3P/qGAieQ6mfChb/em0u3z9arXsSv9pqS3n2j1vuk6q7K
         a+CHFx7VAcp1hlUcJgXWSZixom4YTu38P9nqhF/TjNk3D27c25NO2hvC8L2umZtwt03G
         8RNDh394AS4D6mZPi1kL+/IECcNBNL06l6aBXjQ52FfiqTAyMBOvkm/dkP0EV1lJWSFk
         Dfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iIhirnFklLn1OL2q/K6q4x2b2P+v7Ve0tVmAkHn4AI=;
        b=dCxhMPEniMWcBeYN7xiBJGzg4VKsNX2+ay8w0aWpbXn8uyLnemGdcsGofO2m7cNCgg
         buy+7CMC40Bo78vKEhTEyM6jemWwmuS2+82RbWfUAG/Z21HF/f5CS/iQbn4IjkR03Yd/
         F+wGI9aqRHQ5R+1bD41ZicrMs7tEMjZK/1T3KhWYi0sjv8FP5ldHPATiDVl0eyDTc/gl
         /roj7YnIsbj3JVofNp0Z05xbcznP0e2gzhOxJV9AwxqwCeYblzxIhHaTYDyjZQebyDGA
         ypuOLg95KfCWcqwvtCPQ/yyMgC94B3njvnny/bqVtW55j8LqD7yJqvpcBEEHFz6UI9FC
         GM/w==
X-Gm-Message-State: APjAAAWSP0termHepWIqnaUrVt4zgJ/kFpAv2JwftFDLKrtWYjuwUeHu
        k6DQnuT8nvGF5OL/xHznmcs=
X-Google-Smtp-Source: APXvYqx9Aj+bzPhP4SKA2/HHi5OdNq9ABaLv2/gSl6t5CRNf4lWt1yfDa/aq+s1MgvaefcoeceuYBQ==
X-Received: by 2002:a19:fc1e:: with SMTP id a30mr259921lfi.167.1572472227114;
        Wed, 30 Oct 2019 14:50:27 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id f5sm466493ljn.24.2019.10.30.14.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:50:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
Date:   Thu, 31 Oct 2019 00:50:17 +0300
Message-Id: <20191030215017.14303-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early-resume code shall not switch CPU to PLLX because PLLX
configuration could be unstable or PLLX should be simply disabled if
CPU enters into suspend running off some other PLL (the case if CPUFREQ
driver is active). The actual burst policy is restored by the clock
drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 5942cec9b6ef..2f9e5076d201 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -383,11 +383,8 @@ _pll_m_c_x_done:
 	ldr	r4, [r5, #0x1C]		@ restore SCLK_BURST
 	str	r4, [r0, #CLK_RESET_SCLK_BURST]
 
-	cmp	r10, #TEGRA30
-	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
-	movteq	r4, #:upper16:((1 << 28) | (0x8))
-	movwne	r4, #:lower16:((1 << 28) | (0xe))
-	movtne	r4, #:upper16:((1 << 28) | (0xe))
+	movw	r4, #:lower16:((1 << 28) | (0x4))	@ burst policy is PLLP
+	movt	r4, #:upper16:((1 << 28) | (0x4))
 	str	r4, [r0, #CLK_RESET_CCLK_BURST]
 
 	/* Restore pad power state to normal */
-- 
2.23.0

