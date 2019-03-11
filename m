Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76541C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432C820857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCKOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:20:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54624 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:20:14 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3EFC427D615;
        Mon, 11 Mar 2019 14:20:12 +0000 (GMT)
Date:   Mon, 11 Mar 2019 15:20:09 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 1/5] drm: don't block fb changes for async plane updates
Message-ID: <20190311152009.7c55b797@collabora.com>
In-Reply-To: <01f2b3ba-434a-f61f-e8e8-85f3c9107a5c@amd.com>
References: <20190304144909.6267-1-helen.koike@collabora.com>
        <20190304144909.6267-2-helen.koike@collabora.com>
        <e2eb91f5-25e3-d030-74d8-de2348de5600@amd.com>
        <20190311110616.6b474865@collabora.com>
        <01f2b3ba-434a-f61f-e8e8-85f3c9107a5c@amd.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 13:15:23 +0000
"Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com> wrote:

> On 3/11/19 6:06 AM, Boris Brezillon wrote:
> > Hello Nicholas,
> > 
> > On Mon, 4 Mar 2019 15:46:49 +0000
> > "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com> wrote:
> >   
> >> On 3/4/19 9:49 AM, Helen Koike wrote:  
> >>> In the case of a normal sync update, the preparation of framebuffers (be
> >>> it calling drm_atomic_helper_prepare_planes() or doing setups with
> >>> drm_framebuffer_get()) are performed in the new_state and the respective
> >>> cleanups are performed in the old_state.
> >>>
> >>> In the case of async updates, the preparation is also done in the
> >>> new_state but the cleanups are done in the new_state (because updates
> >>> are performed in place, i.e. in the current state).
> >>>
> >>> The current code blocks async udpates when the fb is changed, turning
> >>> async updates into sync updates, slowing down cursor updates and
> >>> introducing regressions in igt tests with errors of type:
> >>>
> >>> "CRITICAL: completed 97 cursor updated in a period of 30 flips, we
> >>> expect to complete approximately 15360 updates, with the threshold set
> >>> at 7680"
> >>>
> >>> Fb changes in async updates were prevented to avoid the following scenario:
> >>>
> >>> - Async update, oldfb = NULL, newfb = fb1, prepare fb1, cleanup fb1
> >>> - Async update, oldfb = fb1, newfb = fb2, prepare fb2, cleanup fb2
> >>> - Non-async commit, oldfb = fb2, newfb = fb1, prepare fb1, cleanup fb2 (wrong)
> >>> Where we have a single call to prepare fb2 but double cleanup call to fb2.
> >>>
> >>> To solve the above problems, instead of blocking async fb changes, we
> >>> place the old framebuffer in the new_state object, so when the code
> >>> performs cleanups in the new_state it will cleanup the old_fb and we
> >>> will have the following scenario instead:
> >>>
> >>> - Async update, oldfb = NULL, newfb = fb1, prepare fb1, no cleanup
> >>> - Async update, oldfb = fb1, newfb = fb2, prepare fb2, cleanup fb1
> >>> - Non-async commit, oldfb = fb2, newfb = fb1, prepare fb1, cleanup fb2
> >>>
> >>> Where calls to prepare/cleanup are ballanced.
> >>>
> >>> Cc: <stable@vger.kernel.org> # v4.14+: 25dc194b34dd: drm: Block fb changes for async plane updates
> >>> Fixes: 25dc194b34dd ("drm: Block fb changes for async plane updates")
> >>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>>
> >>> ---
> >>> Hello,
> >>>
> >>> As mentioned in the cover letter,
> >>> I tested on the rockchip and on i915 (with a patch I am still working on for
> >>> replacing cursors by async update), with igt plane_cursor_legacy and
> >>> kms_cursor_legacy and I didn't see any regressions.
> >>> I couldn't test on MSM and AMD because I don't have the hardware (and I am
> >>> having some issues testing on vc4) and I would appreciate if anyone could help
> >>> me testing those.
> >>>
> >>> I also think it would be a better solution if, instead of having async
> >>> to do in-place updates in the current state, the async path should be
> >>> equivalent to a syncronous update, i.e., modifying new_state and
> >>> performing a flip
> >>> IMHO, the only difference between sync and async should be that async update
> >>> doesn't wait for vblank and applies the changes immeditally to the hw,
> >>> but the code path could be almost the same.
> >>> But for now I think this solution is ok (swaping new_fb/old_fb), and
> >>> then we can adjust things little by little, what do you think?
> >>>
> >>> Thanks!
> >>> Helen
> >>>
> >>>    drivers/gpu/drm/drm_atomic_helper.c | 20 ++++++++++----------
> >>>    1 file changed, 10 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> >>> index 540a77a2ade9..e7eb96f1efc2 100644
> >>> --- a/drivers/gpu/drm/drm_atomic_helper.c
> >>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> >>> @@ -1608,15 +1608,6 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
> >>>    	    old_plane_state->crtc != new_plane_state->crtc)
> >>>    		return -EINVAL;
> >>>    
> >>> -	/*
> >>> -	 * FIXME: Since prepare_fb and cleanup_fb are always called on
> >>> -	 * the new_plane_state for async updates we need to block framebuffer
> >>> -	 * changes. This prevents use of a fb that's been cleaned up and
> >>> -	 * double cleanups from occuring.
> >>> -	 */
> >>> -	if (old_plane_state->fb != new_plane_state->fb)
> >>> -		return -EINVAL;
> >>> -
> >>>    	funcs = plane->helper_private;
> >>>    	if (!funcs->atomic_async_update)
> >>>    		return -EINVAL;
> >>> @@ -1657,6 +1648,9 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
> >>>    	int i;
> >>>    
> >>>    	for_each_new_plane_in_state(state, plane, plane_state, i) {
> >>> +		struct drm_framebuffer *new_fb = plane_state->fb;
> >>> +		struct drm_framebuffer *old_fb = plane->state->fb;
> >>> +
> >>>    		funcs = plane->helper_private;
> >>>    		funcs->atomic_async_update(plane, plane_state);
> >>>    
> >>> @@ -1665,11 +1659,17 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
> >>>    		 * plane->state in-place, make sure at least common
> >>>    		 * properties have been properly updated.
> >>>    		 */
> >>> -		WARN_ON_ONCE(plane->state->fb != plane_state->fb);
> >>> +		WARN_ON_ONCE(plane->state->fb != new_fb);
> >>>    		WARN_ON_ONCE(plane->state->crtc_x != plane_state->crtc_x);
> >>>    		WARN_ON_ONCE(plane->state->crtc_y != plane_state->crtc_y);
> >>>    		WARN_ON_ONCE(plane->state->src_x != plane_state->src_x);
> >>>    		WARN_ON_ONCE(plane->state->src_y != plane_state->src_y);
> >>> +
> >>> +		/*
> >>> +		 * Make sure the FBs have been swapped so that cleanups in the
> >>> +		 * new_state performs a cleanup in the old FB.
> >>> +		 */
> >>> +		WARN_ON_ONCE(plane_state->fb != old_fb);  
> >>
> >> I personally think this approach is fine and the WARN_ON s are good for
> >> catching drivers that want to use these in the future.  
> > 
> > Well, I agree this change is the way to go for a short-term solution
> > to relax the old_fb == new_fb constraint, but I keep thinking this whole
> > "update plane_state in place" is a recipe for trouble and just make
> > things more complicated for drivers for no obvious reasons. Look at the
> > VC4 implem [1] if you need a proof that things can get messy pretty
> > quickly.
> > 
> > All this state-fields-copying steps could be skipped if the core was
> > simply swapping the old/new states as is done in the sync update path.
> > 
> > [1]https://elixir.bootlin.com/linux/v5.0-rc7/source/drivers/gpu/drm/vc4/vc4_plane.c#L878  
> 
> I completely agree with this view FWIW. I had a discussion with Daniel 
> about this when I had posted the original block FB changes patch.
> 
> - The plane object needs to be locked in order for async state to be updated
> - Blocking commit work holds the lock for the plane, async update won't 
> happen
> - Non-blocking commit work that's still ongoing won't have hw_done 
> signaled and drm_atomic_helper_async_check will block the async update
> 
> So this looks safe in theory, with the exception of the call to 
> drm_atomic_helper_cleanup_planes occuring after hw_done is signaled.

Isn't it also the case in the sync update path?

> 
> I believe that the behavior of this function still remains the same even 
> if plane->state is swapped to something else during the call (since 
> old_plane_state should never be equal to plane->state if the commit 
> succeeded and the plane is in the commit), but I'm not sure that's 
> something we'd want to rely on.
> 
> I think other than that issue, you could probably just:
> 
> drm_atomic_helper_prepare_planes(...);
> drm_atomic_helper_swap_state(...);
> drm_atomic_state_get(state);

Why do we need a state_get() here? AFAICT, it's done this way in the
sync update path because of the non-blocking semantic where the state
might be released by the caller before it's been applied by the commit
worker.

> drm_atomic_helper_async_commit(...);
> drm_atomic_helper_cleanup_planes(dev, state);
> 
> and it would work as expected. But there still may be other things I'm 
> missing or haven't considered here.

Actually, when I said we could swap states, I was not necessarily
thinking about re-using drm_atomic_helper_swap_state(), but instead
swap states directly in drm_atomic_helper_async_commit():

	for_each_oldnew_plane_in_state(state, plane, old_plane_state,
				       new_plane_state, i) {
		WARN_ON(plane->state != old_plane_state);
		old_plane_state->state = state;
		new_plane_state->state = NULL;
		state->planes[i].state = old_plane_state;
		plane->state = new_plane_state;

		funcs = plane->helper_private;
		funcs->atomic_async_update(plane, new_plane_state);
	}

This way we would avoid the WARN_ON() lines we have in
drm_atomic_helper_async_commit() to check that things have been
properly updated in-place, and we would also get rid of the driver
code copying the plane_state property that can change during an async
update.

But, as you said, I might be missing other potential issues.
