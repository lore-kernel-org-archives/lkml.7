Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC96C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C8720872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+zAOQxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFEXof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:44:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44985 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfFEXod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:44:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so201925pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 16:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwf2lq4OY89MkNjiWF+0LhnW12Q+XYPUm3xzzSFfsGc=;
        b=P+zAOQxSjFPWNwxpnYLwFn3h9QlWl4dngQ6RiDF4yle3Hlwdh54wo08HSg3xew7BFa
         M5d+/oLzfDBb6cJsN1NzfSgm16m1c60gEsO4GrXYfwcJTzqJK5JthNdC1idq42gkOlVh
         lM6RaSB4T8dlswjWCTRJT1AcEuqhjKrXlHECg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwf2lq4OY89MkNjiWF+0LhnW12Q+XYPUm3xzzSFfsGc=;
        b=Ovz8z77Rf3inX2G9hjsVkO4x4n802BqRS5nVxpXdXuPlS1jgcQT2QAxrxm2RPSy/iQ
         CmKo45jNkjnzogf2RJwtQvuZfEKlg+pnrw/fSbyyTq6RGCODJgkeM6VpZo7R5dA5f1p9
         8rnJgfA4bqy/5fZiO6M+rfFcpqe5v1k+vegtxpTZ+6gkYASwh3/PIHzwLETQ7SNqnL/I
         l3tCDTjFBs8+KMx0RsidDmohkbCoTrDbe4rqYg+5UNkIs9r0ya7IYUFz9GNtnu/12+Y7
         JNFrEvkof7lAN2VPpMaRgK/Fsa3oy3XRlXEEAh7mz42xsXfZ++nd5AtAdfdxA9iMT1d1
         D0vw==
X-Gm-Message-State: APjAAAW36Am54y35ThfQyL6fFZYU7JylAWJTMC00yNk/fULNVVBnEDS+
        FYYekSjUS+R6VU7PZqWv79pU5g==
X-Google-Smtp-Source: APXvYqyig+GAqhvYzvzXsYbjNJMPdN+fWyPuejoQFAI3jRjtP8BxQTIRqKemQzhkIDjV7vAPg4DEuw==
X-Received: by 2002:a63:d615:: with SMTP id q21mr381674pgg.401.1559778272417;
        Wed, 05 Jun 2019 16:44:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id m128sm71835pfb.95.2019.06.05.16.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:44:31 -0700 (PDT)
From:   davidriley@chromium.org
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Riley <davidriley@chromium.org>
Subject: [PATCH 3/4] drm/virtio: Fix cache entry creation race.
Date:   Wed,  5 Jun 2019 16:44:22 -0700
Message-Id: <20190605234423.11348-3-davidriley@chromium.org>
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

virtio_gpu_cmd_get_capset would check for the existence of an entry
under lock.  If it was not found, it would unlock and call
virtio_gpu_cmd_get_capset to create a new entry.  The new entry would
be added it to the list without checking if it was added by another
task during the period where the lock was not held resulting in
duplicate entries.

Compounding this issue, virtio_gpu_cmd_capset_cb would stop iterating
after find the first matching entry.  Multiple callbacks would modify
the first entry, but any subsequent entries and their associated waiters
would eventually timeout since they don't become valid, also wasting
memory along the way.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index da71568adb9a..dd5ead2541c2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -684,8 +684,11 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	int max_size;
 	struct virtio_gpu_drv_cap_cache *cache_ent;
+	struct virtio_gpu_drv_cap_cache *search_ent;
 	void *resp_buf;
 
+	*cache_p = NULL;
+
 	if (idx >= vgdev->num_capsets)
 		return -EINVAL;
 
@@ -716,9 +719,26 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	atomic_set(&cache_ent->is_valid, 0);
 	cache_ent->size = max_size;
 	spin_lock(&vgdev->display_info_lock);
-	list_add_tail(&cache_ent->head, &vgdev->cap_cache);
+	/* Search while under lock in case it was added by another task. */
+	list_for_each_entry(search_ent, &vgdev->cap_cache, head) {
+		if (search_ent->id == vgdev->capsets[idx].id &&
+		    search_ent->version == version) {
+			*cache_p = search_ent;
+			break;
+		}
+	}
+	if (!*cache_p)
+		list_add_tail(&cache_ent->head, &vgdev->cap_cache);
 	spin_unlock(&vgdev->display_info_lock);
 
+	if (*cache_p) {
+		/* Entry was found, so free everything that was just created. */
+		kfree(resp_buf);
+		kfree(cache_ent->caps_cache);
+		kfree(cache_ent);
+		return 0;
+	}
+
 	cmd_p = virtio_gpu_alloc_cmd_resp
 		(vgdev, &virtio_gpu_cmd_capset_cb, &vbuf, sizeof(*cmd_p),
 		 sizeof(struct virtio_gpu_resp_capset) + max_size,
-- 
2.22.0.rc1.311.g5d7573a151-goog

