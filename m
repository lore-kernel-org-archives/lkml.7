Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22759C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5322082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDJVWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:22:45 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:54300 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDJVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:22:45 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B730A80DBA;
        Wed, 10 Apr 2019 23:22:41 +0200 (CEST)
Date:   Wed, 10 Apr 2019 23:22:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/bochs: use simple display pipe
Message-ID: <20190410212240.GA31691@ravnborg.org>
References: <20190410074828.10296-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410074828.10296-1-kraxel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=R4mCt31-z0I4RcOTawAA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

>  
>  #include <drm/drm_gem.h>
>  
> @@ -69,9 +70,8 @@ struct bochs_device {
>  	struct edid *edid;
>  
>  	/* drm */
> -	struct drm_device  *dev;
> -	struct drm_crtc crtc;
> -	struct drm_encoder encoder;
> +	struct drm_device *dev;
> +	struct drm_simple_display_pipe pipe;
>  	struct drm_connector connector;

Have you considered to embed drm_device in the bochs_device struct?
This is the new way to do it.

This should likely be a follow-up patch...

Rest of the patch looked good.
Did not do a proper review but you can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
