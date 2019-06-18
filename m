Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4120673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VDRhhU5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfFRPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:43:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39720 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFRPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:43:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so3769092wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vbPMnSPTFmTNhTvb78jQv/BzhDnMGLR+xrvA6q/kx0=;
        b=VDRhhU5RFfax5iw/D6bgy+EWGO4v9G3xyws4yLORV4eWIzJ+FQZTTX2x7NttwaSvVf
         bK8l7V8vhqYmhSUgyQ/sRTOMPTvLpBxKYC5k/KQ7fdi9Duu6O5z4Oaf9xXBDQyZssKp+
         qIhECCaw9iKwmiov+X2tMABtA8kzifXjkEp+r3IdyfTCaMmBiy1j00VBTVDo3Bb1ZH1n
         w2Lr9zATdrTXx5jVOf8iA+f0U9OGOTjLO/N6yqwu33aI/OPmXjx6TGd53gIhVWJNtU7f
         5PnxVhRqlP376h4FR8KVPGDFnjsAgEeNRzF8rL2ZloB1/47IxNoAMC5H5MZ7CtXcVHL/
         OSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vbPMnSPTFmTNhTvb78jQv/BzhDnMGLR+xrvA6q/kx0=;
        b=B83ywGA5vxYYwVneU8l5ufYI46iYOz0+372QyA+mAqzBcgMRn+i2JHHZZVXL24FcNR
         iZjctjvYL38rJISPO/7GV1huDbHWtM6kGr6cuoMb6d3L2L3LWlk68Ofwjc4zknRbtnVH
         x/Fqr1mldDvkrSp164Dtkur8RGm2AUhkLm/ZHH4c+Qc6Xx/6phEpm8LuQ697NTUgL/Ju
         pOkm/3FmV0fhOAz9PkgxbJt8andaU7BA+HvkGmMJc2ndF20Fk+4HWV1om3eL8M8fE3KB
         1oPhUC33AUj4op3PiFtxIfSj2kkChxAosd8QL4tCrf8Mp6FWCYFOAC6dDhSUwTi0jBHA
         JC3A==
X-Gm-Message-State: APjAAAU1lq4IxVfhRAVGRtfmaQHO0c1wHuaV+c7o0IEsPMZhGHtZEba8
        PcughJQPEY+TZdJpSx/vkjxgoydJMZE=
X-Google-Smtp-Source: APXvYqwtw4L/aIDQ4+qEJmUYMfZ7EYwaOEj6yOOtOOc3CwsfJo7ZPI8soRXlk3VuzO+bkNaQhH2WCg==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr4270696wms.8.1560872631849;
        Tue, 18 Jun 2019 08:43:51 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z5sm2633287wma.36.2019.06.18.08.43.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 08:43:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] mfd: mt6397: use DEFINE_RES_* helpers to define RTC resources
Date:   Tue, 18 Jun 2019 17:43:47 +0200
Message-Id: <20190618154347.16991-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618154347.16991-1-fparent@baylibre.com>
References: <20190618154347.16991-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DEFINE_RES_{MEM,IRQ} to define the RTC reosurce for the MT6397
PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 190ed86ad93e..1e315712870b 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -23,16 +23,8 @@
 #define MT6397_CID_CODE		0x97
 
 static const struct resource mt6397_rtc_resources[] = {
-	{
-		.start = MT6397_RTC_BASE,
-		.end   = MT6397_RTC_BASE + MT6397_RTC_SIZE,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = MT6397_IRQ_RTC,
-		.end   = MT6397_IRQ_RTC,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };
 
 static const struct resource mt6323_keys_resources[] = {
-- 
2.20.1

