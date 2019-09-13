Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8824FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582A420693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbfIMWUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:20:37 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44049 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbfIMWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:20:37 -0400
Received: by mail-vs1-f68.google.com with SMTP id w195so19627083vsw.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ltRJY4t6aZ+8Y8iUEUcLfwwWLnNXssGvbScXo986/0=;
        b=eP+fekKQN2DRc1QEws5rG6tknSb8bR6ZiskK8JCCrKUQcgiFtNidQsI2xbxI3LuDWA
         /Kruk7/3eR91colF/KqoVT9vCBQkm4gkJWx9CSMqrn5iOODQ3uQeX1IRFddZ5dgrtK+1
         gEI/shsmDLJXoW3HH8tICJHNMR/AUcWDkN73J5l4y6JOnI4Wg2uYTPvdEG0kVnMCtQJg
         vEz6gsElLmxj26PlDrXkB3locKbiAHVhBE+Hj5wO/UWP1O2yKKfflA4r2l7ycnoCLGnO
         YtWGoYlpgDm7U6669jlrmfHU6xL72tFyfytwAj9MWGUxHs9SrYpcIXsFbsdTlKCyW957
         +pQw==
X-Gm-Message-State: APjAAAWRTbybpQ+LNefTVzHYXC2VUSQC69E9QFGenJ5XirjD2m0/WGx0
        CWvXrWvrdnjBqC+7GbtzNCgX7Q+n5HDazBKpg5Q=
X-Google-Smtp-Source: APXvYqzoXpTZC7xF9ayZaVWto3HDJIBUg3jJxJtNZLaddNjhgg2l9CdLOPu3mZ8Jmj/YXqP1gu1EJiyVZPTrZ9587Kc=
X-Received: by 2002:a67:f451:: with SMTP id r17mr7077490vsn.207.1568413236113;
 Fri, 13 Sep 2019 15:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190913220355.6883-1-lyude@redhat.com> <20190913220355.6883-2-lyude@redhat.com>
In-Reply-To: <20190913220355.6883-2-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 13 Sep 2019 18:20:24 -0400
Message-ID: <CAKb7UvgQE0UDTvvhbq4FgtgOWjvXDDKSZs8RSLA-ECa2YZiFLA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/nouveau: dispnv50: Remove nv50_mstc_best_encoder()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 6:05 PM Lyude Paul <lyude@redhat.com> wrote:
>
> When drm_connector_helper_funcs->atomic_best_encoder is defined,
> ->best_encoder is ignored both by the atomic modesetting helpers. That

By both the atomic modesetting helpers and ... (usually "both" implies 2 things)

> being said, this hook is completely broken anyway - it always returns
> the first msto for a given mstc, despite the fact it might already be in
> use.
>
> So, just get rid of it. We'll need this in a moment anyway, when we make
> mstos per-head as opposed to per-connector.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index b46be8a091e9..a3f350fdfa8c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -920,14 +920,6 @@ nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
>         return &mstc->mstm->msto[head->base.index]->encoder;
>  }
>
> -static struct drm_encoder *
> -nv50_mstc_best_encoder(struct drm_connector *connector)
> -{
> -       struct nv50_mstc *mstc = nv50_mstc(connector);
> -
> -       return &mstc->mstm->msto[0]->encoder;
> -}
> -
>  static enum drm_mode_status
>  nv50_mstc_mode_valid(struct drm_connector *connector,
>                      struct drm_display_mode *mode)
> @@ -990,7 +982,6 @@ static const struct drm_connector_helper_funcs
>  nv50_mstc_help = {
>         .get_modes = nv50_mstc_get_modes,
>         .mode_valid = nv50_mstc_mode_valid,
> -       .best_encoder = nv50_mstc_best_encoder,
>         .atomic_best_encoder = nv50_mstc_atomic_best_encoder,
>         .atomic_check = nv50_mstc_atomic_check,
>  };
> --
> 2.21.0
>
