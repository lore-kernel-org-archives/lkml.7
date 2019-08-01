Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FB206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdmQoxQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfHADox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:44:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36044 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfHADou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so33153591pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=glR6oLsrJBxGZFPDkXtm2pq0TMtj5d9cDHh+aCshZSM=;
        b=MdmQoxQbTaoF/R7+yM5VR/ujeIBF5Fb754pcNDvBMGuz9U/tQe77z4f9FvNzWKoVoG
         Mz02LZDfmF0puZa6CKDNrl8gwFRXEbiivEbkx8WgvhSCOWSic5m399U/oGiIe2RyHBvz
         QsOXc4BKoo73GYJrYKtveMj6NjvGpP4OBC/sSOmuQQr6RT5gnFCvxP0x8uns39qhyXKm
         sOFenrXPARzflNWYvqvqWN2uPlujyQukVt3ELkjt2cwvFM43rCyyrRRXPhJ463+lKecb
         vhhIGfgcbMT3LmhQoEicVKt7ZxJh93HH79tJTQKKHQfvzoMtt5ttIRboolYZoHvlBOja
         Qn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=glR6oLsrJBxGZFPDkXtm2pq0TMtj5d9cDHh+aCshZSM=;
        b=tIwpyKkj7mOrFi1yYW9y4szrURYKzOL1XtbnMKKfOJQpVTKqSq8MFj11o7pMoEj3xi
         qzBBVITsUsTxJE1emolTu9hCZm4W3YGkZmubEWHuq5JKRZFqjruBwajJ0XZmy9bNtY/u
         +xKmNtBTDqxwcf8KUApM8mDU8qKpqXe6m5H1wSY+P3gUGJ1YFTpXcKgDTTpVXhcbcuHY
         eEpyKdnh4fLtx/EqNAjwtMYkPO7gW43ehl7tGcbfsP+EHSDIcHhMedqVgjAaisQrwLbb
         DISoNdk67bTeY6D3uyPjtof/WUkXvgdXfvtxf9Uq1clN12Jq9N24eQFW8PwQ3Dy+e01S
         mUmQ==
X-Gm-Message-State: APjAAAX04nBZJseleWGhLnf9J5aGaHNFKAgHRMKplhk4I6M5dpAkqXyW
        /z/8FQ1w7G4tot/F4owyZpi9wO60Vb4=
X-Google-Smtp-Source: APXvYqwZUyVJCtO5ywHyrzDNXrhYzKt4wEMC/xHUqrhtDKQAar1dMPYAHypw7YosnkttUE4n03KNUg==
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr50211433pfr.88.1564631088809;
        Wed, 31 Jul 2019 20:44:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:48 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 02/26] drm: kirin: Get rid of drmP.h includes
Date:   Thu,  1 Aug 2019 03:44:15 +0000
Message-Id: <20190801034439.98227-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove use of drmP.h in kirin driver

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 6 +++++-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index d69b5d458950..9a9e3b688ba3 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -17,8 +17,12 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/platform_device.h>
 
-#include <drm/drmP.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 4a7fe10a37cb..fbab73c5851d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -14,8 +14,10 @@
 #include <linux/of_platform.h>
 #include <linux/component.h>
 #include <linux/of_graph.h>
+#include <linux/module.h>
 
-#include <drm/drmP.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
-- 
2.17.1

