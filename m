Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04971C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3371214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abELyR7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405649AbfIYEqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:46:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36183 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbfIYEqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:46:40 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so10279823iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L0m69X+LQ4frLVby8EeJS1EQVq3OI3wT8S733h98iBY=;
        b=abELyR7FeIlVGJPkjZn9UpCopVU8AQ5F05bm6IeSz1xSMYAXnSpiotzDBDceHJQPEW
         ULcSyUQ7JjYrkFgsySjVXZcGtRWhTZi1aSQ9Lv+TYLvHvFI5wZrevpNyDbWkWtBZDBDq
         kKcg9WddnobR24uaUfYlf3VjfzCiE4OcUYEocPl20BWzTkNFGZYQ6fYcBVFpQTFK3gdi
         e1hH8VDbBkG6fXLNpGPTfgwpU35GBB+OHcEHKjhFe9nS5cYteJLubBJIl7ucnW0mji5y
         xUoDIRLmcuvwceWv2iZx3Afo9OD9T70H7d5GQ0mU0Hq2LhZnprpFf3nkzU1rEFzB3jQy
         cpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L0m69X+LQ4frLVby8EeJS1EQVq3OI3wT8S733h98iBY=;
        b=Ub6jxkOM0GtraQ3EfT9I1PtywLslJV2PbnXKsXzyHlIh4Y9GcdLD69zoQyeD4m82P8
         hXwu3mbSE4LxqAT+xMMXjtwPTmbinzRzXYoO3Dhi4v+WVPx6Zsyuuya6RSeIDAn6cl/8
         2y19eOIYIiNqEZDn50NbLkvGnb4H37nW8pwqqsUSlnN1T282RXXIwypHyeTEH6R8fVxw
         amf/+FpbsVMoQfqTlaI/uADoLHruFehXzqkVZhJk1bEe86lUq43u3/wSM51HoVOh6HBt
         GGU3G315q6jnebhoK27fu8C9AIA7HpPcfmeQPGDMp+KMwalO/xgiNYJOGiJqPOsfSzv3
         JPRw==
X-Gm-Message-State: APjAAAUK9N9fnv4gKBay7bIYHm/UA2aMB/aqFH8o7o3R8wWJKHqYMPDb
        W0TA1OmwNB627QVRHUFYTHc=
X-Google-Smtp-Source: APXvYqyKT3ovdvw1fI5/3vLGvl5AkjEDbTc6sYb0NhOsx0Hd+zOXARsy+Js8tagkLvrb+17Hr4LvtA==
X-Received: by 2002:a6b:210:: with SMTP id 16mr8335610ioc.104.1569386799583;
        Tue, 24 Sep 2019 21:46:39 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t4sm42107iln.82.2019.09.24.21.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 21:46:39 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: prevent memory leak in vmw_context_define
Date:   Tue, 24 Sep 2019 23:46:26 -0500
Message-Id: <20190925044627.2476-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vmw_context_define if vmw_context_init fails the allocated resource
should be unreferenced. The goto label was fixed.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
index a56c9d802382..ac42f8a6acf0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
@@ -773,7 +773,7 @@ static int vmw_context_define(struct drm_device *dev, void *data,
 
 	ret = vmw_context_init(dev_priv, res, vmw_user_context_free, dx);
 	if (unlikely(ret != 0))
-		goto out_unlock;
+		goto out_err;
 
 	tmp = vmw_resource_reference(&ctx->res);
 	ret = ttm_base_object_init(tfile, &ctx->base, false, VMW_RES_CONTEXT,
-- 
2.17.1

