Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD25FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4F02077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FSUPjkY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfH2PXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38440 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfH2PXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so4291851wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4qtGd3bv+h29yhSk22SX0CJaSUFSLWmZFG52XETCDI=;
        b=FSUPjkY6A0N+lU17R2nDiCi+Wpu9Nhe1HAEAWHeXyRhHNhBVqXaeLlGHx/UpWWJsVG
         M1ZcrOhadokARZds3Vrl5++RopTa1GizrCVj7fCvpeFSLYsHF8okzW7sDXCHALx/4OK6
         9e+yFPjhVkD1IQtHiNEzN/AD9ZTYqgKFBcCdC1rHJQaoBEyrOV4JSSpRDDz8q4sA8uV4
         V+8IFU0vFQHs2shx8cXJ2MtPM5ASxFtFhMCCvnmlTAUmkVCt4jwawQm+312MYg8skSkR
         P4S6qb+oxfgaChDmpCGRIsGNaxdKd3tY76Opq8vetB5Zm31ybHmb+0wblFqJxcP9SRN7
         dC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4qtGd3bv+h29yhSk22SX0CJaSUFSLWmZFG52XETCDI=;
        b=DX6u+zN8YuE0D3UbQjh6MxkIS5lfHNmXg4T9wowr2pb/JeXOPywMf7gI0vakNNm37o
         MzZPsjfeJtKSZWpzUCvCfixC3ubPw2sRGlUpjg38cadM1K7W/wm1FuU94QnxGtXPsxXT
         x3XRTDUcIEiKOL8r/Ipyc5aLs3cAvt2woykZgy2kIaT/x2XMOeIeOiQJMrN+9eTpal4J
         M1vIzPZKnoQ0JHyRDrx/VmDxOV5+Wnq1te6YzIhvXrxMNL774NUxy9cKGli2JAjCHRkT
         qXDYKwVpikbCbd3s9noEW31RVc+O56wrjDBkxMGuAIW1Yf57tsaEEAWX/XxCveSTGsHI
         if9w==
X-Gm-Message-State: APjAAAW106LyQQcHWSLV238qHopp+zlPJhysQiQyYboqsvyv1wDqWGzy
        EcDRye2zQL6XDxyj85dR3WsA+g==
X-Google-Smtp-Source: APXvYqw/3Puht71IYQQu2BpacUINPd2n8SKih/ViY/jGkwU097rCP8OcAhVLyZ/qjWn1hqHJKxJLDw==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr12778949wmc.67.1567092228593;
        Thu, 29 Aug 2019 08:23:48 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 05/15] arm64: dts: meson-gxbb-nanopi-k2: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:32 +0200
Message-Id: <20190829152342.27794-6-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 233eb1cd7967..d6ca684e0e61 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -280,6 +280,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddio_ao3v3>;
-- 
2.22.0

