Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D661CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F62086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnPNSwJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfJUSxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:53:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33949 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:53:02 -0400
Received: by mail-il1-f194.google.com with SMTP id c12so13058747ilm.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=erjZddSV8OJ6M5smw9c8mYfNMrltsPqb9R/cRGyaN38=;
        b=QnPNSwJcr8M9bndo9lgdcmLVbusenXSGIcEjUnr4XxJVJmJykAZI7KbITLa0Wny0dp
         O75nQXxEaIslpYQY25szoq/JdGHYOHwfLENyCQafaCGQpkboDYSBTUBnjb1mykSDv6ex
         ECwvV70Vzbc1ea7co9bTdr6O4Y/zg1+T8+x/zmBKNQB4yqwiG6hnPhyGj0dFXWH/q6aw
         i2jhZoROVFhgQ4YES6C3GEZ+v+YfgJ1u20OeYRbXcxkwfeaKHaeGDH39qY+EHCBakbdq
         oatMw7sfoqWm4t4c1e3FWecWIcIewcYzsK9aXdeHhr2gmILAVtQ005k8mOJmFww2EImz
         AqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=erjZddSV8OJ6M5smw9c8mYfNMrltsPqb9R/cRGyaN38=;
        b=Ozz7Znr0ghgYhd5JhlfxuC5nIBKDHafgWQvi/mBWXH/2X119YQ602OoPlaPS3erYr/
         WNZVRPidLxpRf3+L1OeNY1R5q4LvE+qDlubvf5F6gZ3xI0Mln+0y4FMOSWJHztPtFmrp
         ZpZrb1DwkofuMEyZONm/SP0XZlznHcpm3uiBW/mLFHCgISJ7paY+6W0IDbmMuo+FfLKv
         Db+lcUhIHxWP/xqakOLhupeNGUmFiVtoYrZ8/euPStKLVBD8pX0TfoaOxkkMACtsE5/J
         mzJQtxzRXsuslnLRuYzkWfafynYOdcXvWWQHQyskNRIH4rDoVhmsp457vzhHHEhxDJ1t
         tuow==
X-Gm-Message-State: APjAAAWxKty6F4KfgdpEIlIYbuoZaMQZwUPCojb5qkA7AcT+ZVQLBgvK
        zvtOWbSgv3eSHryAh8vMNck=
X-Google-Smtp-Source: APXvYqypeFGVtWeXC2SiZVCheTcw8968x/hQ1h8DTaS56XiKXAhVvfj9p7br1QvWn0gwJeR9Eyjt+A==
X-Received: by 2002:a92:5d88:: with SMTP id e8mr4794924ilg.95.1571683981508;
        Mon, 21 Oct 2019 11:53:01 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id i26sm4780063iol.84.2019.10.21.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:53:00 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
Date:   Mon, 21 Oct 2019 13:52:49 -0500
Message-Id: <20191021185250.26130-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the impelementation of v3d_submit_cl_ioctl() there are two memory
leaks. One is when allocation for bin fails, and the other is when bin
initialization fails. If kcalloc fails to allocate memory for bin then
render->base should be put. Also, if v3d_job_init() fails to initialize
bin->base then allocated memory for bin should be released.

Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 5d80507b539b..19c092d75266 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 	if (args->bcl_start != args->bcl_end) {
 		bin = kcalloc(1, sizeof(*bin), GFP_KERNEL);
-		if (!bin)
+		if (!bin) {
+			v3d_job_put(&render->base);
 			return -ENOMEM;
+		}
 
 		ret = v3d_job_init(v3d, file_priv, &bin->base,
 				   v3d_job_free, args->in_sync_bcl);
 		if (ret) {
 			v3d_job_put(&render->base);
+			kfree(bin);
 			return ret;
 		}
 
-- 
2.17.1

