Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F7A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XL4Yfszo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCRQs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:48:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35845 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCRQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:48:24 -0400
Received: by mail-io1-f65.google.com with SMTP id f6so15085654iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DU0j7gWBwfe7zDyjBs05MgiZSkKZWyXIJCa+ccAxou8=;
        b=XL4YfszorHTM4F1iHrb5JB0fdVp9yf6kG5cHKD5Ks8ekbUmXWIyoaBxMPlRNLJ79c/
         +dLGXRoU7duFICjWKLNn3OhEVxQ7K3UgijjSaMyoX7XjO2DJejYBJvlb+v7ZiubOWtgy
         Tyt4aQkruUtinMfq7fNI7y+WGnR5JV4LBTDYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DU0j7gWBwfe7zDyjBs05MgiZSkKZWyXIJCa+ccAxou8=;
        b=hrWeXOCYy3RClCuYw6kB/06BeotOewNsDIEwvy2LVWGsF/adFqDYc3bRayDTnp1l8f
         ElKqfyAAhR2WuVkxwVlIsGBhWxgPmR52bf3fgzFAxBzsrrH3D46VwIlRwWRjFUBYSVSV
         u8HxI2kU8aCFXjWlle/AEDBja3EUKBov6gr0dPZsvDUXC8om37YLxBdoNCchyv6JeCOG
         9jBr/88DeLjHyItj1L8XdfMJwplozqRSDsuD6M+WWNIwdEnwMyta0Nj4Ass1pKHaj5uW
         9oROPuYRJDwAhPsR3StoyHXp7YBf+hFE5WtRPB02bQc6+3Dc99lsyE3qehiExmiksyZX
         f9hA==
X-Gm-Message-State: APjAAAXNJeFc2DPbnbziwQpu39pBOykOToA/biyBoBoBJILroL9akoKP
        mABTJmEGaK0dlWSWLN5a7CnV0cFWyQi2dB/IgdDrzA==
X-Google-Smtp-Source: APXvYqzuPHY1jkuNIGwTVbjbgMeNmA8zhkwSLwIk+L+/jjHzHRgrvql975Z1F+OpbHgdoj/Kr41vxvg1KQD2lejwSrA=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr11265333iob.114.1552927703397;
 Mon, 18 Mar 2019 09:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-2-jagan@amarulasolutions.com> <c52be751ac1bc7b1ee21e3e2a30d5b494bf95faa.camel@bootlin.com>
In-Reply-To: <c52be751ac1bc7b1ee21e3e2a30d5b494bf95faa.camel@bootlin.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Mar 2019 22:18:11 +0530
Message-ID: <CAMty3ZBOTOR4hHfPE4Ufhb2+VoNJfFQwiii1kti263fi7DEEaQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/6] drm/bridge: Export drm_bridge_detach
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Mar 15, 2019 at 6:58 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Jakan,
>
> On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> > Export drm_bridge_detach from drm bridge core so-that it
> > can use on respective interface or bridge driver while
> > detaching the bridge.
>
> I don't see why this change is required based on the commit log. The
> DRM bridge code clearly indicates that drm_bridge_attach should *not*
> be balanced with a drm_bridge_detach call in the driver, so this seems
> quite wrong.
>
> The DRM core itself should handle detaching the bridge, not the driver.
> Is there any reason why you need to do things differently for DSI?

Yes, you are correct the detach of bridge is being taking care via
drm_encoder_cleanup. This patch exported explicitly, since we need to
taken care bridge detach during unbind even exynos_drm_dsi in other
patch seems using detach by explicitly pointing. so I think the better
approach is to use drm_encoder_cleanup in unbind, what do you say?

Jagan.
