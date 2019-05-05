Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38307C04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A8B206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Fb7tcnhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfEEWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 18:01:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36908 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfEEWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:01:26 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6CF21D5;
        Mon,  6 May 2019 00:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1557093683;
        bh=GtrM0Lc1y/aKOwP2bNFLcJ3g/UR1KMpksm9IfDe28Qs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Fb7tcnhp5u9au8pJH492pToQKAmq/f2tR/MKw5dXORu04BdTeCQhyEoa76abv4rYQ
         kfpaRxRaGtl30MDJBShPVQ9ZFrmsH1C4iPrKQo6GTTPGmKRgLC61VgiL1/6cVZksZ6
         prCMBn4PB0bj0UZ6amSxzev5Sdm3auMikP2CKWuQ=
Date:   Mon, 6 May 2019 01:01:09 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] drm: Add drm_atomic_crtc_state_for_encoder
 helper
Message-ID: <20190505220109.GD4922@pendragon.ideasonboard.com>
References: <20190502194956.218441-1-sean@poorly.run>
 <20190502194956.218441-3-sean@poorly.run>
 <20190503081851.GI3271@phenom.ffwll.local>
 <20190503124737.GH17077@art_vandelay>
 <CAKMK7uGcpFJdXF1xmyMfToT+Vdhe2Q5hQWCNc-grFnq+cMVg5A@mail.gmail.com>
 <20190505211536.GA17751@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505211536.GA17751@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, May 05, 2019 at 11:15:36PM +0200, Daniel Vetter wrote:
> On Fri, May 03, 2019 at 04:06:28PM +0200, Daniel Vetter wrote:
> > On Fri, May 3, 2019 at 2:47 PM Sean Paul <sean@poorly.run> wrote:
> >> On Fri, May 03, 2019 at 10:18:51AM +0200, Daniel Vetter wrote:
> >>> On Thu, May 02, 2019 at 03:49:44PM -0400, Sean Paul wrote:
> >>>> From: Sean Paul <seanpaul@chromium.org>
> >>>>
> >>>> This patch adds a helper to tease out the currently connected crtc for
> >>>> an encoder, along with its state. This follows the same pattern as the
> >>>> drm_atomic_crtc_*_for_* macros in the atomic helpers. Since the
> >>>> relationship of crtc:encoder is 1:n, we don't need a loop since there is
> >>>> only one crtc per encoder.
> >>>
> >>> No idea which macros you mean, couldn't find them.
> >>
> >> No longer relevant with the changes below, but for completeness, I was trying to
> >> refer to drm_atomic_crtc_state_for_each_plane and friends. I see now that I
> >> wasn't terribly clear :)
> >>
> >>>> Instead of splitting this into 3 functions which all do the same thing,
> >>>> this is presented as one function. Perhaps that's too ugly and it should
> >>>> be split to:
> >>>> struct drm_crtc *drm_atomic_crtc_for_encoder(state, encoder);
> >>>> struct drm_crtc_state *drm_atomic_new_crtc_state_for_encoder(state, encoder);
> >>>> struct drm_crtc_state *drm_atomic_old_crtc_state_for_encoder(state, encoder);
> >>>>
> >>>> Suggestions welcome.
> >>>>
> >>>> Changes in v3:
> >>>> - Added to the set
> >>>>
> >>>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>>> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> >>>> ---
> >>>>  drivers/gpu/drm/drm_atomic_helper.c | 48 +++++++++++++++++++++++++++++
> >>>>  include/drm/drm_atomic_helper.h     |  6 ++++
> >>>>  2 files changed, 54 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> >>>> index 71cc7d6b0644..1f81ca8daad7 100644
> >>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
> >>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> >>>> @@ -3591,3 +3591,51 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
> >>>>     return ret;
> >>>>  }
> >>>>  EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
> >>>> +
> >>>> +/**
> >>>> + * drm_atomic_crtc_state_for_encoder - Get crtc and new/old state for an encoder
> >>>> + * @state: Atomic state
> >>>> + * @encoder: The encoder to fetch the crtc information for
> >>>> + * @crtc: If not NULL, receives the currently connected crtc
> >>>> + * @old_crtc_state: If not NULL, receives the crtc's old state
> >>>> + * @new_crtc_state: If not NULL, receives the crtc's new state
> >>>> + *
> >>>> + * This function finds the crtc which is currently connected to @encoder and
> >>>> + * returns it as well as its old and new state. If there is no crtc currently
> >>>> + * connected, the function will clear @crtc, @old_crtc_state, @new_crtc_state.
> >>>> + *
> >>>> + * All of @crtc, @old_crtc_state, and @new_crtc_state are optional.
> >>>> + */
> >>>> +void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *state,
> >>>> +                                  struct drm_encoder *encoder,
> >>>> +                                  struct drm_crtc **crtc,
> >>>> +                                  struct drm_crtc_state **old_crtc_state,
> >>>> +                                  struct drm_crtc_state **new_crtc_state)
> >>>> +{
> >>>> +   struct drm_crtc *tmp_crtc;
> >>>> +   struct drm_crtc_state *tmp_new_crtc_state, *tmp_old_crtc_state;
> >>>> +   u32 enc_mask = drm_encoder_mask(encoder);
> >>>> +   int i;
> >>>> +
> >>>> +   for_each_oldnew_crtc_in_state(state, tmp_crtc, tmp_old_crtc_state,
> >>>> +                                 tmp_new_crtc_state, i) {
> >>>
> >>> So there's two ways to do this:
> >>>
> >>> - Using encoder_mask, which is a helper thing. In that case I'd rename
> >>>   this to drm_atomic_helper_crtc_for_encoder.
> >>>
> >>> - By looping over the connectors, and looking at ->best_encoder and
> >>>   ->crtc, see drm_encoder_get_crtc in drm_encoder.c. That's the core way
> >>>   of doing things. In that case call it drm_atomic_crtc_for_encoder, and
> >>>   put it into drm_atomic.c.
> >>>
> >>> There's two ways of doing the 2nd one: looping over connectors in a
> >>> drm_atomic_state, or the connector list overall. First requires that the
> >>> encoder is already in drm_atomic_state (which I think makes sense).
> >>
> >> Yeah, I wasn't particularly interested in encoders not in state. I had
> >> considered going the connector route, but since you can have multiple connectors
> >> per encoder, going through crtc seemed a bit more direct.
> > 
> > You can have multiple possible connectors for a given encoder, and
> > multiple possible encoders for a given connector. In both cases the
> > driver picks for you. But for active encoders and connectors the
> > relationship is 1:1. That's what the helpers exploit by looping over
> > connectors to get at encoders.
> > 
> >>> Even more complications on old/new_crtc_state: Is that the old state for
> >>> the old crtc, or the old state for the new crtc (that can switch too).
> >>> Same for the new crtc state ...
> >>>
> >>> tldr; I'd create 2 functions:
> >>>
> >>> drm_crtc *drm_atomic_encoder_get_new_crtc(drm_atomic_state *state, encoder)
> >>> drm_crtc *drm_atomic_encoder_get_old_crtc(drm_atomic_state *state, encoder)
> >>>
> >>> With the requirement that they'll return NULL if the encder isn't in in
> >>> @state, and implemented using looping over connectors in @state.
> >>
> >> It seems like we could just tweak this function a bit to get the new or old crtc
> >> for an encoder. Any particular reason for going through connector instead? Is it
> >> to avoid the encoder_mask which is a helper thing? In that case, perhaps this
> >> should use connector links and live in drm_atomic.c?
> > 
> > Well as explained, there's 3 ways you can achieve the same really. I
> > do think the "loop over connectors in drm_atomic_state, WARN() if we
> > haven't found the encoder you want the crtc for" is probably the most
> > solid aproach since it picks up a core atomic concept. But the others
> > (looping the connector list, or looping encoder_mask) all work too.
> > 
> > Aside: plane/encoder_mask was added to go from crtc to
> > planes/encoders, not really to go the other way round.
> > 
> > Another solution would be to pass the connector_state to all atomic
> > encoder hooks, then you could just look at connector_state->crtc. Plus
> > you can get at all the other interesting bits and pieces of
> > information. In a way this is fallout from us keeping encoders as a
> > meaningful concept for easier transition of legacy drivers, while
> > still keeping them entirely irrelevant for the actual userspace api
> > semantics.
> > 
> > So maybe we want drm_atomic_encoder_get_old/new_connector here. Or
> > maybe we even want the full set of functions, i.e.
> > drm_atomic_encoder_get_old/new_connector/crtc.
> 
> Laurent just asked me on irc how to get from a bridge to connector
> information. Bridge knows its encoder (it's static), so a encode2connector
> function would already have a 2nd user with this.
> 
> I.e. I'd say +1 on that approach, and then you can get at the connector
> state and whatever else you feel like from there?
> 
> Adding Laurent.

Thank you. I'll experiment with this, but please don't wait for me to
post a v4.

> > In all cases I think only returning the object, not it's state is
> > simplest, since then you avoid the confusion of old/new state for
> > old/new obj.
> >
> >>> tldr; this is a lot more tricky than it looks like ...
> >>>
> >>>> +           if (!(tmp_new_crtc_state->encoder_mask & enc_mask))
> >>>> +                   continue;
> >>>> +
> >>>> +           if (new_crtc_state)
> >>>> +                   *new_crtc_state = tmp_new_crtc_state;
> >>>> +           if (old_crtc_state)
> >>>> +                   *old_crtc_state = tmp_old_crtc_state;
> >>>> +           if (crtc)
> >>>> +                   *crtc = tmp_crtc;
> >>>> +           return;
> >>>> +   }
> >>>> +
> >>>> +   if (new_crtc_state)
> >>>> +           *new_crtc_state = NULL;
> >>>> +   if (old_crtc_state)
> >>>> +           *old_crtc_state = NULL;
> >>>> +   if (crtc)
> >>>> +           *crtc = NULL;
> >>>> +}
> >>>> +EXPORT_SYMBOL(drm_atomic_crtc_state_for_encoder);
> >>>> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> >>>> index 58214be3bf3d..2383550a0cc8 100644
> >>>> --- a/include/drm/drm_atomic_helper.h
> >>>> +++ b/include/drm/drm_atomic_helper.h
> >>>> @@ -153,6 +153,12 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
> >>>>                                    uint32_t size,
> >>>>                                    struct drm_modeset_acquire_ctx *ctx);
> >>>>
> >>>> +void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *state,
> >>>> +                                  struct drm_encoder *encoder,
> >>>> +                                  struct drm_crtc **crtc,
> >>>> +                                  struct drm_crtc_state **old_crtc_state,
> >>>> +                                  struct drm_crtc_state **new_crtc_state);
> >>>> +
> >>>>  /**
> >>>>   * drm_atomic_crtc_for_each_plane - iterate over planes currently attached to CRTC
> >>>>   * @plane: the loop cursor

-- 
Regards,

Laurent Pinchart
