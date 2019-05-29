Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576EDC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2469D20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2KKu2Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfE2CBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:01:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34573 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2CBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:01:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so341188plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pvnMxrKbCnHwfQp2WAN74LexcQsw7QGG+UxEq4Csp7U=;
        b=n2KKu2RcDPRFrIpFakGYZyBPNk7WBzBQLyKP/9pMr3RF2AYGsGDCwXNfO6r/1CvGpi
         y15Kkbkm0s/AL/ZZ4ggbVJCCWqtzZtLyCV10CoVO7bnnJG/BMKzGpMxpomGYKn4VNaM3
         vbkjkkfl/6grBBAaEzOEgTN6uJCKZb2styzYX0POi2e3ayDsY49UYHzZHQkdbGQ0VkBe
         7hG3lX4OER2PjpwnMlfq/gRfnd6sgiTvgXBWnoomHyCJsrLHKtD6VDqNO4xr5IFHgT6L
         k85reGBMnTRGA0mZpHoyGW09O2lDXiJOCYrsz34i1GY1c5WvKlJebtfQFp+D31Gxem5j
         8rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pvnMxrKbCnHwfQp2WAN74LexcQsw7QGG+UxEq4Csp7U=;
        b=Wj17joG4DXNyPd7OCi+l9NWh5yK8w8dgJKdMBfQahLb4ihbOWo+CYZ8FesziBocXr2
         YRJFpB58SJCRr0O3gIXCzCcXqvPKFCTtRomsZq1P7AArUnmSi+ZDCja4Kp+i64KCEOS2
         pn40AxGx2t0u1SvdAnx3lvLnSUMYDfk96NPmVvfsbxkHMZTqwMu7hz1/chBhoruTg0sp
         GQSvcP8D+eZ6S+9xbQG3YuzzCSu2jv/4zLD4VbsWbJXyESeliitUoNYyye4PDAeO8Rme
         yuv0HvPaFztv+X7LVtzKVFeNg3nnbqdWdAXznGXqdmHLGgzYPM6SxaY+ZytksE8u1G5M
         oZbA==
X-Gm-Message-State: APjAAAWhA0g9GD2rORtC3rBxQPfz+317zPYpBppb+w+nQGNH7FvW7ZYf
        KiWtgbrUDbS4f1xe3kBgDYI=
X-Google-Smtp-Source: APXvYqziL+Wk9gcELY4PK/QjGBkuNLP7foZjEMgf2bPL6GA9rzbuahRKEawbinxkbcQtamA5GteCsQ==
X-Received: by 2002:a17:902:2c43:: with SMTP id m61mr29945832plb.315.1559095277045;
        Tue, 28 May 2019 19:01:17 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id g83sm18489083pfb.158.2019.05.28.19.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 19:01:16 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/gma500: fix edid memory leak in SDVO
Date:   Wed, 29 May 2019 10:02:25 +0800
Message-Id: <1559095345-25538-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable edid returned by psb_intel_sdvo_get_edid()
was never freed.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/gma500/psb_intel_sdvo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index dd3cec0..cc5fb85 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -1656,6 +1656,7 @@ static bool psb_intel_sdvo_detect_hdmi_audio(struct drm_connector *connector)
 	edid = psb_intel_sdvo_get_edid(connector);
 	if (edid != NULL && edid->input & DRM_EDID_INPUT_DIGITAL)
 		has_audio = drm_detect_monitor_audio(edid);
+	kfree(edid);
 
 	return has_audio;
 }
-- 
2.7.4

