Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88778C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610F620820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="he+m3/R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfFJVS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:18:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42963 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfFJVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:18:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so5994132pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NP01C7FGf5lxdvTmoSCPFBCPy5Bu0zVjIzvG3I+uzsk=;
        b=he+m3/R6d4WOz248hKEgrFo7XRgWBhY10YKEcExRTGj4loUd1d2D8qSf/4aeg5scMY
         AyAJux2zPZ583C6cHkDjwiDONDughIB3f4nxO2RH6Pjjv9X6OcnkjLb5/yCxTDwDns1v
         eH6ZyRxvCZ5YyXcJrIgIgdUBsJmOzPBY32ZzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NP01C7FGf5lxdvTmoSCPFBCPy5Bu0zVjIzvG3I+uzsk=;
        b=EJwDmto8SIwpoNpkruEFeWTg9O0tCdyy8LD4uS0mI44DgaFHMZ+SdDXqvqhpriFOuw
         Wi/9RwwiiNJBJCrIAniFRcPV5oUMxGq6pSKS+C8we9dQVYJeqs31PEVfh7OJCrDk5qzZ
         kkAsNTyRK/xm+adVHFq0hDMVmZk5VJvLjIfGH74/yaw7SgF0YcjLEwr8E3aZAX3T9xiR
         53jxocs45Vov1uvdQf6lciCl9X1+6VBL9rhCuiJ+Zx0yt4Tbg8dj3d5ClZtft5gco8tQ
         XGMFFjNbxxvyf13Ob/4OwlCEwAe3zE+fyq7bbAhXKtvaT2bGKWnSDDtwjO1fV0Z3egJv
         aybQ==
X-Gm-Message-State: APjAAAUlEQfhLg/l39s+pi7/dXeFlzs0U6rporssp8iC349AjpRW6T1z
        SIXn4lHAUprOdyo9iRhQFUlBJg==
X-Google-Smtp-Source: APXvYqyWCx2wwO3RZDWC6w+KkvtMx9THHvgIOX7vkYR2WNfySgWalTTwUj9doH3hsQm+oago2gRGvg==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr23816885pjq.89.1560201505577;
        Mon, 10 Jun 2019 14:18:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id a7sm10762032pgj.42.2019.06.10.14.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:18:24 -0700 (PDT)
From:   davidriley@chromium.org
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v2 3/4] drm/virtio: Fix cache entry creation race.
Date:   Mon, 10 Jun 2019 14:18:09 -0700
Message-Id: <20190610211810.253227-4-davidriley@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

