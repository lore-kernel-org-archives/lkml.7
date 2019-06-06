Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC5AC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F0D20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PTfsAfjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfFFNl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:41:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfFFNl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:41:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so2486324wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REJ+F/EoJF8y7ON3vJSgKlf1KSRuyaPRK39EHGB3NLk=;
        b=PTfsAfjsY3oSeBXdMfkfbzyMxHay18usgjxancBC261D9HS/oJoPW8MRYTwi9k+cgd
         C5pIrO03DPJuZGj/KNYUCiZcuFYCVrUT3+mxUO85wpM9uza5rK1+bYgK62GhoCBe4yAY
         mN5RwsM35bRD96SmVPNGUje6hvbcZCeRWs02OCP3IP5VqnaubgQyD9chTChxI+Up5+Ei
         uzkRx6+L+7ckE4FzaR7Na/9w7yrac80z51g5n2hq1mzRdG0rAw2hLsN+MhKvdgTO/N8T
         mRfqierqUjkjftsjsmAkDwvic8gv86SrA+ybXHPq9LaLqzMwVUY2BxGoBQAXG0z8HOKF
         oqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REJ+F/EoJF8y7ON3vJSgKlf1KSRuyaPRK39EHGB3NLk=;
        b=IImJdNvPGdTHJgXBlDUi+r4a4vcmhgkJnL8NGlTZWYQG6gzdFXZvNJ9BO/znyFWIgh
         OfHr6fh90/PYKFl0pisqJMun9JVBOVSfkghc7tGrmETKlhhWWpVGTL8mjAnCsTli7zLK
         e0h9FpS2TDgOTWMIRVOFuNg/sLCepIJEbwBKHDlxg2iSKylw4Fvh8p9cGxilKW9qNx7c
         IjPgEguphj6KLo2NLWGLJp2faVHgh+/qa7s6fWjadshL1jyXk3AIpHWZlrcDsOQoc6tW
         yruoL3FspGSRtS9tqbtfqolVYbfahBrVbpLLI1SFra6hILHTve+5rg2T14oB6UhFrsvl
         eQEw==
X-Gm-Message-State: APjAAAUlyz9FySPF22R/32qLR03NO9e+gmBdGTtXGlwV4KD1nIyQQswN
        6V9mwVsTOH7HMTuuqcIKIHT5Gw==
X-Google-Smtp-Source: APXvYqyCUOdIPEBrdpfpAXbm0UVmVJdKLxKlwPhqBO3kAZC/II9ZDgcuQbgSw0/eBfjKkYYNG+Rhxg==
X-Received: by 2002:a1c:6154:: with SMTP id v81mr61488wmb.92.1559828487221;
        Thu, 06 Jun 2019 06:41:27 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id c11sm1847367wrs.97.2019.06.06.06.41.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:41:26 -0700 (PDT)
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
Subject: [PATCH v9 3/3] MAINTAINERS: Add meson video decoder
Date:   Thu,  6 Jun 2019 15:41:22 +0200
Message-Id: <20190606134122.16854-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606134122.16854-1-mjourdan@baylibre.com>
References: <20190606134122.16854-1-mjourdan@baylibre.com>
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

