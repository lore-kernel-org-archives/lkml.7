Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE09CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB906208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfF1MKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:10:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54026 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfF1MKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:10:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id D1E8C263955
Message-ID: <ee19affecdd64b1f835d193ae742b4f084335b93.camel@collabora.com>
Subject: Re: [PATCH v4 1/2] drm/vblank: warn on sending stale event
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Date:   Fri, 28 Jun 2019 13:10:14 +0100
In-Reply-To: <66e100219a2740e493a7b96ebb95d0a2e697f121.1561722822.git.bob.beckett@collabora.com>
References: <cover.1561722822.git.bob.beckett@collabora.com>
         <66e100219a2740e493a7b96ebb95d0a2e697f121.1561722822.git.bob.beckett@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nak - I forgot the requested doc changes. Ill re-send

On Fri, 2019-06-28 at 13:05 +0100, Robert Beckett wrote:
> Warn when about to send stale vblank info and add advice to
> documentation on how to avoid.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c
> b/drivers/gpu/drm/drm_vblank.c
> index 603ab105125d..7dabb2bdb733 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -918,6 +918,19 @@ EXPORT_SYMBOL(drm_crtc_arm_vblank_event);
>   *
>   * See drm_crtc_arm_vblank_event() for a helper which can be used in
> certain
>   * situation, especially to send out events for atomic commit
> operations.
> + *
> + * Care should be taken to avoid stale timestamps. If:
> + *   - your driver has vblank support (i.e. dev->num_crtcs > 0)
> + *   - the vblank irq is off (i.e. no one called
> drm_crtc_vblank_get)
> + *   - from the vblank code's pov the pipe is still running (i.e.
> not
> + *     in-between a drm_crtc_vblank_off()/on() pair)
> + * If all of these conditions hold then drm_crtc_send_vblank_event
> is
> + * going to give you a garbage timestamp and and sequence number
> (the last
> + * recorded before the irq was disabled). If you call
> drm_crtc_vblank_get/put
> + * around it, or after vblank_off, then either of those will have
> rolled things
> + * forward for you.
> + * So, drivers should call drm_crtc_vblank_off() before this
> function in their
> + * crtc atomic_disable handlers.
>   */
>  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
>  				struct drm_pending_vblank_event *e)
> @@ -925,8 +938,12 @@ void drm_crtc_send_vblank_event(struct drm_crtc
> *crtc,
>  	struct drm_device *dev = crtc->dev;
>  	u64 seq;
>  	unsigned int pipe = drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
>  	ktime_t now;
>  
> +	WARN_ONCE(dev->num_crtcs > 0 && !vblank->enabled && !vblank-
> >inmodeset,
> +		  "sending stale vblank info\n");
> +
>  	if (dev->num_crtcs > 0) {
>  		seq = drm_vblank_count_and_time(dev, pipe, &now);
>  	} else {

