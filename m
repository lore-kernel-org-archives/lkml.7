Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E7F233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OSGfdrzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfHUOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43364 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfHUOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so2211353wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKp/3tQaH/+CAXC5vPIgbu9pLlo8VAlZxJspdFK2/l0=;
        b=OSGfdrzjIJjZpcOjACbI3Seid/ot5zvi51TgigW1XB3XjpmPJB2WNeCwQiLv+BbDaW
         a8/WMma+VwIEpMV7r4nAGjqYIxKA4rjtgJLqjR11N24KUExmK/naz1ns2YEoQ2xjk3+3
         O9pT3UGN428hlyFLjTzVUS7CIOmFQjVi2fAxfDhaFmFmA6wR9Z59OAOoDtt4CnxOCmNS
         ScbnBdTkBV0+n0D7/8IYWicO+1mv9pD3zSwS2KGee0/Pp4Gv6wwtgcHdTytxPhapKOGk
         UOE1rAHKQxTgX3rJcnDuQDcD/CMtFjC/nFzysoRDYU4nxo09WJtxWxvxhCtXSEBE9J81
         3mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKp/3tQaH/+CAXC5vPIgbu9pLlo8VAlZxJspdFK2/l0=;
        b=MXW0hNPsYRk9eI8k4ccTkDPGwyXg6kXXerZngInr8AWxSKtKf6mQq9wXTG0zF6JlxI
         3VD4DBE3/xSgGwlNgmqewGh11Q/3oBapJzgIeAEIw71dNGZS0aPlq9PxouKvGC3SJr4x
         nid5Jh6qmGFYARlFRaOT7JJLhfXJo3JeUvPfWfcM2DEGUQTi89Ef4ktWqM46iYxNXiIo
         DDC8IzMV0FmK/TPf7UxnsWN/L//OX8zYK1npNvKuwfKmQuEe8olLTY7Hah5dQUdgOJSj
         ilfKiizDfQckxvmDptelhm2N39rl0Lb82+cFK7tlRWlWlB12Tm8g8Z+5Ah90acdAtxRH
         /Pbw==
X-Gm-Message-State: APjAAAUbRxUj+s9MEzUcEgHsJoS6H9DxDSPxQ/M3UV8/JLhDh8/uKPNA
        d/4mTRz7IujboDA6WddGZXOleQ==
X-Google-Smtp-Source: APXvYqzzO0DZqhYIzGAFRa6C0TlMr+71d5c5kM8OtSvLjlSjGtrSDPVnGu4LF7KrckfiDIVXcPZQag==
X-Received: by 2002:a5d:5408:: with SMTP id g8mr34532487wrv.201.1566397267868;
        Wed, 21 Aug 2019 07:21:07 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 13/14] arm64: dts: meson-gxbb-p201: fix snps,reset-delays-us format
Date:   Wed, 21 Aug 2019 16:20:42 +0200
Message-Id: <20190821142043.14649-14-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-p201.dt.yaml: ethernet@c9410000: snps,reset-delays-us: [[0, 10000, 1000000]] is too short

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 56e0dd1ff55c..150a82f3b2d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -21,6 +21,6 @@
 	phy-mode = "rmii";
 
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0>, <10000>, <1000000>;
 	snps,reset-active-low;
 };
-- 
2.22.0

