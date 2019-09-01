Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C98C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F142190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 08:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDP406rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfIAI4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 04:56:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32775 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfIAI4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 04:56:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so2093162pfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W+lYISWLd+dLXJ92WanX0SAmm2/oFeQWs1BfMT2py3w=;
        b=oDP406rRTaIX39SIvUpLS8n0W8bK0owcW8hoEKLZcbg/OVy/p5EpAq1CqHu8KDmO6B
         aQmESyGa4lhvcBPvzUEHJ17ay/eelPd73K5hmprOsZhcqrtcLeh3/G8Bvge4Jl8n+Y8G
         1obxUDHjBNa3S+Sp5HmfQGhxq+z7x9VFcGbZorCIhWxezN81617sNaK/4E3cD4fNwPEw
         3T5kfPxqgQnP5cfBt75vBXbe5FSmxCEYVtiFRYn7CctZ8V2PhR4hFmOAjCkke0pZIxih
         d2JLv2xFNxPZAbPyfkhx1gtJHjrMDcpCSXPZJiEhPUR3jMaH9Ca+B+GpHz9OGt9JXuph
         vtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W+lYISWLd+dLXJ92WanX0SAmm2/oFeQWs1BfMT2py3w=;
        b=bKCZg6GB73p9Nr0Em6yOJKfEUEh1mX2xnSr+Bgg8KQ2pu63IRkigkQfU1zUOhJNMMf
         dZtARGTQNnFEPxOxKJusVCvnlwFQ9y9VM8ULmlC1fo1tFVi/lFGFad5htgKAzO1o7XFx
         zg/QSubtc01LNirP0u5+/69/b+OwmGOZD7B0nPeiRxnenJQLuVAYiI/f3oWwYB/nd6nJ
         oTS1bEP4hT86XRA6Bnp6SsxQytEzRg/heFZ764UUCSQLH4/tVd3BwSgnSGH5sr2AdqnZ
         7tu2YcWfWn/aa5jrxFgZ489hp9mbQgcCF0pWf88ctkXXs7yiyqOoynokyqagUTH6kr54
         n4ow==
X-Gm-Message-State: APjAAAWYGCYbyVjmFwl5jVqPVQRgxm59PIDGBoo/+CboelvrZLUWMoSE
        I3aLoKnJmcSpJulWK05IzLNid2kjeyE=
X-Google-Smtp-Source: APXvYqy8daAkWI0h/2UCCRkS0vvaIRVjrZj/5mthq1euwOPfZ7ZhxdNHprlrtZwigNBFdz55q8iTkA==
X-Received: by 2002:a65:4106:: with SMTP id w6mr19893392pgp.175.1567328209482;
        Sun, 01 Sep 2019 01:56:49 -0700 (PDT)
Received: from raspberrypi ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id c12sm16779697pfc.22.2019.09.01.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 01:56:48 -0700 (PDT)
Date:   Sun, 1 Sep 2019 09:56:39 +0100
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20190901085639.GA20694@raspberrypi>
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

