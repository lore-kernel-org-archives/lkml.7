Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF1AC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AFE20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iOFhp97O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbfFJVSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:18:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33713 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfFJVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:18:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so5185800pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsVuZqN3BZSGA+LoVgx6ta+tF2PXiYDgRAf6MbHU3GI=;
        b=iOFhp97OR2XlAA4aQQYWlKmqqKyQE7mzMS+NyecweCZB2em2RWpyOF7yGs/OR4EsPo
         HLRUd7mFxlWl/mhy46zcVHdx1fam2I7BLziF07sxeXDAmX7xJ84JATe1nfiqQpAWfxSH
         aTL2zNkINzYLA9wyQl5EnKhO2k505n8llkvpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsVuZqN3BZSGA+LoVgx6ta+tF2PXiYDgRAf6MbHU3GI=;
        b=PqEqncrROwK8dCtALsA55+CHE7E5PrznUTb9uhcyrQF/tTmKUbpDZQsa0YzBhx1KUm
         xSJmrdKBnFFf3j4JKFddMkjx0c7rAResGb/UptGxouDF79jLW+5vaOhZQUzoI5b9H418
         Q/u5UFfbUwZ9X2EsOQxfEt6ypCuxf1Q5SDl/7uOePDZ1KdT2vxWiIuZKrv8la2bvtQ+U
         pxWgWPk/6tmMYhOwLHX1ylsBK9lF/h0G1xsmc8C4bvjneMYbFfugKEdm0NRZYiDqTFrv
         gckz1FFISRsffLufQYQnkB086qgGLtjg/KowB6z1oziUsQxDZGvzhH+OJ9ppQJt6aP6N
         UbrA==
X-Gm-Message-State: APjAAAV1Npv+CTX6v8MkjfdF1kT02iD3pC+KX3o/PdnIgrNmlzvPpjyr
        dHIEclU3vNNJXBTRfJZIM27WVA==
X-Google-Smtp-Source: APXvYqyAAVeRLFb2ZVyVA/0TT4TC0xtqnzO+EKpJMFECU/BWdHQEiQ+mA4zE+9LfkIxP0C4B1c4e9Q==
X-Received: by 2002:aa7:8188:: with SMTP id g8mr26139750pfi.221.1560201500417;
        Mon, 10 Jun 2019 14:18:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id z15sm10573320pge.40.2019.06.10.14.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:18:19 -0700 (PDT)
From:   davidriley@chromium.org
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v2 1/4] drm/virtio: Ensure cached capset entries are valid before copying.
Date:   Mon, 10 Jun 2019 14:18:07 -0700
Message-Id: <20190610211810.253227-2-davidriley@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Riley <davidriley@chromium.org>

virtio_gpu_get_caps_ioctl could return success with invalid data if a
second caller to the function occurred after the entry was created in
virtio_gpu_cmd_get_capset but prior to the virtio_gpu_cmd_capset_cb
callback being called.  This could leak contents of memory as well
since the caps_cache allocation is done without zeroing.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 949a264985fc..88c1ed57a3c5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -526,7 +526,6 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	list_for_each_entry(cache_ent, &vgdev->cap_cache, head) {
 		if (cache_ent->id == args->cap_set_id &&
 		    cache_ent->version == args->cap_set_ver) {
-			ptr = cache_ent->caps_cache;
 			spin_unlock(&vgdev->display_info_lock);
 			goto copy_exit;
 		}
@@ -537,6 +536,7 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
 				  &cache_ent);
 
+copy_exit:
 	ret = wait_event_timeout(vgdev->resp_wq,
 				 atomic_read(&cache_ent->is_valid), 5 * HZ);
 	if (!ret)
@@ -544,7 +544,6 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 
 	ptr = cache_ent->caps_cache;
 
-copy_exit:
 	if (copy_to_user((void __user *)(unsigned long)args->addr, ptr, size))
 		return -EFAULT;
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

