Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F40720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="V9ZvLzwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCKTx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:53:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33562 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCKTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:53:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id d12so366536edp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9/GZ89GtKL7faQhKKsvVpTwuReix+qA08T2TKT0KKY=;
        b=V9ZvLzwJzHCCBPMwKQYIa0tEYdI0orYtSw5f3LCtrL1flHwv0k4VYF2yR3MxkHe3Nu
         VxDc7Iww5RqDhstC70mYN70JvcX6XzwFAa9V5D6RkMwOMzmwbDwEorcjjUvO9RQvDCE3
         +FwB6DLlXcdTyjTkb+l6x17K95L+S/jxs7A38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=e9/GZ89GtKL7faQhKKsvVpTwuReix+qA08T2TKT0KKY=;
        b=LZe2t0UqGz2zjF8fVdegNIgjmrwzOLmcnajnIy7cYPwhPSu8tmgKUlvvvz35T8AtT1
         8q+3vUTjDelSvfBCq/jRydvZ5+IJb/WdkvSRdffwDaV2IGlrcIpb5R+W2OIJ2WbtzehG
         2rnXE+uzyEqi6KIavyuSV9GcUlGaenWtwMIyPtJvKnuK0QL/BxXNTG44NBACmxZlptk+
         etJfm1O6FAI934UpCNzrunAceD7UO+Gq8Bl/IAB5804xWbiwkdMCsKut4E8dMjTxg0jq
         9ymvRyO+nJkCx9LDKSvm5e5nZjmD++1Sh0YEhEZYaI3QaOFYv7ZbhfUyQB7ugEWxvFAQ
         vpQg==
X-Gm-Message-State: APjAAAXD6cik9oZE9ejcDM9sKtBN1eJppu89sAYKAxHIF8rK7ujlsCxl
        GCVoYaGNhS61LE/p6h+anDql+w==
X-Google-Smtp-Source: APXvYqwEK9dWYANHfQNlqFvvjz4D+Fq0RHhG5MOe0q9byjr9rf+VtZ9CX7n3Lq74VG+7E7jsy1jvBg==
X-Received: by 2002:a17:906:d20e:: with SMTP id w14mr6812725ejz.160.1552334035074;
        Mon, 11 Mar 2019 12:53:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r48sm4975688edd.87.2019.03.11.12.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 12:53:54 -0700 (PDT)
Date:   Mon, 11 Mar 2019 20:53:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>
Subject: Re: [PATCH 1/5] drm: don't block fb changes for async plane updates
Message-ID: <20190311195352.GU2665@phenom.ffwll.local>
Mail-Followup-To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        Helen Koike <helen.koike@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>
References: <20190304144909.6267-1-helen.koike@collabora.com>
 <20190304144909.6267-2-helen.koike@collabora.com>
 <e2eb91f5-25e3-d030-74d8-de2348de5600@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2eb91f5-25e3-d030-74d8-de2348de5600@amd.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:46:49PM +0000, Kazlauskas, Nicholas wrote:
> On 3/4/19 9:49 AM, Helen Koike wrote:
> > In the case of a normal sync update, the preparation of framebuffers (be
> > it calling drm_atomic_helper_prepare_planes() or doing setups with
> > drm_framebuffer_get()) are performed in the new_state and the respective
> > cleanups are performed in the old_state.
> > 
> > In the case of async updates, the preparation is also done in the
> > new_state but the cleanups are done in the new_state (because updates
> > are performed in place, i.e. in the current state).
> > 
> > The current code blocks async udpates when the fb is changed, turning
> > async updates into sync updates, slowing down cursor updates and
> > introducing regressions in igt tests with errors of type:
> > 
> > "CRITICAL: completed 97 cursor updated in a period of 30 flips, we
> > expect to complete approximately 15360 updates, with the threshold set
> > at 7680"
> > 
> > Fb changes in async updates were prevented to avoid the following scenario:
> > 
> > - Async update, oldfb = NULL, newfb = fb1, prepare fb1, cleanup fb1
> > - Async update, oldfb = fb1, newfb = fb2, prepare fb2, cleanup fb2
> > - Non-async commit, oldfb = fb2, newfb = fb1, prepare fb1, cleanup fb2 (wrong)
> > Where we have a single call to prepare fb2 but double cleanup call to fb2.
> > 
> > To solve the above problems, instead of blocking async fb changes, we
> > place the old framebuffer in the new_state object, so when the code
> > performs cleanups in the new_state it will cleanup the old_fb and we
> > will have the following scenario instead:
> > 
> > - Async update, oldfb = NULL, newfb = fb1, prepare fb1, no cleanup
> > - Async update, oldfb = fb1, newfb = fb2, prepare fb2, cleanup fb1
> > - Non-async commit, oldfb = fb2, newfb = fb1, prepare fb1, cleanup fb2
> > 
> > Where calls to prepare/cleanup are ballanced.
> > 
> > Cc: <stable@vger.kernel.org> # v4.14+: 25dc194b34dd: drm: Block fb changes for async plane updates
> > Fixes: 25dc194b34dd ("drm: Block fb changes for async plane updates")
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > 
> > ---
> > Hello,
> > 
> > As mentioned in the cover letter,
> > I tested on the rockchip and on i915 (with a patch I am still working on for
> > replacing cursors by async update), with igt plane_cursor_legacy and
> > kms_cursor_legacy and I didn't see any regressions.
> > I couldn't test on MSM and AMD because I don't have the hardware (and I am
> > having some issues testing on vc4) and I would appreciate if anyone could help
> > me testing those.
> > 
> > I also think it would be a better solution if, instead of having async
> > to do in-place updates in the current state, the async path should be
> > equivalent to a syncronous update, i.e., modifying new_state and
> > performing a flip
> > IMHO, the only difference between sync and async should be that async update
> > doesn't wait for vblank and applies the changes immeditally to the hw,
> > but the code path could be almost the same.
> > But for now I think this solution is ok (swaping new_fb/old_fb), and
> > then we can adjust things little by little, what do you think?
> > 
> > Thanks!
> > Helen
> > 
> >   drivers/gpu/drm/drm_atomic_helper.c | 20 ++++++++++----------
> >   1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 540a77a2ade9..e7eb96f1efc2 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1608,15 +1608,6 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
> >   	    old_plane_state->crtc != new_plane_state->crtc)
> >   		return -EINVAL;
> >   
> > -	/*
> > -	 * FIXME: Since prepare_fb and cleanup_fb are always called on
> > -	 * the new_plane_state for async updates we need to block framebuffer
> > -	 * changes. This prevents use of a fb that's been cleaned up and
> > -	 * double cleanups from occuring.
> > -	 */
> > -	if (old_plane_state->fb != new_plane_state->fb)
> > -		return -EINVAL;
> > -
> >   	funcs = plane->helper_private;
> >   	if (!funcs->atomic_async_update)
> >   		return -EINVAL;
> > @@ -1657,6 +1648,9 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
> >   	int i;
> >   
> >   	for_each_new_plane_in_state(state, plane, plane_state, i) {
> > +		struct drm_framebuffer *new_fb = plane_state->fb;
> > +		struct drm_framebuffer *old_fb = plane->state->fb;
> > +
> >   		funcs = plane->helper_private;
> >   		funcs->atomic_async_update(plane, plane_state);
> >   
> > @@ -1665,11 +1659,17 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
> >   		 * plane->state in-place, make sure at least common
> >   		 * properties have been properly updated.
> >   		 */
> > -		WARN_ON_ONCE(plane->state->fb != plane_state->fb);
> > +		WARN_ON_ONCE(plane->state->fb != new_fb);
> >   		WARN_ON_ONCE(plane->state->crtc_x != plane_state->crtc_x);
> >   		WARN_ON_ONCE(plane->state->crtc_y != plane_state->crtc_y);
> >   		WARN_ON_ONCE(plane->state->src_x != plane_state->src_x);
> >   		WARN_ON_ONCE(plane->state->src_y != plane_state->src_y);
> > +
> > +		/*
> > +		 * Make sure the FBs have been swapped so that cleanups in the
> > +		 * new_state performs a cleanup in the old FB.
> > +		 */
> > +		WARN_ON_ONCE(plane_state->fb != old_fb);
> 
> I personally think this approach is fine and the WARN_ON s are good for 
> catching drivers that want to use these in the future.
> 
> I do think it would be good to add something to the function docs that 
> explains this requirement and the issue that it addresses. It's a little 
> unintuitive to require that the old fb is placed into the new state, but 
> it makes sense as a workaround to this problem.

Agreed.

And yeah this looks like a reasonable short-term fix.
-Daniel

> 
> Nicholas Kazlauskas
> 
> >   	}
> >   }
> >   EXPORT_SYMBOL(drm_atomic_helper_async_commit);
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
