Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59008C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A20206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F92JhV41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfC0QMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:12:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40262 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfC0QMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:12:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so9935434pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jkZ2hr27HPMhS9m1VJNrg0kukcfh5YaVg9wVSXAsMPg=;
        b=F92JhV41FO7etqxGJ+p1TOFdjzMvn1yeJYSAfvfxD+tvO1KLYxG/p/uSy19nARkpMl
         jZfH3w+sMD34FGXm+p62SAXESAW3817vaAPe6pZ0Z1hgTwDF/kSKwJx2rHddR9sc8Owa
         FJV+XcpwoklnbfwDm+oZtsh8zoUUZuAdDY3XB7wArJG5TGtXVHpfx/kSbZblH7Ky9jj5
         rNA0UKsPwFjkOm//ozr3Wvp28Wfn2Wqt/wUhn60Jspap3QLjc92nOva/9tjli5cJ2hPh
         tW2b2ADEaCMw8jzbkeOeUyBt619Bk+iGbJuXQbhUjpV9rZFn9q1p/Q55jjZL0J6hdmwA
         s/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jkZ2hr27HPMhS9m1VJNrg0kukcfh5YaVg9wVSXAsMPg=;
        b=WwS9RqzXYGXDd4W+tsZZNQECKIvsCA6RdsXNOXOljuZhvNjKLTnj10jUw/gbEctFCk
         2xcISH4k+SVXVYXvlXQ8J7c7bz+VscFktKx2uEqj/qO5+iLDN9jg3UZ3TscWpWd/NI6O
         gtnNfRgJxTIj4ivfCi73RRZPQFOWnyTUHXvkmnHMA/n4LDbLlkn9XgEADGSx0NiInd3e
         UsqRbTIB77Iz7yBoqU/8HHmgalG5y8SuccVNMQE4WKzuyk7jCrmavduX/AuQh3CmooNi
         PX2+Pix8QbxMjLH5XgPqLccD9PnNJT1HmhmBs265FOxrQ5y5JRyjbwsoW/9y0jsXHaSn
         vq+g==
X-Gm-Message-State: APjAAAWhIBSoS8SjwqIFkrQFDq8pVJB4GJg9VdBoyg9AL7k36wdkKL0I
        XgwCjlFp8BkoDC9I5r+4PFI=
X-Google-Smtp-Source: APXvYqwBn9gnmzPfntdGH9Wu5eH7fT4kYRuxbUpdoAh0ZlJclARI69st9OHesKdZGfLyUzXWp7duYg==
X-Received: by 2002:a63:4343:: with SMTP id q64mr5635918pga.105.1553703139536;
        Wed, 27 Mar 2019 09:12:19 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id l187sm27218206pgl.75.2019.03.27.09.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:12:18 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] gpu:drm: Remove duplicate headers
Date:   Thu, 28 Mar 2019 02:41:56 +0530
Message-Id: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 drivers/gpu/drm/bridge/panel.c       | 1 -
 drivers/gpu/drm/i915/intel_display.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 38eeaf8..eb9567d 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -15,7 +15,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_panel.h>
 
 struct panel_bridge {
 	struct drm_bridge bridge;
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index ccb6163..1166342 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -51,14 +51,7 @@
 #include "intel_dsi.h"
 #include "intel_frontbuffer.h"
 
-#include "intel_drv.h"
-#include "intel_dsi.h"
-#include "intel_frontbuffer.h"
-
-#include "i915_drv.h"
-#include "i915_gem_clflush.h"
 #include "i915_reset.h"
-#include "i915_trace.h"
 
 /* Primary plane formats for gen <= 3 */
 static const u32 i8xx_primary_formats[] = {
-- 
1.8.3.1

