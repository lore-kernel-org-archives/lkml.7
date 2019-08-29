Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B30E23426
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Cj3G6Kse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfH2PX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfH2PXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so3878463wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwwXyUaZ++vFBXnvVpZlNzI3ezWmJMjo0i3+SjZjRro=;
        b=Cj3G6KseravZPmCocBwTLjeSXyhpMmYOjnNaVqWbOvzjH25MQF0a8Qeavf8V1UsEoN
         yrRLAUnnYUuYaxbhmwV/1PiNoppGlmqCVMhy6HJZe3Upl6zgn+ymIVtss5WIVXHx2tHz
         dwjOrAvjmxeHdTcBzV6Tra27SDdpuENIeZFb1lWrQibIT8PnANB6dMPsK/eRIcMp7/NE
         ui0z627LwRWyAC7awuLu0wIfk5Qr8aiDLKr9HRwRbBP64d8ZcIPTowD60BwVLReRLEv4
         sAqGFOYFYh13ubt9O/HYIfxDQfDLnwpwtZtnbC3XUtb04x7yQFziT0zlk6I3aNvxTsMR
         XdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwwXyUaZ++vFBXnvVpZlNzI3ezWmJMjo0i3+SjZjRro=;
        b=c3JXEdDeGyHmgDzERwZ7CqlonPC86f3FalPFIy3+0BHoPIbJESg5AbZBRdhm3RfrWe
         +/MvLq+gaz7nHN7XXFFAjbh6T1j3PpCuPfTIUPe96YKbN47601P+yKmsj96droJwHCFU
         5fIaz3zzdszvW4zKqUz57em522aqPrqe7h/ElU10zGqN2owl3IMFi/6TfdMNi6wY1LFR
         TnV5QTpt5Qq+MVOEH2nvbQ660d2/qd0R/HzSZRT5sJONCdP5Brn/SO/LurogO+AusFom
         dbvEWfNFcq1zkn/g67m1BtePVsDSyp1fSDyxp4Z8LNOBqr0vDMnJfMUPgNjHVYeYk95E
         /AwQ==
X-Gm-Message-State: APjAAAU68B3NwfLFv7tNakShJeTMVmq01UxgVQmZ4sGIEP4pdOHGrzqL
        akzGj90GoGmqlRtjoEB7JWovKA==
X-Google-Smtp-Source: APXvYqzYVoZuoT0UPIenN7xLbSyJul31lDx7z7ZHiB7y5DTkS5ZM9sRj1I5vYKPkEau4HlaA0y4HRg==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr12687950wrq.29.1567092231192;
        Thu, 29 Aug 2019 08:23:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 09/15] arm64: dts: meson-gxbb-wetek: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:36 +0200
Message-Id: <20190829152342.27794-10-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 4c539881fbb7..dee51cf95223 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -200,6 +200,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

