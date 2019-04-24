Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E1AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881BA2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJgLC5S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfDXTcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:32:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33127 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbfDXTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:32:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so157729wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BM0o59w29LzTOtXYJkT+N2fBAMozkK2J2RQoo1XWQdg=;
        b=zJgLC5S4jeK7p8VX3r8/2P49VBXIrNhjElVmFgl48faRKOwa9N9Eu7F3KERsx7eE8X
         TL3cxg90a8Cm8nnsL8aOHDieoRWVIVrP7W0tyvfi7LCZCnq4qDc7bQM+7XA2mVzMMRSJ
         UJPpY3uecsoGrg97QIg77CV7JqvGuUfxKik6a8vT68LmS0UU1WPscDSgO6DyEzN/C4ct
         Fsg2SFB+DsyHOzO0ap5NMCRL1VxBMJgV2heu1L7LHkQzyLPYPan9wMFgz1MRTpnHyiOd
         ILgTOURNZiNPMRSs5+QKRh3Sf/2oSJtEbpH57AI5G1JRPiBmJIG0iXPGRkHpO3QGwMYW
         6PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BM0o59w29LzTOtXYJkT+N2fBAMozkK2J2RQoo1XWQdg=;
        b=pUd0u9wa7EwZREwZQpcWP2QKVoTjX8xDXbR6UmSPXijgCdge8YuX0dxpgd298mBD6o
         iHtaoa9PLoomPMV42Vq77DBmyWItFa0x0TLptLGwBLT7Q+VRItCIAx1duEuoTzuK2UqG
         s7vSnmaRus+xNLvn0nGdkxdI7lqh1K1aIEBU8i3BZwTz7dM/YxkiNZz9QukJtwkJWXGC
         Dhf2s1iwDbTorXm5G+OtTHgB4B38rCQHRBhp5ZSop6QbqfzU+nHVH9NEO+Vcgpfg6Rw7
         TcJ970eAZ3lIagKXpcU8jPl1U2LZjFbtlVRtIknFfSb7U5glkiKatzd6XHR8tURc+4H8
         JG2A==
X-Gm-Message-State: APjAAAW3ujqbZns1k1taOUA/CjNTR4XTyn/JxG5VKlh7mJTsB3/s/5xr
        7gHdjjeIpE3Du+2u9sUF0YdpSWoJfrRIKOgu7Gt5ng==
X-Google-Smtp-Source: APXvYqx2mYf77kZByumpYyncTnogPY+3TP9zTFTzgDGqBf5npj96JwGDwpDksc237hOmqDfrRi1RjIIAa3AGm3a17f8=
X-Received: by 2002:a7b:c115:: with SMTP id w21mr504911wmi.55.1556134369539;
 Wed, 24 Apr 2019 12:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-25-git-send-email-john.stultz@linaro.org> <20190424170910.GC21067@ravnborg.org>
In-Reply-To: <20190424170910.GC21067@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 12:32:38 -0700
Message-ID: <CALAqxLWmrabPxnpN7T_9KCLNrpzj0dnzbNs8vLhz+GBGyRxp_Q@mail.gmail.com>
Subject: Re: [PATCH 24/25] drm: kirin: Pass driver data to crtc init and plane init
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:09 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Apr 23, 2019 at 04:20:55PM -0700, John Stultz wrote:
> >  static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> > -                      struct drm_plane *plane)
> > +                             struct drm_plane *plane,
> > +                             const struct kirin_drm_data *driver_data)
>
> Indent looks wrong here.
>
..
> >       ret = drm_universal_plane_init(dev, &kplane->base, 1,
> > +                             driver_data->plane_funcs,
> > +                             driver_data->channel_formats,
> > +                             driver_data->channel_formats_cnt,
> > +                             NULL, type, NULL);
> Indent looks wrong here.

Thanks! I've now fixed those up.

> I missed where ade_driver_data came from.
> This looks an extra patch to intoduce driver_data,
> that maybe should be merged with an earlier version?

I'm not sure I'm following you here. Can you clarify a bit more?

thanks
-john
