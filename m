Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBF5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4EC2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="caS1ks0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:58:14 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:38135 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=eFM0G4j+uB/cPBSfX3qK8wS87ggWBWsIWJP58jQ80Qw=;
        b=caS1ks0rRTfnyPgQ1mfBi3Te0MRPP6/36UVQMQlv8u6D7MNref0wjEGHcEpha3glFatpnKF43e+nRQh94b59vNc0UNo4/VJHw8YW9YAnpAfv9PsZiAx3QLz10/gAPYibMxLYyn01Ot+ZUMNgMyrWf+DVykeTKiilWESY7HANxJg+cY3Jb5mcjZiJ7bpelP1TFkDgN0z/5SzN6haweYB3Gka/sP90X+y9OecM/brGqelGTK05hACOTd7FneTmjd8ZEX+jCQBNyIE2HODKb5p/o3Hl/nYvxVMq5i7RPZ2tGPtBhbahGZhGbLlMvCkNnU2Jtqyl6SCeY8QgHQuFaJdxVA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50380 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hBcep-0001Wy-0m; Wed, 03 Apr 2019 11:58:11 +0200
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
 <20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0c959f3a-15e9-8295-dc11-2f6b9a4229ac@tronnes.org>
Date:   Wed, 3 Apr 2019 11:58:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 03.04.2019 10.53, skrev Gerd Hoffmann:
>>> +struct cirrus_device {
>>> +       struct drm_device              *dev;
>>
>> Why not embed drm_device? It's the latest rage :-)
> 
> Sure, can do that.
> 
>>> +void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
>>> +                       struct drm_plane_state *old_state)
>>> +{
>>> +       struct drm_plane_state *state = pipe->plane.state;
>>> +       struct drm_crtc *crtc = &pipe->crtc;
>>> +       struct drm_rect rect;
>>> +
>>> +       if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>>> +               cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
>>> +
>>> +       if (crtc->state->event) {
>>> +               spin_lock_irq(&crtc->dev->event_lock);
>>> +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
>>> +               spin_unlock_irq(&crtc->dev->event_lock);
>>> +               crtc->state->event = NULL;
>>> +       }
>>> +}
> 
>>> +static int cirrus_fb_dirty(struct drm_framebuffer *fb,
>>> +                          struct drm_file *file_priv,
>>> +                          unsigned int flags, unsigned int color,
>>> +                          struct drm_clip_rect *clips,
>>> +                          unsigned int num_clips)
>>> +{
>>> +       struct cirrus_device *cirrus = fb->dev->dev_private;
>>> +
>>> +       if (cirrus->pipe.plane.state->fb != fb)
>>> +               return 0;
>>> +
>>> +       if (num_clips)
>>> +               cirrus_fb_blit_clips(fb, clips, num_clips);
>>> +       else
>>> +               cirrus_fb_blit_fullscreen(fb);
>>> +       return 0;
>>> +}
>>
>> Why not use the dirty helpers and implement dirty rect support in your
>> main plane update function?
> 
> Dirty rect support is already there, see above.
> 
> So I can just remove cirrus_fb_dirty() and hook up
> drm_atomic_helper_dirtyfb() instead.  Easy ;)
> 

You can even use drm_gem_fb_create_with_dirty() instead of
drm_gem_fb_create_with_funcs().

Noralf.

> cheers,
>   Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
