Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951C62070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LehSVoC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCRJ71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55932 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfCRJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:59:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so12251619wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2hCudhASw8wxsHkqG+RXtSVr+MYVBar9SgnbE9VlWc=;
        b=LehSVoC1cbIXe0Guk+p7qfvtOhPZ5JYvkaolJ8F14KBrq4civ5pHQJWtVI/+cDPuVg
         PeXrjR1K74DmMhI8NN2i8zDzsL/f4BwUUWHNzqwmna9KmLCZQuNaUX7rdNurDAcFZDcg
         A2RfWJW4EohlZEwvoT5Z+D4kGYp8YPm5F3Iy+YpAJWY47LATi+3QZ/uP7H9/FhYSG+7e
         yAOy7Xa9i4DykBYGKFwOYVGQexZrvJnK5Oy08njjg9gzDxlqMTg6JGVIMQ2NTgS4UzKV
         B9byFcNkIBKoFPJEwVP/DDodSQFe/khSt+4CIsDzCyWb+hTFr8CGdc3ehje06FM7PTqo
         y2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2hCudhASw8wxsHkqG+RXtSVr+MYVBar9SgnbE9VlWc=;
        b=EMLgdEgyLp7nUc1LVeAeOj8K+ycBz61I/ct+tKpBYEMj5bpA8Ohekutm1LrHM1d/9i
         PZ32UEQpwQY3cSitZ1nJnb61JeUjZsDl0ETVKKcbhPGSZjmoPJ/77unbUedz3gNYX88T
         BkC4KbKZptiDgYVSa9z6zOiAsyHq3GPphSnOhwhmq2RzRSDVI3vMZoJfQ2pMUimolL0j
         Iu+bfs7EOoNIgKLdKK8EA+XrrE+l2cMU+x5kY+5OXs0hXhJhD6WFprqJVZxFzIxKyzXE
         91GsfQX92khHwK+PpjRYLZLH9Gyt6WG2s0g3IfafGakqMShRS9NYcSzuJrhn1VUhyIXO
         10Aw==
X-Gm-Message-State: APjAAAUoj9xoJQH1c0xfgPX/V56U3ZjY0TPv+8ULnIynO1elAFKATW18
        5piFwK1Gw864U8f8N1rPbg73Bg==
X-Google-Smtp-Source: APXvYqx6g/IvMnCBJz+Nq2uI6KU+gcFL9xBk3shoRMPKYs5GBkh+tXyLowXIKixDOavBuKxE8HSakw==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr11128724wmh.42.1552903138367;
        Mon, 18 Mar 2019 02:58:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 4/8] arm64: dts: meson: g12a: add reset controller
Date:   Mon, 18 Mar 2019 10:58:47 +0100
Message-Id: <20190318095851.4062-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add the reset controller device of g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 7023c1c0f23c..cefd6e27c7a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -247,6 +247,13 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 
+			reset: reset-controller@1004 {
+				compatible = "amlogic,meson-g12a-reset",
+					     "amlogic,meson-axg-reset";
+				reg = <0x0 0x1004 0x0 0x9c>;
+				#reset-cells = <1>;
+			};
+
 			clk_msr: clock-measure@18000 {
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
-- 
2.20.1

