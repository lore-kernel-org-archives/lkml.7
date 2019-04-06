Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779AC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E2B21019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L140M9Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDFXJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:09:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFXJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:09:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so5054765pgk.12;
        Sat, 06 Apr 2019 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZxOPx40sM31sXATrJWIrdV0RTZA1DlPQH1xR20a6EI=;
        b=L140M9NwbWyz6AhYHSMJDKQiieDEmJyG2w8gK/BOeZFmFKmbl2voNn0xThg47HhnGJ
         nKBTe5unSIlxzduxUqtUuWlXURSR51JWlPFVZhOa7ahGx+DwZQPH34kzIavY0Uaopwbh
         n7R0cFo6BlpEgmvNG45jriJW+E3hFk4ykjt/jUobgqUl1B8w3oYna52QNnSeSF+vEh0c
         4MUDjVufjo9qHGY/oMtinl2cidvynzDfq0NzfWKz3Yqddm+9t5TyW0UPuJkXPUQTQmib
         UnuPDSUVV+cgD37yigzKNJtyfeRuAJZk2o+DEgfbLXlQHlwrW9135R0lrz47FLMhS5cn
         7dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZxOPx40sM31sXATrJWIrdV0RTZA1DlPQH1xR20a6EI=;
        b=Lt722asD2QZafqNNaiMy8oEWD9bVemFVvPNoVntYd23g2+MiTFoDQvleHMXPfeUM18
         B0gS3YlTllqcVs1yKVKShS+SZd5ODB+ZJ2xflsSqne8gBA1smtRGwAi8U7n9zDpLmtuB
         nBGh1hdcuLIsJsqaWDwxzBvEqYkLR1tmdfIBf2dj6ff8oPIIxhk+hsFG5lN9VP+S5DKC
         cUoH5XZ20/7ACW6t7wa3iBk95VbHqIcBsO3Eh4CBzSH2jGfAQJsz44rB3W0Afl/kludA
         8O0d9z+UlyImy6lWRhL8h9gRobxHp1ZMrN98yv2jo8hRmqdyt7YMPCIN0gZcC6o58g8e
         wPBg==
X-Gm-Message-State: APjAAAUw59HGpwI/KJ5Is+0LwiUQy7teeXf5xwCJ1hT34tHPQ+sRymgA
        eO8WgDWDPJ45GotItqzPvVcFbGaq
X-Google-Smtp-Source: APXvYqzZQtLjLKEkOW25mrG0uokCAfSeQE3/W3jrtSjSbSkD5F6vf/Kl2IWaOQEnkXsQFYjWc1avaw==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr21031709pfa.134.1554592152216;
        Sat, 06 Apr 2019 16:09:12 -0700 (PDT)
Received: from mappy.sklembedded.com (c-24-4-228-186.hsd1.ca.comcast.net. [24.4.228.186])
        by smtp.gmail.com with ESMTPSA id i31sm44550127pgi.36.2019.04.06.16.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 16:09:11 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>, stable@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 1/5] gpu: ipu-v3: ipu-ic: Fix saturation bit offset in TPMEM
Date:   Sat,  6 Apr 2019 16:08:59 -0700
Message-Id: <20190406230903.16488-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406230903.16488-1-slongerbeam@gmail.com>
References: <20190406230903.16488-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The saturation bit was being set at bit 9 in the second 32-bit word
of the TPMEM CSC. This isn't correct, the saturation bit is bit 42,
which is bit 10 of the second word.

Fixes: 1aa8ea0d2bd5d ("gpu: ipu-v3: Add Image Converter unit")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/gpu/ipu-v3/ipu-ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
index 594c3cbc8291..18816ccf600e 100644
--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -257,7 +257,7 @@ static int init_csc(struct ipu_ic *ic,
 	writel(param, base++);
 
 	param = ((a[0] & 0x1fe0) >> 5) | (params->scale << 8) |
-		(params->sat << 9);
+		(params->sat << 10);
 	writel(param, base++);
 
 	param = ((a[1] & 0x1f) << 27) | ((c[0][1] & 0x1ff) << 18) |
-- 
2.17.1

