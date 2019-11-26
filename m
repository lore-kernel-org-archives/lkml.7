Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A50C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846262089D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPdg/Xxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKZKNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:13:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfKZKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:13:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so2531001wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 02:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=el/FpqOcsaC4sI4snGd/4tXRjMT6hnOv5XPSv5sNfp0=;
        b=lPdg/Xxu9EwouEmwc85ZRdEJslPJ6/BKDm6vXCfiAcsnQmvRztK76oNfhREHlGw7BJ
         MMwJubWE7O47MXdINJT/JdD1vZuTIvh7ovxaDKpTKJ+0SRlJ4EpQYzRoxBJRNYAFRJWF
         Tj3VLe1KU8XndPPuYu7pPsqRlHXP9RTN/rsyg7fsgISYftikABD5ZrehErdmU38rYhme
         xhMTboA5C8YEODiIw79Sa2YbMtXHKXd/KOA9i5+sXIfAu3VvGQcb6kHZ2FC1xutJWoSt
         fN34/94zexhA/QUoPkKPVEa6LdIAMf3TVrT/OHz0KNPrbuaDSveVxVQjnI1k0AnfJCua
         ccJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=el/FpqOcsaC4sI4snGd/4tXRjMT6hnOv5XPSv5sNfp0=;
        b=ps8Lc4wxRnhWpf2Zoa1MyZ5yOV9v7VozpShwDfqyA+4+06TT1f4pVVtBMGITX5kiJL
         HhwqA80AZH1kGXW4TEjtK1kom9Sy18puJNfjBi+xIIMiqj6vsJUzLXEXce38Im5+LtW5
         3dHJQftsCHdO6hGE2qjY4D9w9Tza5BvVIRpPO7+FUQcN5tulLFc/sneTDYOaeY82dRma
         9Zg4Hsp8VHRplYcYZotDvbNRm3QKeWdWwW2TQcSGTXG6ZnU2u904c7mhzf7xZPc0j4O4
         q779A0LM64fV8MGco3BhhxkiqIVjQFsR51tmc9Yt0SWKdTuEDK3YBYKLc/R1AAnS91d0
         kp/w==
X-Gm-Message-State: APjAAAXQP8EvyyvZsC6Dn5sSYA77QSw0noKSIC/2VfNQyLktLnnE17MX
        5ZXaULsgCrMzXGl5NcJk6Q==
X-Google-Smtp-Source: APXvYqx+juliVqLJsGm3ametfniK+SlcdPqQueJDWTqi7mBCn6dDn+3hojDZoVjKS6gogY/tip54Lw==
X-Received: by 2002:a05:600c:2103:: with SMTP id u3mr3659033wml.150.1574763210066;
        Tue, 26 Nov 2019 02:13:30 -0800 (PST)
Received: from ninjahub.lan (host-2-102-12-67.as13285.net. [2.102.12.67])
        by smtp.googlemail.com with ESMTPSA id o7sm14826392wrv.63.2019.11.26.02.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 02:13:29 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boqun.Feng@microsoft.com, Andrea.Parri@microsoft.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] gpu: ttm: add __releases function
Date:   Tue, 26 Nov 2019 10:13:19 +0000
Message-Id: <20191126101319.79476-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add releases() function to fix context imbalance.
 Issue detected by sparse tool.
warning: context imbalance in ttm_bo_cleanup_refs - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 98819462f025..c87481d667a9 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -544,7 +544,7 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 
 static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 			       bool interruptible, bool no_wait_gpu,
-			       bool unlock_resv)
+			       bool unlock_resv) __releases(&glob->lru_lock)
 {
 	struct ttm_bo_global *glob = bo->bdev->glob;
 	struct dma_resv *resv;
-- 
2.23.0

