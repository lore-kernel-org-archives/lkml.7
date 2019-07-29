Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1BFC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CAB205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430823;
	bh=L+tRwcr+gkZhY0fZr/oRffdokB2aqA3LwmbU+a2UaPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XlgW3tUrUJ3Bz/ecQRVOmROxDrWr/2kQIhfxnAItFkGBeA4wxIZLSXvhR9n/eL/LQ
	 FGPbP5Oeo6AHlO6s7D6HCh7Z5xGuJZOfoA2EUc/lad34YMEmmWMAcIXbgSKEm+tW1W
	 zo7VpIXL2f0b9BZNAUpDDTA4IUYOqs2U4ppMO4dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfG2TkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388834AbfG2TkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:40:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0031A21773;
        Mon, 29 Jul 2019 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429214;
        bh=L+tRwcr+gkZhY0fZr/oRffdokB2aqA3LwmbU+a2UaPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZ/NsHOtpv9gVM/A2QKjBbCT0NVpwn1Ys/9Cih7OesIYZ4DlzQ6MSKOtaGyQh42mg
         vzfkN1nwipdA5zgcd1/i0Aa5tNDJe2iTS2zHYBlHQBU0VcO7BcpTYj7wtA05cfX1nT
         Jm88nJjlnBsNZlkHwX84A7lq64geJG9RupeCavMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Riley <davidriley@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/113] drm/virtio: Add memory barriers for capset cache.
Date:   Mon, 29 Jul 2019 21:21:54 +0200
Message-Id: <20190729190702.363655497@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9ff3a5c88e1f1ab17a31402b96d45abe14aab9d7 ]

After data is copied to the cache entry, atomic_set is used indicate
that the data is the entry is valid without appropriate memory barriers.
Similarly the read side was missing the corresponding memory barriers.

Signed-off-by: David Riley <davidriley@chromium.org>
Link: http://patchwork.freedesktop.org/patch/msgid/20190610211810.253227-5-davidriley@chromium.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7bdf6f0e58a5..8d2f5ded86d6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -528,6 +528,9 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	if (!ret)
 		return -EBUSY;
 
+	/* is_valid check must proceed before copy of the cache entry. */
+	smp_rmb();
+
 	ptr = cache_ent->caps_cache;
 
 copy_exit:
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483d3..c8a581b1f4c4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -588,6 +588,8 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 		    cache_ent->id == le32_to_cpu(cmd->capset_id)) {
 			memcpy(cache_ent->caps_cache, resp->capset_data,
 			       cache_ent->size);
+			/* Copy must occur before is_valid is signalled. */
+			smp_wmb();
 			atomic_set(&cache_ent->is_valid, 1);
 			break;
 		}
-- 
2.20.1



