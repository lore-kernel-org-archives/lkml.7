Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF7CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE7822CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y3j3iCJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405132AbfHWHDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38493 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405069AbfHWHDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so7618210wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKp/3tQaH/+CAXC5vPIgbu9pLlo8VAlZxJspdFK2/l0=;
        b=y3j3iCJEVDtu7oGjTnedwcQgrl2JHBVZOJrVixukWgmdfKEeK/FW8LAE0L8dTexkRn
         ZxN5FN5t2WY8yWY87/2pUYi5BlR1oB/YcUs6FxnPf7bVE7hjIyhbxVfDzR/34SXwtsMm
         WV5ZcPjM2SHrPP20E44e3c4XoV9qgfI1+3kyWS8iBvi7TOz3F679oEBfjvf1U7BprN3r
         50SB9ZCwTIwoPKvEBgusHzOI3zirbI07qz3AvoKZhUZ7xM3YynCN5GlgwBN8ne8DOWCZ
         yAeZMagJzM0DmDCvwcojhMb9CVGEmRQSy71orEyPT/3AD1BhhPXb/fcAPFgeb+oqmf5j
         GvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKp/3tQaH/+CAXC5vPIgbu9pLlo8VAlZxJspdFK2/l0=;
        b=JdoKAMGUmCR9Z2Bp9GrKx+C94ZznDNkVUxyT6IZhC1K92VyQI49pfRsL0J/9TDp32C
         z2sJh8neNKdMiKlLBgE455BymPep38ySPBr8SEuZ7TUVBoKWDooGK76QrK37MzwLIWhp
         PuZd4GE9cIqiG5zbr3I/QfHDlqtHdKlAJ5NipgsazkcByAjwEGCOz0ZpgKHCcPLmtPXS
         FX0QelEfvb54l7zbS/YLkfJJHS9Q70dCUUOwQpsUCaj53heG6cSie3fE0YNVx9+qU44t
         psoLf1qXO4KwoVqm1DYaYQvT3mFwBKGl4FeR2onbcOzjtwd/nK0aYH3TmS4fzfR0cvja
         szjg==
X-Gm-Message-State: APjAAAWRSC6zletI++xAdKo5pzxCX9MmqpLWUNh3LOXceY4c4MG1Drrn
        KJ3Jt9plbBzABR4Ht7N/9L870d9CRCStLQ==
X-Google-Smtp-Source: APXvYqzHQysbTFU4MseJMlikAoQNVPMZIuTg9LNrYO5FU4enKFF06okMREZkZdmBoHmutZTGESobKA==
X-Received: by 2002:adf:b60c:: with SMTP id f12mr2522969wre.231.1566543786329;
        Fri, 23 Aug 2019 00:03:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 13/14] arm64: dts: meson-gxbb-p201: fix snps, reset-delays-us format
Date:   Fri, 23 Aug 2019 09:02:47 +0200
Message-Id: <20190823070248.25832-14-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
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

