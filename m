Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F84CC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838320717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHtX30vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFEXoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:44:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40272 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfFEXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:44:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so213695pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/rnPOIToTFx5TLEufnCNbUgXKKUEmLsHgR6/mZpdjU=;
        b=MHtX30vwaCImP+Gi+3ZHA5YFvCgatPC5P2V/vbOYhAkd3uKWFpSwfQdIMqKJ1UN9mn
         ubpHA9QgM0UPJc143fTWqiXbi4prMSZRarIR96MLM1tgPc563MWE5mRtsemIxnOR/+2i
         tvCWi/hmoOEQ3lAIw8K9OJ6Tm6wuPY1LbOh44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/rnPOIToTFx5TLEufnCNbUgXKKUEmLsHgR6/mZpdjU=;
        b=FIlzOWS8UrhY+iVfhj190ucjhDC0t15EPpycmQ0rvF+d0Fkb22uLqYJYX9Szc+nBfG
         XXkxrEdiMTecBaUMnl6FBjYTv3s2TwCGjxcahPhSLex5AVb2HAn0qi/5eTWAECS7lFFZ
         pWmPiUHNSXXEOa0uY+Rty/CrpIA5MkeJL4s4EbVcxlCilv9SuSCLQcGhv4Cw7IWHdJw1
         UlFpfNZYOWP40b2yBha9l9JKWgpo5v45Y5NRS0rarQYlLKmFoRPD65lfGaHyKk1btvrd
         CFirkBhJKsP8Blz/zE5o3CDvfkc+htNa6P1ymTcAG9yY1t6dQwP44zjILOCAoWAdjJ8m
         /88g==
X-Gm-Message-State: APjAAAWB7EtKa8Ujp42OGZXHHXfSjGONT/slDiXUIzuhBNwxc/tv2lI6
        mqCqNxpnUq6jpoM0y4bZU39HCCscEsU=
X-Google-Smtp-Source: APXvYqx3zG9rCLgbcYNCrxQmCKphQkBdlVy6ZRX+tG+qVBLLyEt6Kt8hYiRlUljA7AErFG1Rw0gooQ==
X-Received: by 2002:aa7:824b:: with SMTP id e11mr48252024pfn.33.1559778274578;
        Wed, 05 Jun 2019 16:44:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id n13sm73547pff.59.2019.06.05.16.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:44:33 -0700 (PDT)
From:   davidriley@chromium.org
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Riley <davidriley@chromium.org>
Subject: [PATCH 4/4] drm/virtio: Add memory barriers for capset cache.
Date:   Wed,  5 Jun 2019 16:44:23 -0700
Message-Id: <20190605234423.11348-4-davidriley@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Riley <davidriley@chromium.org>

After data is copied to the cache entry, atomic_set is used indicate
that the data is the entry is valid without appropriate memory barriers.
Similarly the read side was missing the same memory barries.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 88c1ed57a3c5..502f5f7c2298 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -542,6 +542,9 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	if (!ret)
 		return -EBUSY;
 
+	/* is_valid check must proceed before copy of the cache entry. */
+	virt_rmb();
+
 	ptr = cache_ent->caps_cache;
 
 	if (copy_to_user((void __user *)(unsigned long)args->addr, ptr, size))
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index dd5ead2541c2..b974eba4fe7d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -583,6 +583,8 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 		    cache_ent->id == le32_to_cpu(cmd->capset_id)) {
 			memcpy(cache_ent->caps_cache, resp->capset_data,
 			       cache_ent->size);
+			/* Copy must occur before is_valid is signalled. */
+			virt_wmb();
 			atomic_set(&cache_ent->is_valid, 1);
 			break;
 		}
-- 
2.22.0.rc1.311.g5d7573a151-goog

