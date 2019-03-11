Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3772CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0732220449
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfCKGWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfCKGWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:22:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 889A53082AF4;
        Mon, 11 Mar 2019 06:22:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-211.ams2.redhat.com [10.36.116.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 151905D70E;
        Mon, 11 Mar 2019 06:22:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 073BB11A9A; Mon, 11 Mar 2019 07:22:00 +0100 (CET)
Date:   Mon, 11 Mar 2019 07:22:00 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 11 Mar 2019 06:22:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 06:21:50PM -0300, Rodrigo Siqueira wrote:
> When the subtest basic-plain-flip from IGT project was executed on Bochs
> driver, the following bug appears:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000

>  ? drm_atomic_helper_commit_modeset_disables+0x396/0x3e0 [drm_kms_helper]

> +static void  bochs_crtc_atomic_disable(struct drm_crtc *crtc,
> +				       struct drm_crtc_state *old_state)
> +{
> +}
> +
>  static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *old_crtc_state)
>  {
> @@ -66,6 +71,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
>  static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
>  	.mode_set_nofb = bochs_crtc_mode_set_nofb,
>  	.atomic_enable = bochs_crtc_atomic_enable,
> +	.atomic_disable = bochs_crtc_atomic_disable,

Shouldn't we make the callback optional instead of adding empty dummy
functions to drivers?

cheers,
  Gerd

