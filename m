Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944E0C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671A920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kKQ+Velk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfFFQFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:05:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbfFFQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:05:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so3019729wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REJ+F/EoJF8y7ON3vJSgKlf1KSRuyaPRK39EHGB3NLk=;
        b=kKQ+VelkUt6JaYM6/XzEtySTnRdqSxbVzVFAxBo810/cywmokiLiR9kZNee1J0oD8f
         ZUiQBCwReVS8IyTTxN1o5MB7Sfd2YRlfLfxryIof6HGtRhKx2z3iC42g0gt6pdBEmz/J
         ErTPSjLXXxXyj5qQQEumXBGTkg42dC6rF7dt4FYx3io5Zdg31GFQvL9+QfjHedb295WE
         F85dgv+buyyOakKpy5ZmUS+XaQqk632bXD2ZFp1o0aBdSrrEp/DlP6ar/Z9eWPRkwnpo
         GudcD18NWBPIchRHYt5YhwfABUMyzJJp7v3A+4jOj65U46ofalj9D+2VhG5iJgz0MkT8
         3/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REJ+F/EoJF8y7ON3vJSgKlf1KSRuyaPRK39EHGB3NLk=;
        b=QpQJO0G0++rqrEwrKXL+RXPCwoye/IqXbz/mDwTpf2EEybWh9g37ZIlq2nrr/s+GsD
         gEcHBscEhpjGt2n0QDj/8x287KLYETURNvtRIhRb4qGmMVTNrowJmndcUnOjjLLbRVmA
         wzWmIHKqDb67K9R/5k8bUOBSPwhnHR734/zSFOJFrRCASlPnETUjFisB3Oy49YGe70rC
         x7qiYSABQzYFIaZkC3peI3ojXPQvTrtL1whSNOhlutFw8bKyeKHLejtNDkbKqhUxbLj+
         ICcfJEBxZRPa8RnbqkYBPJbh47qj9teiJYXx4zWrjG1kxRURnoRQTqBX5711VQ1kgLnM
         wXQw==
X-Gm-Message-State: APjAAAVJKIiUSDUaHCAtGkijWYWb3CTYsvJ6CJjUHM9AdR5jInaa7/vB
        CVp/HN/lAeRa8h/ifsMhhvHlUw==
X-Google-Smtp-Source: APXvYqz3gbNA2D0bF0Eq0O2oDIySuKiZynD3XFfUkI1kKWkAxWifm2Gws82DrVcaBKGHZEl7uIaLzQ==
X-Received: by 2002:a05:6000:1c6:: with SMTP id t6mr31836953wrx.236.1559837125386;
        Thu, 06 Jun 2019 09:05:25 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id t140sm2180901wmt.0.2019.06.06.09.05.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 09:05:24 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v10 3/3] MAINTAINERS: Add meson video decoder
Date:   Thu,  6 Jun 2019 18:05:12 +0200
Message-Id: <20190606160512.26211-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606160512.26211-1-mjourdan@baylibre.com>
References: <20190606160512.26211-1-mjourdan@baylibre.com>
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
index b8fbf41865c2..7cf3ece9f0cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10222,6 +10222,14 @@ S:	Maintained
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

