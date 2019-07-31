Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2120693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnp1qCHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGaCqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:46:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42514 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfGaCqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:46:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so29800316plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w5cOyOxhAUID1tCPC1X8j3Oj8XkaYtpNz6fVEgap7bY=;
        b=rnp1qCHcYJAwRdiabKV6cNpufFzp/A6Vxrprvi6fx4IJ8mS+WV2U6/yDr6/9+8xoY0
         VF5vHB0iDUOSz1JdcfyQVrrrpjJZjDPNUt/gTa59VrBZ+1PzA2n1Ulwyz4vqPPSyJljk
         i/MNLD59hZ+Tl+aC1fziE60Tdsxe7YvKmO88pQaQAoNIfEgYf5iHGvOBabPbUHhQuCNo
         ZEkAan+pqyvT5kmtZqR+0Bnx7DMNkzsAIBBRfGmPUUTlsZyeecKeCOT+qpxj6aVXJxGc
         QReanCXCCqmRJV3MFvkQBMu3pgnqs+aDI0rFoLyCe3OXABJ4+W1/BBgIAI0ko56UEtxM
         vDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w5cOyOxhAUID1tCPC1X8j3Oj8XkaYtpNz6fVEgap7bY=;
        b=FY31TQ14u0gc4kJwbIj/VuSRo8UzooDK6lA7tHZ56dDoip0K5q5mkBXohW2GH2rKKW
         vO8AVtNSzy3+5dOpwWru/eLoFNjkS6bzXGA20+HtfWF5AkVQpDAmPRNRa0l/m52It9jS
         8o5aJ74IiYNjWnKmsyRAXkSBmHlK+/DoydMMmwmfnCzCT/rfTFWDTg+/JW+nQSGD5SoM
         GWswxHWSMEjQslw66QueOa8xv1hySychSxN2VAVCGW3YIYBsDCa7j49RUHh6SbrG37rB
         Isuyuafdi3ztmDtcXYGlzHMiDA3aBfHa3nP5jhJsGzn3Jfu4q2bvMr7GUjrAIbDueA1l
         b2pg==
X-Gm-Message-State: APjAAAUjaDBUgFyqlcgIrx4YTjryxfX4vnAmTpsUryBVDc/cmqhSNPnS
        UFemyYbGoLnnW4rrFb8x4pVDn3khfpY=
X-Google-Smtp-Source: APXvYqxTJb5eodj2ckVumlL+0RDRIYaiUcKFGf7ihkxXWYXlVSjbmj8L5fzvw20rUBnlycwjnBJWyQ==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr120329921plb.64.1564541159865;
        Tue, 30 Jul 2019 19:45:59 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q69sm230530pjb.0.2019.07.30.19.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 19:45:57 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] drm: use trace_printk rather than printk in drm_dbg.
Date:   Wed, 31 Jul 2019 10:45:33 +0800
Message-Id: <20190731024533.22264-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
finally calls printk.
As amdgpu_ih_process is called from an interrupt handler,
and interrupt handler should be short as possible.

As printk may lead to bogging down the system or can even
create a live lock. printk should not be used in IRQ context.
Instead, trace_printk is recommended.
Link: https://lwn.net/Articles/365835

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index a17c8a14dba4..90cded140146 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -236,7 +236,7 @@ void drm_dbg(unsigned int category, const char *format, ...)
 	vaf.fmt = format;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+	trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
 	       __builtin_return_address(0), &vaf);
 
 	va_end(args);
-- 
2.11.0

