Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F224EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53CB2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GNzT3FnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfHNO3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:29:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52752 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfHNO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so4643545wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9R5lD+eyPtty/EDRB0dxvoT1lDKjG0Cf5Gg/5QaCyE=;
        b=GNzT3FnIRl2b3ybIdQLPxMtE9bcdJkCqUB/3O8hct7afWdURosTJPbMY96tVMfIvjk
         CvSVfwooKZNsxNPcBIFpagBc7IfYBvJbbOm9x39Q21Edp8unNSxuRrFEj/wi8Csdg947
         sTs2lsUyNp+YcFPbIPC4T870vz13/0JgLc5vL2d+x/lvaNrPSrQ3BqJO+++YihV+v0+/
         E6zpiWoSI7G2EHzpnYIo8UjuCCXin2rui80fisFkDcYBofOR9AFj9Qicfqfery2wgEvJ
         Dfcjd2GvMzLSUSpu3skeR3k4ucBm17R9M21hyFtnKt5Tr+qWa30wSPfVSvOqaKC2JGVA
         XSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9R5lD+eyPtty/EDRB0dxvoT1lDKjG0Cf5Gg/5QaCyE=;
        b=Q5Thg3rUT4k4i923Tl0TgkiExot8KhRvDuu0RyZfFhVogVHCVJ3cKO8KnO2aKv9GCl
         fbD72Rk9EBGQ3Bdhu6yOT44ltfeZWv14UbQ/KODNNz1DgsRxdG8m/rvnzbyukatxPP1F
         EyKwavQVNhLFbJbgPn+f0dvoF/RAeSYf3JEIfYV/VxdokC7NQSQQj4J5OBi6v0o6ve0n
         04Cao9WwIE0bY/iS3zDAQ0OtIv2ld+K2h32EBLZcxIo1fqir8H/jEmj34m0K2E+/kgGb
         TUNK7DAV+Qd3+H99YzgEZLXN1Q4w9faHtEFjTbrRyZ+ZJj2kyzFg5REEYtBTCCWjbymb
         w44Q==
X-Gm-Message-State: APjAAAX0Y0MGug5gxnfNhBEVlPwtvIcqrqGsxknjm24YvxXcJbrL71jV
        98dYmk6RS3XW7jqKrrxehZErzQ==
X-Google-Smtp-Source: APXvYqw9hNnn1+mAsquSAj/R9n5028pqU8HwYAJy2MdmuUrEF/+GoIdhBFhAN4poaGz3c4MgOPxF/g==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr8796545wmd.73.1565792969990;
        Wed, 14 Aug 2019 07:29:29 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 07/14] arm64: dts: meson-gx: fix periphs bus node name
Date:   Wed, 14 Aug 2019 16:29:11 +0200
Message-Id: <20190814142918.11636-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-nanopi-k2.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
meson-gxl-s805x-libretech-ac.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index d8127f863b55..a7735d2f0037 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -437,7 +437,7 @@
 			};
 		};
 
-		periphs: periphs@c8834000 {
+		periphs: bus@c8834000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc8834000 0x0 0x2000>;
 			#address-cells = <2>;
-- 
2.22.0

