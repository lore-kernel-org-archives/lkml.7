Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD685C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC5A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392882AbfFMQrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:47:09 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:53141 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfFMFEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:04:11 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 81A992001E;
        Thu, 13 Jun 2019 07:04:05 +0200 (CEST)
Date:   Thu, 13 Jun 2019 07:04:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Drop use of DRM_WAIT_ON() [Was: drm/drm_vblank: Change EINVAL by the
 correct errno]
Message-ID: <20190613050403.GA21502@ravnborg.org>
References: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=7gkXJVJtAAAA:8 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8
        a=Jn-_o28iN5fng-a6wa4A:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo.

On Wed, Jun 12, 2019 at 11:10:54PM -0300, Rodrigo Siqueira wrote:
> For historical reason, the function drm_wait_vblank_ioctl always return
> -EINVAL if something gets wrong. This scenario limits the flexibility
> for the userspace make detailed verification of the problem and take
> some action. In particular, the validation of “if (!dev->irq_enabled)”
> in the drm_wait_vblank_ioctl is responsible for checking if the driver
> support vblank or not. If the driver does not support VBlank, the
> function drm_wait_vblank_ioctl returns EINVAL which does not represent
> the real issue; this patch changes this behavior by return EOPNOTSUPP.
> Additionally, some operations are unsupported by this function, and
> returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> libdrm, which is used by many compositors; because of this, it is
> important to check if this change breaks any compositor. In this sense,
> the following projects were examined:
> 
> * Drm-hwcomposer
> * Kwin
> * Sway
> * Wlroots
> * Wayland-core
> * Weston
> * Xorg (67 different drivers)
> 
> For each repository the verification happened in three steps:
> 
> * Update the main branch
> * Look for any occurrence "drmWaitVBlank" with the command:
>   git grep -n "drmWaitVBlank"
> * Look in the git history of the project with the command:
>   git log -SdrmWaitVBlank
> 
> Finally, none of the above projects validate the use of EINVAL which
> make safe, at least for these projects, to change the return values.
> 
> Change since V2:
>  Daniel Vetter and Chris Wilson
>  - Replace ENOTTY by EOPNOTSUPP
>  - Return EINVAL if the parameters are wrong
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
> Update:
>   Now IGT has a way to validate if a driver has vblank support or not.
>   See: https://gitlab.freedesktop.org/drm/igt-gpu-tools/commit/2d244aed69165753f3adbbd6468db073dc1acf9A
> 
>  drivers/gpu/drm/drm_vblank.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 0d704bddb1a6..d76a783a7d4b 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1578,10 +1578,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>  	unsigned int flags, pipe, high_pipe;
>  
>  	if (!dev->irq_enabled)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	if (vblwait->request.type &
>  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |

When touching this function, could I ask you to take a look at
eliminating the use of DRM_WAIT_ON()?
It comes from the deprecated drm_os_linux.h header, and it is only of
the few remaining users of DRM_WAIT_ON().

Below you can find my untested first try - where I did an attempt not to
change behaviour.

	Sam

commit 17b119b02467356198b57bca9949b146082bcaa1
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Thu May 30 09:38:47 2019 +0200

    drm/vblank: drop use of DRM_WAIT_ON()
    
    DRM_WAIT_ON() is from the deprecated drm_os_linux header and
    the modern replacement is the wait_event_*.
    
    The return values differ, so a conversion is needed to
    keep the original interface towards userspace.
    Introduced a switch/case to make code obvious and to allow
    different debug prints depending on the result.
    
    The timeout value of 3 * HZ was translated to 30 msec
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    Cc: Maxime Ripard <maxime.ripard@bootlin.com>
    Cc: Sean Paul <sean@poorly.run>
    Cc: David Airlie <airlied@linux.ie>
    Cc: Daniel Vetter <daniel@ffwll.ch>

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 0d704bddb1a6..51fc6b106333 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -31,7 +31,6 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
-#include <drm/drm_os_linux.h>
 #include <drm/drm_vblank.h>
 
 #include "drm_internal.h"
@@ -1668,18 +1667,27 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 	if (req_seq != seq) {
 		DRM_DEBUG("waiting on vblank count %llu, crtc %u\n",
 			  req_seq, pipe);
-		DRM_WAIT_ON(ret, vblank->queue, 3 * HZ,
-			    vblank_passed(drm_vblank_count(dev, pipe),
-					  req_seq) ||
-			    !READ_ONCE(vblank->enabled));
+		ret = wait_event_interruptible_timeout(vblank->queue,
+			vblank_passed(drm_vblank_count(dev, pipe), req_seq) ||
+				      !READ_ONCE(vblank->enabled),
+			msecs_to_jiffies(30));
 	}
 
-	if (ret != -EINTR) {
+	switch (ret) {
+	case 1:
+		ret = 0;
 		drm_wait_vblank_reply(dev, pipe, &vblwait->reply);
-
 		DRM_DEBUG("crtc %d returning %u to client\n",
 			  pipe, vblwait->reply.sequence);
-	} else {
+		break;
+	case 0:
+		ret = -EBUSY;
+		drm_wait_vblank_reply(dev, pipe, &vblwait->reply);
+		DRM_DEBUG("timeout waiting for vblank. crtc %d returning %u to client\n",
+			  pipe, vblwait->reply.sequence);
+		break;
+	default:
+		ret = -EINTR;
 		DRM_DEBUG("crtc %d vblank wait interrupted by signal\n", pipe);
 	}
 
