Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0642083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="brU6yRC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDKIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:45:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52093 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfDKIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:45:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so5619362wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=72YojJ2ZI4Hnj5UZWtMVH1bJJscttQzZHVGA77jha6k=;
        b=brU6yRC2/R67qR7FwEPXgWq7TMtY3G392GEJp4iDaBRyvhCusWFHyAaS6pYicJMf60
         FJV8zzS64jtbceJfeADF5+UAO8jacrkTYcZ7pp6+JGcHd5z/neIKvlLN+wRfC7qUHsIh
         YOEUxQTUj6SDJ+t9OGUxNCOID2PE43j+B4dvYouzart1YuyCaOp/MMPwSJLE6bpX8aZD
         NDbVvy3g5fHNVl1xV+TuRZOS7beZEef5kJmo5F1wFntu8AfiJt3eVeDYMr48o3LoqYXn
         +VdlfQayRS8iyKStauO6bGg45cnZefIdE1snnnrxUcwm9SgI1JygDlhOmNyxVecixHZx
         HqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=72YojJ2ZI4Hnj5UZWtMVH1bJJscttQzZHVGA77jha6k=;
        b=qy24PODTvm6wujSNr/Z3qLR2VG5GdN/32bb7r1ir/VzFmHeHXnYvY8yx95EXLR3fdA
         /ARK3FDbMrcyM1mqk4b7SeCwWo5R7u9isPPUuuRbNXbK4JRehIjjqcN8h+knO5qtf1LS
         /U5tAc+B8u4IVbdVCQYT1uYY49Rh5GjkpaewX8y4xFAmHOZw9ZgYyS5D9jV43pDtF63e
         2rsmJo5+hOX7ldl/+2f2Cca+t2GOM8tjQfy9Bd7fQzp1sQjQF25ls5F1J1PZJHI1Jt1U
         kXcu54EcWfpy62zXaoE5gl2BWUSuiFB1P5f6GJIbbZYOqxAX20hhtZ0pEJv5vnxENgHu
         Unqw==
X-Gm-Message-State: APjAAAXPvQB79fEjk+WNK4fxIK/kI2AAz5qGBZguTdenu3nM7vN5eM1E
        dziqCG97G45mST358XAXwJtp/w==
X-Google-Smtp-Source: APXvYqzD6/VS9PfVDNO6HphW5M4EV309P4F8/HO4da7MQt2vi/o/ZoTzBqwZPAJIq2PCDip1y0tfhA==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr5858487wmf.5.1554972340768;
        Thu, 11 Apr 2019 01:45:40 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 7sm128602876wrc.81.2019.04.11.01.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:45:40 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clk: g12a-clkc: add Temperature Sensor clock ID
Date:   Thu, 11 Apr 2019 10:45:36 +0200
Message-Id: <20190411084537.30299-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411084537.30299-1-glaroque@baylibre.com>
References: <20190411084537.30299-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock id used by temperature sensor for G12A Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/dt-bindings/clock/g12a-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 30303728fe09..85cfcab10507 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -133,5 +133,6 @@
 #define CLKID_MPLL_5OM				177
 #define CLKID_CPU_CLK				187
 #define CLKID_PCIE_PLL				201
+#define CLKID_TS				203
 
 #endif /* __G12A_CLKC_H */
-- 
2.17.1

