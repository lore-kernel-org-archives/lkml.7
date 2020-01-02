Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6DFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DE72465B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YATk5J7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgABKC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:02:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgABKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:02:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id c127so4637043wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=De6Z7XlByT/3y43y8ANqlsh9lPr7hWe/7UFt2ZwYqp4=;
        b=YATk5J7gbPl8aSHbGfbKvNtScL1wLi/SmbrgwfdHCFO53alDDQe6bpj3xhOaiw54fP
         iWW9bxSoChvzWwHweh5nzSHbxJgsfCG0909tt9AnIoMXLWdAM2CGWF1ecM/aPmDuSqYM
         rl3DXWMbMvWGmE/FMRzDroXXn9hHtgb9+eJITdbEAxviCn/m6LZ3q2Ot1ic3yY7pVkRF
         6xoeoOVc7ZzSRiVrGPy5GpRVGdEYiRVxJzCd2eBa/HAn/EUmoTUHOGryhojEwDjlrL9R
         Uen6nPmMmoLFIX4rDo2Gchm1gaYURR3k71bqDsAb4lc+4CZ/R9S7LnW6HDFuvBznZ0tw
         jk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=De6Z7XlByT/3y43y8ANqlsh9lPr7hWe/7UFt2ZwYqp4=;
        b=GzwAkgFJQRLYZnb+9D9/RBHJeELjCa2ATiGH8xOcY3HQwL0gHoSPsBQrNsi7OgpxzL
         yN1w9wcinI6JA8oL+wpxdc9CmrUZFtoEefc6Y7sOyv0WRGyCDWVvqdqfOyEwRS+EWffM
         Kh714lEjo8yCgi1pzcwsh1i+7/Ne/IDvxWSDVGpIzl9OkmthL+tmja3MF0UyTJ4Uk5p7
         nJ/zbD2TTfe7dRSGV6/Eg4CG0846YnamrGEzxwCMwKNR4ryzBh1NXK1KwJXlEzexiVKI
         hnNnyhw9b18HdIrwFwyAHao8q+lUbTpQ/IzBZECElmz1F0OqoNSK9rQWQquYjX28A8Nl
         +BzQ==
X-Gm-Message-State: APjAAAWF95uKhKNLXncLhiZcX0N9E7SlE85t4rJTSRxkNGjjKke65aRU
        tN6UQV7vglmwBAVI1xCGlp56T11CQb8=
X-Google-Smtp-Source: APXvYqywYgY1OpijhABjU9VkAhd9hds5Pl2h/firY7w1mQDLa1s7CITtTjAt+znNZtG0BnLfCiA0pw==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr13403333wmo.48.1577959373515;
        Thu, 02 Jan 2020 02:02:53 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r6sm55418683wrq.92.2020.01.02.02.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 02:02:52 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] drm/etnaviv: update hwdb selection logic
Date:   Thu,  2 Jan 2020 11:02:19 +0100
Message-Id: <20200102100230.420009-6-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102100230.420009-1-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take product id, customer id and eco id into account. If that
delivers no match try a search for model and revision.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index eb0f3eb87ced..d1744f1b44b1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -44,9 +44,26 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 	struct etnaviv_chip_identity *ident = &gpu->identity;
 	int i;
 
+	/* accurate match */
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
 		if (etnaviv_chip_identities[i].model == ident->model &&
-		    etnaviv_chip_identities[i].revision == ident->revision) {
+		    etnaviv_chip_identities[i].revision == ident->revision &&
+		    etnaviv_chip_identities[i].product_id == ident->product_id &&
+		    etnaviv_chip_identities[i].customer_id == ident->customer_id &&
+		    etnaviv_chip_identities[i].eco_id == ident->eco_id) {
+			memcpy(ident, &etnaviv_chip_identities[i],
+			       sizeof(*ident));
+			return true;
+		}
+	}
+
+	/* match based only on model and revision */
+	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
+		if (etnaviv_chip_identities[i].model == ident->model &&
+		    etnaviv_chip_identities[i].revision == ident->revision &&
+		    etnaviv_chip_identities[i].product_id == ~0U &&
+		    etnaviv_chip_identities[i].customer_id == ~0U &&
+		    etnaviv_chip_identities[i].eco_id == ~0U) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
 			return true;
-- 
2.24.1

