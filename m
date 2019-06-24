Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07DAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7878320820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFXGpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:45:03 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:43903 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFXGpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:45:03 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 02:45:02 EDT
Received: by mail.osadl.at (Postfix, from userid 1001)
        id C37BB5C02F0; Mon, 24 Jun 2019 08:37:18 +0200 (CEST)
Date:   Mon, 24 Jun 2019 08:37:18 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tuomas.tynkkynen@iki.fi,
        inf.braun@fau.de, tobias.buettner@fau.de, hofrat@osadl.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835-camera: Avoid apotential sleep while
 holding a spin_lock
Message-ID: <20190624063718.GD31913@osadl.at>
References: <20190624053351.5217-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624053351.5217-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:33:51AM +0200, Christophe JAILLET wrote:
> Do not allocate memory with GFP_KERNEL when holding a spin_lock, it may
> sleep. Use GFP_NOWAIT instead.
>

checking for this in the rest of the kernel with a cocci spatch
<snip>
virtual report

@nonatomic@
position p;
identifier var;
@@

  spin_lock(...)
  ... when != spin_unlock(...)
* var = idr_alloc@p(...,GFP_KERNEL);
  ... when != spin_unlock(...)
  spin_unlock(...);
<snip>
this seems to be the only instance of this specific problem.

> Fixes: 950fd867c635 ("staging: bcm2835-camera: Replace open-coded idr with a struct idr.")

The GFP_KERNEL actually was there befor this patch so not sure if this Fixes
ref is correct - I think the GFP_KERNEL was introduced in:
4e6bafdfb9f3 ("staging: bcm2835_camera: Use a mapping table for context field of mmal_msg_header")

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>

> ---
>  drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> index 16af735af5c3..438d548c6e24 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> @@ -186,7 +186,7 @@ get_msg_context(struct vchiq_mmal_instance *instance)
>  	 */
>  	spin_lock(&instance->context_map_lock);
>  	handle = idr_alloc(&instance->context_map, msg_context,
> -			   0, 0, GFP_KERNEL);
> +			   0, 0, GFP_NOWAIT);
>  	spin_unlock(&instance->context_map_lock);
>  
>  	if (handle < 0) {
> -- 
> 2.20.1
> 
