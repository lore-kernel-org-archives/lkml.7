Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5666C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C512080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACsUX2E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406248AbfITWtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:49:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32845 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfITWtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:49:33 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so19869459ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wOpJQk7o6uD40KwVMmu8VQcBIeJeRyt/YndwGm9kx/0=;
        b=ACsUX2E2WcuZZFmvPnh2nXTsETrz8yamMn3bO6rMtq/UC1IFTo5Q9N2tcaMQH2EChi
         o/5jdQNjzXTYviqKafcRo+xbmAAD7tKV/F5Xa6eGMWs3pc+c62WzMfvlrNp4/m42ne2S
         jvZLlMIqQrSeOuc6YRgeLnUMd/KxDX/Uy0olM0H0qNgMjgfXnjHrDAo0PO8adFmuL6rr
         fv5gGcbx1HRGvda/OiHQ4QxhLuqr14NxyS3INmNjyLnHP1dnMcTcSCQxFc22TBfBz4lZ
         ZNZn5IL8lRABN6AB0iWFzBsNmz5PWd9P/Mst27mRvSxjMWFczBsgGOERFcDn+YHm15t7
         y3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wOpJQk7o6uD40KwVMmu8VQcBIeJeRyt/YndwGm9kx/0=;
        b=AslU+2K6Z17/vgwMhbiH0L3XX3mNmmrjRf+RxPez92htnOo6ReHW8yR2cRzU+pO+vv
         Od+u7T+Ny1bJef2/jcfusJMQMF35OyJlHwxG3kNChlWCSZ1MYiAThwtubFz982US3jWn
         btiX8JzVG8KiCeu7MsuR9hrUkjloFNjf4hnNxc4zB+VnJfb5uvbk7//6hgWvTg2x4079
         EBAUUDECIvgXruP1jiWHkTs3bNYHtX77BgbYDX8Ng039zn/2TzY83zcKCbpa/Ke9IUTa
         TDc9vMfqPjdQ/nv+xsVkXnZp4KIIKpc3llM8qLdnuHou5UlqNDKfcHuaQUJpnBlpoMu+
         2/2g==
X-Gm-Message-State: APjAAAXBj/CFcmhX44Ogim8baPp/1ZZajsyRq/CkkK5qenX1GAMwCEAY
        PVkEgdPCHq+x6sVXQCniU2LoUcgQsrg=
X-Google-Smtp-Source: APXvYqwwbVOjmnF+xSJ83lf0QEM65bDBvT+0GLoqdM7aVkcp+sFzFWRjgpRovLgsdFtvQ4qa85aHqQ==
X-Received: by 2002:a6b:3a43:: with SMTP id h64mr550056ioa.89.1569019771106;
        Fri, 20 Sep 2019 15:49:31 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id a14sm3835732ioo.85.2019.09.20.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:49:30 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: release allocated memory
Date:   Fri, 20 Sep 2019 17:49:10 -0500
Message-Id: <20190920224915.2788-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_vmid_grab_idle, fences is being leaked in one execution path.
The missing kfree was added.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 57b3d8a9bef3..9063cd36fa94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -244,6 +244,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 		r = amdgpu_sync_fence(adev, sync, &array->base, false);
 		dma_fence_put(ring->vmid_wait);
 		ring->vmid_wait = &array->base;
+		kfree(fences);
 		return r;
 	}
 	kfree(fences);
-- 
2.17.1

