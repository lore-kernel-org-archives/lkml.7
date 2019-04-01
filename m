Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510A2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141623;
	bh=4ChKukL+wvxdqXaHwo+CWoefDZkX74mYvkyybd56718=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0S7GQEtg9ykjfrF+ezWj/NiMiMZE2K2DWZqJSyLA1PKhNz4gSIpGyye0E++9FdEA
	 IvYVa0sOTqwXjLL9j4BLT1bQbGbDN+s8JtPexoxBg2vWNwCQPio/5Ou129mDod2xqc
	 KP4MtLYCIU/rr34h2VFYo6RXLyRUblwfPDsbtFSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfDASAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730824AbfDARRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBD220883;
        Mon,  1 Apr 2019 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139051;
        bh=4ChKukL+wvxdqXaHwo+CWoefDZkX74mYvkyybd56718=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFWuIr0Mw0DdwIPjZehalJIns2dwNx0I9vhqz3GxivLb0c2GajKxXD5rKwnmqs2rX
         Ctn4ydkMVk2/sNaWNIYYfuslfuzfbTsALRREzSazgE4Pvvz1hCG15Ei6TtwWfdznTG
         ZkvQPUmhZSMLZD5C20RTdTTQ3RL345b67YM75TRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Eric Biggers <ebiggers@google.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.19 098/134] drm/vkms: fix use-after-free when drm_gem_handle_create() fails
Date:   Mon,  1 Apr 2019 19:02:14 +0200
Message-Id: <20190401170053.448431437@linuxfoundation.org>
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

commit 36b6c9ed45afe89045973e8dee1b004dd5372d40 upstream.

If drm_gem_handle_create() fails in vkms_gem_create(), then the
vkms_gem_object is freed twice: once when the reference is dropped by
drm_gem_object_put_unlocked(), and again by the extra calls to
drm_gem_object_release() and kfree().

Fix it by skipping the second release and free.

This bug was originally found in the vgem driver by syzkaller using
fault injection, but I noticed it's also present in the vkms driver.

Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190226220858.214438-1-ebiggers@kernel.org
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vkms/vkms_gem.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -110,11 +110,8 @@ struct drm_gem_object *vkms_gem_create(s
 
 	ret = drm_gem_handle_create(file, &obj->gem, handle);
 	drm_gem_object_put_unlocked(&obj->gem);
-	if (ret) {
-		drm_gem_object_release(&obj->gem);
-		kfree(obj);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return &obj->gem;
 }


