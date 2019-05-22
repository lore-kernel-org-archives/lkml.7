Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E5C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F41920856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CfYeCurN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfEVKib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:38:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35872 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbfEVKia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:38:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id y124so1218773oiy.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6wg+K+WgL8DG2zwYLLZfjFG8NTa66iAHPjSVdCuEsY=;
        b=CfYeCurNCDn3hjO3u+qMUfNRL8mmvk/0/jcHv9r7SPKY4JNDX3NteV015dcJVd9TK8
         SIW4fXoGb9TFfWFqeFvDoP/3nZX/90MMyKwi0UaTZ6KePlwPAzcuJCSRHMJzg54SCKkI
         y9ZLrtCLN4J1Zw1wVyMLAy9yHyGGEaNg8ZM5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6wg+K+WgL8DG2zwYLLZfjFG8NTa66iAHPjSVdCuEsY=;
        b=fjbr22ctaRcMaTVLAnhXMybwqUhXRu6SiM8ByjMS1g5K/QTE3GukCAwZAWd/LhjEK/
         TpLdXs4dwv58rhyy2VwQ8FhQPPcef30a+uSWhiafbx0B4DRsxqy9iYUn8eD3cWthqTz/
         KJX4FaiRsWR9OvI4cgS8aK20sjlfvUR23DOWRSdalJqT/kzGvQGlp8nKBV5c7bU8/YJo
         hpywB22FAaENqAPQMlPhp/BFA+WYUDusZX51iMAqw7dkJzzfzcaQfqt42Vr/iFbHg10i
         eOds9VJYIAX1tcMCVrdxqUIXcrqdmWplMBV5jurDgHv1RHvGDNU88uhG9LAARNPhR/pp
         ak3g==
X-Gm-Message-State: APjAAAWpB5zDGYApCHeYi0Lmgu36ptyTt3r6wfbg9/as4ZqyqWr0OtxF
        Uvo8iM3KVrC9Qi+MaN3qeZo+msHlwWKNaVKiGCKwCw==
X-Google-Smtp-Source: APXvYqwllTuVFaRTom2Ip1w7DVtCIKIg6vGydfbmkMa8+rELmqaShoNcHtv/A67nH461Y6ux1PJV6d4Wlcb3hog8J/0=
X-Received: by 2002:aca:e4c8:: with SMTP id b191mr6914932oih.110.1558521509592;
 Wed, 22 May 2019 03:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190520082216.26273-10-daniel.vetter@ffwll.ch>
 <CGME20190521142317epcas2p44d184ead3ec7d514a8fa6784abf30747@epcas2p4.samsung.com>
 <20190521142304.9652-1-daniel.vetter@ffwll.ch> <6b9747cf-8845-0eb9-878e-f2953665fcec@samsung.com>
In-Reply-To: <6b9747cf-8845-0eb9-878e-f2953665fcec@samsung.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 22 May 2019 12:38:18 +0200
Message-ID: <CAKMK7uGKxny2cM9wPBvu9jRUKR0KP2OOHa8qAsReNsKWTvscAA@mail.gmail.com>
Subject: Re: [PATCH] fbcon: Remove fbcon_has_exited
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:04 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> Hi Daniel,
>
> On 5/21/19 4:23 PM, Daniel Vetter wrote:
> > This is unused code since
> >
> > commit 6104c37094e729f3d4ce65797002112735d49cd1
> > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date:   Tue Aug 1 17:32:07 2017 +0200
> >
> >     fbcon: Make fbcon a built-time depency for fbdev
> >
> > when fbcon was made a compile-time static dependency of fbdev. We
> > can't exit fbcon anymore without exiting fbdev first, which only works
> > if all fbdev drivers have unloaded already. Hence this is all dead
> > code.
> >
> > v2: I missed that fbcon_exit is also called from con_deinit stuff, and
> > there fbcon_has_exited prevents double-cleanup. But we can fix that
> > by properly resetting con2fb_map[] to all -1, which is used everywhere
> > else to indicate "no fb_info allocate to this console". With that
> > change the double-cleanup (which resulted in a module refcount underflo=
w,
> > among other things) is prevented.
> >
> > Aside: con2fb_map is a signed char, so don't register more than 128 fb_=
info
> > or hilarity will ensue.
> >
> > v3: CI showed me that I still didn't fully understand what's going on
> > here. The leaked references in con2fb_map have been used upon
> > rebinding the fb console in fbcon_init. It worked because fbdev
> > unregistering still cleaned out con2fb_map, and reset it to info_idx.
> > If the last fbdev driver unregistered, then it also reset info_idx,
> > and unregistered the fbcon driver.
> >
> > Imo that's all a bit fragile, so let's keep the con2fb_map reset to
> > -1, and in fbcon_init pick info_idx if we're starting fresh. That
> > means unbinding and rebinding will cleanse the mapping, but why are
> > you doing that if you want to retain the mapping, so should be fine.
> >
> > Also, I think info_idx =3D=3D -1 is impossible in fbcon_init - we
> > unregister the fbcon in that case. So catch&warn about that.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> > Cc: Yisheng Xie <ysxie@foxmail.com>
> > Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
> > Cc: Prarit Bhargava <prarit@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 39 +++++---------------------------
> >  1 file changed, 6 insertions(+), 33 deletions(-)
> This patch was #09/33 in your patch series, now it is independent change.
>
> Do you want me to apply it now or should I wait for the new version of
> the whole series?

It's an in-reply-to replacement for the totally broken one, so that
patchwork picks things up correctly (and therefore our CI). I'm not
sure how far that convention is used beyond dri-devel ...

I did fix up all the issues pointed out thus far, but I haven't fully
appeased our CI just yet. Once that's done I'll resend.

Thanks, Daniel

> [ I looked at all patches in the series and they look fine to me.
>   After outstanding issues are fixed I'll be happy to apply them all
>   to fbdev-for-next (I can create immutable branch if needed). ]
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
