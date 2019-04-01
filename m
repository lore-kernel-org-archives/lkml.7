Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05BE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139487;
	bh=oc4mGY9FeABI81VQ2F6/T6V+xpV2n54YYWjCJQvT8tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tIVyNRSUeZprPTSkZ0MjmR8m2GJIHseWh1I00ExP+28UpJPJBZlkiMXRGvQmPGuZG
	 y/H2lzJ4nFVHEX21WNB/3IMkw1NykwSQDcHzyFQXbMr848/F16nEmY00DP2ZFIgCSE
	 JtBEu2w/+NY5FSWcPbymyvK1BUNi5eDLBgTOSpzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfDARYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbfDARYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B78E2063F;
        Mon,  1 Apr 2019 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139483;
        bh=oc4mGY9FeABI81VQ2F6/T6V+xpV2n54YYWjCJQvT8tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAT8Oy7nbi8ljcQta430n4+/yd2IEGu8FBLYEhDUyrf32TiEfFSsfIR85Lwewq5KB
         6WEsGJ2fzqVuwqVtVy5uY+tnA2gOgzuvQzGrHtU6dBFFL9a6xvsEahX1Jlz6RKnHOp
         85nE5rQoRxvuP7KvCrY7bYFDYoCmyb+iIwsyTo6g=
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
Subject: [PATCH 4.14 090/107] drm/vgem: fix use-after-free when drm_gem_handle_create() fails
Date:   Mon,  1 Apr 2019 19:02:45 +0200
Message-Id: <20190401170053.879654244@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -192,13 +192,9 @@ static struct drm_gem_object *vgem_gem_c
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


