Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C84C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1C20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139055;
	bh=RSboMfHQ+qEjwa1+a/GyWSyG0GmvuI9fLVSGvbR+Tzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ry6spAqzRee0yaI0lS3AKnSIUwhgUWnD6IL3Shm6SdC3bVdZxt6CPqkT+iKz+xAFm
	 UnIeae7l7jo4pybgcBRMAevTdv6VrhAIY434AgDfEfkXq9mhM5FeGLQU4mYBCbutVv
	 Q4CnYTRKFL9VEJ/6QoeBUcK/zUMSB1abS1zbyPwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfDARRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbfDARR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C468720856;
        Mon,  1 Apr 2019 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139048;
        bh=RSboMfHQ+qEjwa1+a/GyWSyG0GmvuI9fLVSGvbR+Tzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U456mb/tPcVFWvlgzmTYTrWdqmV5O56n8mUM9ycvxutcjMzcIWacVyS3kXWM6SoPj
         YzmCHKNyBrIKGbBN0p7VqmfAxB3Hz6d6ba1EZdoYzOBrQywetuoGPQrVF2m9vQ0N2+
         oICehKI9HEvq7en96iv0/926hg+MSjxTBsotgsEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Biggers <ebiggers@google.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.19 097/134] drm/vgem: fix use-after-free when drm_gem_handle_create() fails
Date:   Mon,  1 Apr 2019 19:02:13 +0200
Message-Id: <20190401170053.340382505@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 21d2b122732318b48c10b7262e15595ce54511d3 upstream.

If drm_gem_handle_create() fails in vgem_gem_create(), then the
drm_vgem_gem_object is freed twice: once when the reference is dropped
by drm_gem_object_put_unlocked(), and again by __vgem_gem_destroy().

This was hit by syzkaller using fault injection.

Fix it by skipping the second free.

Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
Fixes: af33a9190d02 ("drm/vgem: Enable dmabuf import interfaces")
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190226214451.195123-1-ebiggers@kernel.org
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vgem/vgem_drv.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -191,13 +191,9 @@ static struct drm_gem_object *vgem_gem_c
 	ret = drm_gem_handle_create(file, &obj->base, handle);
 	drm_gem_object_put_unlocked(&obj->base);
 	if (ret)
-		goto err;
+		return ERR_PTR(ret);
 
 	return &obj->base;
-
-err:
-	__vgem_gem_destroy(obj);
-	return ERR_PTR(ret);
 }
 
 static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device *dev,


