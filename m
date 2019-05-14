Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A44C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B4C2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0/8LCAaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfENN40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:56:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38619 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfENN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:56:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id f2so2928642wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86654d179AmYQd0W155rp/5r8oXi5m1uO9ZO93VNkFk=;
        b=0/8LCAaGJNktegVp5hvXEJKrCJyGBEztPbgPxBjNprn70liAooiXylCnf9NmSqffJu
         6FdNYMu0hUEVzlblwjLVxsyZ8sqmvPUCzZw++tMu1JOPxtF4KZKCFxkf0vly9g9zOMmA
         muv/ksRVk1QZN3Oq8Q7wcRclQveCNtgDCG2ImYKhGbPoICiZBtNnXzsVLpyeoVTKYAIC
         v/j5fNPYfuosfBhVnuYHWpR/K5uzQehrOSM97xnq4XlAnUZpZbKxAqOn/gB6Px/arZV0
         eHECJ4cl9S8YY0QpVdpchL31zC9aGTuWDlThXekNtMU9yvVq9wXfZTdoqVLpz1bkp97L
         tzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86654d179AmYQd0W155rp/5r8oXi5m1uO9ZO93VNkFk=;
        b=WkGJYV7WcJZOmfkRdSBeI20E70waUi3c4v6PwHbJppr0KjEs9PS9bjLNlOfUWlSMoM
         82+wX11H/Du1BN+Grz2qkVtQIBK9Ce4F4R4rgEkRo3LKs7HfFdYFaLu+OwpYfrqGM6q5
         A6Xhnri0JqXW43HVRiJWsQzJqy6eSuqJ7ZDYniUi8P1CwLywirAr40VvI+6BhZrRz566
         KhbO5qAuskDlNh20oZtUjNygpcR1OtM6IZS+5TTYsrgDFw9deWV0LvedgNYqjVixct0+
         cWic9FYhs7ygfJi0JDW/UTWfI0FHkJs/It/u7vBYwnGpXKydTo5B6oBiqeHL4EdB+jJu
         Vfcw==
X-Gm-Message-State: APjAAAVPQhmijyLwlqAKRQq5VaZAjWma3BLJm74dyGlZHRrHpKh7k87y
        h1HOchrbb4ADueXKdxTEJ2Y6vQ==
X-Google-Smtp-Source: APXvYqwb3bU1jO/QwSVdfeHhtnBJGUvDAKBhKSKwgt+bw0bfGUlasyzQ02SmuLaRek4uISPMHzwBng==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr18652009wmj.32.1557842181297;
        Tue, 14 May 2019 06:56:21 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id d72sm1375764wmd.12.2019.05.14.06.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:56:20 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add meson video decoder
Date:   Tue, 14 May 2019 15:56:12 +0200
Message-Id: <20190514135612.30822-5-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514135612.30822-1-mjourdan@baylibre.com>
References: <20190514135612.30822-1-mjourdan@baylibre.com>
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
index 878588cfb453..87c1e469ed63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10057,6 +10057,14 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/meson_*
 F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media@lists.freedesktop.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+F:	drivers/media/platform/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 METHODE UDPU SUPPORT
 M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
-- 
2.21.0

