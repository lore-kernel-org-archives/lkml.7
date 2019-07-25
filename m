Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B845F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kji/UF2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfGYKVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:21:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40986 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGYKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:21:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so23145909pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JpFXTqBiiF/d0FWq+ji6QHY6zUynDSMtWm/er7s/Jh0=;
        b=kji/UF2eV8qHYMdbqskMt6Ux4Dd8KtsNq7korGFByiRLA//9JNBlfJnLK3kLPqni24
         LZlQcEqlULQCkSFaswVc4umI+nHSlLgVEcuANIcOLfDEL/syjIcQ/48J4Cc+UoCXEQdJ
         x8HPK7REeezOh69mIMxMAnlD/IRMr3WI/r/A0facrnc1RXNNFa6Yd/ZkNnP6WXB8+nC/
         Pslct7+Sv3kxiQBp1niRy1cJ38JMklfghh6U1RtUCYe5QexyeepJ2TCzm9lwrC7Ejv3k
         OpmTrsVFBcg1GpFxhgS2KyUgSsvTwzaGERRHQhafwNdEPm4Jgc/Yysi5PnnQnrj5/UK4
         j51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JpFXTqBiiF/d0FWq+ji6QHY6zUynDSMtWm/er7s/Jh0=;
        b=Ay8oetzjLK2NdQxMONQq+GaBz+V9Jn484lqRR1CAR38o/QRr0Db1hQcB1Xtr7oNr66
         H5AK0V1Iw6X5d6x6WWMGHy6vhOsi/HYboI1iDHV87xH9ZeFBUumD5CSjAGoltC4vf2dM
         BeBuX0WwcawkuuSxeqC7mTaWLQcz6Je7MZiH28c3iEunAx5rLtkcyPzLAO+unU227HL3
         gZ7DBtFHhx/NaJA0KQ5TNIcUpWyhPniWttDZ2QzWcbUvktIZR4HTVNM+l9qcHbaHza6j
         PVKWuY+PJQ5EP8VmfAA4QOs+HFYSx/6OsqyIi01b0rPGI+GA6tIcVKg00yqzk8gGb/6r
         /wUw==
X-Gm-Message-State: APjAAAVSwXZU59RfnXv1kSHblaWI27jJU3TbM0SyW0VWyRDprVjJwJmW
        +MBtLpa+m5HHu8VJXxGrY+k=
X-Google-Smtp-Source: APXvYqzh1lqPLfRIcHRSuzwanRKOlrhGFebC2GTMee0mYsp8VZxX5o3zpNO6UUAl4caXFvOkglFXdg==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22mr92009461pll.39.1564050097023;
        Thu, 25 Jul 2019 03:21:37 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id p27sm74548188pfq.136.2019.07.25.03.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:21:36 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: qxl: Fix possible null-pointer dereferences in qxl_crtc_atomic_flush()
Date:   Thu, 25 Jul 2019 18:21:27 +0800
Message-Id: <20190725102127.16086-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qxl_crtc_atomic_flush(), there is an if statement on line 376 to
check whether crtc->state is NULL:
    if (crtc->state && crtc->state->event)

When crtc->state is NULL and qxl_crtc_update_monitors_config() is call, 
qxl_crtc_update_monitors_config() uses crtc->state on line 326:
    if (crtc->state->active)
and on line 358:
    DRM_DEBUG_KMS(..., crtc->state->active, ...);

Thus, possible null-pointer dereferences may occur.

To fix these bugs, crtc->state is checked before calling
qxl_crtc_update_monitors_config().

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 8b319ebbb0fb..fae18ef1ba59 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -382,7 +382,8 @@ static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 	}
 
-	qxl_crtc_update_monitors_config(crtc, "flush");
+	if (crtc->state)
+		qxl_crtc_update_monitors_config(crtc, "flush");
 }
 
 static void qxl_crtc_destroy(struct drm_crtc *crtc)
-- 
2.17.0

