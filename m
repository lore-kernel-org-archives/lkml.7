Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CE5218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUWcHKtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfDXMDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:03:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34837 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbfDXMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:03:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so9301165pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W9bSn0OqpP5RdzN44itrr4Bd4P8/I8xsjoaJwybVMyw=;
        b=oUWcHKtglfevDr79ibcbnHC0CQACs+X1fLjHBpqiw0pRgA1ncsIVM/hVxcQoC05Fls
         SPZHMA+jf8R0hUYlXc9C1NSO7/k9y9B5ru13VCWmcghib+sIDuxHxNx0WA8X0pHdFnUn
         e3BDPQct1ny0LsPKy5nyn3UK+1F3vxyEU/EuoLwYvE52r0BAAmC0sI+jwwfqXHDCUZYm
         U61l5XmrtfOXSaU+VSQOOXpmlaijyI1tg/3mtNkHnZhmDmoFQecGVTq9XsplP6xbhI6Y
         ZBKcvMXPuxFGsTVqMnKVjiJ2CLa5R0NGnwXyP1dO3yKqYXb92cQyCHa8mlDEE38NnCv0
         mDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W9bSn0OqpP5RdzN44itrr4Bd4P8/I8xsjoaJwybVMyw=;
        b=Q+7aPz98M74f2mW2fw6SFbmN1oVGZl4EGxGCxjguOPAeC36Dn6zI9S5J3JXokOgopB
         Xv49ZPWAw9r891jykEMNaB8JtVnYMkAIsxrGev9PlwOEKVvbUe/iawjCXFkGC3GFKaAR
         xkbpzLMgjPPxmrXT2pUJzlWEuYPZVG3mlZY0Q6tx0b8GpsKbmN/8K9X2BLf6oyi73Nu6
         s1NMJJiuRUrTjv0sWgfmoMjOx/WHgUggVzzOp8hAGj2jT7UCTu+FpcjOYkpA6StEPH+3
         H+KJO/IfF26WxAz7iPRWXBBmXCbdTkwJiEBYC77NZR6d6l2v2i1yA4dELmllh446fuNQ
         uOPw==
X-Gm-Message-State: APjAAAXUukCa7BroDfGEWVRB2mY0jAgUWr3Al4si+ew8Tn7R2btrkYN9
        oQVB3d21b9HiKyxbnl0ZyvkL
X-Google-Smtp-Source: APXvYqwdiFSPjTk/uYcmlb5Y0aomlYGMBuKmWWjMHA0BaUDcIwsWbZa8SM5Avh2SERfTQ+TOTsTmKg==
X-Received: by 2002:aa7:920b:: with SMTP id 11mr32005423pfo.3.1556107422940;
        Wed, 24 Apr 2019 05:03:42 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:711:bac8:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id j22sm25870840pfn.129.2019.04.24.05.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:03:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] MAINTAINERS: Add entry for BM1880 pinctrl
Date:   Wed, 24 Apr 2019 17:32:24 +0530
Message-Id: <20190424120224.22660-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Bitmain BM1880 SoC pinctrl.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fdea5010..8b5fcb89a8a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1416,7 +1416,9 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/bitmain/
+F:	drivers/pinctrl/pinctrl-bm1880.c
 F:	Documentation/devicetree/bindings/arm/bitmain.yaml
+F:	Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
-- 
2.17.1

