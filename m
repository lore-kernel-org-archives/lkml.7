Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44DEC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27BA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDfBZYOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfC0OwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:52:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42549 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfC0OwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:52:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so8618730edc.9;
        Wed, 27 Mar 2019 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEpGIQC5OezqJU8AwwswvJ5tJSp4EH9zwnzBibNlD44=;
        b=kDfBZYOCsfrVcQAgDzL+tYP0Ca79Mbw5Md7oxrrtAYJ+NVY47qDB5pEE74teM0xTtl
         YRDRoPPT8Jf4np/JV/1limIO4SYJYen6Qbel387EMiQwaek/Z0wPW45BrYxY9pjUneOZ
         ESiKMDwjLXB6vZ/K42o82isK/+qWcPAiUyIt8b66ReMcwdYqe0fMCpoyKupZQW2VO4z9
         WZKgWpWufkRrGOFi52jbJvK0VcdpaO6AmsSdTO9LIsuwGBn2C7OgStQRSVCXw7VBKS8F
         iDUBXA1ETjdFN/clyF47ib7BtE8+EB/K8Nex+rC+jIfW1EDCkiOdAwcTZdncNj8thtq4
         F32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEpGIQC5OezqJU8AwwswvJ5tJSp4EH9zwnzBibNlD44=;
        b=Fft6DTYyPu5N5f44iTNJvuQK6wrO1wgeNcOrWFNgIcFYbu5tsC9cCGEO4zF7MBprXi
         Je6JbALJHJuJ3Mz4q2r49vn2KncxpmP5Z8b0sHTn4FWY5dOxbFS5JEURHSjn3EceVxWE
         cPY3zJrmsYAAYKDVBNyMaBkwSJn23yFvs3Xd6yqYxTOp5Z5on/WhVnWFQxl952cvvAM3
         eJ1hOLCpPqNSiWbbolMhPY5aGCjL/VHtwqH4qnIn87mEEU4ENBY0D1YgW/3YmmJ9v8X3
         EuPB9/6dG0IYeM40FUh1H7yYjw9bjaW+2WdXsve5U1LlCozlW6tmio3LEEMUAUMpBhJX
         nzLQ==
X-Gm-Message-State: APjAAAVj1QpEbXV3pCgZGSSxXBxt4+10oxkK3NJEGmzPUbJXQa5mRB+3
        U1lk62w9AD7AO93hx0BbxoOs/lED7If21IBPmx8=
X-Google-Smtp-Source: APXvYqz0b0fujuPE6IBsJAqyb7+qCnfbcVT49ch5kCbXnHOW8VqC4x9uD2799lRgiQ6SEzJDmZPQnYIAslsX4pfn0ck=
X-Received: by 2002:a17:906:69c3:: with SMTP id g3mr20707127ejs.245.1553698340825;
 Wed, 27 Mar 2019 07:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190314002027.7833-1-helen.koike@collabora.com> <20190314002027.7833-4-helen.koike@collabora.com>
In-Reply-To: <20190314002027.7833-4-helen.koike@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 27 Mar 2019 10:52:09 -0400
Message-ID: <CAF6AEGtsZ7eoErhnq08kKv3d0NTEG-GKH52ucgvRPNOHkPcOjA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm/msm: fix fb references in async update
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        nicholas.kazlauskas@amd.com,
        "Grodzovsky, Andrey" <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        stable <stable@vger.kernel.org>, Sean Paul <sean@poorly.run>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 8:21 PM Helen Koike <helen.koike@collabora.com> wrote:
>
> Async update callbacks are expected to set the old_fb in the new_state
> so prepare/cleanup framebuffers are balanced.
>
> Cc: <stable@vger.kernel.org> # v4.14+
> Fixes: 224a4c970987 ("drm/msm: update cursors asynchronously through atomic")
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>
> ---
> Hello,
>
> As mentioned in the cover letter,
> But I couldn't test on MSM because I don't have the hardware and I would
> appreciate if anyone could test it.
>
> In other platforms (VC4, AMD, Rockchip), there is a hidden
> drm_framebuffer_get(new_fb)/drm_framebuffer_put(old_fb) in async_update
> that is wrong, but I couldn't identify those here, not sure if it is hidden
> somewhere else, but if tests fail this is probably the cause.
>
> Thanks!
> Helen

Apologies, I haven't had a chance to test this yet, and it is likely
to be a few weeks before I have a chance..

That said, not refcnt'ing the fb seems suspicious.   I read the
explanation in the other patches, but kind of think it is more clear
to keep the extra refcnt'ing.. or at least have a comment.

I do a bit wonder if we hold the ref to the outgoing cursor long
enough.. I think the hw will actually continue to scan it out until
the next vblank.  But Archit was the one who added async_update
support so maybe that is handled somewhere else.  It's been a while
since I've looked at this.

BR,
-R



>
> Changes in v3: None
> Changes in v2:
> - update CC stable and Fixes tag
>
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index be13140967b4..b854f471e9e5 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -502,6 +502,8 @@ static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
>  static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
>                                            struct drm_plane_state *new_state)
>  {
> +       struct drm_framebuffer *old_fb = plane->state->fb;
> +
>         plane->state->src_x = new_state->src_x;
>         plane->state->src_y = new_state->src_y;
>         plane->state->crtc_x = new_state->crtc_x;
> @@ -524,6 +526,8 @@ static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
>
>         *to_mdp5_plane_state(plane->state) =
>                 *to_mdp5_plane_state(new_state);
> +
> +       new_state->fb = old_fb;
>  }
>
>  static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {
> --
> 2.20.1
>
