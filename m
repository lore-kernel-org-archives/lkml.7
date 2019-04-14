Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D1C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E28A206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5m2ulI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDNXhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:37:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35330 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfDNXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:37:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id a71so8840836qkg.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCqGPPK0U0RsupI+EaKEUzGq7H7/R4e4XV2uhzuZDaE=;
        b=u5m2ulI/woHnvkyIpMTJy6BnOqUb05W3A6tmZHgdC93haFy19buttF4U/59TMsuWar
         IRzQR3dKttQdQmDGQcuF6SKc2WQt2InXnqfw5Pf/nw4e/VDzG82fftkFEf5WdNgEH7Ow
         FElZN2GaMzMTTWJzFB0hw9O71fNcqzjyLb5Mksgm+e7dRcBeRa9NEsLyThs6d4YQw6nj
         UT89fdnZaD3FIlEDEiZSDfR7sRSU2W2DVt1WaqlWP3ju480gR+dZ9V4S75pVp5PzQjfq
         M6X1sZkQ+blt9mn+itYS+HGQYLtpQ+GoLa0ibunSv5DO47ETrFv0gg1U8DPLe/CzlU1c
         AlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCqGPPK0U0RsupI+EaKEUzGq7H7/R4e4XV2uhzuZDaE=;
        b=VE/nKS6ft4lovQc5zEr7FD68l+rDN+Oj9h78wPFd6YR+ty5LqRIcyum3Tj/xEdtdHp
         mbAB5REKvn1pyYo5y3ZPWxhUItH76/NP6LvZvgzkrB1mv5ZpDVI3rEvTsAZeNwjELHvg
         Ohj6muuWbD4f5RqQL4zQBAVIpH0H7VQeYqwjk5iRW++B25DXktloDu3tlkcnAdfKctuV
         s7Bj7zHltm+AI8z74Jx7HR0k98RTWLi8fZh2W7qtmHCqiN2ghwdV73GYcGbSdOX3E12I
         K4iMDc/XxgzgyZt3jrIxXMIa/Bxu73joPzFjhzR6BqzkrVUTqHGk4nLQt7e/UHqrjvdb
         y7Vw==
X-Gm-Message-State: APjAAAV5Ba+L8DifZ/WEqJ/gbevl4vbVFqm3WFh8ovxu2mKFnzzUDv/T
        e8O+WibH0Iheq+6Uvny/Im4=
X-Google-Smtp-Source: APXvYqwE7m23WgsRCTnUgIqvyswInRhxsUgkW71Nh8OYX9+6mUH3dz/VmKnYhqZ8Eockn7Cvloruuw==
X-Received: by 2002:a37:ad15:: with SMTP id f21mr51644675qkm.152.1555285073149;
        Sun, 14 Apr 2019 16:37:53 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id v58sm31167205qtv.66.2019.04.14.16.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 16:37:52 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH 2/3] drm/ttm: Fix ttm_mem_glob.kobj state on cleanup
Date:   Sun, 14 Apr 2019 23:37:28 +0000
Message-Id: <20190414233729.17956-3-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414233729.17956-1-itsbriany@gmail.com>
References: <20190414233729.17956-1-itsbriany@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup ttm_mem_glob.kobj when its reference count hits 0
so that it can be re-initialized by future ttm_mem_global_init calls
without dumping a stack trace.

Signed-off-by: Brian Yip <itsbriany@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
index 55ccb9800893..63d82a81912e 100644
--- a/drivers/gpu/drm/ttm/ttm_memory.c
+++ b/drivers/gpu/drm/ttm/ttm_memory.c
@@ -479,8 +479,10 @@ void ttm_mem_global_release(struct ttm_mem_global *glob)
 	kobject_del(&glob->kobj);
 	kobject_put(&glob->kobj);
 
-	if (!kref_read(&glob->kobj.kref))
+	if (!kref_read(&glob->kobj.kref)) {
+		glob->kobj.state_initialized = 0;
 		glob->num_zones = 0;
+	}
 }
 
 static void ttm_check_swapping(struct ttm_mem_global *glob)
-- 
2.20.1

