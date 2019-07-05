Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F57C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9ED216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLp+9NqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfGEPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:15:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35675 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfGEPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:15:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so4455736pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3shWyjUMuq9t5Vu5n5b4WyN7Fp07Hz5BxwWZP81hBQ=;
        b=GLp+9NqHTitbzc/EsYIplus2wwytDD1COg7tthvJ2z5C8u6TdKlK6E52+9zQmpo/WA
         vr2Ea2RI3BbF84Mjk8+R3Ql1MGPwxtXnLPOc0v6pelHEkoPT1mrL1wgi6ZR6EmyyHvAI
         jS8p0xLZHL2Pkqpa341OyGhxtca7Ga12OwWYTVagEvFpGj5CIhDJxSCMW0JasKA5K9mG
         ZyaqF8WakEI2giuswI29XVelWqw+Jy+oFJ+0oIeFIF5mADrGyv8nsL0DG5Vn1F3pE01R
         Hb10poYOGOSaXMvo7zwOHatpZhAqtyIwKRaMsnKjgtURH+zuyJLF2xJcCEC/5xNRlbOG
         mLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3shWyjUMuq9t5Vu5n5b4WyN7Fp07Hz5BxwWZP81hBQ=;
        b=IMSA7Z4f0Gj8WaTp5TnMrtbbMD6YH2DltgthKclj5WM7stih4Xp4NMgJEOlBqEWTVo
         4GV+vugS377ZSCi5quJC+5KjAsiRMB2i45cIXYaD9MPy9zkBbQQZFlq1eQQuq40AfVpv
         03BG8A8PkS2X1MfGKy4ofvwPJc0ybsbYvhdSnfIdsjctHGRAbvdI03O3EDRGJT3BiYSR
         yMMh3VjVP3kOV1f8LP/f5OPqaWK1ez/Vsq5vjvHolQ2pUg9yJ7SLX+CU11+sCrBtKPCt
         z4uMsSObDi+cM21UlxTyzcvEHI8aEOGWeGq0VKZYP+V1clSM/M1SAYraBcFLYZH4Eluw
         bcNQ==
X-Gm-Message-State: APjAAAVCnsZxJwYpZyIIWlyk1zwDipCf9lfH8qeXsbSviokc+xq48Eef
        Q3Dcq4lvnBY2Jc568memUKMi
X-Google-Smtp-Source: APXvYqw6EQk4uR8VqbeRigjfRsmWR1YAaEHXOOQRQW99S4UWiNDtnjOUj1yeXWg4KdwRNP1FZyRfPw==
X-Received: by 2002:a17:90a:25e6:: with SMTP id k93mr6322707pje.100.1562339727172;
        Fri, 05 Jul 2019 08:15:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:916:7317:a59d:72b6:ef7f:a938])
        by smtp.gmail.com with ESMTPSA id w3sm8248778pgl.31.2019.07.05.08.15.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 08:15:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] MAINTAINERS: Add entry for Bitmain BM1880 SoC clock driver
Date:   Fri,  5 Jul 2019 20:44:40 +0530
Message-Id: <20190705151440.20844-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Bitmain BM1880 SoC clock driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01a52fc964da..f9259161cb5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1464,8 +1464,10 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/bitmain/
+F:	drivers/clk/clk-bm1880.c
 F:	drivers/pinctrl/pinctrl-bm1880.c
 F:	Documentation/devicetree/bindings/arm/bitmain.yaml
+F:	Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
 F:	Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
-- 
2.17.1

