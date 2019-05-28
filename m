Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D52C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3262075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DIUw/kO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfE1JGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:06:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35997 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfE1JDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so30639339edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01fUYB3VzPGfcTugqgqBx5jW8iq7wLyVUX3qXdYLYSk=;
        b=DIUw/kO/LXyngvpKwzC2ewKvPzp/6OUUrTW3jHZNYZjGOyfUOx9k0Ymf2PWGe0uTX1
         aFGbqCs0JBCbXRctZ3Clc9hEOdMbgD2j3dVb6uM642xcQ+8j4uPyEreOpxw8GzNrxnV1
         fOlYw4DwyEZcV634rmGq6J/k76ZdCQuxlqhWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01fUYB3VzPGfcTugqgqBx5jW8iq7wLyVUX3qXdYLYSk=;
        b=D7U+DwqML9tFImDP3+cQ0kDR0sQaIhk+r7vxVzuMgjeLcdlBHB/qFnrFNn4RSOg0aX
         AsUKkIrnOQtPzvr5X0m7dhpWvmlzJ823KLsF+qS3zaaN7if0491pIvx1E/bjdMLYR9n4
         m0RJfuLcRcaAgbw1ywLBdrN1UlqYndU0TIeJqp8BVnEb2LKS+6f4VvbLtTIwYAJ1/MKr
         vYiTKm3HAca6VlAIjhG6cRXfAvA5tc7n60RifZJj78D7iPkrtAh+M9FXs5EVqv9m8TSC
         LVqqy92udcbWzldH45uZQfTK/NyjwTkAVooQP9gK3JKGeoIOavJd1J2SIrjEZbqyRDU4
         t6WQ==
X-Gm-Message-State: APjAAAUfXqsOOuCXTWHtFj+csGvMZ/bzvRLa9YRlcUi7hYwAaikKHVGV
        HxWOrWlVvX7Whl0yqUJhplO4Tx/r8Hc=
X-Google-Smtp-Source: APXvYqz0EMzb0SG65WaaBqt1bSsx+8cxym9XyhE58ExT9b6/OKWIr27r6jDPAQ9wP/aEEzvPm7cAVg==
X-Received: by 2002:a50:8903:: with SMTP id e3mr126039162ede.11.1559034213606;
        Tue, 28 May 2019 02:03:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:32 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>
Subject: [PATCH 15/33] fbdev/atyfb: lock_fb_info can't fail
Date:   Tue, 28 May 2019 11:02:46 +0200
Message-Id: <20190528090304.9388-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's properly protected by reboot_lock.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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

