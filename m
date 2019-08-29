Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DFAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F0F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lm+R47r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfH2PXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35404 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfH2PXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so3890267wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7s8XMIK1ADDSwZv8wtPDqa4O7M6uLq+I4bE0RIGmcEU=;
        b=lm+R47r8Kmpg0fcSiVVqBAUz5TJdRxQtY69fXCLqNtPrai2qyCdQVHuBqsuHh64jJ7
         Tjkz2dTkfZqSmobqpCNEsabD3L1OE5q6yZOduPppAVV+oFR25R+0c2b32fZ2VS4j7moX
         fu6SRno4oB4Mve7wLphj9nCGwuP8jKyOrQeQyYDwpJfMb3w8yW/fcGzMFi9PMtXEMgU8
         Yn27dcCkk+U99x7NqpXRP49LufDMrsil4ZgqUPtyR7m+/AcWOkPGM+vMUsddAYi/Fgeh
         5TCnsPLetVnYNjMGEA7gwD8FOxUqeM/g/IWa6F536foYkG6xFO0UKWa8lPN/QWX2+w/0
         zY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7s8XMIK1ADDSwZv8wtPDqa4O7M6uLq+I4bE0RIGmcEU=;
        b=oM7xZbeCksKjWN6e2h1vcynRsg5vucaJ76kndl84psHqOnU0/rPD1HxBcQ/jIdk/ws
         zz+NzFmCdULfw0gJ3IDEQCBPL/M2itvGWY01lBvnbDVFdJl6rjAvuj7z2C2BWODetwA3
         2r2gxRO9OKxXCOj19JtV8L0hLiMsuL8WL36W7qQJYqajlqYqRtf+OAsp3PYuXyDMTTeW
         RzJMDVXv55iq3oZ4gpU6ZzCumB/8OiPXPva5YLnrsV2yI1EAQMVjAddw/y+Uga9yMmS7
         tdE+ki6/PY3AJ06jil2GtbsaT3+0WXnDNukGy35Zac2PyPZIb5Ou9cYKCKabrEYP46PT
         kFqQ==
X-Gm-Message-State: APjAAAVkKd4tn0rQPtWWsglbuCnupM7NsSFQUy91uCpkHNtKUP9LcjnU
        RmPRUvshHnzk70+YZKrax2+8cw==
X-Google-Smtp-Source: APXvYqwFLT41DeScFhlvt4emDzNWRXlIfn7uKN3hZ5D3QZDhRaeGQz6cTcK38nnK/nmCOCgIJBfEGQ==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr12361490wro.337.1567092226498;
        Thu, 29 Aug 2019 08:23:46 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 02/15] arm64: dts: meson-g12a-x96-max: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:29 +0200
Message-Id: <20190829152342.27794-3-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 17155fb73fce..4f2596d82989 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -409,6 +409,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

