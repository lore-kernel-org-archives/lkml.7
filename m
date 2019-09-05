Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F86C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AB720882
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+wWW+zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfIEBpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:45:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39919 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfIEBpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:45:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so455533oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOF+ZPHpYR3Xq1yEKnmzXHsOmTQNpIQkThMXvnUhVnc=;
        b=L+wWW+zqfhvIK5s50CRQN9eMZcVRT3Jh5t+ZjUc2Wt5L7v0CeTyHEFh6irH8z7niKo
         JCq/2CckgEaRzgtT9BJ1H5qP0GBJ3HtrjQ5Ifn17S2utsp59l/WzQq5YSvZT5GHSBX2O
         KyQ1ybyjX5Yg9SmMRVFTrG5GzXWNkAzVOWFwSCKe53W9eK5VBIsYbCiWGp2XTHUI90BZ
         C0mWjQsrL07iTQ1XvMRKfg9eD8fDoX7qXRzIV56G7N9xhlDdHpBWTj2XPb8DxolG1VM3
         2wY09qTLZTJUmN22H6lJcH0dGsFCQdY0ThP6meYY8D+9zQgHjyJzLMG7xSnjaeD5lbTu
         YwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOF+ZPHpYR3Xq1yEKnmzXHsOmTQNpIQkThMXvnUhVnc=;
        b=NG0m4/47J71iyboBFX01gAJOb1IuO0JWQZdQ5Em4lNSLiKTo/rYeoB2EH2+LG9BhMm
         wv3nCgfY5/MgNKyoqnOyz4ThLo/v1stFcWF53tA7EWT20KJBStq0VFvH7Z6cfVvV94YR
         FroGozIj+2g0up9GV8dVygrwApMBKwpW7VXExvGxrGIQrgrQGyTwwQO0O1MWTPoLyS2h
         AZZ4ZRhW+K+s1DzlMp37IFDXQ4g+8XZ6+sNYIrIizUUMvi5RFCxC7igovpr+3aFe14ey
         vktudnELcghc1BwGmL687r7si/YBrm1tgXwdAbFQVrOxu9hI3ONbR7/UYBe5OSgIWW7x
         86iQ==
X-Gm-Message-State: APjAAAV9SqfHFcCApWatDmhMSIdIqSrCpTIPifsuMDlxg3BYgue7/bqC
        4Dkxq1XIomBkvkUG7OGLhPgvfiYKRs/OvBzCgCKbxg==
X-Google-Smtp-Source: APXvYqzfiqJq/DMGiXcEwCOAMX5aRkF63SEJA1OgBe7uOUrr5rCBSNyt2Orw+TH4LR2eUQun3bC3KcwkSlZ/jlhrL7E=
X-Received: by 2002:aca:f48e:: with SMTP id s136mr746525oih.57.1567647899440;
 Wed, 04 Sep 2019 18:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567492316.git.baolin.wang@linaro.org> <5723d9006de706582fb46f9e1e3eb8ce168c2126.1567492316.git.baolin.wang@linaro.org>
 <878sr442t8.fsf@intel.com>
In-Reply-To: <878sr442t8.fsf@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 5 Sep 2019 09:44:48 +0800
Message-ID: <CAMz4kuJVTaDnDEKD77G_X=iVZf98e3isgSt0w7Yvb+_KnSfc9Q@mail.gmail.com>
Subject: Re: [BACKPORT 4.14.y 1/8] drm/i915/fbdev: Actually configure untiled displays
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, chris@chris-wilson.co.uk,
        airlied@linux.ie, Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 21:19, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Tue, 03 Sep 2019, Baolin Wang <baolin.wang@linaro.org> wrote:
> > From: Chris Wilson <chris@chris-wilson.co.uk>
> >
> > If we skipped all the connectors that were not part of a tile, we would
> > leave conn_seq=0 and conn_configured=0, convincing ourselves that we
> > had stagnated in our configuration attempts. Avoid this situation by
> > starting conn_seq=ALL_CONNECTORS, and repeating until we find no more
> > connectors to configure.
> >
> > Fixes: 754a76591b12 ("drm/i915/fbdev: Stop repeating tile configuration on stagnation")
> > Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20190215123019.32283-1-chris@chris-wilson.co.uk
> > Cc: <stable@vger.kernel.org> # v3.19+
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Please look into the scripts to avoid picking up stuff that has
> subsequently been reverted:

I am very sorry, I missed this patch had been reverted, I will check
why this revert patch was not in our product kernel. Thanks for your
comments.

>
> commit 9fa246256e09dc30820524401cdbeeaadee94025
> Author: Dave Airlie <airlied@redhat.com>
> Date:   Wed Apr 24 10:47:56 2019 +1000
>
>     Revert "drm/i915/fbdev: Actually configure untiled displays"
>
>     This reverts commit d179b88deb3bf6fed4991a31fd6f0f2cad21fab5.
>
>     This commit is documented to break userspace X.org modesetting driver in certain configurations.
>
>     The X.org modesetting userspace driver is broken. No fixes are available yet. In order for this patch to be applied it either needs a config option or a workaround developed.
>
>     This has been reported a few times, saying it's a userspace problem is clearly against the regression rules.
>
>     Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109806
>     Signed-off-by: Dave Airlie <airlied@redhat.com>
>     Cc: <stable@vger.kernel.org> # v3.19+
>
>
>
> BR,
> Jani.
>
>
> > ---
> >  drivers/gpu/drm/i915/intel_fbdev.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
> > index da2d309..14eb8a0 100644
> > --- a/drivers/gpu/drm/i915/intel_fbdev.c
> > +++ b/drivers/gpu/drm/i915/intel_fbdev.c
> > @@ -326,8 +326,8 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
> >                                   bool *enabled, int width, int height)
> >  {
> >       struct drm_i915_private *dev_priv = to_i915(fb_helper->dev);
> > -     unsigned long conn_configured, conn_seq, mask;
> >       unsigned int count = min(fb_helper->connector_count, BITS_PER_LONG);
> > +     unsigned long conn_configured, conn_seq;
> >       int i, j;
> >       bool *save_enabled;
> >       bool fallback = true, ret = true;
> > @@ -345,10 +345,9 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
> >               drm_modeset_backoff(&ctx);
> >
> >       memcpy(save_enabled, enabled, count);
> > -     mask = GENMASK(count - 1, 0);
> > +     conn_seq = GENMASK(count - 1, 0);
> >       conn_configured = 0;
> >  retry:
> > -     conn_seq = conn_configured;
> >       for (i = 0; i < count; i++) {
> >               struct drm_fb_helper_connector *fb_conn;
> >               struct drm_connector *connector;
> > @@ -361,7 +360,8 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
> >               if (conn_configured & BIT(i))
> >                       continue;
> >
> > -             if (conn_seq == 0 && !connector->has_tile)
> > +             /* First pass, only consider tiled connectors */
> > +             if (conn_seq == GENMASK(count - 1, 0) && !connector->has_tile)
> >                       continue;
> >
> >               if (connector->status == connector_status_connected)
> > @@ -465,8 +465,10 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
> >               conn_configured |= BIT(i);
> >       }
> >
> > -     if ((conn_configured & mask) != mask && conn_configured != conn_seq)
> > +     if (conn_configured != conn_seq) { /* repeat until no more are found */
> > +             conn_seq = conn_configured;
> >               goto retry;
> > +     }
> >
> >       /*
> >        * If the BIOS didn't enable everything it could, fall back to have the
>
> --
> Jani Nikula, Intel Open Source Graphics Center



-- 
Baolin Wang
Best Regards
