Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE26C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D858020859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCNlBwOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbfFJVSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:18:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38030 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390027AbfFJVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:18:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so4139943plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8nq9Im362lbv4azULZvOC9Ag2G2ZekGR7CCYDprgGF8=;
        b=FCNlBwOefmxV9kPIPrpaBd9HyXv2yEenUtOaw++Q3b8DYUHSXihBeppW/SIaMfVj5X
         jP4AxfQTg5gmZCoy5a/s/T7DlqJANXVakIx9E4W7j2FILbiSvu0yUKGMDBpgoqSfIRkG
         8f4i+L37sKl82vKcRN0id86xV7zHPQ7j7xd8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8nq9Im362lbv4azULZvOC9Ag2G2ZekGR7CCYDprgGF8=;
        b=DZAfPr2SJGiUtwDfrHMAbJwnyt4TVHLkh0c0vQtWwWC0LNmndrml4r1mx+tvRsMxbZ
         uKTrg1CBD33PKDybVpMuBrfCNm7locdwpHjeG4a8RQIaAEnun+jwZuMb1KUQOcYGAABH
         iWWotPL8tGUjj/iQN/vRSzsQqQTGNbZseQ4ToF9J08tOXNWeqPmybF2C8IzrX4+Jxfdn
         zLJcAC2jHpnNP+6rVX4VnCK0xEC1m/j40tdr/sq/xejOusPxUlzb8XTkMKCfGD63RxKL
         VO1sHRU8gpnc4H9PdYrSHR/I7Y1XvA9iPmi9fZIDqVrktySLZb/74FE+9ymmLI1Za73G
         03jQ==
X-Gm-Message-State: APjAAAWazsJPoqzVkxCtBnSeqhah1y5M2POx26dtrDZMQJfUwV+s90/9
        71CZvvyAeUM7i5NdPu6JA10NQQ==
X-Google-Smtp-Source: APXvYqyMASM4YCvHQ5Ip2z9vUnGHsH6b1vlzz/iXUjTKHtkcitMyf7/FMV1pmortsoFPZ6YfD+n6Cw==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr72275000plf.176.1560201508490;
        Mon, 10 Jun 2019 14:18:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id q20sm16377982pgq.66.2019.06.10.14.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:18:27 -0700 (PDT)
From:   davidriley@chromium.org
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v2 4/4] drm/virtio: Add memory barriers for capset cache.
Date:   Mon, 10 Jun 2019 14:18:10 -0700
Message-Id: <20190610211810.253227-5-davidriley@chromium.org>
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

After data is copied to the cache entry, atomic_set is used indicate
that the data is the entry is valid without appropriate memory barriers.
Similarly the read side was missing the corresponding memory barriers.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 88c1ed57a3c5..a50495083d6f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -542,6 +542,9 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	if (!ret)
 		return -EBUSY;
 
+	/* is_valid check must proceed before copy of the cache entry. */
+	smp_rmb();
+
 	ptr = cache_ent->caps_cache;
 
 	if (copy_to_user((void __user *)(unsigned long)args->addr, ptr, size))
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index dd5ead2541c2..c7a5ca027245 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -583,6 +583,8 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 		    cache_ent->id == le32_to_cpu(cmd->capset_id)) {
 			memcpy(cache_ent->caps_cache, resp->capset_data,
 			       cache_ent->size);
+			/* Copy must occur before is_valid is signalled. */
+			smp_wmb();
 			atomic_set(&cache_ent->is_valid, 1);
 			break;
 		}
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

