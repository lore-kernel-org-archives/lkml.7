Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D97C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A9420717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="01D8s1Q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfHFJug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:50:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfHFJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:50:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so71683392wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cR9AZT/YDTInU9+YBz6pXMm816wSfM4wzlR1DgdPSTo=;
        b=01D8s1Q83HQIaEzHNLAeEGXDLx5exn9je9X3eFRcKcfmSUdFximps8ev0hxN7OHFo3
         NG2fT8+GrUXx4No4yvM9qZ5X+CzImJSWFodIsWDDdy9t1b+YpY5cWQOy5bmoe4glLzrn
         5dt8WSAI/aQMHTJ8oS5zoICASi/RGhMGymuQ1ltqkIGVwUXLZ1N9iypI5sbFNc4K2Sh2
         oE/mTUt2gMhH+/VRGWAWfDRk2J2Dd+VjkFs4bvZgbkoVT9PedkARa4WrmgN0fc2SvZ4O
         r8Hg35fr+HDLcWJ2ARsQlnkmcTFQVCSbNGTS0W/YkAZlU240sWrYOxh+hNM5ZE1E1J6j
         kySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cR9AZT/YDTInU9+YBz6pXMm816wSfM4wzlR1DgdPSTo=;
        b=KoVkjiLtJMMYzRbkjgY4bGL5vXRpnl6ffsrAbA8SlU4CsGJOTCVlVP5sSOSVpeiDtC
         hipJJENnMTv25QoiMnk1VgDcmk9clLS2MiXWNvT4w1CD/Ibdll3ZuTggsKEz1EimGCc1
         qk6megotOJuBsf9pmzOp2KeHNvOoFAAvvVwidA9fylwdA+GN3DQlgesO+5SGCnjrm2m8
         x48D9MlGZ9P7+6FLPtdsPIDU/uj8GUGlxUcRbbXWL23I4feQStn5R/u1cwqDU6BsPJFr
         oIJdsyYEN9jEq8Tvris3Afpm6lhMvm2iR7ZyPoxa+0+UhagumiTnqNp6diUFAYC/Xdip
         k4Hg==
X-Gm-Message-State: APjAAAUZuWq7R7TnibbDMTYLLRcAJ75hjmdTUsvH4UqVVyQEPBoqCudP
        8NWRxPhb/J65N+eiHhJ9bsUo4Q==
X-Google-Smtp-Source: APXvYqxsiIzJezgCwkrreRZ71gp/fn0cBu6In2uUwfEVFYSgvXVBLB7sp+DXVqSHhsu/NHLt74v6UQ==
X-Received: by 2002:a1c:107:: with SMTP id 7mr3807202wmb.84.1565085033769;
        Tue, 06 Aug 2019 02:50:33 -0700 (PDT)
Received: from radium.local ([2a01:e34:ecba:5540:2c05:40e4:899d:aef0])
        by smtp.gmail.com with ESMTPSA id p18sm91017343wrm.16.2019.08.06.02.50.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 02:50:33 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, matthias.bgg@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] cpufreq: mediatek-cpufreq: Add compatible for MT8516
Date:   Tue,  6 Aug 2019 11:50:29 +0200
Message-Id: <20190806095029.4758-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for MT8516 in order to take advantage of the
MediaTek CPUFreq driver for Mediatek's MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index f14f3a85f2f7..10bc06f5dd45 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -535,6 +535,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
+	{ .compatible = "mediatek,mt8516", },
 
 	{ }
 };
-- 
2.23.0.rc1

