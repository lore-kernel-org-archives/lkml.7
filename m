Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC4122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hH5RdNmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfHUOVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbfHUOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so2215959wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiVmfKlzhX6+dDL5MvsL5C8YsLLtVButKhe8QPNlosA=;
        b=hH5RdNmjJBT3vYOf4J5894Cvw2Zmb84ZuGMO502LyGx4AnTAzCTn1v+kpKBzaQfura
         AwEbyduOMk/aWyY/Zy3wXKW3463ceYmpLBoIJJy5YmTjGkXAhGFcICtFKM/BRZAki9sq
         wQ2YmFDn/UgZL3s2JQVi0vgJ9oAce7Kg5LJvclONdqBz0QAWa4mIvSMyHEY6jMAL/A8X
         5AW7uC2J3FYKYcnlANlVpvV+ZhKit5y5AMmfy36Axbez3TT6ZTMWyDaZk61htlibFy9m
         PGeKgpC0BE9aA4ZeAp5HRRDl1AaPRVnb6uBW59ssn0VvqUFgiLIflcj7A9Wiqqq3YmSW
         6JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiVmfKlzhX6+dDL5MvsL5C8YsLLtVButKhe8QPNlosA=;
        b=f1wwV2jHMl51HrohHW+qjUkHj68vBV8d2RfmYL31JWFA+XCcs9Ub559YtTTqm67muY
         nsIg2K2aIvafDTsmFNVFrqSisiyJrQPHTB+sjLfVsUWwlGKLyoLQiYKmn031jpkXr6My
         RWQ5+tqv6HOmrsTbmadUm5+lVWCR/YYSulVvsDoliSMp9Bgp2eAUm7TykGhMYUDD5guX
         iNybwhyHyMF2OWDhivk0KsB7+IkfX/hWJTp30i2fENOaqKolcRvgMaAJnNFl02CdMrDs
         1+HVe4vXeaSA6w9bPb/YBbfCumJNf6abY7rSy/7uQzrhwJbqtlUZdcMqTWbqmIX8xh9F
         7K+w==
X-Gm-Message-State: APjAAAVHbEtBhvvudwikbPLgG7W8/w/dwCGosevOzqE+TTeJ2MF4LYli
        P8MPczp37iyd8cwDyy2ri5Q0pQ==
X-Google-Smtp-Source: APXvYqytA+IeL/TCAscedhtLS8+0EAHXjl0jLspWbuKk28WrOv8yxzZKMrlxagIGQlNyH/+Yr4ns8g==
X-Received: by 2002:a05:6000:4f:: with SMTP id k15mr4084382wrx.221.1566397260022;
        Wed, 21 Aug 2019 07:21:00 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 06/14] arm64: dts: meson-gx: fix mhu compatible
Date:   Wed, 21 Aug 2019 16:20:35 +0200
Message-Id: <20190821142043.14649-7-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: mailbox@404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']
meson-gxl-s805x-libretech-ac.dt.yaml: mailbox@404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 00215ece17c8..d8127f863b55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -476,7 +476,7 @@
 			};
 
 			mailbox: mailbox@404 {
-				compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+				compatible = "amlogic,meson-gxbb-mhu";
 				reg = <0 0x404 0 0x4c>;
 				interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 					     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
-- 
2.22.0

