Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63800C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8F22175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Xeo0NgYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390085AbfEXIy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39285 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390001AbfEXIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so13342641edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brzEwqzIIXnydSs/RGKR5pFbo4J3hD4vcbto6AdqxGk=;
        b=Xeo0NgYq2zY1qZPEankOx3NnBKnR25IXVXKxHkt4Y0761hcMWTCBOBv7E29ft9gKMK
         UuKrb+d5LMYjosukYAmOB+0jLjO/Y+J6bSeJt3HuAbXJzhngH6TYBnlErxYlaaJpzn03
         9plmnzfTUhDWJle88EbXJyyIodmCNhuCQStxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brzEwqzIIXnydSs/RGKR5pFbo4J3hD4vcbto6AdqxGk=;
        b=CjOTLla4yTHIG37c0lIGcOXQCkkF9cG2sTLWpfTeecAeKdRwe8LEhHxHuQePgCDEHs
         5OzPVXo2xYHD3Q9TM7ufXf1O06w2bc6WLBW0gwLgXyI9iaPrdYbTUpBf+plJHEsmdqa0
         c7JgtR0djUcphOaNQwD3DVfwOUUCcClQWK3vFuyrBgvUNN+IdFQtVpCR0ccjpTqihN/e
         rLVXMV814eHyeieSZ3L71U3KLS6bPDdhZ0AM9ZzcG96QpPwLEyv6MjdkEt3J35ZeGSfs
         CaA7Xcfy5HLO5Vo43ji3ND78mp+FjJZsBjyLVCRCtDSw+K6Baea3/XID90aYsik1bkdK
         QJIw==
X-Gm-Message-State: APjAAAXH1+fGmZuQrfc0qjIKLqtK/foKnCJSvU7KMjG9rL6kS1M40nuf
        5g3QC/i3OveE368/kj1+jA9+4YJ83VM=
X-Google-Smtp-Source: APXvYqyWxvUGXtbZ3ghrLc8v+hKyKnYCdQVb8oPo8l7h4OBwvxyDc3SSjNPuRkrd519zrYDMbCVOGA==
X-Received: by 2002:a50:9858:: with SMTP id h24mr55620849edb.147.1558688061759;
        Fri, 24 May 2019 01:54:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:21 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 15/33] fbdev/atyfb: lock_fb_info can't fail
Date:   Fri, 24 May 2019 10:53:36 +0200
Message-Id: <20190524085354.27411-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's properly protected by reboot_lock.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Ville Syrjälä" <syrjala@sci.fi>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/aty/atyfb_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index b6fe103df145..eebb62d82a23 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3916,8 +3916,7 @@ static int atyfb_reboot_notify(struct notifier_block *nb,
 	if (!reboot_info)
 		goto out;
 
-	if (!lock_fb_info(reboot_info))
-		goto out;
+	lock_fb_info(reboot_info);
 
 	par = reboot_info->par;
 
-- 
2.20.1

