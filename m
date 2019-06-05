Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA5C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA262075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xSvGQ9SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfFEQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:19:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfFEQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:19:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so2871720wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REJ+F/EoJF8y7ON3vJSgKlf1KSRuyaPRK39EHGB3NLk=;
        b=xSvGQ9SIw52V+xJMZSJu1t5JISloHTwQ/WcAqny7yeQQZs1S1UcR0Y4sA80dMU38y2
         GM6DmHjk9PmL6JZaXLxXOBZdJrwYcAju226VUJyhkORsLc2qHDvJDwNPAOuow/WANc+E
         oUSD+9NxBoOjnoS3Po5Z0EKMmRNKI7L6wDIBjxmxNVfNcuift44HPNGuHNE7Z9iOju1K
         K8ZqdQyUtq/DUKZ0/ICjCuEL0kPB8rNlVPDATjnZAiYnBuCeYFptndmVC6KLQzkHMyiy
         f7auDVsLTJ8PxPn+kGauN3fZHPjISBgiclFUj9Ek14U5Yy7ebiCeRSNUSX8MwOZ6yUrE
         0p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REJ+F/EoJF8y7ON3vJSgKlf1KSRuyaPRK39EHGB3NLk=;
        b=gStFvjRsG21YzyDnqe06d/o36+1jXbfZ1P1TcNJeQXn5vVyF/aOPSNV9rfzlmqHI9G
         y9f7I0meUBuUEsH//HjnkDmnUXY1R0eC8LnW3bkn/a352P4nfNR/UxKJwFbN17hhkPJK
         ibraClI+h9NgII5Ww/B1eeuh1HLFN5X0cL/VYQqaScL7S9700uSFDBIhpxGV4IBhWUFL
         n1yhGQuZlEgUokYcNN/xChMc3Db/M4dvSNr/+kBTHeyyTOysOqy62IuZsHaCJP2nxGlT
         sj+2TL87uCGW1QOoPUjyTpROGUS5EqUDhXXTwAoknaGfe4WfgCO343yf0wBrvfEWurXE
         TyfA==
X-Gm-Message-State: APjAAAV9Qbb9SR5bo6DNmtoQWolMFQAgftcek+FxH0fo7JNGgIomlDs8
        R51dnh5Z0Cl7mIw2m6+sxW2fXA==
X-Google-Smtp-Source: APXvYqwmf+UWLALwoDRIoedcMvv5gTJrZReDlb+XPS5jcOrSEieCWO3wlZSFz74KYV9MywZPz2GGww==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr20301333wml.97.1559751582725;
        Wed, 05 Jun 2019 09:19:42 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id 95sm40062336wrk.70.2019.06.05.09.19.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 09:19:42 -0700 (PDT)
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
Subject: [PATCH v8 3/3] MAINTAINERS: Add meson video decoder
Date:   Wed,  5 Jun 2019 18:18:58 +0200
Message-Id: <20190605161858.29372-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605161858.29372-1-mjourdan@baylibre.com>
References: <20190605161858.29372-1-mjourdan@baylibre.com>
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

