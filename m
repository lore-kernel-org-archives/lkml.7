Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92962C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658E22166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fbztu1Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH2PXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34266 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfH2PXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so2321344wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYP9GFJZ0QFKzqxWJbg4GUUkUmcZCZkrYKJIkvHiNWk=;
        b=Fbztu1QrcR5B3nPkxILJF/td8lbixGBXFQcrN2ejlLKJwYhvY7u+cqiw9cOtcamT4T
         FEOsOl1ssHSc+4Z4HGmWWG/vrJbliAUSAq5H5A9p8VGYi2Ov6cN7Reurg/BPYAfB8hnG
         FblMIm20VEUPX7bzpp78oGqTUReqVFr0Ucx8bgBIRpGbVP6ZhphES1E4noOfv97pTbUC
         PntIXhknVINUqZDfU0u4sh0d5sbcvuAOhWXTXwFVvgcjtk+lI/0031f6sfpUe7HCR5iT
         KsdFLGC7EsjbpD4swscN/sNTwQ8wVBkhID4sgl/OeYTX0cUKD1AIz+i4VEvkfoUCzvMf
         ypWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYP9GFJZ0QFKzqxWJbg4GUUkUmcZCZkrYKJIkvHiNWk=;
        b=aEcs41Fv76VxLlXP6HDIzFlJIsgS27yPpJxd4lG0yoSCmWZyM9nULU+K5/+VfVr+qo
         T0Dhs0egQyOytKhmNE8CSD1T52db0G55aAH3cG2hgE5wIkfzAyxKR3oBePpW0dRdSDus
         pAtkGMkgUwPFrkrO0dV06QDVRAIc3QuXmkYS2PSQPGl3tDYpWuyhQSgAEjD0BWR/U1pm
         vSNoacMfuhVYLFA4/4T+QkRrazvUXh/0tLVTv/cVqn8u4S8H4dKb3W4qcOpLjnq74vUb
         JgoP7iYyQpRbnAliUmLcARbblcbnu0GhRMpDNvCAmc5hmOmFx3GIp45AhD2oy/v2sd1Z
         5isw==
X-Gm-Message-State: APjAAAUq5soGsG60kU28QMXqS071tu6whv2DUgTG0CtUySiRzhgExVr/
        7eAnKs7BZ8zWjM2UWyCOqiJZdg==
X-Google-Smtp-Source: APXvYqxN5V7NJodBKWG/AvkjSt+uzMe3XdB0D2IodxjvrLvBBQ9uzK+GDDMvesObgwhQRev+LGSArg==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr12560799wmk.51.1567092225839;
        Thu, 29 Aug 2019 08:23:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 01/15] arm64: dts: meson-g12a-sei510: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:28 +0200
Message-Id: <20190829152342.27794-2-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 35d2ebbd6d4e..b31502727d4a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -508,6 +508,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

