Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87B821D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilh8wyes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439176AbfJYJtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:49:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439160AbfJYJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:49:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so1561493wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uzPaMEUG7uzlUaWgLj84V/5JtUR6Pevk4lkhYdYRgg=;
        b=ilh8wyesMchbb9NRybDxrhIKd3t7KS4WEAJhQEvgBO70lPCJrL27bNYUejtd4AHFcy
         zRmXLq0PTnXnDjGkDJPwpa6xjTnzjkZE0qIca5JafDVC+rIH9RIyWTpBfKCJcYoESMwH
         6gFUrZnM2qJOlP+0GEZhMqBbV3iOjps4qSSvo2021RJdetxIEAswV6b8Yq/gSe0C6Xxz
         RuEVk9u9J9MqHgMwjVXe/C6h3kWNjaWX13/NlNjtCEELK9m4leLkBoaPdZOyBHB5X244
         61HwCnc3i76BlYzO8u+GDW6N1N3o0/SYF6p4ogJ0FDwCDCqUvAzJ4cEA4xPI2enFnPAK
         wjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uzPaMEUG7uzlUaWgLj84V/5JtUR6Pevk4lkhYdYRgg=;
        b=h2scK1PtG/Mc79FyAFZ43fyRn89Dnd9tbpb3r0GFqokWVFS2smklwEJPJC2Y4XKSpk
         MGiRtdIUXDtgT9UCkso47wBuzvJbRetct+7WjlVp64s34zS4e6uMiOVNQbVBUjVIiul0
         QvUinqyAxFNkCOTLvvetqDk2Wsv0tYDm7+BbzVtSd2iR2ospuVW/ZI2CRcQ/6fIBJqeI
         jH/X3r20nads7K6VIppQHvtCeyS6n3TuS9bGv8pXuvWHSKwnLAeNlKVTIpNPeUVyIUox
         tP5An6gIdgU6Lf9c64Gv87cNzfKcCuyCX6AFPaQJmk/l8S8g6jORmmcNecMre7GxvsF9
         bXFw==
X-Gm-Message-State: APjAAAW4cZuIaxDWtcb9U7x9T2MyhZHIvRyhTJS4jd2T5PxNghi2UZvq
        s7tL8MtmgIDkpDfSg4R4j0c=
X-Google-Smtp-Source: APXvYqxXxmjr5OAjFpkJ3ppbV54p68g3ca6vAeJMxmyG/pnqg27NNe1nvr9M2G2LEvpAPGX2NQSKLQ==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr2109312wrr.207.1571996952978;
        Fri, 25 Oct 2019 02:49:12 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id q14sm2130403wre.27.2019.10.25.02.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:49:12 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy][PATCH] drm: use DIV_ROUND_UP helper macro for calculations
Date:   Fri, 25 Oct 2019 12:49:07 +0300
Message-Id: <20191025094907.3582-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded divisor calculations with the DIV_ROUND_UP kernel
macro for better readability.
Issue found using coccinelle:
@@
expression n,d;
@@
(
- ((n + d - 1) / d)
+ DIV_ROUND_UP(n,d)
|
- ((n + (d - 1)) / d)
+ DIV_ROUND_UP(n,d)
)

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_agpsupport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
index 6e09f27fd9d6..4c7ad46fdd21 100644
--- a/drivers/gpu/drm/drm_agpsupport.c
+++ b/drivers/gpu/drm/drm_agpsupport.c
@@ -212,7 +212,7 @@ int drm_agp_alloc(struct drm_device *dev, struct drm_agp_buffer *request)
 	if (!entry)
 		return -ENOMEM;
 
-	pages = (request->size + PAGE_SIZE - 1) / PAGE_SIZE;
+	pages = DIV_ROUND_UP(request->size, PAGE_SIZE);
 	type = (u32) request->type;
 	memory = agp_allocate_memory(dev->agp->bridge, pages, type);
 	if (!memory) {
@@ -325,7 +325,7 @@ int drm_agp_bind(struct drm_device *dev, struct drm_agp_binding *request)
 	entry = drm_agp_lookup_entry(dev, request->handle);
 	if (!entry || entry->bound)
 		return -EINVAL;
-	page = (request->offset + PAGE_SIZE - 1) / PAGE_SIZE;
+	page = DIV_ROUND_UP(request->offset, PAGE_SIZE);
 	retcode = drm_bind_agp(entry->memory, page);
 	if (retcode)
 		return retcode;
-- 
2.23.0

