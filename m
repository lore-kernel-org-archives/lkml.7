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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA96CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6082084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1I6gh7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfJUVO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:14:59 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39180 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:14:59 -0400
Received: by mail-il1-f195.google.com with SMTP id i12so2897667ils.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LR3+seWWFASqTSZQrCeqQuAxv454H5+n1q+3KOFbBcs=;
        b=G1I6gh7o/OFhK2+ufBpndx46sR9cyY67N6CBxIyxkgWvcaRC5RoOzDnEuqkOFFZ9Xh
         G2lGR9XhD9UJd43XoN6GjpKobREtEatr0444g4HiQ0vIp6qcNtT9izy8dxqFp7CXKHce
         8ZBaD4kQTeheSROXlCqCHJqYicJ5iQ9VeVlwsT+l0LYnADQQy12XeEgxz24VbihIbmas
         EBjpvrrl1tTvDVxNOoo+e8t7++Ptu20ey5KWx8LMT5lgriVDB4E5qG+qhKZbKmv0K1nQ
         sj6wWW0LedhBb9aXveHWrW2drichJEGv+dQwI930GHMCZji2BtPwr2uJu7Pbcz+SohQR
         h8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LR3+seWWFASqTSZQrCeqQuAxv454H5+n1q+3KOFbBcs=;
        b=K1dW2EdisHjdiR/XxHVZS2ZxOQPPcatCALh1iZX9T8syWtYR0IVkwHvagwrVSwSzu/
         7CXzyTumYVoa8CLlhhZW9ns4aoRBZM4NWSgwA+jzTgeFTMgiMpGD7bVxk1qJhUr47K8o
         oaJBRFdxJL33HchjIiY6weUVeQAMRNSJqHGu4Vq35vLNbmsa+Fb/sFfgtzShToYNf8hY
         gGzbd+Q76YIEnUYFEptPXSefVg7vjW2gZPWpW8lKuqZthoJNlWe7ZnvaSvbTrp9Eu5cV
         5IomvGjQb9qCBfX6m+itFHmDP+pdBqf5oOgXMs/qbWzaknYselDIQXrTiedmOnWBJSv7
         5sGg==
X-Gm-Message-State: APjAAAWRfPn2T3KYav4kYcTtjlsEShGP6jk5hdTO+Mla/0V6ZRWgbZ0A
        DEz9Cu39unt6mlMotXTjtag=
X-Google-Smtp-Source: APXvYqyUmrw7izwsnnLUWNHlEPHYO40uOt6aOQoTUw2Mw/Tsn91K4k/anOyP4E2hJDIrHP3dqzyD8w==
X-Received: by 2002:a92:5b16:: with SMTP id p22mr29585825ilb.226.1571692498435;
        Mon, 21 Oct 2019 14:14:58 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id m9sm6722618ilc.44.2019.10.21.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 14:14:57 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix memory leak in nouveau_bo_alloc
Date:   Mon, 21 Oct 2019 16:14:48 -0500
Message-Id: <20191021211449.9104-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of nouveau_bo_alloc() if it fails to determine the
target page size via pi, then the allocated memory for nvbo should be
released.

Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index f8015e0318d7..18857cf44068 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -276,8 +276,10 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 flags,
 			break;
 	}
 
-	if (WARN_ON(pi < 0))
+	if (WARN_ON(pi < 0)) {
+		kfree(nvbo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	/* Disable compression if suitable settings couldn't be found. */
 	if (nvbo->comp && !vmm->page[pi].comp) {
-- 
2.17.1

