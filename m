Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027CDC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC22208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QXPL+94F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392886AbfETRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:24:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40957 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392873AbfETRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:24:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so145118wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37CxHYKlFVVAIEnj21tdjvUOrJCuiyhrkjA75AgmUDE=;
        b=QXPL+94F09z4z+ao64JQeUt9XFjjtv8g/N09kNE3fTGLUbp/qYLl1g57/r3St9bLbM
         8ytkzOh0Wuy8BN9SlXxU9XZyfWLOan/bGagJczwA0VwsDnRdfZC+BvBUhMUoa7OVVnGu
         Xm4cRqIxYjsIiLDMFpj6u8/02xysp+dxL6e8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37CxHYKlFVVAIEnj21tdjvUOrJCuiyhrkjA75AgmUDE=;
        b=mOGwZ/J6Z4PW41m3xBfJkvsdrfK2NN0EZpE/w/BwYDG6a+NuLnUR5SX5AJ7Ek3ugmk
         7zGafD0YcCXsPJy/yk/gtrVrOdpFRHtPu4IQfvGaYH6SiLJ+g75JxgMEkEjZA313JvPC
         LZGl6P506S1ARfyddyt8i20ITamux5ZJwvxQsbgKGOPI41u+j5HGjm3O0y3dfbQGwEtQ
         zbzezbxmVSJlbBQQwY4Uew4a4hPhMMibHzj5N3Ttyq74Xjc3ASr7tFituEDK1dyj4TJM
         Lb+CHHX+yPpleUa+mtqjjd5yL42YpmYPs/M2D4OS2hqy+dxGBdN9/5IpWodJ0+tHV6+d
         MzBA==
X-Gm-Message-State: APjAAAWRbfEazQtm6Gt/DYKfuvg2enZAknmiqF/T+H4iiTt4koeaw5Sj
        /ensJZkj/mFZAa0TMNoFcZEYmSHl3HrnpQ==
X-Google-Smtp-Source: APXvYqxV/0ooJTzXznpbzssyf0Zwt44GQp/pzzVYbD8W+Rh1jTkMM3EzUOJLQxOAZDv/ikTEgktB8w==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr146017wme.121.1558373075294;
        Mon, 20 May 2019 10:24:35 -0700 (PDT)
Received: from localhost.localdomain ([91.253.179.221])
        by smtp.gmail.com with ESMTPSA id b12sm180021wmg.27.2019.05.20.10.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 10:24:34 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/4] drm/msm: Fix improper uses of smp_mb__{before,after}_atomic()
Date:   Mon, 20 May 2019 19:23:55 +0200
Message-Id: <1558373038-5611-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These barriers only apply to the read-modify-write operations; in
particular, they do not apply to the atomic_set() primitive.

Replace the barriers with smp_mb()s.

Fixes: b1fc2839d2f92 ("drm/msm: Implement preemption for A5XX targets")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 3d62310a535fb..ee0820ee0c664 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -39,10 +39,10 @@ static inline void set_preempt_state(struct a5xx_gpu *gpu,
 	 * preemption or in the interrupt handler so barriers are needed
 	 * before...
 	 */
-	smp_mb__before_atomic();
+	smp_mb();
 	atomic_set(&gpu->preempt_state, new);
 	/* ... and after*/
-	smp_mb__after_atomic();
+	smp_mb();
 }
 
 /* Write the most recent wptr for the given ring into the hardware */
-- 
2.7.4

