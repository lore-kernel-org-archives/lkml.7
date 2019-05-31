Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A99C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F36B266EA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MLOrSTV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfEaJb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:31:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfEaJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:31:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so5475886wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XUFa5U6isWZ7sY5b7KzRU7MZCM9RrE7vyQt7fpmtT4=;
        b=MLOrSTV7dTXzxU49x4bDt+i4tkXD7kzAQpmwQ9bfTBv/B0cg9fAvuxgqkLXRIjEr9c
         aFSbGbkA3xaQsc40nPleliurFUDWlHuT4f5hb74t2arP26m0Nf0g7fBCgMJY42OYRBJd
         KDUmnjhPwj9+0aeWInVRsHpjkRC3ymeKr2WmduIQMk2YS97ZOmrx0mk3OKc+iQunLVp0
         hNifdZ6j4EsjCbskrCt5DYr9K6H3ODgVt43y27Xnqa5Y0ShU5EgUTr/DJ09GhQVB81cU
         z/QrhG3bjKA0sP5isGkvTkti38x+V22BYt6RfBT1cNnjXVEoqa3L/iOhEsK2v4nSW1YA
         LcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XUFa5U6isWZ7sY5b7KzRU7MZCM9RrE7vyQt7fpmtT4=;
        b=hP/pZcLMMewoeOuMGQzI97pxsN+5MYOhCaZroWziCzXT4IL8mrrZfkAJvClixxmqV9
         q+ydjhaYqZbSjYVsIyuEwEmDwUHobLZ+pN9W4Js+hX6edev770pAZgcZ9oujZtCaM/23
         jO7cr/s5so+ZnJ9KS++2WLSdCxWr7GXwcULccOnQPwE26I/DnutFv2osTiXssGde4ZVY
         uWL59QucANq22/pWe70cQQM/eU01N6xpkxRvDILN+0S2APPV53vixGA4ltaKoiPgl3Wk
         1SvHoZh/Esq7OUaiRXeSUrn3SoCEiBWvJgh6e4t7sDS7k8AJqCyhFOfZJCK2OH3hHqQS
         Ax5g==
X-Gm-Message-State: APjAAAXbCA8KTKkhVjJE5PvLJME93aaFePCTp5LVWVbNd1JNqcubMW0I
        1CSoWLDl8Ct2k0PQjOKQUxq/zQ==
X-Google-Smtp-Source: APXvYqzgrqYZPxkbQY0KTYLUCn3TpwKRSYfNypkhzNaTip4VP3njQzLsn0of+r+EUNCcWFHL4ErJtw==
X-Received: by 2002:a1c:4083:: with SMTP id n125mr4896062wma.54.1559295095233;
        Fri, 31 May 2019 02:31:35 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id b136sm7187023wme.30.2019.05.31.02.31.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 02:31:34 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 4/4] MAINTAINERS: Add meson video decoder
Date:   Fri, 31 May 2019 11:31:26 +0200
Message-Id: <20190531093126.26956-5-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531093126.26956-1-mjourdan@baylibre.com>
References: <20190531093126.26956-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the meson video decoder for amlogic SoCs.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 429c6c624861..4aa50e83a494 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10215,6 +10215,14 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/meson_*
 F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media@lists.freedesktop.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+F:	drivers/staging/media/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 METHODE UDPU SUPPORT
 M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
-- 
2.21.0

