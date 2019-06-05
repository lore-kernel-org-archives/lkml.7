Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14392C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AB320866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRxSI6zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFEXo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:44:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42090 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFEXo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:44:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so208155pgd.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyHkbOEMkgWVI1yREjgkQjgyvZb+xK4A4sfaT0UjXqc=;
        b=MRxSI6zkTMXESmwtjNnyGJHwIuyYXxr3GsKIJLzp62KNe+JF4RahnVj735T5TQpjTJ
         1DmcVhwU5wSDdCbOUqKVzxah/TfKcYHnfXJmIwd7rFo3xD1LU0upA51lJQo8prBDT1uc
         7d7/Hz8UYsm1aD8AnuYU3GESzf2NT38q94dOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyHkbOEMkgWVI1yREjgkQjgyvZb+xK4A4sfaT0UjXqc=;
        b=JlqVrMnThft1mnUbXTKyL+DRx8l0KtSu5+8R3tTZiA31PZUxSoePLUTygyo+k2e+Zv
         aUePMZAE6fCHImoeuiEIRAsxUOGSMh4afste61yCifpAYLXNcye2Vz8QQare+qgbjGSM
         AmXKdZOpzPQ4k80JMkBwFxN+KleD8bMDHiXHyxLnDoFmH2Mm5Z3Ecf2dayE4s3zYgl81
         0/rdZzTp8sFIe49B1gWrYvN7HuZU8OiLtlx5HmI0ifr2UDG0hHanv8BvIG9dVN6yD151
         Gpb0Fh44sZgdA1Bgm+zOrH2QzjxRSdNhxKWF1PiqFSrqFyyTQSeuLqxk0leNQeLO6ua8
         Nlpw==
X-Gm-Message-State: APjAAAVyvhsF8/rJLlNDpeHESMXMWjvzYvZDx0FzzPrmK8O2etPaGbhl
        Nnw14PIjrlB65lpP8j4BcEPU1w==
X-Google-Smtp-Source: APXvYqxR2BZjwTQAkG75ysAdGk8mlHNMgXAGJfJSmgUvu6H+vcz7IhZJ5J9HpwEQabmlAAHkJhMbVg==
X-Received: by 2002:a63:5ca:: with SMTP id 193mr446060pgf.232.1559778266823;
        Wed, 05 Jun 2019 16:44:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id y185sm68596pfy.110.2019.06.05.16.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:44:26 -0700 (PDT)
From:   davidriley@chromium.org
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Riley <davidriley@chromium.org>
Subject: [PATCH 1/4] drm/virtio: Ensure cached capset entries are valid before copying.
Date:   Wed,  5 Jun 2019 16:44:20 -0700
Message-Id: <20190605234423.11348-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
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
2.22.0.rc1.311.g5d7573a151-goog

