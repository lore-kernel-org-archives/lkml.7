Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A620650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QedqKnSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfKAO73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:59:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43449 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKAO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:59:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id f25so7746250edw.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5ZzLP/IcCz7TftSNBIQxjV0PGw5DJLdvIlhpSJMVoA=;
        b=QedqKnSYIBI1TPjEsN8ylW1vOKDJi41jkAYqG3biOAyV6DI5UHugXyFk2o0phw8iDD
         H5dzNn19X25GY7nRMCmsYFvHVmZufMiBlowWn0kKH7I6FjvnnHj4NSRDvEpi4MRVGdyM
         qdAhhDgdATXQ4U6qexB0FM3w309vB1ou2hKP7WtkiJiE+6KGxQziWivu4IbB944T8S7e
         GIUL79sdIssWr6uu561dKnfLelYxlRrOHravyJ4wkRnAGj7fYlUTw3JMz3wet3GhruQH
         ZyHKNVl4M16FnXO2knoaD2BlLYdned+X4AIwEH0UE+Ylk/H68egUtjFV908T4BPeE++L
         0RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5ZzLP/IcCz7TftSNBIQxjV0PGw5DJLdvIlhpSJMVoA=;
        b=CsqWPHLg1G5XvhOS4kD8HKy6HvVk520uJtbpQxJfaP5qT42giB4P+Vs+Ph+Qz9kPKz
         y7jpBozfyXBtca9JIRwP8Lga/bLaJ7/k6MkEsTLDv5O48YEPRTm6eOwVmADDUo3dXK9n
         Iu1yB7itKdnjcdmVH+ZkQVWc2RloWr8kBqefJeUpYGE6I4M/7NFzFvveBaqTirxHmGGh
         3ce3M20TMtpQKHlmxFHx4Rnw/rIB3IBgncxZ0HcbYiAq3YG4V9KXGo4g29Qi8hDitkOj
         7pEGsUsYPjQNo5kGuM8bJ8tjkonVJ4CZI7D6kTtTYJtCKFzMVJELRgYVaf6c7+ZMGW3L
         87Xw==
X-Gm-Message-State: APjAAAVFLsvB1XLrtO4HDbp6ngvuTGgOw6rmrXhN6ulgKylnps9P+X1G
        A56nwpAT5SXEQ9HjAjJKpAwtKmB4okUgdOr2OanbMQ==
X-Google-Smtp-Source: APXvYqwKN33wqnhYQ6zjc9fRS5U7y8tu5i9hU+zOvQ1N1rpgbf7lLDHtTBFBCxCXui0arOL/mtlwoAGwOvCEshKFzqg=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr10220299ejb.90.1572620367138;
 Fri, 01 Nov 2019 07:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191031223641.19208-1-robdclark@gmail.com> <7b97af56-be9b-ed2e-f692-36433a889d6e@linux.intel.com>
In-Reply-To: <7b97af56-be9b-ed2e-f692-36433a889d6e@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 1 Nov 2019 07:59:16 -0700
Message-ID: <CAF6AEGs9CwDLv7O4ymvTsK1+Bjopy8Q+DzOqqfeW9jM=n5beUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic: swap_state should stall on cleanup_done
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 7:47 AM Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
>
> Op 31-10-2019 om 23:36 schreef Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Stalling on cleanup_done ensures that any atomic state related to a
> > nonblock commit no longer has dangling references to per-object state
> > that can be freed.
> >
> > Otherwise, if a !nonblock commit completes after a nonblock commit has
> > swapped state (ie. the synchronous part of the nonblock commit comes
> > before the !nonblock commit), but before the asynchronous part of the
> > nonblock commit completes, what was the new per-object state in the
> > nonblock commit can be freed.
> >
> > This shows up with the new self-refresh helper, as _update_avg_times()
> > dereferences the original old and new crtc_state.
> >
> > Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Other possibilities:
> > 1) maybe block later before freeing atomic state?
> > 2) refcount individual per-object state
> >
> >  drivers/gpu/drm/drm_atomic_helper.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 3ef2ac52ce94..a5d95429f91b 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -2711,7 +2711,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
> >                       if (!commit)
> >                               continue;
> >
> > -                     ret = wait_for_completion_interruptible(&commit->hw_done);
> > +                     ret = wait_for_completion_interruptible(&commit->cleanup_done);
> >                       if (ret)
> >                               return ret;
> >               }
> > @@ -2722,7 +2722,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
> >                       if (!commit)
> >                               continue;
> >
> > -                     ret = wait_for_completion_interruptible(&commit->hw_done);
> > +                     ret = wait_for_completion_interruptible(&commit->cleanup_done);
> >                       if (ret)
> >                               return ret;
> >               }
> > @@ -2733,7 +2733,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
> >                       if (!commit)
> >                               continue;
> >
> > -                     ret = wait_for_completion_interruptible(&commit->hw_done);
> > +                     ret = wait_for_completion_interruptible(&commit->cleanup_done);
> >                       if (ret)
> >                               return ret;
> >               }
>
> Nack, hw_done means all new_crtc_state (from the old commit pov) dereferences are done.
>

hmm, it would be nice if the for_each_blah_in_state() iterators would
splat on incorrect usage, then..  it tool a while to track down what
was going wrong.  And Sean claimed the self refresh helpers worked for
him on rockchip/i915 (although I'm starting to suspect maybe he just
didn't have enough debug options enabled to poison freed memory?)

> Self refresh helpers should be fixed. :)

Looks like what they need out of crtc_state is pretty minimal, maybe
they could extract out crtc_state->self_refresh_active earlier..

BR,
-R
