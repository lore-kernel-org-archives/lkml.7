Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB743C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ADF218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbjIoTJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfDWXXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:23:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40348 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfDWXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so8361177pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffq6t3h4iha2b8rRhkjsypDQIKuHdAwEEoooYwQNUbA=;
        b=pbjIoTJHu8+xPePFhwY4xi9ya/ligccZ0pj7BpUULWYCP1l020YPTE4IeijEjdARQq
         tpgr7CKCzne4FecwXpBNa5o1486idq5SFsH9RMOUef8xBqn6yDeyN1Zii7clSuLcepNk
         +2h5o6st23kjLObnaMHmTvvU37Tbcl0EntgE8AiEy7MQjYedduMhHpmYLRrkGCYiJ9b9
         sX5Ew3NodXoIrY/dAXLQB8uN6tBP5QQL0iR8wcrMUKaP7wkHj7HXdp8ubct0QQ0oqWLO
         ijP3pNdtoxkx1zxJxYHPGHqr6SO1x+MguxaOhkD4Li8luNGdQhZ5lKl1tgXyJ8Xstxj+
         hQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffq6t3h4iha2b8rRhkjsypDQIKuHdAwEEoooYwQNUbA=;
        b=dLXnOBHgydnU3NiuIt3G4vlgFgcjyEFE/JgTUyINkkFG059cGO0ijNRTRUJ6fs4srz
         eDInyOjToYE9bObILoQPb37Hg4/3OFzde3Q7yrbUndggvUj7HNhglQO8b70sB0lvCaxy
         sIxzzAQ/rz1NQ8bhrmT/E5/1xrQcrxfL9iEG4q07oGP07zuYr0dQDgUqS5u2o//ywIuq
         Me/xwWaL/Q+uPcUgqWZ627c/R+Dp1omTtwfW1Hsdn8hSUvd+VcWgGQEJveYmscJznB14
         Ze9cOBOM+VbYgW9bFq8q0ZeV9ohwQ0DgHrkeJ8Qm5uxFp4L5gE4H2oAa4o26XkBrb38C
         IhmA==
X-Gm-Message-State: APjAAAWX4PPfGCIPzFBEmRswu5J6pk4xUfIFvKtuskuZ6IXGWc0mnCT+
        YIsU3905WSRWwkgDXMHO0Lygrnl5amo=
X-Google-Smtp-Source: APXvYqyy7+HL910ob3T/U/6+X+behbvUMZtG72iWdqYN0rvFz1h1auspIOq2AIb3SBVVn4K+kYH1dQ==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr28060734pgc.40.1556061663317;
        Tue, 23 Apr 2019 16:21:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:02 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH 02/25] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Date:   Tue, 23 Apr 2019 16:20:33 -0700
Message-Id: <1556061656-1733-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_HISI_KIRIN_DW_DSI option is only used w/ kirin
driver, so cut out the middleman and condense the config
logic down.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/Kconfig  | 10 +---------
 drivers/gpu/drm/hisilicon/kirin/Makefile |  4 ++--
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
index 499f644..6ef7906 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
+++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
@@ -4,16 +4,8 @@ config DRM_HISI_KIRIN
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
-	select HISI_KIRIN_DW_DSI
+	select DRM_MIPI_DSI
 	help
 	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
 	  If M is selected the module will be called kirin-drm.
 
-config HISI_KIRIN_DW_DSI
-	tristate "HiSilicon Kirin specific extensions for Synopsys DW MIPI DSI"
-	depends on DRM_HISI_KIRIN
-	select DRM_MIPI_DSI
-	help
-	 This selects support for HiSilicon Kirin SoC specific extensions for
-	 the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
-	 hi6220 based SoC, you should selet this option.
diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
index cdf6158..3585327 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Makefile
+++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
@@ -1,6 +1,6 @@
 kirin-drm-y := kirin_drm_drv.o \
-	       kirin_drm_ade.o
+	       kirin_drm_ade.o \
+	       dw_drm_dsi.o
 
 obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
 
-obj-$(CONFIG_HISI_KIRIN_DW_DSI) += dw_drm_dsi.o
-- 
2.7.4

