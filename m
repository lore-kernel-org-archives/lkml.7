Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F57C218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3tLyJtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfHTDIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:08:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46196 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbfHTDIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:08:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so1954428plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 20:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQXeeGH4NH+KvW3vYvA+Nx1Bgh03ehE84T2MSrh9Vas=;
        b=B3tLyJtTm2TA0hYSaI+H2E8POTbX14nTZz2lb0BO3134Ewsp94i1jyKT6lPoehBxND
         Qntt2KyYo/A0nYaa/UnmfqW1k8u/2RWYYOpHwv0+IOO/OTHSsaTpm/M0F8/pOd06kRd8
         3o7w5MaHLnrn+K/+XTxRwsvIcVnsEWyrcGMMHzDimhCUBw56h0+TpDHvGIomaRRzUtcZ
         quaHYuShFdaTVInv/ymvdCax6KBo01yyAjqn7urD/Wm9q5VlVVEDaNRpKo6JGfU3W1+N
         yQUBufeDte/SsHAukvKyk7YGc6NIKQrqEzqRHNWHXrub8QiHoR5CCrnRV0bREerbNKdz
         yNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQXeeGH4NH+KvW3vYvA+Nx1Bgh03ehE84T2MSrh9Vas=;
        b=cj5Ylm7inUaA//hs56AOmuZ0adLUsbbYzUlnMS0yp40B0zL2e+jW12T6kKbpF4L0bQ
         0S/R8Tfd76VZh8YdRDirkFeTwd0e2/YpeJPKPy5XGTBE7+D1CerwfZDEcURdUFKrrRmM
         nL57uAQQevhKy4+Iy3RNXB4e4LEsqsYbgJJu7nXWJbL4EPzCyiRgJZH6tDIhrRMstj7H
         sIC702NoMKQRDHgz6JzpCDycS7m523yRaRfyMo9fnLX4C3f3FMebytR3Sdmj+Adx0n0T
         82GzEMDUI8Qargw26Ugju/C9V+z0nJcewLzON4IEnci2ZFofDpYc2B1+Jw/fWUrJLv92
         fkqQ==
X-Gm-Message-State: APjAAAV2FLQsYObbdSVvGNyEm7JyIAULFgqkm25KzYN8jCtT3Gyjfh72
        vUWoDfFfItX2xibE3+g8uCI=
X-Google-Smtp-Source: APXvYqz9UYjUBmx1ljMCAHrt8bWvXlmb1n8GPFsSICAllhOtahyOWgcPHMQTEhHeB2gzzg/C6Yaovg==
X-Received: by 2002:a17:902:a509:: with SMTP id s9mr26456371plq.310.1566270518183;
        Mon, 19 Aug 2019 20:08:38 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id e24sm18694863pgk.21.2019.08.19.20.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:08:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100kHz
Date:   Mon, 19 Aug 2019 20:08:04 -0700
Message-Id: <20190820030804.8892-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fiber-optic module attached to the bus is only rated to work at
100kHz, so drop the bus frequncy to accomodate that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index ff460a1de85a..28732249cfc0 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -207,7 +207,7 @@
 };
 
 &i2c0 {
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0>;
 	status = "okay";
-- 
2.21.0

