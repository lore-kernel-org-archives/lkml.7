Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5525C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C19622CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YfxImhG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392612AbfHWHDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39694 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404064AbfHWHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:02:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so8015345wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPoIVNTOyXYZTC/cgAG7gahdttdsAPpU7OveXGHBbvU=;
        b=YfxImhG+22XDen7JHzl0JDxmhGa7/ESUm4mJtSmdvZZTAOX26RHAl0qk5t/UO+X36E
         6RInxOsMCTA97hEWnyoWvP4c8d/pgUlRkrPXZ9gfGK7CUqDWH8WNbWxzq3tlvqeOqxPF
         XqL5CSjR2oCGJ2pwYBq93hVb/vNQGZRrTTw7xwyYKYaMvT+Kr+g9yWI0ZxdNPWtEwtqg
         MoZs9LdcH4SYPLWmUYCuDXWCvRpKMbQ1KU4sAiuAl8DJygbyXaH8CjupU499pz+fHNMn
         eHotGOnYvhJVaa4mUcUjQi3SIBv+tJIYoAp7K59mwNBi7TUEay91nnn9Igw4nA7NAkvd
         7vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPoIVNTOyXYZTC/cgAG7gahdttdsAPpU7OveXGHBbvU=;
        b=VMi2b+lNpmiObpVpHajhiuNCVhyfvLId9/4wmwn50D5emNE/CuzkrzbHEem8weLNZP
         Y/3t4P//W+v2nV25KDsei3N0PHcqgudkoIHEZnPdRKU0VlEG0wVukvC/xInA0BZf/I/I
         zRoYrj9IFpfDfuqU2N33ga9aTzL1MQtTKfL3qB2YP/brLHIN9p+8u0eNmpaDzFTLOExT
         5DnhsdtrpL/vRB2xX9kgycYpOvq7OINBKHupiJVF8meXk4dI1kix8EFtbwnXbjoT7v1a
         qxdZS6GqlG5HViKN0SOH0KIFjwer7ZMWDnFJVKkcrsb/Bo0ZSeZ9iJmX9/X4OXSp1Zkj
         88PA==
X-Gm-Message-State: APjAAAVVKfC/dNrbhGRdE6SBpu4I5BzS/C6gzAG55R0N3yirTy8yD758
        O/JYpXIrE0N0nkfShDb4jCJL3A==
X-Google-Smtp-Source: APXvYqzRycjTAeMvnARLoalSZo6AnDl57rvyZAJDxY3tg33MTQOXf9kfJt0kHqntUwrkIABojGsTnQ==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr3076694wml.134.1566543777680;
        Fri, 23 Aug 2019 00:02:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:02:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 04/14] arm64: dts: meson-gx: fix spifc compatible
Date:   Fri, 23 Aug 2019 09:02:38 +0200
Message-Id: <20190823070248.25832-5-narmstrong@baylibre.com>
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
meson-gxl-s805x-libretech-ac.dt.yaml: spi@8c80: compatible:0: 'amlogic,meson-gx-spifc' is not one of ['amlogic,meson6-spifc', 'amlogic,meson-gxbb-spifc']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 08c01e11ba1b..1c580f42e818 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -317,7 +317,7 @@
 			};
 
 			spifc: spi@8c80 {
-				compatible = "amlogic,meson-gx-spifc", "amlogic,meson-gxbb-spifc";
+				compatible = "amlogic,meson-gxbb-spifc";
 				reg = <0x0 0x08c80 0x0 0x80>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.22.0

