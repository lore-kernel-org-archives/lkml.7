Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9786423405
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnZ5tugQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfHaRZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 13:25:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37048 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfHaRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 13:25:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so5140322pgp.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W+lYISWLd+dLXJ92WanX0SAmm2/oFeQWs1BfMT2py3w=;
        b=EnZ5tugQP34UeJgn4IKjljMkw6g/r2XQhYWuLXTTBrbhaKStb+RM0UVzzufhpp1qLv
         Ff8Ywjqj3au5uIP4uAbejFYh1DshxGMprh90esrq87mkg/MlR5mfIHwPLT1vOCXMZrYq
         u26RhYDgu8LqLRf6DrYGSGHXLgs6jjGIv3AGIrWuoQ3tMsU+WG4WFTtG7dudJQVTJxRb
         KXhMt6ktrAEKhhMHN/L3muV7uzKb83a/VxYfVsNltHbsPc0EKYfGdu962XXPRbJEjcOe
         x6loROZolOFlkaCR9Kapw0tT+ePPv4b1WsQ88b1gzFjlqvR9pJtoegxkY3AdX5OPoWrZ
         4vyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W+lYISWLd+dLXJ92WanX0SAmm2/oFeQWs1BfMT2py3w=;
        b=Bcg0J4pZY+ORK7pMYe2Zhm6X7zFW1mfbe/tbPkHUUhGIG+2keje5vPD59pSkMuGX0C
         4816uBTnqSjsqU4bzUpmD6ddYs6pwBxdmda6Jukf9d135mPMntl0Bj5s5Ss1zOt3Fe3a
         BDk7qZvJk5WJih4OTYR723EhsfCOUUyFcjUezDO/rmxbNoT4mz0C/3uRBK6HY5GNi5Ao
         I/FXxaswLDLafgKqtOzsB4Q1iR1etCqN3KkREwiFpTaK2m0Q7G1GR8BVpI/gNRzbmmUy
         UoFKNXCIOgIBNA4H2CmbA4cxNLjGw3dvWFnClR1rnM7JwL23dXSEbhsVXdBuNAgnr1eA
         RlUw==
X-Gm-Message-State: APjAAAWtbUKEEsmCjZtQsXjTIQSB9wqDPPrhCL6JhRBA9Sq4hs+PhlZ+
        NvDqLc/J4xBQCO2tWo6rQ8Y=
X-Google-Smtp-Source: APXvYqxdoO9pFlTeP02tVUV36XLk12Ox0QdQ2UHgL0ppo691dkIMsMrSYKu0tKtaDl5y02Jj5/kgUg==
X-Received: by 2002:a17:90a:de0f:: with SMTP id m15mr4855206pjv.18.1567272355239;
        Sat, 31 Aug 2019 10:25:55 -0700 (PDT)
Received: from raspberrypi ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id v8sm6151231pje.6.2019.08.31.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 10:25:54 -0700 (PDT)
Date:   Sat, 31 Aug 2019 18:25:46 +0100
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20190831172546.GA1972@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use alpha value to blend source value and destination value Instead of
just overwrite with source value.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index d5585695c64d..b776185e5cb5 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -75,6 +75,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 	int y_limit = y_src + h_dst;
 	int x_limit = x_src + w_dst;
 
+	u8 *src, *dst;
+	u32 alpha, inv_alpha;
+
 	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
 		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
 			offset_dst = dest_composer->offset
@@ -84,8 +87,14 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 				     + (i * src_composer->pitch)
 				     + (j * src_composer->cpp);
 
-			memcpy(vaddr_dst + offset_dst,
-			       vaddr_src + offset_src, sizeof(u32));
+			src = vaddr_src + offset_src;
+			dst = vaddr_dst + offset_dst;
+			alpha = src[3] + 1;
+			inv_alpha = 256 - src[3];
+			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
+			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
+			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
+			dst[3] = 0xff;
 		}
 		i_dst++;
 	}
-- 
2.20.1

