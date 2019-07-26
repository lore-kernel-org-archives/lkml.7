Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC289C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17F216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyWwp9fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfGZL2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:28:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40550 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfGZL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so36866130lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9BcHX1v0OYZtD+fOK5bR3iP5Bzz548SH0Qfuyk3u+M=;
        b=cyWwp9fJP19UoMGz9ozXhDRzbbe71Ox1BNxqfqJHcs+M2C7zqmX99TGYs/etpPyptI
         ky7wdp9/Qddn/czFwkgjlUz1gwSELt2+LGXRhe+pdvLqYxXC06fCbOldfaPm6hpWdP77
         ZZQku0IkEG2Z/1DNOXZS4wpuT6hHQsHDRgIzWccW28SZ+XVK+9njzTCM+3vv/tkswX1e
         Ci/jzIwZt6kclF/FxcjlYH6SYv59ApVqKvlTl1ILvaCM6qYPtUgZIpIAc2zMrVSOhJrZ
         R4s8hnHgjUZNMD2NT8+TCnx6u58Uzm/QdaSw1OHjF+PURt8z76b7If9U0mXHxFsxAzQe
         mP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9BcHX1v0OYZtD+fOK5bR3iP5Bzz548SH0Qfuyk3u+M=;
        b=LicAtoHQroOjwSH3SXP0QWXbxhT7ISSagk9FjLqq2Sa5WMlaNoV6Ml+IecHPGSEDEL
         LgfJlTDhIDJ6acEfR0RqvVrVMB0Sb0pQYzSTXG4QAmdqR7Wp/dnmiGXjf2azKmWWdtog
         S0mFLRMbeaAxAxHxqSIGsKgT+MJLBIHEaDiRYhv5gPL2TecgcfBPun7/5NylIdxExZSO
         /xr2y7VdH13O7L/M3QR5MJbkOQWWe4BWq/cPqjQo5Ad749oDXscN7p8eWYEFgzm7aL/q
         FHTMJkJWAq7Y0tdF5IRntZC0uyTSYSG5zrVd+vUf0s9944PxrufN/Z3w67UjPlMmwvtJ
         JQwg==
X-Gm-Message-State: APjAAAUrsF0oKaLQKgf4nz9NhzCfRxU/5OaxHANBaurMPKk86CxvRVwb
        pEdGWfEgO7FDjZfg+F5XlBb7ygzyPLK8SA==
X-Google-Smtp-Source: APXvYqxB8OuCSnAveM3yLRJ0PfblnXOWtOWvNxXLe9Ac4zMOsHOMqT4GraqxuwItrMX1jGyDWSK9Hw==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr44970761lfh.15.1564140491963;
        Fri, 26 Jul 2019 04:28:11 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id k124sm8319427lfd.60.2019.07.26.04.28.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:11 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch, wens@csie.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] drm: sun4i: tcon: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:07 +0200
Message-Id: <20190726112807.19615-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warning
was starting to show up:

../drivers/gpu/drm/sun4i/sun4i_tcon.c: In function ‘sun4i_tcon0_mode_set_dithering’:
../drivers/gpu/drm/sun4i/sun4i_tcon.c:316:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   val |= SUN4I_TCON0_FRM_CTL_MODE_B;
../drivers/gpu/drm/sun4i/sun4i_tcon.c:317:2: note: here
  case MEDIA_BUS_FMT_RGB666_1X18:
  ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 690aeb822704..04c721d0d3b9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -316,6 +316,7 @@ static void sun4i_tcon0_mode_set_dithering(struct sun4i_tcon *tcon,
 		/* R and B components are only 5 bits deep */
 		val |= SUN4I_TCON0_FRM_CTL_MODE_R;
 		val |= SUN4I_TCON0_FRM_CTL_MODE_B;
+		/* Fall through */
 	case MEDIA_BUS_FMT_RGB666_1X18:
 	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
 		/* Fall through: enable dithering */
-- 
2.20.1

