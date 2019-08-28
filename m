Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E140C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166B620674
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6vawmtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1CTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:19:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46071 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:19:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so607536pfq.12;
        Tue, 27 Aug 2019 19:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4YuiMpobDlcYnjhOk7zxi7m9l9242C7iA7++UvziMw=;
        b=Q6vawmtj+NkxhnHzDqRflMCf3AlCGwoxQ03u80WUSlIb64vN4t1TwTa3TDHiY25sro
         ZioiEOsqQTvHq1ewFBWR0GZg2rx0NhcIxKjeip9xlPQtOaiXXIm8AALR71NV/lJ6YtEC
         9oOSLSg/fl8E/Om3huZk5Pm6PQOqYsaAz72uwKeFzzzZdNNtmELXrYaBX6SFV+dFcqHC
         o7DuoKL7KeEuurZXBrdDzsLcsNPMJ9WY7weo3KxSfJf3YJ9NWE02eXSK7O0zYVemdO1I
         AG6cafw1br5aDhqG/iwfVYXUfVEYlVNsqYCQ08kkMbzaIpO6CRp1BYJca7bGz5KcUMXD
         PklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4YuiMpobDlcYnjhOk7zxi7m9l9242C7iA7++UvziMw=;
        b=bgqgTK5i+zKXgF6FbtR3Vcxty6bhwbRFv66PxBBoF1Tj7ep+LCxpFWFWHxW30rlfV2
         +pwimtNJ0uS7956kjYzd/LY6yspGRRL95lafasT1XDHcwpep7BqGrqhzZ7nnCuqqQKHZ
         WS1pmVhtMvBC1W8qhWKH2q4IVRImMhFhj/FcaptkgzBvN7WjtzzkD5CFxAP+pnlHQiVi
         BSyAXRZhR/AS0xSoRw/8RsdffO15mIxtxq2jH5BthSt7FFWmvf+/U1f+WK+nlbTpJeDD
         gD45P7UXYmQNmf6x28llk9GTqIEH5TbiqZbwj2C7wkV0OQm3qSTxal6o8IsLxct3f7K+
         v4Xw==
X-Gm-Message-State: APjAAAUaXimCQ/+c4lkIz17ATGYjpZa5Ibj7oPjlpQawzfkoqnqt/hM0
        OzUeBG72m1LMt/So8HjMyKQ=
X-Google-Smtp-Source: APXvYqxjGeNIw65ZQ+hMgVwzWsQsXvFjrCZ6a4YsCZ8qCNDm8jP2KmczghI/zWqp5BVRgghE0jwZfA==
X-Received: by 2002:aa7:938d:: with SMTP id t13mr1863977pfe.180.1566958758004;
        Tue, 27 Aug 2019 19:19:18 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm673249pfi.160.2019.08.27.19.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:19:17 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 3/5] mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Wed, 28 Aug 2019 10:17:34 +0800
Message-Id: <20190828021736.22049-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828021736.22049-1-zhang.lyra@gmail.com>
References: <20190828021736.22049-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The bit of PRESET_VAL_ENABLE in HOST_CONTROL2 register is reserved on
sprd's sd host controller, set quirk2 to disable configuring this.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 90cb2af91159..27d0b57f3f89 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -510,7 +510,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
-		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
+		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_sprd_ops,
 };
 
-- 
2.20.1

