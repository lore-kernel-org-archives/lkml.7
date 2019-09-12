Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E87C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B882020684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n9ZAP1uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfILQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:00:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42962 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbfILQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:00:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so16281679pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZDNqEnv4EmFhQfK0XZBrV/jYzvQOHibAKE2NrjIUg0=;
        b=n9ZAP1ukn//d7pJMbvivuEhJH9dW8ljZ3TQSume+cAb44Ay5une9clipJXr+osOEVJ
         UmnNf68fglbomW2DPCZpTYraLXqQifTF+Ka9DIkPOtu2DnS8xS/cbfpahKe80ek4KW/F
         D1gSaIhFJjokLkMezGrZ1q7xVooMDYgUZZ6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZDNqEnv4EmFhQfK0XZBrV/jYzvQOHibAKE2NrjIUg0=;
        b=ddTReZm9SFuJwJM/9qq11eBVZ7Bi8IvNy0G2CBsw4KbiphSrILaCtMrI8w02+cj8DJ
         xXTziO3NxkEUyDmUodEG6C7RlYpiC3ffGJQCnmOXD3ZYoBqTU+rgmoXfY+4KyMZKj/+B
         M0jD384LLduu0PS4MDvVsM8AOCrUEpWI3DLgfhvcBmVJAn0lfuviI+QJd4OiBG+Wgml0
         NEGz/WHHsIgEWPNZMpm6eiXXJfSKeyxLNj5gXTogW47l73lDWgi/b8B1ZMCFfLFxRAsX
         NlYKS8HPUreGUORVKsxIiq+Yj6WNSl4lY5kYIgb4xcibSMSiuvFnkSwZoVvrZorVu+3A
         dNFg==
X-Gm-Message-State: APjAAAVEHaYFVqrn2/QCpn2ZAqoX82NRhvOSChgH6bFMafy+XFA/drTe
        v0bwf+NYMEi3TTvxHrlRUkbOJg==
X-Google-Smtp-Source: APXvYqw/ay5iAGudFoue/juWTHwzUaTUPAvaaep73lKG3ftykR072bfY4K+CVgDD8Hjs5ekI18e+zA==
X-Received: by 2002:a62:5583:: with SMTP id j125mr5989380pfb.257.1568304052145;
        Thu, 12 Sep 2019 09:00:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id v18sm20573654pgl.87.2019.09.12.09.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 09:00:51 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Riley <davidriley@chromium.org>
Subject: [PATCH] drm/virtio: Fix warning in virtio_gpu_queue_fenced_ctrl_buffer.
Date:   Thu, 12 Sep 2019 09:00:48 -0700
Message-Id: <20190912160048.212495-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning introduced with commit e1218b8c0cc1
("drm/virtio: Use vmalloc for command buffer allocations.")
from drm-misc-next.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9f9b782dd332..80176f379ad5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -358,7 +358,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
 					     &outcnt);
 			if (!sgt)
-				return -ENOMEM;
+				return;
 			vout = sgt->sgl;
 		} else {
 			sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
-- 
2.23.0.162.g0b9fbb3734-goog

