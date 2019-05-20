Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D761C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EC721537
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="k225G4By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfETIX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:23:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40880 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfETIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so22535203eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brzEwqzIIXnydSs/RGKR5pFbo4J3hD4vcbto6AdqxGk=;
        b=k225G4BySl1X7q+UlZP4Nituk6duwxPLxugM6XbySvaJv68rXCwZLb3vHIHnpUiVtt
         RMs142ozoZpwli8WRmc7BaQJrVmTQEAYyzOd8QwAVlCuFVjST21Uh742TKY/EU7jI4tn
         FvVS9T4MOsKO5Bio5SHMWrXZSZUxfL3BAeT14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brzEwqzIIXnydSs/RGKR5pFbo4J3hD4vcbto6AdqxGk=;
        b=YeZ/8S1Jyk9QcRkhMshW03+p2Bp4ZCs8SY5GCHpP+0IQPbrBfUKiJD19UxwLHe3QPu
         Cqb5y/pZp+1P6TOULPn42WLZqtLYAGKS9n8KEBl/NGyTklEAsZ/6oo/0KDRfKMpVxdAr
         r3OQjbuTEI8seGcoJ4PHa3WZvAlI0cvvBdOPQVMWyvHi4zAnGf/k+nNMgh2qoLTSI/1B
         1bfyL0SahfOdPFSH0evt62IqiFut5D3RpwyYvCWLAYcQu3Z5dKMkuKscf1VRkDOWKTR+
         vj2g9l6gVoLJ0uMc2xro7q8sW5N2gYjyeiE/auodhhrVDS5wjVBCBxxtxsyWKzVeJ4cB
         hNBg==
X-Gm-Message-State: APjAAAXoHyw9Yqe22LwzVSjQPOh2dYsDlScfAVjSSGznrbQYk3ezO7Sw
        nmGPVNLyT1lrs01L3KZ1RQrI7A==
X-Google-Smtp-Source: APXvYqwcYQ/FNu9mKgR5y78+1RNm9YWWN/rbv1Dyk1fxTiJfn1IMT8JiRGTvl3E3oG9ZgSkImRa3bQ==
X-Received: by 2002:a17:906:4911:: with SMTP id b17mr50845503ejq.3.1558340560091;
        Mon, 20 May 2019 01:22:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:39 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 15/33] fbdev/atyfb: lock_fb_info can't fail
Date:   Mon, 20 May 2019 10:21:58 +0200
Message-Id: <20190520082216.26273-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
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

