Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2EC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617FB217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+QM6K+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfEVBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:15:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42576 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfEVBPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:15:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id e17so257906pgo.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4R0Z1avkl5DcwArAEdYF5RKsOqx23+ElfNwQfhlhU8U=;
        b=N+QM6K+mnnUhvHa1pDTd4k5bms70Vaku4Jjp/BA2dHEnOKKOnLtyIKbS/22xAaO5WJ
         sqV6/CiZpmxKCDFjs1WN4GbfR+dwiBNCrkD/fGw1TgFbrIuB2fFGHlqzCOA16m6sgSts
         B7bFD7A12JdmPrjFhuEHpW6gIsDlHC52uzpG/x96Rsq4sBLNNDKBmaBNxpPNlPqIDhMH
         VdhqfkIvdXLUTSgi9+hjW9/+yJDhs303p/1dV1ki442GfeO0gj8pvyBcVXXbA2RqxvXI
         xOwYpHkDQD6docsy8KCY2NjXUrUPU/j/IdJMNHDkG3gYHfNPCIUo+2XJpvREn7X8+yy2
         Xo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4R0Z1avkl5DcwArAEdYF5RKsOqx23+ElfNwQfhlhU8U=;
        b=Mxbc4Di0QKnNplvCBac2+2PEaqORaghElT3UVSgBs+kEH80Nm9iZ9QsgoY4yIfe5n+
         VQePEiRjRw1fC5ymb6VnAponsBf8wlOd/vmhtsaeMs+5qJIrwfswfFRF10RdbIX3WQsK
         6A7x2VetnuspzC4PkIFPh3niO0VISfjp2qkwwUBhU8+aq+Vp8oadfA9xvKkNgD3Mmfjl
         C7p+lvdKyYSM8TOH59KTB+M6zSCYR9LEk7F7C+zsDhWLwxGYOjSntLFUxSXMyd9BXImq
         pggXWPVSFBU2ySnFdij5L+rVs8JmMHsaRZC+f1i2wVtv36cyVZ7P574RILIZp4qEAyF7
         YFvg==
X-Gm-Message-State: APjAAAW9imoqHgN0hBiljFUSyQdsR4n2C+P9/ObkIoKwOh3Av8JsjO1N
        w+TM36HFZzmnODO1Vn4HwbH3jw==
X-Google-Smtp-Source: APXvYqzbklwZKF6I8bdsKqHWeztOzDBBspaVQu25VOCc+BGlsekcn7V3hdflg1i8vRhnSKdoGmRD3Q==
X-Received: by 2002:a62:640e:: with SMTP id y14mr72010463pfb.109.1558487753226;
        Tue, 21 May 2019 18:15:53 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e184sm31756061pfa.169.2019.05.21.18.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:15:52 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 3/3] clk: sprd: Add check the return value of sprd_clk_regmap_init()
Date:   Wed, 22 May 2019 09:15:04 +0800
Message-Id: <20190522011504.19342-5-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522011504.19342-1-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sprd_clk_regmap_init() doesn't always return success, adding check
for its return value should make the code more strong.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/clk/sprd/sc9860-clk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/sc9860-clk.c b/drivers/clk/sprd/sc9860-clk.c
index 9980ab55271b..1ed45b4f2fe8 100644
--- a/drivers/clk/sprd/sc9860-clk.c
+++ b/drivers/clk/sprd/sc9860-clk.c
@@ -2031,7 +2031,9 @@ static int sc9860_clk_probe(struct platform_device *pdev)
 	}
 
 	desc = match->data;
-	sprd_clk_regmap_init(pdev, desc);
+	ret = sprd_clk_regmap_init(pdev, desc);
+	if (ret)
+		return ret;
 
 	return sprd_clk_probe(&pdev->dev, desc->hw_clks);
 }
-- 
2.17.1

