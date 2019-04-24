Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A197121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HymB0GuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDXLlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:41:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33557 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfDXLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:41:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so14397482lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtvtGScjMLArFBOzrjIEryeoo7D1MPsprhdaOfNtLJE=;
        b=HymB0GuVbuB6r/bnIepLi6TmZNwCI8g/Yt+ZXmDn4zbflebfymygIfUBWCas0tq56J
         QzMGqMBw2usbbHeGTJJcPP3GPJok5h+P683VFqurT3Mkjudv2xTHUj5xjZlFJ+mGyFmC
         QE1D2epfNOYM1ObVSg81gmYOrkp8LjAfbLETGb1v5PPowlii68Xf/OW+83uSdOz13C68
         9sCyBsqY0tyP/xRFPvgEw7MMKGCr3ibWt77XVW3MyIw8Uc/n2K/908ccPkml4OUgX3/B
         rm4ke6ujkuQUZLQWgunXDoK8HmKGV6FLuwhcsqiAs6OuAYObdlM3+NHvOf4JkWXYEVsa
         osww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtvtGScjMLArFBOzrjIEryeoo7D1MPsprhdaOfNtLJE=;
        b=qTctIeAcs9BmqgaWV8fKBJXoRS26AN4Mf1zwB6SVFJNDEz5EBBjEDeq1o/p239F5j2
         XQhicl4mi3+XvCcfTeTPXXRI9TVn0fQSddAnhgQihf1tqUrSFx2nf3Zhqu/1TziwUUWS
         Ep21lICrY+VBO0DOmbLNmEOMaCJwvVhNohbXLwmCPbftSmch+afiul5czH1M7Wtbtxll
         jmm8PO0MKv/wYQ2p3sBt93Dosm2v4Q1zIR0KJumtythwytIgK6VD3w49BCpXYS6lelr/
         FYdb0RczdiT9yqEzXqVqMJrWf4GF5/YC3R5YE/1fVY5bBqsr8TtevU2yj/OsXxzF1sIk
         yonQ==
X-Gm-Message-State: APjAAAVTaC22vMwiPfAjwTJ29mY05l2LONvLwE4h6rY7Z9JiQhz+e+9o
        ALZquhXdsXEG23AQqDLTs0Hl4xP5b2n41Q==
X-Google-Smtp-Source: APXvYqwupmJgM3vXicFjUkJB17bjgtQP6TlDVr65o0vP3bYZEpsIm9hYnlCpMRaphiZHnKlaEcq2hg==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr17085845lfk.125.1556106080718;
        Wed, 24 Apr 2019 04:41:20 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id r77sm3968589ljb.29.2019.04.24.04.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 04:41:19 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ASoC: Intel: bytcht_es8316: fix cast warning
Date:   Wed, 24 Apr 2019 13:41:14 +0200
Message-Id: <20190424114114.27073-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bytcht_es8316 the following warning shows up:

../sound/soc/intel/boards/bytcht_es8316.c: In function ‘snd_byt_cht_es8316_mc_probe’:
../sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   quirk = (int)dmi_id->driver_data;
           ^

Rework to use uintptr_t instead of int.

Fixes: a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 38975827e276..68136ba1519e 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -505,7 +505,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	/* Check for BYTCR or other platform and setup quirks */
 	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
 	if (dmi_id) {
-		quirk = (int)dmi_id->driver_data;
+		quirk = (uintptr_t)dmi_id->driver_data;
 	} else if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
 		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
-- 
2.20.1

