Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537EBC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A212133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gSJn7Rk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfELQsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:48:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39422 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:48:54 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E55E42B6;
        Sun, 12 May 2019 18:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1557679732;
        bh=CA/PysDALKcIhU90hFulWgynRfk2ktIHJ/gRb5Rtyyw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=gSJn7Rk+EdGNm4KDzNICPnnX/R5mO5BiwGSNXageBEX7x59LSCGknZUESsYrm36CR
         gWeb0IdnLz+s9uSHQqTdaVz1/YUKPgXkr7d9FeYEQ+LO9ipuEBhepx9Kd9kZXFwSfv
         HwM8AxTiLf41yEVnQAGhwOgQtnRC36q6xMyRQzRc=
Date:   Sun, 12 May 2019 19:48:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/11] drm: Add
 drm_atomic_get_(old|new-_connector_for_encoder() helpers
Message-ID: <20190512164836.GA15762@pendragon.ideasonboard.com>
References: <20190508160920.144739-1-sean@poorly.run>
 <20190508160920.144739-3-sean@poorly.run>
 <20190508163327.GZ17751@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508163327.GZ17751@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

In the subject line, s/-/)/

On Wed, May 08, 2019 at 06:33:27PM +0200, Daniel Vetter wrote:
> On Wed, May 08, 2019 at 12:09:07PM -0400, Sean Paul wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Add functions to the atomic core to retrieve the old and new connectors
> > associated with an encoder in a drm_atomic_state. This is useful for
> > encoders and bridges that need to access the connector, for instance for
> > the drm_display_info.
> > 
> > The CRTC associated with the encoder can also be retrieved through the
> > connector state, and from it, the old and new CRTC states.
> > 
> > Changed in v4:
> > - Added to the set
> > 
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > [seanpaul removed WARNs from helpers and added docs to explain why
> > returning NULL might be valid]
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic.c | 70 ++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_atomic.h     |  7 ++++
> >  2 files changed, 77 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index 5eb40130fafb..936002495523 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -797,6 +797,76 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_get_private_obj_state);
> >  
> > +/**
> > + * drm_atomic_get_old_connector_for_encoder - Get old connector for an encoder
> > + * @state: Atomic state
> > + * @encoder: The encoder to fetch the connector state for
> > + *
> > + * This function finds and returns the connector that was connected to @encoder
> > + * as specified by the @state.
> > + *
> > + * If there is no connector in @state which previously had @encoder connected to
> > + * it, this function will return NULL. While this may seem like an invalid use
> > + * case, it is sometimes a useful to differentiate commits which had no prior

s/a useful/useful/

> > + * connectors attached to @encoder vs ones that did (and to inspect their
> > + * @state). This is especially true in enable hooks because the pipeline has

s/@state/state/, otherwise you refer to the parameter passed to this
function, which is not a connector state.

> > + * changed/will change.
> 
> s/has changed// ... I meant you'll pick the right ver tense :-)
> 
> > + *
> > + * Returns: The old connector connected to @encoder, or NULL if the encoder is
> > + * not connected.
> > + */
> > +struct drm_connector *
> > +drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
> > +					 struct drm_encoder *encoder)
> > +{
> > +	struct drm_connector_state *conn_state;
> > +	struct drm_connector *connector;
> > +	unsigned int i;
> > +
> > +	for_each_old_connector_in_state(state, connector, conn_state, i) {
> > +		if (conn_state->best_encoder == encoder)
> > +			return connector;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(drm_atomic_get_old_connector_for_encoder);
> > +
> > +/**
> > + * drm_atomic_get_new_connector_for_encoder - Get new connector for an encoder
> > + * @state: Atomic state
> > + * @encoder: The encoder to fetch the connector state for
> > + *
> > + * This function finds and returns the connector that will be connected to
> > + * @encoder as specified by the @state.
> > + *
> > + * If there is no connector in @state which will have @encoder connected to it,
> > + * this function will return NULL. While this may seem like an invalid use case,
> > + * it is sometimes a useful to differentiate commits which have no connectors

s/a useful/useful/

> > + * attached to @encoder vs ones that do (and to inspect their state). This is
> > + * especially true in disable hooks because the pipeline has changed/will
> > + * change.
> 
> s/will change//
> 
> > + *
> > + * Returns: The new connector connected to @encoder, or NULL if the encoder is
> > + * not connected.
> > + */
> > +struct drm_connector *
> > +drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
> > +					 struct drm_encoder *encoder)
> > +{
> > +	struct drm_connector_state *conn_state;
> > +	struct drm_connector *connector;
> > +	unsigned int i;
> > +
> > +	for_each_new_connector_in_state(state, connector, conn_state, i) {
> > +		if (conn_state->best_encoder == encoder)
> > +			return connector;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
> 
> Maybe also add a "See also drm_atomic_get_old_connector_for_encoder() and
> drm_atomic_get_new_connector_for_encoder()." to the kerneldoc of
> drm_connector_state.best_encoder.
> 
> With these doc nits:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> > +
> >  /**
> >   * drm_atomic_get_connector_state - get connector state
> >   * @state: global atomic state object
> > diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> > index 824a5ed4e216..d6b3acd34e1c 100644
> > --- a/include/drm/drm_atomic.h
> > +++ b/include/drm/drm_atomic.h
> > @@ -453,6 +453,13 @@ struct drm_private_state * __must_check
> >  drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
> >  				 struct drm_private_obj *obj);
> >  
> > +struct drm_connector *
> > +drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
> > +					 struct drm_encoder *encoder);
> > +struct drm_connector *
> > +drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
> > +					 struct drm_encoder *encoder);
> > +
> >  /**
> >   * drm_atomic_get_existing_crtc_state - get crtc state, if it exists
> >   * @state: global atomic state object

-- 
Regards,

Laurent Pinchart
