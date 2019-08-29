Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6BCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644332166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B3ZGPqjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfH2PYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37145 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfH2PXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so4289811wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGMiOymgVde3bgRb+DG9WorFnJ3h5/TfeAtHJfoWjlE=;
        b=B3ZGPqjTyaCWvlxDHFPBBGVhYkZNze/okso9J4FFdKcmGYWM+M3hBtt8WlUbxOsGMl
         Y4CDy+UqQ1yaEKiONf5+OyfRCgU8hxdZ9zCTCdAZTHZk6tqdA9974t67ns1s1MO03/jN
         UiEYoREge9K1WCIX8aAodDh9pvdTfGJwFL9hUjwYYYd5+hkAtI4BKgzquk43GPyXEG+q
         Uv5TSnXXQEROzP93N2JhJALRETIRDbGprFiWzSERHyL2usBfPqgLxwEl4lvARzzwLK9g
         9Cuv6tTMbcZzw6xGXOKuZd3d/D268t+Jo4guN2YWvkUkzlgtPF7lUi9T3rP1CbdZA06J
         XrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGMiOymgVde3bgRb+DG9WorFnJ3h5/TfeAtHJfoWjlE=;
        b=DQngXRkGVQz/n0k/UHYjo72CkneHcPK4oAxu6V4KVWDH5NepWh/JI5qMyFlCmpT54u
         EHJDWCNDuzIAekP+IDDbgnLXFw2y8QGant817192SRJHmLgoSFMV+pkUJKpEI8YoCq2C
         LqnBt6gUBicW84SwuNgmZkmYztrVRtmtEu/oiCwUlWVyUGbpiufMgJClwrmM1TqmQKhS
         q8XV1NGgOFUqLg8br4nPa0dvQmEeJBH9LhysZjt4PiVOarm0/CoNQ1THVfmjugj74P6s
         AjrSl+HwcXlHSnSLRq3En2B7LeRAkKERk3KxL4CnlCbvbamOFU5SSkCh/6Bop6DgbLQD
         xfaw==
X-Gm-Message-State: APjAAAXn1OjMgCEILpeSp6M7r8BHUClzyDhu8fHrCwJeTYKAd3Mso9ZD
        Xj65fDJjg0qEhg02hw7aabI7Bg==
X-Google-Smtp-Source: APXvYqwRSgUqZVgf8FcfNwRbtUbHqSqrNKXZhIUwvNA/2Nzi/56ye1nAZMRQFiYvOjmXmn7DudBoUQ==
X-Received: by 2002:a7b:c7c4:: with SMTP id z4mr12183286wmk.13.1567092229200;
        Thu, 29 Aug 2019 08:23:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 06/15] arm64: dts: meson-gxbb-nexbox-a95x: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:33 +0200
Message-Id: <20190829152342.27794-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829152342.27794-1-narmstrong@baylibre.com>
References: <20190829152342.27794-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi firmware requires that the power is kept enabled while in
suspend mode. Add the keep-power-in-suspend property in the SDIO node
to specify that the power must be kept when entering in a system wide
suspend state.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index afcf8a9f667b..65ec7dea828c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -220,6 +220,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

