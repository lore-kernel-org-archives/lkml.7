Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9644C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B2208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm1TfpZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfFNL2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:28:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46397 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfFNL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:28:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so1276330pfy.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T6oFXDd7RFgkDhvVzkPX+FeD473fViFpef2JxosV0BQ=;
        b=Tm1TfpZUG6v9dqJ7S/nLPcnNLBnUCudYbvvrro2nNlyeCF4TQk2uwU39x1Sk/qQ6G2
         ccDCBEyvTxYmQplnoOReO+BeCl84+2vjjuKYS/Mp/5NqsaS3xLgg9nsGJPJES6apYWjJ
         sBwlJKmbueYj4cW2R0fw3IJk7GNJKZfbnkWK+IvOaStZbBQY6jNbQbgHkZVXYIwR10F1
         pKdG/SESJeRKdzjy8XIKgSipH4KiO7bl8MtyYebSWvR+SqWyj/3ZnazLzd4zTrDnJ17G
         SHZn/5pnV6eQ46Kyk3ZWfRK0e+pdlx1zZLsbkVYotTrOdwMFnN8IbMm8wHM537Pb0ULL
         WYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T6oFXDd7RFgkDhvVzkPX+FeD473fViFpef2JxosV0BQ=;
        b=rJRz2yktRzh3TueT68w1KOdWrVSp6SDz4MpgRRwuOWTImUjyZvmnDbBXKz1T071Gn3
         /tNvHAyYu+8VAEAqN4DG+0I/nsaNC+V6GjUgyjNzg5QMLvH7L3rRspPmCrph9ea4MZPr
         vWQaflB7KKaiHupsweLnr9Ij3AG0b43QtpdJbf/2lxFfjEKCFq8hwn8KutEjAnhm9iuJ
         lqUljByR1ZynpLRUrwMk9eEC15wHyRgtkR1ByjbyEWBdwSlO5bTuB1YlogTma3znu47M
         poU6hs92nNgNtC7vM+NXC1GauLRCe3V42xbMM4JVGYU1N+eDjE4xY8Xx7EKRKkTDTric
         0WKw==
X-Gm-Message-State: APjAAAU9GHhXGmC9h/sEFemHkcORqG63Bb6eo25EBmJosvLXC0gotkPb
        D2OE4+ZcnHlKo6ukOb1eN/A=
X-Google-Smtp-Source: APXvYqwPYqScXoW9ZuO5k06QZdNzmPdYb8Qc3R9ESnIh+b5Es9GZM2ARs5/8AIxFKMBcfwZjbTq/4w==
X-Received: by 2002:a17:90a:23a4:: with SMTP id g33mr10930800pje.115.1560511700146;
        Fri, 14 Jun 2019 04:28:20 -0700 (PDT)
Received: from xy-data.openstacklocal ([159.138.22.150])
        by smtp.gmail.com with ESMTPSA id t11sm2205147pgp.1.2019.06.14.04.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 04:28:19 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/amd: fix hotplug race at startup
Date:   Fri, 14 Jun 2019 19:29:23 +0800
Message-Id: <1560511763-2140-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should check mode_config_initialized flag in amdgpu_hotplug_work_func.

See commit 7f98ca454ad3 ("drm/radeon: fix hotplug race at startup") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index af4c3b1..13186d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -85,6 +85,9 @@ static void amdgpu_hotplug_work_func(struct work_struct *work)
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_connector *connector;
 
+	if (!adev->mode_info.mode_config_initialized)
+		return;
+
 	mutex_lock(&mode_config->mutex);
 	list_for_each_entry(connector, &mode_config->connector_list, head)
 		amdgpu_connector_hotplug(connector);
-- 
2.7.4

