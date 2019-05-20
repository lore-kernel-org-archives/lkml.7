Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBCC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215BE2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RTZ93kzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfETIWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33564 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfETIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so22608275edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFqlt6mo9F4Pd9G7O8MT8qo6u/5jZNMJ/2yl3qsAQiY=;
        b=RTZ93kzVk9zGtnHtCaoZcwrmjSjG2Mp581U8LZiMJO9kPtk70WxR1ULXsE+s8Ev7ul
         bUysO8XL+pRY2yc7jmOEeZJBz6sHilS5rSOo0Hi+uHKPgTCJJhnmZu57MFXxVDkkyBXZ
         HRh/z9TwO6V3f8214ma3SZ0+PxgdfNq4IR6oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFqlt6mo9F4Pd9G7O8MT8qo6u/5jZNMJ/2yl3qsAQiY=;
        b=lRO8xc0jCuHAehfES2HoQbWKBgnX/KZMQW2SKBia7iuxjpdZuF8+g4aOyqqCfJoA3H
         IyvcAuMwMEKSJUYr9cjOC5JtXeMsuDQTKt0A/I2Xf2A18YrBBoQyvy8k+8qOpbPrqflf
         49GS+X1t4Xtb1iU3WSGstmYwQEXZPrC0xV5DKy0F/yyb2hRxBI0I2p53VnXHLSaBrGdz
         xv9V5sTBuNNWCKLg1+vpq4ejFKwDwkl0yPSyAFkKqqg77CF62z/tuQYcyrCsGNv9wbCH
         plUFj3gQad+ommWBrDjP2CDoM/lHytyHuykk594ADGzTiztAahnn/cR2S3bWJhkZOv5q
         Jx0w==
X-Gm-Message-State: APjAAAWYsiqKmGYP/9H+CbFfgKCDbjiRJIeJSqeaqXBw+02XU/9Wvytv
        D+uGI6sAaPePZAo5gsALCBC+Fw==
X-Google-Smtp-Source: APXvYqzMmvmbNckNLQCV3bNeFbcu8iFFcSc/sM1SOnUv0GtRrF3LCHc2XNNQ3XBMx6YgDvVqoDnpoA==
X-Received: by 2002:a17:906:a34e:: with SMTP id bz14mr37528317ejb.82.1558340558649;
        Mon, 20 May 2019 01:22:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:38 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: [PATCH 14/33] staging/olpc: lock_fb_info can't fail
Date:   Mon, 20 May 2019 10:21:57 +0200
Message-Id: <20190520082216.26273-15-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply because olpc never unregisters the damn thing. It also
registers the framebuffer directly by poking around in fbdev
core internals, so it's all around rather broken.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 6b714f740ac3..a254238be181 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -250,11 +250,7 @@ static bool dcon_blank_fb(struct dcon_priv *dcon, bool blank)
 	int err;
 
 	console_lock();
-	if (!lock_fb_info(dcon->fbinfo)) {
-		console_unlock();
-		dev_err(&dcon->client->dev, "unable to lock framebuffer\n");
-		return false;
-	}
+	lock_fb_info(dcon->fbinfo);
 
 	dcon->ignore_fb_events = true;
 	err = fb_blank(dcon->fbinfo,
-- 
2.20.1

