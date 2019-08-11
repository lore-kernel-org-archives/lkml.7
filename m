Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B2C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EF52085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBa4gJEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfHKVBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40757 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfHKVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so72962761lff.7;
        Sun, 11 Aug 2019 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=nBa4gJEnzVz4H9ay8Hnir7XLvYkmkGxv5NIPZ5m/Gmvejqz0kqLO00ti5iunFwGi6i
         IJkN8RN1S6jffhdmQwwBahEh9f0Js3+9pmS5fDby0UAxW2BU9DDfzmWGfHce91iBr1ty
         dyD0IEf+hoHXSA0z72oV2ginntGe6akmWaHW2Tw/HJGqDAjffqM6toJV1LHoCtWaT0ht
         bovaT2QsLe5HLZfkQr/WHjsTIbiGZfFjSij8Auz1LfNTkGpLr3Rda+Tyw1ieqq5nULBZ
         TuNYvehVtRFAH9GM7133G6sWSNpSdixTOOBp622uab38VE1qUzBsaORum40wAj5+yQcW
         92Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=aHL1GFwnXhLoph2yfHJkp6NlK/8yI9wxmsaAsz8oM8O/O8Yl8VlW7RH5CZSlA6AjqK
         unxasPlJ2881qSbNnswtZ0hDSfI0N4C6hAl25X5iXge+vBfB7DDHB9G+8opUt6R/MSh/
         55Xm/cjTuKuXlDLOkZyM94sq0kPU4ZV3goG9ORGs2EXyFcRuwDECpwihLcNIwHxl373Y
         28ZPVN4mneiKtXuv5PZ5lZ3aR4PM3rUpzct9Bd9QF4zsO5R0VrI5318iJAskuS8XVsYs
         HeqRESmqL2orQtD0jlw4yvRvNRzTGNMJ0MC4yIHjy/xa4WBs6p3NvSnosSh9sOBCr9qq
         Xuxw==
X-Gm-Message-State: APjAAAXZfrFXu38yEny+S/Jfy000n9x17bOpClRpOMlUXaGI88J4rted
        66lKzEmtoRMEf18FVCn6ZfY=
X-Google-Smtp-Source: APXvYqzNP7ZwZgY913FGGgrbkLxuuWuf7J1Mrd3PM87BcAgXErg8K7p1PSMvMKExihkajZnEhPeVlQ==
X-Received: by 2002:a19:8586:: with SMTP id h128mr18772052lfd.62.1565557300506;
        Sun, 11 Aug 2019 14:01:40 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 13/15] memory: tegra: Ensure timing control debug features are disabled
Date:   Mon, 12 Aug 2019 00:00:41 +0300
Message-Id: <20190811210043.20122-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 43819e8df95c..1bad7f238881 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -657,6 +657,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 410efc4d7e7b..cd52628c2b96 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -30,6 +30,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

