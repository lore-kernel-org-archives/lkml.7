Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2490021721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NgiLNEQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfHNO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:29:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55472 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfHNO3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so4784536wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjZFeXutoTQ9/qwc4S4Gcm70WvgFxAPchw/gNgg9Wa0=;
        b=NgiLNEQtWUqX8P0Ei3iD8b+27RBLhfEvXaGa5FbFEKc8Bv5yrBx19Hhi8CxjN6q0Xy
         p0GFoQiVrVzNKOYiSNdP/YrNCYo8faWlX/7+qB6ipIC316sqZX+3E5tSEWls1PjjHbEo
         MOm/tL0LaspddVNdp0JWBIwuJp/aYgydIuRb024JoEm6xYNON8zIhaP/O6AjeXe5W5mH
         wXoXCkVcAlK/QpG26EUfCdQTlzKCNSHSZ46l8A8Vq553cSLbNMjU8GjL3DXxrJmNWBIQ
         7NVFnG1NIjtTDdOqlmM21h4P5i805AIMNsyvPqi75lnUIMaJXb+GFE26bJLzamvBZdV8
         ovbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjZFeXutoTQ9/qwc4S4Gcm70WvgFxAPchw/gNgg9Wa0=;
        b=JpVwBSPrQRk8CyyHVdwLQCIVRgd4zoVLz3a175Po/MiePGXft/CrggBBO1oDthKPPK
         CZRciDKEuuCRmZLup1u1tPIBBH97pyF5+vb+UMzcfe5iXRlgq90qlnkYzgUGOLAok6tW
         L3drS5Tkh7hLYwWhdASs0OhD7yjyrolkiTEu3bEx9o0uYWIk067bK/f8OccDS5Rb01GW
         1iPS7CAXZy4eFHpnBYQT1lVsnkVc3k9xh2mrouqsb5ra1xEDYD091QC/pMpS8SfwsRHe
         ylB5xVulN+VbQBmC9rO+W4tz0O/N2nyaxQE4wURRE3NkgH8GKfx0j2MANCEeLDLc7YgD
         sTtg==
X-Gm-Message-State: APjAAAVONgEvMfFGZ+lpG60mymIg/rmBvAB6wRe13hNxgB0yAdBMcAK+
        T8c+obwCYYz5HJEkfOsqhYPVbQ==
X-Google-Smtp-Source: APXvYqwnY1gffUMlCVMUCn3kHuB6YdQrHQx7tWm9YoFB/Jk+tK27whKhtRCrnI7ghOzZMtc9UWOcYw==
X-Received: by 2002:a1c:494:: with SMTP id 142mr8635972wme.12.1565792975630;
        Wed, 14 Aug 2019 07:29:35 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 12/14] arm64: dts: meson-gxbb-nanopi-k2: add missing model
Date:   Wed, 14 Aug 2019 16:29:16 +0200
Message-Id: <20190814142918.11636-13-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: /: 'model' is a required property

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index c34c1c90ccb6..1a36d2bd2d21 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -10,6 +10,7 @@
 
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
+	model = "Nanopi K2";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.22.0

