Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0268C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0F22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CVdltlJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfHUOVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfHUOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so2247521wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ugngOdLxigFZemdrr4eu8WpRfTmu8+1TiC9WgYeXhU=;
        b=CVdltlJ+0GpGDymZlihjbeAuNTaI4yJ74G3OZ8zyICLH6U5wQg7gVyorSEPUxWPchC
         TpSxORmVobChRkZ9l9nGGl7/JYa0hoDqFntjUdTu0lwQ3T+5tpHc3jisJXwPmtuq/tB6
         iB+Z7rDm3246/RJQyqFzm0iSxr63epeG0jfZXPHqszwQdKQ1HhtNIAL0Bx9mCNz4TpIv
         DnsVyefnJFUFvEjNt7azQNeXbtuJjiJj5tyyX2APyoIQm3/2/mYXPQZpRJurThv99kO/
         e43RbJSTD3tyjx3EIN0l7PwyOhKtI/SMeXxegF1APCftI8tsUFU2qlApVFAwMLzrau4Z
         8pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ugngOdLxigFZemdrr4eu8WpRfTmu8+1TiC9WgYeXhU=;
        b=QvSuWzICuxARD4DPBXo9laUvosA1ioFD2b30U5dBB9uAShBvchfmHD0NwIt/hMske0
         hT1+9CATOtI4Bgxk4Z2hYgqosevnSpRU58A6VEZ9NuGhHzBn6KIdJvWzqeAvyDEL5nAa
         sZJPZQp893tjcP/eyfvWX16l94eQD2aPgMqHU6+NjNl+Mg+9sW01uaZ3iWcJa0idDkvM
         v57HaWeBu7378OGK/1pbMZMry1FGAVUlC0qwwUQo4Xk0ZWxGoaU/w8JdaU2RoophR8z7
         WsYgFBx6LKO3O3m/bdzqRYrzaNy8IRv4pkd0/ZC9cHXhY6OWaOXO3OhmHLPPOYbYXHhf
         WaLQ==
X-Gm-Message-State: APjAAAW+d/RTQKl3GEBdHvfGiDGRgLdzKsjlQ7/OqFgn5RSn+Hav1/4k
        VhqmoxGVm6JVGjwe2wLu8TWdSQ==
X-Google-Smtp-Source: APXvYqwSD79nk88x7e6MpuJ7uI9b+ep5KWOY2LfGTvIApMFVEqrcd2lvgI3fGWMtA+/eD2tBRB6+sQ==
X-Received: by 2002:adf:f206:: with SMTP id p6mr42438473wro.216.1566397261043;
        Wed, 21 Aug 2019 07:21:01 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 07/14] arm64: dts: meson-gx: fix periphs bus node name
Date:   Wed, 21 Aug 2019 16:20:36 +0200
Message-Id: <20190821142043.14649-8-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
meson-gxl-s805x-libretech-ac.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

