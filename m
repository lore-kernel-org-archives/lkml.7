Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58221222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJpW+xhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfJDKR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:17:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388630AbfJDKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:17:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so5229080wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Vcf+UVY2rqjJRPiANDeBRpXqOSdb6/jb+sfnhdp7MM=;
        b=vJpW+xhTbLcgoLYjISojp3oyFM70IqtJPOBBYFcbZkhWynU5Z8bYhxHuN7YednMisa
         64/5PGDK2NwVv58w7wEsVJGBRp8laLhuJYKH2nt+XqCq3wUhz2H/OLJndPRKfsSQuPDd
         UcntM3z55GL+5uq6zUXU8jJoSpiE30YqO0ZKM7OqWmjjUAeaPM1NDym8yrA7sDqV5iPW
         FwjWE5AXVOY96r7uZiBk2d++9CiPErENN8vW7L7HEb9z30mUzpJ4lgSaBoj5Kb0a5g1u
         KxccvAuu0IsMCrV55yKKERr53DTtwpTgijWlFx/ViRu+WKjMyjgJMTrtRYOCrqVDRRxT
         ORew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Vcf+UVY2rqjJRPiANDeBRpXqOSdb6/jb+sfnhdp7MM=;
        b=RYFx7HPLm0Z7hXb/IBHOgtdtzoIwFGEOBJ8Zyvp+1+Xp6GjGbIm7tWVnCZ/Y/e31fz
         2PvM72w9Z5jWaz6/TNpYUuXML98OXSUm+XKqoULo4+1wLC/o8oJ7unh5ccyP/12MtzAH
         aK6COJIB6aToBSBr9tEcpNFU3Dp4V79CspaF+gd8zk/mbc/7nYtUH+Amt5se2JtZD5EY
         TCLySXJaq2Knpvt2k7ZEuXJAws01OCEhb6vYQ5Xlwj8NJOIrsECHGhDZZJZYoKSKfgmQ
         iwtQxrNDmhNw6gD/mAYhdIRnVcvymvJjN70IF9KsPRa8kI1sGx6fREelQQ/ElRXuSoio
         D2pw==
X-Gm-Message-State: APjAAAXeEcjxG5RCeYJvfN/mVjeHWC579HviCS91VIrrPkaSTvaBMNwD
        7lnXlC5eqxyvF37QW6apZ8o=
X-Google-Smtp-Source: APXvYqyOe3FXbS45/9CxnBvy82+J1R+6Ye4lJbdrFwXRJC0rYLNRsJ1HE34LHIbyZYreSgkDWSBc+A==
X-Received: by 2002:a7b:caaa:: with SMTP id r10mr10829469wml.100.1570184274042;
        Fri, 04 Oct 2019 03:17:54 -0700 (PDT)
Received: from brihaspati.fritz.box (p5DE53CC9.dip0.t-ipconnect.de. [93.229.60.201])
        by smtp.gmail.com with ESMTPSA id t18sm5278823wmi.44.2019.10.04.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 03:17:53 -0700 (PDT)
From:   Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nirmoy.das@amd.com
Subject: [PATCH] drm/amdgpu: fix memory leak
Date:   Fri,  4 Oct 2019 12:17:46 +0200
Message-Id: <20191004101746.19574-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_bo_list_ioctl when idr_alloc fails
don't return without freeing bo list entry.

Fixes: 964d0fbf6301d ("drm/amdgpu: Allow to create BO lists in CS ioctl v3")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 7bcf86c61999..c3e5ea544857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -284,7 +284,7 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
 		mutex_unlock(&fpriv->bo_list_lock);
 		if (r < 0) {
 			amdgpu_bo_list_put(list);
-			return r;
+			goto error_free;
 		}
 
 		handle = r;
-- 
2.23.0

