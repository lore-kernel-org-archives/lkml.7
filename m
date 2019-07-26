Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE266C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2948216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+2C7W+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGZL2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:28:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46786 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfGZL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so32570268lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBXqC7DkQwKqkOuJceKqqWGtbn5TCwbm7RbUyvhZTFE=;
        b=S+2C7W+37ohe6bGgtuXYTdXJGM8T5ohSQlHPAzmsrvk398LEdPoWhPV/m/nzghQI5v
         W/ynOWka+ROdXjq3wZx0SU5bXSkI8xsvR7m9JeSogoFZ9okwuGEnqPEjlGjROjHjGIva
         mB1VipwLDzpthrV0Oe/nYMqcKcnKgfaK0ocaFXs9wuRQrGEiGE8p5MAwmLKboL370EQ/
         7HsqDSPXh0uLWTzNzKXAhZdPAy50RxUyeN8iSN7WJUVHNXAAbGEFRYbwtye13r4H0RN6
         d1O6oWzPXvPJVyEhSHBHvBtoWervTtRey3wpMXYA9PJrRYUAwaiQ/LmzqdeBN4YwXTPw
         dL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBXqC7DkQwKqkOuJceKqqWGtbn5TCwbm7RbUyvhZTFE=;
        b=VIQCyeJej6PkwI9x2jiPm50f00fUm9yCGaCuoJOWuRaVrsuE5CUhoJhaJXXTv1ukP2
         J6vVJ2sSFSBYIyQ4Csgvf1kNWE6vyY3anSvbjnSBhoIUC1xfUUyBXia1z8Yh1fZhsw57
         XpIW2mIDB8ixu5tAi/EZMXgW7HGdkGe48C6GHBGgLb+38IWx+mXNdT1R+vtZHqDG2jfI
         fCcNUVU2idPI8f2KrosE/Sln6oX1XnzrnX3Pi/Ea+NHyplOOJbPtMSqA3AizjQnWqJbW
         nktvOyFFDMO2HoYZMNK4+U1t2dz6PVSKKheid53A3wGy8Pt0m/WCCNPcQfxUPOS9W7aP
         45SA==
X-Gm-Message-State: APjAAAXZzr7WXvf9wXWoNnAv3HYQmYveg+CyzDWGah5Ts9oBXXKp2qZB
        HyqRbLgOJZxVKcukK2gVHq1zmaEtbBRVKQ==
X-Google-Smtp-Source: APXvYqylnBrvToUHEFBagkx2prc/Tv4T9RQ3PARODD6GUeEx7QMqJ1gF8b+lZNvDISocpsu3GK6MPA==
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr45521185lfg.62.1564140487096;
        Fri, 26 Jul 2019 04:28:07 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id z25sm8306560lfi.51.2019.07.26.04.28.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:06 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch, wens@csie.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] drm: sun4i: sun6i_mipi_dsi: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:02 +0200
Message-Id: <20190726112802.19563-1-anders.roxell@linaro.org>
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

../drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: In function
‘sun6i_dsi_transfer’:../drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:992:6: warning:
 this statement may fall through [-Wimplicit-fallthrough=]
   if (msg->rx_len == 1) {
      ^
../drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:997:2: note: here
  default:
  ^~~~~~~

Rework so that the compiler doesn't warn about fall-through. Change
the if-statement so that we can move out 'break;' one level.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 472f73985deb..40ed21e527f9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -992,8 +992,10 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	case MIPI_DSI_DCS_READ:
 		if (msg->rx_len == 1) {
 			ret = sun6i_dsi_dcs_read(dsi, msg);
-			break;
+		} else {
+			ret = -EINVAL;
 		}
+		break;
 
 	default:
 		ret = -EINVAL;
-- 
2.20.1

