Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3345E20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fOG5Im97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfETUIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:08:49 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34561 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:08:49 -0400
Received: by mail-wm1-f45.google.com with SMTP id j187so712770wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gE13JPen70lcMMYSkQ0HyqWDIMF6fiHhH8f8FN2aii4=;
        b=fOG5Im971iCuPbnYpmVYbVF3G+VRwOao6B3Fo3ILm3lnQamKYXq7wZxB9dakHZdkMZ
         87SqakQueLuzs6r6+yu4F6K6LxRn8UpWMUKAIDS89GJbTpRi8L/uO1tkm4d0nE/PrpFc
         qwcKRtU8el51LdFqKBP2TGNE2/RJx4WRTYYZJOYeAfr3NFj41wcYxbhPbRCUEFlZna5k
         qSIZ+hTIp1xe1Jo5rySeQyDdnKsSidXhC6cgEeF2nVSqPh5HLH035uxYNnnXWkrYbKyI
         YrxMR8/7wQdh9119FeCOGgVsXnrJNWcBu+XvQvTnigGkZk4KH1WHtKVyR0Ynfl8CTNGU
         BGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gE13JPen70lcMMYSkQ0HyqWDIMF6fiHhH8f8FN2aii4=;
        b=Zt4r0c8i0icqpN9aL/LPYsGFoLCYYgdRS1VvFENO8nK9BOeYLdOSjwB+C341Sl6Ztg
         bBcFoqOaCdemHxLBIPXh732mCqrdxYd5bJZVqCn8cLZp91m+xZm11reU7RVGUCkHAEi8
         d8C2EaYLFc0GssOCGX1BMQj2ZF5NaRA8LLKKArhyBel3GK+RXqGChWrbv/DJ3l9ucsKa
         4F5LgOAbczE3/33P/uTfPC8NMvIU1Kfhg7H4bETG3caZOhWz6S/uMeztoLQTwdFP0Ta1
         rDjbTXM1lGgyMofIHlaeRFCPqDrdBC689Benk/EupunCXaMY2JXBDTj0y0ErsgP2K9Wr
         jCSA==
X-Gm-Message-State: APjAAAXtAow2bcCTHWTNtWZS9+F0pWZOmJS2OX5twzQHzMc0O8slIudK
        8Czc7ZpO8eH4zOiAfKez6dQ=
X-Google-Smtp-Source: APXvYqytU8M2tjA/trPL2Vcu2FJ/xCYKepRIwq6re0I7MsPFKJSM8JsrESii0HlWggbEz5V9+fZ76w==
X-Received: by 2002:a1c:2889:: with SMTP id o131mr588924wmo.101.1558382926819;
        Mon, 20 May 2019 13:08:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id i185sm918627wmg.32.2019.05.20.13.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:08:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     balbes-150@yandex.ru, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] ARM: dts: add the GPU voltage supply on MXIII-Plus
Date:   Mon, 20 May 2019 22:08:37 +0200
Message-Id: <20190520200839.22715-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mainline lima driver doesn't support DVFS yet. However, once it does
we want to be sure that the voltage supply is hooked up.
The goal of this series is to do just that.


Martin Blumenstingl (2):
  ARM: dts: meson8m2: mxiii-plus: rename the DCDC2 regulator
  ARM: dts: meson8m2: mxiii-plus: add the supply for the Mali GPU

 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.21.0

