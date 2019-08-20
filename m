Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C64C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC0C22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tK+RLHY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfHTOlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:41:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33873 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfHTOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:41:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id e8so2570500wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9n4vL5AKnXTdEpCX2BHNEpG2Tbnp3//JpmPid0dGPgs=;
        b=tK+RLHY6zUlOOhsKM4rznnfPISNI24hB1YvLotfEWrM86a66y6A2twRdVzvLjA5o9f
         I/XIEzeTDjmV5nILoSjmz5Qsb/tQo3ykPKXnKzwe+Ne/PAWIHztByhdEN1RdgvJBgpn4
         +eqFRwLRneDDaHQM+g1OO5D9m2F+CT+2a8uHnAXC4XvGFfRWtq58SZxiTEAShxfGGCA2
         uoNZSai4xYdpugLLZZ8oaG6RgAlO+Ebfozs9N1mOws7dZqhhbna/3KqhiGxHIEO7dAbz
         MINfNe5FDClZw6BQiJNzBcQgeB7WVsDX99H0cPBaI6SLvAU42TtQ2zrra22jUBq9vQWA
         NfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9n4vL5AKnXTdEpCX2BHNEpG2Tbnp3//JpmPid0dGPgs=;
        b=Xpyn5sp5BfB2jrWqzegPa+w+HrHTqrAYRAOXV4/fnKL1/AfjSkff6fq3fyeTTxMTMY
         RyR5EHP7bz9mNDSTDa7ze92BrMARG9rfVafU/vcA8xi4cxkJHhN0pihMU3PNL5/GSJnt
         VcUFXCIqNQxwAdipGw1wprDq3MuMznRRzxljGK6O4BGsk6gG/5UQl9deKAFcAmKNaehJ
         4e4eekPHMjVDRP0gOp2H52yLRTfgIyWwD3FDKBEfBC79ia8OZTMUi7lj2o+m9HZLE43u
         4ZYE33so4WsoxDXUFnDnUoCnt/2/W3US+AcRDE21RUlHZnW7t9MuT9mOyu+7uTBYgxBo
         VgAw==
X-Gm-Message-State: APjAAAW+1jGWTFKc+wMwOGrkqGo8Amx4jlhJyA7CcyIXUEBZFZFJHdGb
        OJIS1F7l1TaYJVPh2/w0f1fQQWl9ExjqqQ==
X-Google-Smtp-Source: APXvYqzMgawTTA6xqA+odeNgl1YDT1Da7njoTjpy/er3HfA/XKn/fAVRNydIf3lGgZQmeLbxRI+uNw==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr351562wma.53.1566312060700;
        Tue, 20 Aug 2019 07:41:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18sm21826750wrt.18.2019.08.20.07.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:40:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
Date:   Tue, 20 Aug 2019 16:40:51 +0200
Message-Id: <20190820144052.18269-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820144052.18269-1-narmstrong@baylibre.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the Amlogic SM1 Based SEI610 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index d701e8447363..b48ea1e4913a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -152,5 +152,7 @@ properties:
 
       - description: Boards with the Amlogic Meson SM1 S905X3 SoC
         items:
+          - enum:
+              - seirobotics,sei610
           - const: amlogic,sm1
 ...
-- 
2.22.0

