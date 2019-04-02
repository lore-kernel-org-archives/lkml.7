Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24C9207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFq3bliU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfDBJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:43:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43256 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfDBJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:43:36 -0400
Received: by mail-vs1-f66.google.com with SMTP id i207so7348981vsd.10;
        Tue, 02 Apr 2019 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVFK2/nfa1Y7zwZTbvajIIekUF/axJJ/WuHM1N8l/l0=;
        b=NFq3bliUUYwEDLgqg/dqYv0Fpgh6GuhbFe23GJlotxPaKqJKToZsDp2XIFIczLC3d9
         6Qu7ByAwdx6fczC9gy2MRrk9wP+rXqR2prCBpgxsJqILiQsvNjeGvuEhEDe/SGf25SuB
         B69YERays3UuZ5Ol2m4g1+kVPZElSP8Puub8vogcE/ku9Tjk3mLueVKPJ4OR405k7EXv
         cDYrMgMc6yPEVvgCZQxROr/fOMj0LJwn66Wj3fBcR5PxkXCSXzJcGEM8Gr6ZZp0SmGvb
         2MlSOn0b+M+a87KJGfzVaOi6BVofK8QazeS2cfiWUil4+KmfdUjjThvy0ux4N+7HkgQ5
         uAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVFK2/nfa1Y7zwZTbvajIIekUF/axJJ/WuHM1N8l/l0=;
        b=ic7c9KaJ5HRTUTcva0KdWuzDp40QMY6/Pme+qJsaBg4J9dz920OEC91FcusnjzTXAf
         HLvqLkBdg5kbSkKykHbcTG+vmtelRPWqqPygAu73hL847tk72EGGAmQcs1EKWce0Lkoy
         0dvYx1pw6mDZoFYtYBSHC7+V4hG5elI1x+bWM4g4nDghBWrXeTmmPOpi/tDYB5hBY0sT
         wP4A5IDmbjTBQqXDU6rO6Oo2Ic44+IuxqNsv4mAyFPXxdOMJ8q6t8OZ1d3f/ognkDQU4
         DnsBklu/an5cBsPoci38P78tqAJxoxuTYG0ibF5MHtNO2FGjk603+r7X+yzQK2VA7SkS
         bVlw==
X-Gm-Message-State: APjAAAVFBxR8ed1oKhLsjrFKSNLXegnYwlzce07RyGK86y4buqS1Fdo6
        73chyd5bkms2iT9TEjDJpZO1gk57dKBGUmMnN+I=
X-Google-Smtp-Source: APXvYqys/B0tQs0aYjkwbejZiC6gd3fP52I+yNeCRgDDAsq0kui4wIpq2sow1/NrFj5WuiTs7jIgUCtfqrHaHkXcb24=
X-Received: by 2002:a67:e9cc:: with SMTP id q12mr40767849vso.208.1554198214884;
 Tue, 02 Apr 2019 02:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <fecde1c7b65caa0e876a2f01769289a883014712.1553032382.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <fecde1c7b65caa0e876a2f01769289a883014712.1553032382.git-series.maxime.ripard@bootlin.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Apr 2019 10:43:31 +0100
Message-ID: <CACvgo51WMD5hsyLB5QTriGNwcPmeN4TDjscJV11M3PXFncPHeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] drm: Remove users of drm_format_num_planes
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 19 Mar 2019 at 21:57, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> drm_format_num_planes() is basically a lookup in the drm_format_info table
> plus an access to the num_planes field of the appropriate entry.
>
> Most drivers are using this function while having access to the entry
> already, which means that we will perform an unnecessary lookup. Removing
> the call to drm_format_num_planes is therefore more efficient.
>
> Some drivers will not have access to that entry in the function, but in
> this case the overhead is minimal (we just have to call drm_format_info()
> to perform the lookup) and we can even avoid multiple, inefficient lookups
> in some places that need multiple fields from the drm_format_info
> structure.
>
I'm not fan of the duplicated loop-ups either.

> -int drm_format_num_planes(uint32_t format)
> -{
> -       const struct drm_format_info *info;
> -
> -       info = drm_format_info(format);
> -       return info ? info->num_planes : 1;
> -}
> -EXPORT_SYMBOL(drm_format_num_planes);
> -
The existing users are not updated to cater for the num_planes != 0
case... Which seems non-existent scenario since all the current format
descriptions have 1+ planes.
Should we add a test (alike the ones in 6/20) to ensure, that no entry
has 0 planes? Is it even worth it or I'm a bit too paranoid?

The above comments apply to 2/20.

With the name suggestions by Paul, patches 1 to 5 (incl.) are:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

HTH
Emil
