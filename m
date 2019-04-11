Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D561C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A41120693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KS/NfPl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDKXWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:22:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40974 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfDKXWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:22:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so4224421pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8FKJf/NaqYGyiUvGYru2/2r1FkwEHrLbQS3N/eYB4lI=;
        b=KS/NfPl8RJldrt8mNhy3MbR0s3XVMRoY1JtQVPa2H5JgXYDmX2Gj5reoKqtC6MPJZo
         MnntIAMLm0VT6DvXWGY+7IVnisZGpq5PMZB0pjigiJOn5VyXVfCaQap5sZgNyAFp0Wkz
         N7b4JoVpM4Onl7eGHR3DySurhjWIo/rJxSGrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FKJf/NaqYGyiUvGYru2/2r1FkwEHrLbQS3N/eYB4lI=;
        b=WgqnOpkEVGBF3VTmE3DxEdV0RXeQfxpN4Q3xgULL5By+bb5z7g20/SuwYgeYlQBC1W
         7oMQumOylZQzpMMwe3k+V3J1UbNc6Ky7HG1zvr9S3vDA87J8uSg7fEEjZYbGimfMWNVH
         wkNHKIYSqI2jel/aWaSa8nOCt7qM5nQkIjotgBwf9n2K1dnYKTnJ0XrROu+TVG6Ihllr
         YYexDqwJwlGGBdmxqUqaYTE7/EOs0g7r1yh6DuL8zsNtOSPhf8ZrBj8MgBc2KXB4g1GV
         LYmd75wRJ/hHy4c7JaL/NCwt+JXdokopC+7Hdh6moZ3wroY8BVutG3BLNctkzCTg05ZH
         Mx9w==
X-Gm-Message-State: APjAAAVEK1B5xXI9yqwMtVZjpCm7ij2ip5mSWoymBvJ5FgPx91th5Fn+
        Txmxfo8M34PJ5Ozyy1TBVsetVg==
X-Google-Smtp-Source: APXvYqzF6EMcdmnX13ucI/Kyu+YMU4DSuvUyYP7dA+WAWkBpVu3DEO/SrCvvL0Esyk6oCZIVsOY/ZQ==
X-Received: by 2002:a63:c302:: with SMTP id c2mr50588843pgd.235.1555024969853;
        Thu, 11 Apr 2019 16:22:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y20sm37288903pfe.188.2019.04.11.16.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:22:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     dbasehore@chromium.org, amstan@chromium.org,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: rockchip: pm: Mark init functions __init
Date:   Thu, 11 Apr 2019 16:21:54 -0700
Message-Id: <20190411232157.55125-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190411232157.55125-1-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions rk3288_config_bootdata() and rk3288_suspend_init() are
only called in the context of rockchip_suspend_init() which is already
marked __init.  We can mark them __init too.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/mach-rockchip/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index 0592534e0b88..065b09e6f1eb 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -59,7 +59,7 @@ static inline u32 rk3288_l2_config(void)
 	return l2ctlr;
 }
 
-static void rk3288_config_bootdata(void)
+static void __init rk3288_config_bootdata(void)
 {
 	rkpm_bootdata_cpusp = rk3288_bootram_phy + (SZ_4K - 8);
 	rkpm_bootdata_cpu_code = __pa_symbol(cpu_resume);
@@ -230,7 +230,7 @@ static void rk3288_suspend_finish(void)
 		pr_err("%s: Suspend finish failed\n", __func__);
 }
 
-static int rk3288_suspend_init(struct device_node *np)
+static int __init rk3288_suspend_init(struct device_node *np)
 {
 	struct device_node *sram_np;
 	struct resource res;
-- 
2.21.0.392.gf8f6787159e-goog

