Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ADAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939642073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355688;
	bh=Q+jh8GSnk2gMzsHIfh+S60MXUdJtLyPwB6ZmMysJz0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRKqcuhhfzr7s1qTHSWqesopGP4glaIFZKkMK7aIQsaqwUDw5NZ+sZgDf/lYkRxkN
	 ZS2eL/SPUNkp0EHdCsNiwcL865xEg9H0j0iAfSyHoQNOeWO9fbXTb6CqrdHLTnggG2
	 8axeAJy3OJM0usWYCN0ifIXi7zd1ZSHor1Inroos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfDOTOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbfDOTOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9A8218DA;
        Mon, 15 Apr 2019 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355674;
        bh=Q+jh8GSnk2gMzsHIfh+S60MXUdJtLyPwB6ZmMysJz0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/sw2JOM8rDXuscw2lD5fm9qNj5pZXWY3Atsnf/on3nrqEMc168izb7cNLru9/mkM
         A5yBgMyhzI5lXhAqITaHwLaaKCGmAB1lw3ZPG22SUn24FkLutf90znN7TYxI/r4SeF
         QswgJuWUZoT5H6LTM89BLzmQAkvwcielx+j4K4lM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 5.0 117/117] drm/virtio: do NOT reuse resource ids
Date:   Mon, 15 Apr 2019 21:01:27 +0200
Message-Id: <20190415183750.700572385@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerd Hoffmann <kraxel@redhat.com>

commit 16065fcdd19ddb9e093192914ac863884f308766 upstream.

Bisected guest kernel changes crashing qemu.  Landed at
"6c1cd97bda drm/virtio: fix resource id handling".  Looked again, and
noticed we where not only leaking *some* ids, but *all* ids.  The old
code never ever called virtio_gpu_resource_id_put().

So, commit 6c1cd97bda effectively makes the linux kernel starting
re-using IDs after releasing them, and apparently virglrenderer can't
deal with that.  Oops.

This patch puts a temporary stopgap into place for the 5.0 release.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190208140409.15280-1-kraxel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/virtio/virtgpu_object.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -28,10 +28,21 @@
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
+#if 0
 	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
+#else
+	static int handle;
+
+	/*
+	 * FIXME: dirty hack to avoid re-using IDs, virglrenderer
+	 * can't deal with that.  Needs fixing in virglrenderer, also
+	 * should figure a better way to handle that in the guest.
+	 */
+	handle++;
+#endif
 
 	*resid = handle + 1;
 	return 0;
@@ -39,7 +50,9 @@ static int virtio_gpu_resource_id_get(st
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
+#if 0
 	ida_free(&vgdev->resource_ida, id - 1);
+#endif
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)


