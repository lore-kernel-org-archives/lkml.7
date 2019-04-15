Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73505C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD920651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356157;
	bh=pQYJmHJT7PBNeH2DZM8AKGRrSD7/IDnhcH7KXwxPyTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnlM6bfCP3Vj1SElYugVe9Vxw7TdNTes8G+NxzIKkGjDrp4lDgIejq72keQegzmwq
	 5BMG66LRQ5X8j2L6t+sUij8W8qlaXVrWziqf5gXtRmR+4UwF9oofZkQyKQMVgMZyme
	 bvMOaiLbND8ivnvqaERSjp1CaWiFLb+eeBBSTvIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfDOTWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbfDOTIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082942087C;
        Mon, 15 Apr 2019 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355286;
        bh=pQYJmHJT7PBNeH2DZM8AKGRrSD7/IDnhcH7KXwxPyTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpbDuz/KwJ1E7reAEnE9v7xEd35WjDVP0hhISvnfVNTR7XKubManiDjt/v4eOn0RL
         GqOwQxygyzjPTt5EOSpylBc74YanyK9WcqQZJkUj2RpnziYUnWK0fV8tqdQViTaLrC
         hL84Ftu2ToqbqyyAZ5Uu4BlxHzT75f9UPtVYTlPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.19 061/101] drm/udl: add a release method and delay modeset teardown
Date:   Mon, 15 Apr 2019 20:58:59 +0200
Message-Id: <20190415183743.729868656@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Airlie <airlied@redhat.com>

commit 9b39b013037fbfa8d4b999345d9e904d8a336fc2 upstream.

If we unplug a udl device, the usb callback with deinit the
mode_config struct, however userspace will still have an open
file descriptor and a framebuffer on that device. When userspace
closes the fd, we'll oops because it'll try and look stuff up
in the object idr which we've destroyed.

This punts destroying the mode objects until release time instead.

Cc: stable@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190405031715.5959-2-airlied@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_drv.c  |    1 +
 drivers/gpu/drm/udl/udl_drv.h  |    1 +
 drivers/gpu/drm/udl/udl_main.c |    8 +++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -51,6 +51,7 @@ static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
 	.load = udl_driver_load,
 	.unload = udl_driver_unload,
+	.release = udl_driver_release,
 
 	/* gem hooks */
 	.gem_free_object_unlocked = udl_gem_free_object,
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -104,6 +104,7 @@ void udl_urb_completion(struct urb *urb)
 
 int udl_driver_load(struct drm_device *dev, unsigned long flags);
 void udl_driver_unload(struct drm_device *dev);
+void udl_driver_release(struct drm_device *dev);
 
 int udl_fbdev_init(struct drm_device *dev);
 void udl_fbdev_cleanup(struct drm_device *dev);
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -378,6 +378,12 @@ void udl_driver_unload(struct drm_device
 		udl_free_urb_list(dev);
 
 	udl_fbdev_cleanup(dev);
-	udl_modeset_cleanup(dev);
 	kfree(udl);
 }
+
+void udl_driver_release(struct drm_device *dev)
+{
+	udl_modeset_cleanup(dev);
+	drm_dev_fini(dev);
+	kfree(dev);
+}


