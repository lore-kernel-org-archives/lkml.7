Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968721855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X1Pu3Mke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfDEJe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:34:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35744 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:34:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so6444724wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sFg9IaMybZg87mNCTA2W2IHIRutwglsZx75wyHfcxvg=;
        b=X1Pu3MkeJmSVn5Uzn3EqWX49UnrSpE4m6Kv1GHAdk57ZtGfE32ETQk859T39W9/cyX
         F8y3MCpHV/3Z1xm/tCl/yDkkhpWi24m8tP2T89VKpm/eSX5zpuzbGHm7cAQrGj4+Ho/e
         j7UFFtRZ+tNxP1aaFTWNfggrXCOJdM3tiee4qDmzdPpTzxJCCBzkIx4d3Fqr14cLuPVx
         OzUr6Pp2PmMk8FKvie7psfnUjy7G/+mnNi8/mmk+KRA78cNk4Y2dP78wcygxnA0xOBgs
         whchgxea0yBr4KqwZy1YmE8YkToAWvaMGPQd4kVVu9itb2Q3Ynga6F/hC19qcmqqG442
         Hzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sFg9IaMybZg87mNCTA2W2IHIRutwglsZx75wyHfcxvg=;
        b=Azp+ww09yUQhRGdVzitR1nAyIr/gPVMWXphaCHSUlb7i2c9ggt/b8ptqRnZ2e57hZb
         R1xy2bdzmLeUjA9hrMh0U/6Mw1NMsjpo85HQ7WFWMluP7Aviy6vWd1bUWRLm8D5xkfKD
         WrMeepXo+4F6O+VUZHitegINXTGwG3O+4Xn/7RCUJBxoLeecocukC+a2xP8lihjV+x8e
         fyvK8V/ewm+dSqRT5eBNMI2Lq47q5XdGxS/MQFhpULiYw7uzGey7MbNc9OR45mK5klIQ
         0pVeMNiFKIHfVsKAJI3OLnOyuPi0EM3T6xiigJ1yIzO/RMubx5dsSnRQQZXczeTd4EJY
         bDyA==
X-Gm-Message-State: APjAAAWq/4GOmUVTY6gvkYYmRo04+rlXlIAQYbbMoHvLbzgi+zqYr6GW
        UFwYMNAY+dK08Dc0dwZ0MRNEeA==
X-Google-Smtp-Source: APXvYqyab+2cwyBOIa0dwK24OotGY7eykkMEkpi06jQa2St+oPz6kvtVeXrKrDd4hWE2i7sb/U7Umw==
X-Received: by 2002:a1c:2d45:: with SMTP id t66mr7297226wmt.106.1554456893907;
        Fri, 05 Apr 2019 02:34:53 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t15sm1954128wmt.2.2019.04.05.02.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 02:34:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: Add pixart vendor
Date:   Fri,  5 Apr 2019 09:34:28 +0000
Message-Id: <1554456870-8104-2-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
capacitive touch controllers and related imaging application development.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0e..dbd8893 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -313,6 +313,7 @@ phicomm PHICOMM Co., Ltd.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
+pixart	PixArt Imaging Inc.
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plantower Plantower Co., Ltd
 plathome	Plat'Home Co., Ltd.
-- 
2.7.4

