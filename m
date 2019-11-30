Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91980C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2E22075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tBO5/eSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfK3Sx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:53:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54134 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3Sx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:53:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so17270555wmc.3;
        Sat, 30 Nov 2019 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kgxHfmrLrW74snZZglbmg5V/YCpIUHU33YjewUkzMA=;
        b=tBO5/eSaNaTn3qZ5phIDYDVnDD/KurOdupHxeZOSTuhWIP8nSsFhAm/g9TZ0MrOTty
         N1qkRdu2uEu15LuO9FJnXJqk1y44ZBoz7uU6bpqfP2TJwRDdmGUEzBLoxukNyke6HTSa
         YeJ8SbdVnjX6KTlHHDtBtHmqfAyWwR4xPF/kLZKjPI9HGtTZwx+RKsgEKzrqG5WmPFJ+
         0kPEihJQsJvLZ+U9OaXyaxUv4GQCj2xX/Acro4FowuGOnyRGCoLdaLQRP1DVrLm/Uq6q
         RJ9hjfDX81UtmVAOOJVIh/0hvyR4h5ZWaacb+Nw4Z5JpCaqU6p8e3ONvzpVA1aoakD7p
         8ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kgxHfmrLrW74snZZglbmg5V/YCpIUHU33YjewUkzMA=;
        b=Ec6ntE42lQOyIDW0M3brMVvNv8LGxVZGlOcwIrCpGX2KaMrtKMPXERWy/VEGIOF7k/
         IYnSVy/2ECe7Fb1Fb5c4L3yRwbMmZ982IzA/G4FF3NNB92R4nWGt6OEGAGtZeN7i++dN
         Lspb9Yft+7wNxhlsrRTDYy8rjAmx6uqc/3qCBkyAuQRaiRet0UUmTWoWRjAbfDxQTz/O
         f3uqJx3d9GpHJL3rA81tigipW0Oex6uA42tmBI+9FvMIbhxTKvtdqZIuWLDVZj+5zQLB
         0662lmVrneurJeBX4nhyzcBuOjbWC+pNJEvXjl5rx96jtNrsLoY4rtylIIBtfURPgZdi
         YoLA==
X-Gm-Message-State: APjAAAXq3DM7Y0dV8rTpgP+VUsIayNLn6ppg9BTzFEMQ0QF5SI/oYcHC
        AlwwrU5vfSvs39XRnMbcd0E=
X-Google-Smtp-Source: APXvYqy+AptLFvOg56oiPA3eBF+V/0bqwP6CitN+KxZd1XEwAi/fIeyCYGRVq/t79HRYvwAZ1FDOOg==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr19716529wme.35.1575140034761;
        Sat, 30 Nov 2019 10:53:54 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r6sm19295637wrq.92.2019.11.30.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 10:53:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     p.zabel@pengutronix.de, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] dt-bindings: reset: meson8b: fix duplicate reset IDs
Date:   Sat, 30 Nov 2019 19:53:37 +0100
Message-Id: <20191130185337.1757000-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the public S805 datasheet the RESET2 register uses the
following bits for the PIC_DC, PSC and NAND reset lines:
- PIC_DC is at bit 3 (meaning: RESET_VD_RMEM + 3)
- PSC is at bit 4 (meaning: RESET_VD_RMEM + 4)
- NAND is at bit 5 (meaning: RESET_VD_RMEM + 4)

Update the reset IDs of these three reset lines so they don't conflict
with PIC_DC and map to the actual hardware reset lines.

Fixes: 79795e20a184eb ("dt-bindings: reset: Add bindings for the Meson SoC Reset Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/reset/amlogic,meson8b-reset.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/reset/amlogic,meson8b-reset.h b/include/dt-bindings/reset/amlogic,meson8b-reset.h
index c614438bcbdb..fbc524a900da 100644
--- a/include/dt-bindings/reset/amlogic,meson8b-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson8b-reset.h
@@ -46,9 +46,9 @@
 #define RESET_VD_RMEM			64
 #define RESET_AUDIN			65
 #define RESET_DBLK			66
-#define RESET_PIC_DC			66
-#define RESET_PSC			66
-#define RESET_NAND			66
+#define RESET_PIC_DC			67
+#define RESET_PSC			68
+#define RESET_NAND			69
 #define RESET_GE2D			70
 #define RESET_PARSER_REG		71
 #define RESET_PARSER_FETCH		72
-- 
2.24.0

