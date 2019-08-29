Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F3EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016092166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P/xTEs3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfH2PY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfH2PXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so3878263wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxngJDCKM3LeX2Xo9mNwW4G2eN4EwlpJZJC7Q7VWjbM=;
        b=P/xTEs3TsV85z8C0bFkgbtLi0e3P0df5M45kuBNz8dxe/j6MiSpIPEvZuWJFoFtaUU
         TIOkofgqstGOtCgh4NqOMN3jN/jRL7qCHLowF0tzfadTXzrs3DJChcox65n19JctBwts
         gdEvTkgYN1jn2J9SAGk9jocN8zD+RVG+ixyg3ErC/nqJdzX8vSYuKUxRvtYBQY+w02l/
         u/KonWpZscEP7bEHljgm8yF+Sd3Odqnpg9bvE3OmSpTwhcwnaa26MfQzX1nmKWnRVbiI
         i4fvmpIBmtnhIvlEJ5NRu95kH9SC/l72m9IcafYuglbACExv7Lwc9qFzo6y+KUt16IBe
         lpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxngJDCKM3LeX2Xo9mNwW4G2eN4EwlpJZJC7Q7VWjbM=;
        b=a5ob7WVwObFOR35tZ/fC2OXwXCAjT8gQFgPonUkr6WO6V40rlQlUixNURu4PRNO98M
         xyM9DleEe+aFkkQLkCsizIIK2WacLQucWeRV5XIJHzzAXll0/ZquSTajwtLFtZBd7rUX
         qWguFIVyO2zXaKlUqG1FLzwpM8kHoiwV6mBjLSXzmTF5ZH9KykZ0lJyNb1RC77YLGjmh
         xPSJRvY0sJ2b22q1BK0PWKX7VdIAqKlDVrAKvlw/Qa3pqz9PuvPrY4e7LECZo7zoE0jx
         d3m4s3RE6Q80WVcU4AHE1omqheMf3zjrmc6ObDq3XCUta3b81IGeGp8KIeiV7nXKI+Tt
         FARQ==
X-Gm-Message-State: APjAAAWxySlEafc1TeSNk8ldvSG1TY81Q2DG3P0ufLmPAfIDutD+fjVi
        Sv6Z0Iuzt7KCM2v8aKFyms8zdA==
X-Google-Smtp-Source: APXvYqyBAN4/Ban1Og0YFLOBOTc573DLTUUOgxbeF+T0Df4k1C1R9djHlN0ZncmhdtdCh8ch3GwAjw==
X-Received: by 2002:a5d:604d:: with SMTP id j13mr11973154wrt.244.1567092227153;
        Thu, 29 Aug 2019 08:23:47 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 03/15] arm64: dts: meson-g12b-khadas-vim3: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:30 +0200
Message-Id: <20190829152342.27794-4-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 9c3ca2edc725..0bbf69fd9672 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -446,6 +446,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vsys_3v3>;
-- 
2.22.0

