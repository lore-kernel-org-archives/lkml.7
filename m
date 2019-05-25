Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C8C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA0F2175B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATa9IqXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEYHEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 03:04:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36711 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYHEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 03:04:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so6613486pfa.3;
        Sat, 25 May 2019 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ou9qucjjS1yvpscRKVmRRDKnwn1q8SEEK4iftZmvq6M=;
        b=ATa9IqXhpNknuRnnk037f1U6Wxr3N5YBbIe47DjrNQJKxe/WJi9JnrTLdBwB5NLGpb
         S0kubHshm4bHRHlbBkWQ61ZfQUbqLb7Ow9TotSlUyA+nDbq0aIfCRnn8BZ4fXwUJCED8
         9EvuIJka24CFEde+tWxY020XqIbnCNSmsM5KB0TZLb2GtZbJYZCbw/80PeG/gZq8YAm/
         iwX3FkCRSNamIt87A9L47qHWNqDAHMVbLX7UHvj1LSWzm9qRtfKkUcHhVRLM0N0Zdi2u
         E/k66nOFfavkbQG+MpD9q72O/P80f6xbNGslU9lZT8eDASSPMNN1FPiSpY62XJjE1lNY
         nMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ou9qucjjS1yvpscRKVmRRDKnwn1q8SEEK4iftZmvq6M=;
        b=f/DnPUFgleSbEMzSEpp8EcljpNz6/mfXuJZcVfbSB3oo/jbDYXNQ8fi1Xe0jtlZ6qP
         BrTxmCfSL5RosfuErFN1QMO8P5SaNdOu4LoytUzoLno+htE1PP+e1XCSWPpW8uv1lZPX
         IFRXowauwNb7YgQknw/6qTM13NZkVEeArmHGrYq8FUUJI1FItmDATe6ezruy0B8IZQoL
         pEibbrP15baQQ2UEV+d52rv3qltLbUm+OQ1jIaEJl0UE57Y0FvhJZaKr0G1ODlU8qPhG
         SJYnqtNcX1EPmM6PYxiKi12t5IlGQbTwlW26PA35h/PVx84Cy1x9817xh4NDwbWC2ey/
         sYcw==
X-Gm-Message-State: APjAAAUzh24ECYhQIfWAGgSf23K1RyR01TsCaSh/wxIEzuE9dmHwmH1M
        W1iRRfVstTFz0ebxVD5QKPo=
X-Google-Smtp-Source: APXvYqz2fGzaLhOvTZ21B/Yj6WrUS10LI1Zb4JIpAoP+/EKpHI31hwmtNsEYlR5FcngbX8d1WspBsA==
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr14288409pjq.80.1558767839357;
        Sat, 25 May 2019 00:03:59 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id l3sm5637001pgl.3.2019.05.25.00.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 00:03:58 -0700 (PDT)
Date:   Sat, 25 May 2019 12:33:53 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525070353.GA6727@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

/drivers/gpu/drm/tegra/drm.c:509:1-3: WARNING: PTR_ERR_OR_ZERO can be
used
./drivers/gpu/drm/tegra/gem.c:419:1-3: WARNING: PTR_ERR_OR_ZERO can be
used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/tegra/drm.c | 6 ++----
 drivers/gpu/drm/tegra/gem.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 0c5f1e6..0a8fcc1 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -506,10 +506,8 @@ static int tegra_gem_create(struct drm_device *drm, void *data,
 
 	bo = tegra_bo_create_with_handle(file, drm, args->size, args->flags,
 					 &args->handle);
-	if (IS_ERR(bo))
-		return PTR_ERR(bo);
-
-	return 0;
+	
+	return PTR_ERR_OR_ZERO(bo);
 }
 
 static int tegra_gem_mmap(struct drm_device *drm, void *data,
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 4cce11f..6e27fc0 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -416,10 +416,7 @@ int tegra_bo_dumb_create(struct drm_file *file, struct drm_device *drm,
 
 	bo = tegra_bo_create_with_handle(file, drm, args->size, 0,
 					 &args->handle);
-	if (IS_ERR(bo))
-		return PTR_ERR(bo);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(bo);
 }
 
 static vm_fault_t tegra_bo_fault(struct vm_fault *vmf)
-- 
2.7.4

