Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B89C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B32053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d+nJyr8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfICHk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:40:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36165 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfICHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:40:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so17597838edu.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NAYtAfFgiR4FrS37WYAOhE0k2qFwYg4eaJYuul3ALvs=;
        b=d+nJyr8/oqqMeSVtA7xWc59RolPI1d2eehc2Lt88CMF7UUgCP3pfwPvTJn2Z+m0lQW
         v+lLPzGKLURenuIfwOB1sxMvMKx4py8P3PPpUyIh+kyfc1b7Y0BbaCLkHdiP1MymreRQ
         vPUqgX5zM8nepOWTOnR5i0JJfBC49722KFoFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NAYtAfFgiR4FrS37WYAOhE0k2qFwYg4eaJYuul3ALvs=;
        b=Jqu0bjI2mwMNre2ofeE6ojK9lnKnNHIw/yezL6eW5LLuA84ljTUYJf87tY33844PI5
         XzQLYCPQngpxwe0iXf3zGenBu+Ytu6X4oa+le/yUcbGtMLRN2xEsPpiwGIu8wesihFGT
         3BI3fleDw1hfh4S8PTxnRz8ZPmRu5MtSxFDic1EBiw/2fCFlbQzsF9Y475ZVGVjkTpYU
         J7KSON4+KjrUX+nqFbq/de7jWegvWyTIcKNRCfQKXvNVKIPtq75YmWQsqB1GO7+vYXAX
         SiubQ+mhinhSnxcIFH72xEH9dsNOrNjklW0lbai77YMes2EAr4ivRmmUBPaZIo3wt1sH
         AxGg==
X-Gm-Message-State: APjAAAUNeolUYobDYeWpXCVV5NoPGWuHrHKfmwfcqM9NUp7c7xgvBGBI
        wwiFVQX0k6uoGpZQQTeDtZ1F6w==
X-Google-Smtp-Source: APXvYqyaUnfTMX5OmS3CMrws6t3+a8nlcybyBJHX3vsOWX3EC2oZvBgr7vpOxiCGit0WhgR46D3Byg==
X-Received: by 2002:a17:906:6818:: with SMTP id k24mr1140725ejr.271.1567496424313;
        Tue, 03 Sep 2019 00:40:24 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id o50sm1187738edc.56.2019.09.03.00.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:40:23 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:40:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Deepak Rawat <drawat@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] drm/dp_mst: Add sideband down request tracing +
 selftests
Message-ID: <20190903074021.GH2112@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Deepak Rawat <drawat@vmware.com>, linux-kernel@vger.kernel.org
References: <20190718014329.8107-1-lyude@redhat.com>
 <20190718014329.8107-6-lyude@redhat.com>
 <20190813145048.GV7444@phenom.ffwll.local>
 <70c42b3ae529d51c79b3ab9bb2c604549413d808.camel@redhat.com>
 <20190827171510.GF2112@phenom.ffwll.local>
 <33afac9298855b3cbf96e97387f0c7e38d080ac8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33afac9298855b3cbf96e97387f0c7e38d080ac8.camel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:31:06PM -0400, Lyude Paul wrote:
> Two things below
> 
> On Tue, 2019-08-27 at 19:15 +0200, Daniel Vetter wrote:
> > On Tue, Aug 27, 2019 at 12:49:17PM -0400, Lyude Paul wrote:
> > > On Tue, 2019-08-13 at 16:50 +0200, Daniel Vetter wrote:
> > > > On Wed, Jul 17, 2019 at 09:42:28PM -0400, Lyude Paul wrote:
> > > > > Unfortunately the DP MST helpers do not have much in the way of
> > > > > debugging utilities. So, let's add some!
> > > > > 
> > > > > This adds basic debugging output for down sideband requests that we
> > > > > send
> > > > > from the driver, so that we can actually discern what's happening when
> > > > > sideband requests timeout. Note that with this commit, we'll be
> > > > > dumping
> > > > > out sideband requests under both of the following conditions:
> > > > > 
> > > > > - When the user has enabled DRM_UT_DP output, of course.
> > > > > - When the user has enabled DRM_UT_KMS or DRM_UT_DP, and a sideband
> > > > >   request has failed in some way. This will allow for developers to
> > > > > get
> > > > >   a basic idea of what's actually happening with failed modesets on
> > > > > MST,
> > > > >   without needing to have DRM_UT_DP explicitly enabled.
> > > > > 
> > > > > Since there wasn't really a good way of testing that any of this
> > > > > worked,
> > > > > I ended up writing simple selftests that lightly test sideband message
> > > > > encoding and decoding as well. Enjoy!
> > > > > 
> > > > > Cc: Juston Li <juston.li@intel.com>
> > > > > Cc: Imre Deak <imre.deak@intel.com>
> > > > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > Cc: Harry Wentland <hwentlan@amd.com>
> > > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_dp_mst_topology.c         | 308
> > > > > +++++++++++++++++-
> > > > >  .../gpu/drm/drm_dp_mst_topology_internal.h    |  24 ++
> > > > >  .../gpu/drm/selftests/drm_modeset_selftests.h |   1 +
> > > > >  .../drm/selftests/test-drm_dp_mst_helper.c    | 212 ++++++++++++
> > > > >  .../drm/selftests/test-drm_modeset_common.h   |   1 +
> > > > >  include/drm/drm_dp_mst_helper.h               |   2 +-
> > > > >  6 files changed, 543 insertions(+), 5 deletions(-)
> > > > >  create mode 100644 drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > index 9e382117896d..defc5e09fb9a 100644
> > > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > @@ -36,6 +36,8 @@
> > > > >  #include <drm/drm_print.h>
> > > > >  #include <drm/drm_probe_helper.h>
> > > > >  
> > > > > +#include "drm_dp_mst_topology_internal.h"
> > > > > +
> > > > >  /**
> > > > >   * DOC: dp mst helper
> > > > >   *
> > > > > @@ -68,6 +70,8 @@ static int drm_dp_mst_register_i2c_bus(struct
> > > > > drm_dp_aux
> > > > > *aux);
> > > > >  static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_aux *aux);
> > > > >  static void drm_dp_mst_kick_tx(struct drm_dp_mst_topology_mgr *mgr);
> > > > >  
> > > > > +#define DBG_PREFIX "[dp_mst]"
> > > > > +
> > > > >  #define DP_STR(x) [DP_ ## x] = #x
> > > > >  
> > > > >  static const char *drm_dp_mst_req_type_str(u8 req_type)
> > > > > @@ -124,6 +128,43 @@ static const char *drm_dp_mst_nak_reason_str(u8
> > > > > nak_reason)
> > > > >  }
> > > > >  
> > > > >  #undef DP_STR
> > > > > +#define DP_STR(x) [DRM_DP_SIDEBAND_TX_ ## x] = #x
> > > > > +
> > > > > +static const char *drm_dp_mst_sideband_tx_state_str(int state)
> > > > > +{
> > > > > +	static const char * const sideband_reason_str[] = {
> > > > > +		DP_STR(QUEUED),
> > > > > +		DP_STR(START_SEND),
> > > > > +		DP_STR(SENT),
> > > > > +		DP_STR(RX),
> > > > > +		DP_STR(TIMEOUT),
> > > > > +	};
> > > > > +
> > > > > +	if (state >= ARRAY_SIZE(sideband_reason_str) ||
> > > > > +	    !sideband_reason_str[state])
> > > > > +		return "unknown";
> > > > > +
> > > > > +	return sideband_reason_str[state];
> > > > > +}
> > > > > +
> > > > > +static int
> > > > > +drm_dp_mst_rad_to_str(const u8 rad[8], u8 lct, char *out, size_t len)
> > > > > +{
> > > > > +	int i;
> > > > > +	u8 unpacked_rad[16];
> > > > > +
> > > > > +	for (i = 0; i < lct; i++) {
> > > > > +		if (i % 2)
> > > > > +			unpacked_rad[i] = rad[i / 2] >> 4;
> > > > > +		else
> > > > > +			unpacked_rad[i] = rad[i / 2] & BIT_MASK(4);
> > > > > +	}
> > > > > +
> > > > > +	/* TODO: Eventually add something to printk so we can format
> > > > > the rad
> > > > > +	 * like this: 1.2.3
> > > > > +	 */
> > > > 
> > > > 	lct *=2;
> > > > 
> > > > missing here? And yeah the todo would be sweet, but quite a bit more
> > > > typing I guess.
> > > > 
> > > > > +	return snprintf(out, len, "%*phC", lct, unpacked_rad);
> > > > > +}
> > > > >  
> > > > >  /* sideband msg handling */
> > > > >  static u8 drm_dp_msg_header_crc4(const uint8_t *data, size_t
> > > > > num_nibbles)
> > > > > @@ -256,8 +297,9 @@ static bool drm_dp_decode_sideband_msg_hdr(struct
> > > > > drm_dp_sideband_msg_hdr *hdr,
> > > > >  	return true;
> > > > >  }
> > > > >  
> > > > > -static void drm_dp_encode_sideband_req(struct
> > > > > drm_dp_sideband_msg_req_body *req,
> > > > > -				       struct drm_dp_sideband_msg_tx
> > > > > *raw)
> > > > > +void
> > > > > +drm_dp_encode_sideband_req(const struct drm_dp_sideband_msg_req_body
> > > > > *req,
> > > > > +			   struct drm_dp_sideband_msg_tx *raw)
> > > > >  {
> > > > >  	int idx = 0;
> > > > >  	int i;
> > > > > @@ -362,6 +404,249 @@ static void drm_dp_encode_sideband_req(struct
> > > > > drm_dp_sideband_msg_req_body *req,
> > > > >  	}
> > > > >  	raw->cur_len = idx;
> > > > >  }
> > > > > +EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_encode_sideband_req);
> > > > > +
> > > > > +/* Decode a sideband request we've encoded, mainly used for debugging
> > > > > */
> > > > > +int
> > > > > +drm_dp_decode_sideband_req(const struct drm_dp_sideband_msg_tx *raw,
> > > > > +			   struct drm_dp_sideband_msg_req_body *req)
> > > > > +{
> > > > > +	const u8 *buf = raw->msg;
> > > > > +	int i, idx = 0;
> > > > > +
> > > > > +	req->req_type = buf[idx++] & 0x7f;
> > > > > +	switch (req->req_type) {
> > > > > +	case DP_ENUM_PATH_RESOURCES:
> > > > > +	case DP_POWER_DOWN_PHY:
> > > > > +	case DP_POWER_UP_PHY:
> > > > 
> > > > OCD warning: the enum isn't ordered the same way here and in
> > > > drm_dp_encode_sideband_req().
> > > > 
> > > > > +		req->u.port_num.port_number = (buf[idx] >> 4) & 0xf;
> > > > > +		break;
> > > > > +	case DP_ALLOCATE_PAYLOAD:
> > > > > +		{
> > > > > +			struct drm_dp_allocate_payload *a =
> > > > > +				&req->u.allocate_payload;
> > > > > +
> > > > > +			a->number_sdp_streams = buf[idx] & 0xf;
> > > > > +			a->port_number = (buf[idx] >> 4) & 0xf;
> > > > > +
> > > > > +			a->vcpi = buf[++idx] & 0x7f;
> > > > 
> > > > Complain here if 0x80 is set?
> > > > 
> > > > > +
> > > > > +			a->pbn = buf[++idx] << 8;
> > > > > +			a->pbn |= buf[++idx];
> > > > > +
> > > > > +			idx++;
> > > > > +			for (i = 0; i < a->number_sdp_streams; i++) {
> > > > > +				a->sdp_stream_sink[i] =
> > > > > +					(buf[idx + (i / 2)] >> ((i %
> > > > > 2) ? 0 :
> > > > > 4)) & 0xf;
> > > > > +			}
> > > > > +		}
> > > > > +		break;
> > > > > +	case DP_QUERY_PAYLOAD:
> > > > > +		req->u.query_payload.port_number = (buf[idx] >> 4) &
> > > > > 0xf;
> > > > > +		req->u.query_payload.vcpi = buf[++idx] & 0x7f;
> > > > 
> > > > Same here for the highest bit?
> > > > 
> > > > > +		break;
> > > > > +	case DP_REMOTE_DPCD_READ:
> > > > > +		{
> > > > > +			struct drm_dp_remote_dpcd_read *r = &req-
> > > > > >u.dpcd_read;
> > > > > +
> > > > > +			r->port_number = (buf[idx] >> 4) & 0xf;
> > > > > +
> > > > > +			r->dpcd_address = (buf[idx] << 16) & 0xf0000;
> > > > > +			r->dpcd_address |= (buf[++idx] << 8) & 0xff00;
> > > > > +			r->dpcd_address |= buf[++idx] & 0xff;
> > > > > +
> > > > > +			r->num_bytes = buf[++idx];
> > > > > +		}
> > > > > +		break;
> > > > > +	case DP_REMOTE_DPCD_WRITE:
> > > > > +		{
> > > > > +			struct drm_dp_remote_dpcd_write *w =
> > > > > +				&req->u.dpcd_write;
> > > > > +
> > > > > +			w->port_number = (buf[idx] >> 4) & 0xf;
> > > > > +
> > > > > +			w->dpcd_address = (buf[idx] << 16) & 0xf0000;
> > > > > +			w->dpcd_address |= (buf[++idx] << 8) & 0xff00;
> > > > > +			w->dpcd_address |= buf[++idx] & 0xff;
> > > > > +
> > > > > +			w->num_bytes = buf[++idx];
> > > > > +
> > > > > +			w->bytes = kmemdup(&buf[++idx], w->num_bytes,
> > > > > +					   GFP_KERNEL);
> > > > 
> > > > But if we go really strict on validation we'd need to make sure we don't
> > > > walk past raw->cur_len ... probably not worth it?
> > > > 
> > > > > +			if (!w->bytes)
> > > > > +				return -ENOMEM;
> > > > > +		}
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_READ:
> > > > > +		{
> > > > > +			struct drm_dp_remote_i2c_read *r = &req-
> > > > > >u.i2c_read;
> > > > > +			struct drm_dp_remote_i2c_read_tx *tx;
> > > > > +			bool failed = false;
> > > > > +
> > > > > +			r->num_transactions = buf[idx] & 0x3;
> > > > > +			r->port_number = (buf[idx] >> 4) & 0xf;
> > > > > +			for (i = 0; i < r->num_transactions; i++) {
> > > > > +				tx = &r->transactions[i];
> > > > > +
> > > > > +				tx->i2c_dev_id = buf[++idx] & 0x7f;
> > > > > +				tx->num_bytes = buf[++idx];
> > > > > +				tx->bytes = kmemdup(&buf[++idx],
> > > > > +						    tx->num_bytes,
> > > > > +						    GFP_KERNEL);
> > > > > +				if (!tx->bytes) {
> > > > > +					failed = true;
> > > > > +					break;
> > > > > +				}
> > > > > +				idx += tx->num_bytes;
> > > > > +				tx->no_stop_bit = (buf[idx] >> 5) &
> > > > > 0x1;
> > > > > +				tx->i2c_transaction_delay = buf[idx] &
> > > > > 0xf;
> > > > > +			}
> > > > > +
> > > > > +			if (failed) {
> > > > > +				for (i = 0; i < r->num_transactions;
> > > > > i++)
> > > > > +					kfree(tx->bytes);
> > > > > +				return -ENOMEM;
> > > > > +			}
> > > > > +
> > > > > +			r->read_i2c_device_id = buf[++idx] & 0x7f;
> > > > > +			r->num_bytes_read = buf[++idx];
> > > > > +		}
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_WRITE:
> > > > > +		{
> > > > > +			struct drm_dp_remote_i2c_write *w = &req-
> > > > > >u.i2c_write;
> > > > > +
> > > > > +			w->port_number = (buf[idx] >> 4) & 0xf;
> > > > > +			w->write_i2c_device_id = buf[++idx] & 0x7f;
> > > > > +			w->num_bytes = buf[++idx];
> > > > > +			w->bytes = kmemdup(&buf[++idx], w->num_bytes,
> > > > > +					   GFP_KERNEL);
> > > > > +			if (!w->bytes)
> > > > > +				return -ENOMEM;
> > > > > +		}
> > > > > +		break;
> > > > > +	}
> > > > 
> > > > For safety: Should we validate cur_len here? Or return it, and let the
> > > > caller deal with any mismatches.
> > > > 
> > > > But I'm kinda leaning towards no safety here, since it's not dealing
> > > > with
> > > > any replies we get from the hw/externally, which might be used for
> > > > attacking us. If we later on have the same thing but for
> > > > drm_dp_sideband_parse_reply() then a lot more fun.
> > > > 
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_decode_sideband_req);
> > > > > +
> > > > > +void
> > > > > +drm_dp_dump_sideband_msg_req_body(const struct
> > > > > drm_dp_sideband_msg_req_body *req,
> > > > > +				  int indent, struct drm_printer
> > > > > *printer)
> > > > > +{
> > > > > +	int i;
> > > > > +
> > > > > +#define P(f, ...) drm_printf_indent(printer, indent, f,
> > > > > ##__VA_ARGS__)
> > > > > +	if (req->req_type == DP_LINK_ADDRESS) {
> > > > > +		/* No contents to print */
> > > > > +		P("type=%s\n", drm_dp_mst_req_type_str(req-
> > > > > >req_type));
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	P("type=%s contents:\n", drm_dp_mst_req_type_str(req-
> > > > > >req_type));
> > > > > +	indent++;
> > > > > +
> > > > > +	switch (req->req_type) {
> > > > > +	case DP_ENUM_PATH_RESOURCES:
> > > > > +	case DP_POWER_DOWN_PHY:
> > > > > +	case DP_POWER_UP_PHY:
> > > > > +		P("port=%d\n", req->u.port_num.port_number);
> > > > > +		break;
> > > > > +	case DP_ALLOCATE_PAYLOAD:
> > > > > +		P("port=%d vcpi=%d pbn=%d sdp_streams=%d %*ph\n",
> > > > > +		  req->u.allocate_payload.port_number,
> > > > > +		  req->u.allocate_payload.vcpi, req-
> > > > > >u.allocate_payload.pbn,
> > > > > +		  req->u.allocate_payload.number_sdp_streams,
> > > > > +		  req->u.allocate_payload.number_sdp_streams,
> > > > > +		  req->u.allocate_payload.sdp_stream_sink);
> > > > > +		break;
> > > > > +	case DP_QUERY_PAYLOAD:
> > > > > +		P("port=%d vcpi=%d\n",
> > > > > +		  req->u.query_payload.port_number,
> > > > > +		  req->u.query_payload.vcpi);
> > > > > +		break;
> > > > > +	case DP_REMOTE_DPCD_READ:
> > > > > +		P("port=%d dpcd_addr=%05x len=%d\n",
> > > > > +		  req->u.dpcd_read.port_number, req-
> > > > > >u.dpcd_read.dpcd_address,
> > > > > +		  req->u.dpcd_read.num_bytes);
> > > > > +		break;
> > > > > +	case DP_REMOTE_DPCD_WRITE:
> > > > > +		P("port=%d addr=%05x len=%d: %*ph\n",
> > > > > +		  req->u.dpcd_write.port_number,
> > > > > +		  req->u.dpcd_write.dpcd_address,
> > > > > +		  req->u.dpcd_write.num_bytes, req-
> > > > > >u.dpcd_write.num_bytes,
> > > > > +		  req->u.dpcd_write.bytes);
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_READ:
> > > > > +		P("port=%d num_tx=%d id=%d size=%d:\n",
> > > > > +		  req->u.i2c_read.port_number,
> > > > > +		  req->u.i2c_read.num_transactions,
> > > > > +		  req->u.i2c_read.read_i2c_device_id,
> > > > > +		  req->u.i2c_read.num_bytes_read);
> > > > > +
> > > > > +		indent++;
> > > > > +		for (i = 0; i < req->u.i2c_read.num_transactions; i++)
> > > > > {
> > > > > +			const struct drm_dp_remote_i2c_read_tx *rtx =
> > > > > +				&req->u.i2c_read.transactions[i];
> > > > > +
> > > > > +			P("%d: id=%03d size=%03d no_stop_bit=%d
> > > > > tx_delay=%03d:
> > > > > %*ph\n",
> > > > > +			  i, rtx->i2c_dev_id, rtx->num_bytes,
> > > > > +			  rtx->no_stop_bit, rtx-
> > > > > >i2c_transaction_delay,
> > > > > +			  rtx->num_bytes, rtx->bytes);
> > > > > +		}
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_WRITE:
> > > > > +		P("port=%d id=%d size=%d: %*ph\n",
> > > > > +		  req->u.i2c_write.port_number,
> > > > > +		  req->u.i2c_write.write_i2c_device_id,
> > > > > +		  req->u.i2c_write.num_bytes, req-
> > > > > >u.i2c_write.num_bytes,
> > > > > +		  req->u.i2c_write.bytes);
> > > > > +		break;
> > > > > +	default:
> > > > > +		P("???\n");
> > > > > +		break;
> > > > > +	}
> > > > > +#undef P
> > > > > +}
> > > > > +EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_dump_sideband_msg_req_body);
> > > > > +
> > > > > +static inline void
> > > > > +drm_dp_mst_dump_sideband_msg_tx(struct drm_printer *p,
> > > > > +				const struct drm_dp_sideband_msg_tx
> > > > > *txmsg)
> > > > > +{
> > > > > +	struct drm_dp_sideband_msg_req_body req;
> > > > > +	char buf[64];
> > > > > +	int ret;
> > > > > +	int i;
> > > > > +
> > > > > +	drm_dp_mst_rad_to_str(txmsg->dst->rad, txmsg->dst->lct, buf,
> > > > > +			      sizeof(buf));
> > > > > +	drm_printf(p, "txmsg cur_offset=%x cur_len=%x seqno=%x
> > > > > state=%s
> > > > > path_msg=%d dst=%s\n",
> > > > > +		   txmsg->cur_offset, txmsg->cur_len, txmsg->seqno,
> > > > > +		   drm_dp_mst_sideband_tx_state_str(txmsg->state),
> > > > > +		   txmsg->path_msg, buf);
> > > > > +
> > > > > +	ret = drm_dp_decode_sideband_req(txmsg, &req);
> > > > > +	if (ret) {
> > > > > +		drm_printf(p, "<failed to decode sideband req: %d>\n",
> > > > > ret);
> > > > > +		return;
> > > > > +	}
> > > > > +	drm_dp_dump_sideband_msg_req_body(&req, 1, p);
> > > > > +
> > > > > +	switch (req.req_type) {
> > > > > +	case DP_REMOTE_DPCD_WRITE:
> > > > > +		kfree(req.u.dpcd_write.bytes);
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_READ:
> > > > > +		for (i = 0; i < req.u.i2c_read.num_transactions; i++)
> > > > > +			kfree(req.u.i2c_read.transactions[i].bytes);
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_WRITE:
> > > > > +		kfree(req.u.i2c_write.bytes);
> > > > > +		break;
> > > > > +	}
> > > > > +}
> > > > >  
> > > > >  static void drm_dp_crc_sideband_chunk_req(u8 *msg, u8 len)
> > > > >  {
> > > > > @@ -893,6 +1178,11 @@ static int drm_dp_mst_wait_tx_reply(struct
> > > > > drm_dp_mst_branch *mstb,
> > > > >  		}
> > > > >  	}
> > > > >  out:
> > > > > +	if (unlikely(ret == -EIO && drm_debug & (DRM_UT_DP |
> > > > > DRM_UT_KMS))) {
> > > > 
> > > > Hm I'd only check for DRM_UT_DP here.
> 
> Was going to go ahead with this, but realized it might not be a great idea.
> One of the reasons I went with DRM_UT_DP | DRM_UT_KMS here is because
> generally, I'd assume that (this is the case for me at least) DRM_UT_DP serves
> as a way to trace what's going on with DP, and DRM_UT_KMS is for non-atomic
> specific modesetting debug info. That being said, if we fail sending a message
> like PAYLOAD_ALLOCATE then the modeset itself is going to not work correctly
> and thus - the contents of failure would still be relevant to someone working
> on modesetting issues even if they're not interested in the entirity of what's
> going on between the sink and the source.
> 
> That, and we were already printing when messages timed out under DRM_UT_KMS.
> Granted though, that printing was added well before I introduced DRM_UT_DP.
> However, I suppose I could just move that back to using DRM_DEBUG_KMS() and
> dump the sideband message seperately.
> 
> Maybe I'm overthinking this a bit, thoughts?

Yes. Or at least, the drm debugging stuff we have is a mess already, let's
try to not make it even more fun. I think consistently using DP for this
stuff would make a lot more sense (and for general debugging I guess
everyone just gets to add the DP bit to their drm.debug option).
-Daniel

> 
> > > > 
> > > > > +		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > > > > +
> > > > > +		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > > > > +	}
> > > > >  	mutex_unlock(&mgr->qlock);
> > > > >  
> > > > >  	return ret;
> > > > > @@ -1927,8 +2217,11 @@ static int process_single_tx_qlock(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >  	idx += tosend + 1;
> > > > >  
> > > > >  	ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
> > > > > -	if (ret) {
> > > > > -		DRM_DEBUG_KMS("sideband msg failed to send\n");
> > > > > +	if (ret && unlikely(drm_debug & (DRM_UT_DP | DRM_UT_KMS))) {
> > > > 
> > > > Same.
> > > > 
> > > > > +		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > > > > +
> > > > > +		drm_printf(&p, "sideband msg failed to send\n");
> > > > > +		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > > > >  		return ret;
> > > > >  	}
> > > > >  
> > > > > @@ -1990,6 +2283,13 @@ static void drm_dp_queue_down_tx(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >  {
> > > > >  	mutex_lock(&mgr->qlock);
> > > > >  	list_add_tail(&txmsg->next, &mgr->tx_msg_downq);
> > > > > +
> > > > > +	if (unlikely(drm_debug & DRM_UT_DP)) {
> > > > 
> > > > Like you do here.
> > > > 
> > > > > +		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > > > > +
> > > > > +		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > > > > +	}
> > > > > +
> > > > >  	if (list_is_singular(&mgr->tx_msg_downq))
> > > > >  		process_single_down_tx_qlock(mgr);
> > > > >  	mutex_unlock(&mgr->qlock);
> > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > > > > b/drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > > > > new file mode 100644
> > > > > index 000000000000..eeda9a61c657
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > > > > @@ -0,0 +1,24 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-only
> > > > > + *
> > > > > + * Declarations for DP MST related functions which are only used in
> > > > > selftests
> > > > > + *
> > > > > + * Copyright © 2018 Red Hat
> > > > > + * Authors:
> > > > > + *     Lyude Paul <lyude@redhat.com>
> > > > > + */
> > > > > +
> > > > > +#ifndef _DRM_DP_MST_HELPER_INTERNAL_H_
> > > > > +#define _DRM_DP_MST_HELPER_INTERNAL_H_
> > > > > +
> > > > > +#include <drm/drm_dp_mst_helper.h>
> > > > > +
> > > > > +void
> > > > > +drm_dp_encode_sideband_req(const struct drm_dp_sideband_msg_req_body
> > > > > *req,
> > > > > +			   struct drm_dp_sideband_msg_tx *raw);
> > > > > +int drm_dp_decode_sideband_req(const struct drm_dp_sideband_msg_tx
> > > > > *raw,
> > > > > +			       struct drm_dp_sideband_msg_req_body
> > > > > *req);
> > > > > +void
> > > > > +drm_dp_dump_sideband_msg_req_body(const struct
> > > > > drm_dp_sideband_msg_req_body *req,
> > > > > +				  int indent, struct drm_printer
> > > > > *printer);
> > > > > +
> > > > > +#endif /* !_DRM_DP_MST_HELPER_INTERNAL_H_ */
> > > > > diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > > > > b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > > > > index dec3ee3ec96f..1898de0b4a4d 100644
> > > > > --- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > > > > +++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > > > > @@ -33,3 +33,4 @@ selftest(damage_iter_damage_one_outside,
> > > > > igt_damage_iter_damage_one_outside)
> > > > >  selftest(damage_iter_damage_src_moved,
> > > > > igt_damage_iter_damage_src_moved)
> > > > >  selftest(damage_iter_damage_not_visible,
> > > > > igt_damage_iter_damage_not_visible)
> > > > >  selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
> > > > > +selftest(dp_mst_sideband_msg_req_decode,
> > > > > igt_dp_mst_sideband_msg_req_decode)
> > > > > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > index 51b2486ec917..ceca89babd65 100644
> > > > > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > @@ -8,6 +8,7 @@
> > > > >  #include <drm/drm_dp_mst_helper.h>
> > > > >  #include <drm/drm_print.h>
> > > > >  
> > > > > +#include "../drm_dp_mst_topology_internal.h"
> > > > >  #include "test-drm_modeset_common.h"
> > > > >  
> > > > >  int igt_dp_mst_calc_pbn_mode(void *ignored)
> > > > > @@ -34,3 +35,214 @@ int igt_dp_mst_calc_pbn_mode(void *ignored)
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > > > +
> > > > > +static bool
> > > > > +sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> > > > > +		       const struct drm_dp_sideband_msg_req_body *out)
> > > > > +{
> > > > > +	const struct drm_dp_remote_i2c_read_tx *txin, *txout;
> > > > > +	int i;
> > > > > +
> > > > > +	if (in->req_type != out->req_type)
> > > > > +		return false;
> > > > > +
> > > > > +	switch (in->req_type) {
> > > > > +	case DP_ENUM_PATH_RESOURCES:
> > > > > +	case DP_POWER_UP_PHY:
> > > > > +	case DP_POWER_DOWN_PHY:
> > > > > +	case DP_ALLOCATE_PAYLOAD:
> > > > > +	case DP_QUERY_PAYLOAD:
> > > > > +	case DP_REMOTE_DPCD_READ:
> > > > > +		return memcmp(in, out, sizeof(*in)) == 0;
> > > > 
> > > > Just memcmp the entire thing for everyrone (we assume kzalloc anyway),
> > > > and
> > > > then only have the additional checks for the few cases we need it? Would
> > > > slightly reduce the code.
> > > 
> > > Just realized also - this wouldn't work: remember that I2C_READ,
> > > DPCD_WRITE,
> > > and I2C_WRITE contain pointers which of course will be different even if
> > > the
> > > contents are the same. Unfortunately I don't think there's really a good
> > > solution for this, unless we want to just remove the pointers and store
> > > things
> > > within the down request struct itself
> > 
> > Uh ... disappoint :-/
> > 
> > Then at least put that into a comment, and maybe make this the default:
> > handler?
> > > > > +
> > > > > +	case DP_REMOTE_I2C_READ:
> > > > > +#define IN in->u.i2c_read
> > > > > +#define OUT out->u.i2c_read
> > > > > +		if (IN.num_bytes_read != OUT.num_bytes_read ||
> > > > > +		    IN.num_transactions != OUT.num_transactions ||
> > > > > +		    IN.port_number != OUT.port_number ||
> > > > > +		    IN.read_i2c_device_id != OUT.read_i2c_device_id)
> > > > > +			return false;
> > > > > +
> > > > > +		for (i = 0; i < IN.num_transactions; i++) {
> > > > > +			txin = &IN.transactions[i];
> > > > > +			txout = &OUT.transactions[i];
> > > > > +
> > > > > +			if (txin->i2c_dev_id != txout->i2c_dev_id ||
> > > > > +			    txin->no_stop_bit != txout->no_stop_bit ||
> > > > > +			    txin->num_bytes != txout->num_bytes ||
> > > > > +			    txin->i2c_transaction_delay !=
> > > > > +			    txout->i2c_transaction_delay)
> > > > > +				return false;
> > > > > +
> > > > > +			if (memcmp(txin->bytes, txout->bytes,
> > > > > +				   txin->num_bytes) != 0)
> > > > > +				return false;
> > > > > +		}
> > > > > +		break;
> > > > > +#undef IN
> > > > > +#undef OUT
> > > > > +
> > > > > +	case DP_REMOTE_DPCD_WRITE:
> > > > > +#define IN in->u.dpcd_write
> > > > > +#define OUT out->u.dpcd_write
> > > > > +		if (IN.dpcd_address != OUT.dpcd_address ||
> > > > > +		    IN.num_bytes != OUT.num_bytes ||
> > > > > +		    IN.port_number != OUT.port_number)
> > > > > +			return false;
> > > > > +
> > > > > +		return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
> > > > > +#undef IN
> > > > > +#undef OUT
> > > > > +
> > > > > +	case DP_REMOTE_I2C_WRITE:
> > > > > +#define IN in->u.i2c_write
> > > > > +#define OUT out->u.i2c_write
> > > > > +		if (IN.port_number != OUT.port_number ||
> > > > > +		    IN.write_i2c_device_id != OUT.write_i2c_device_id
> > > > > ||
> > > > > +		    IN.num_bytes != OUT.num_bytes)
> > > > > +			return false;
> > > > > +
> > > > > +		return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
> > > > > +#undef IN
> > > > > +#undef OUT
> > > > > +	}
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +static int
> > > > > +__sideband_msg_req_encode_decode(int line,
> > > > > +				 struct drm_dp_sideband_msg_req_body
> > > > > *in,
> > > > > +				 struct drm_dp_sideband_msg_req_body
> > > > > *out)
> > > > > +{
> > > > > +	struct drm_printer p = drm_err_printer(pr_fmt());
> > > > > +	struct drm_dp_sideband_msg_tx txmsg;
> > > > > +	int i, ret;
> > > > > +	bool eq;
> > > > > +
> > > > > +	drm_dp_encode_sideband_req(in, &txmsg);
> > > > > +	ret = drm_dp_decode_sideband_req(&txmsg, out);
> > > > > +	if (ret < 0) {
> > > > > +		pr_err(pr_fmt("Failed to decode sideband request @
> > > > > line %d:
> > > > > %d\n"),
> > > > > +		       line, ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	eq = sideband_msg_req_equal(in, out);
> > > > > +	if (!eq) {
> > > > > +		pr_err(pr_fmt("Encode/decode @ line %d failed,
> > > > > expected:\n"),
> > > > > +		       line);
> > > > > +		drm_dp_dump_sideband_msg_req_body(in, 1, &p);
> > > > > +		pr_err(pr_fmt("Got:\n"));
> > > > > +		drm_dp_dump_sideband_msg_req_body(out, 1, &p);
> > > > > +	}
> > > > > +
> > > > > +	switch (in->req_type) {
> > > > > +	case DP_REMOTE_DPCD_WRITE:
> > > > > +		kfree(out->u.dpcd_write.bytes);
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_READ:
> > > > > +		for (i = 0; i < out->u.i2c_read.num_transactions; i++)
> > > > > +			kfree(out->u.i2c_read.transactions[i].bytes);
> > > > > +		break;
> > > > > +	case DP_REMOTE_I2C_WRITE:
> > > > > +		kfree(out->u.i2c_write.bytes);
> > > > > +		break;
> > > > > +	}
> > > > > +
> > > > > +	/* Clear everything but the req_type for the input */
> > > > > +	memset(&in->u, 0, sizeof(in->u));
> > > > > +
> > > > > +	/* Clear the output entirely */
> > > > > +	memset(out, 0, sizeof(*out));
> > > > > +
> > > > > +	return eq ? 0 : -EINVAL;
> > > > > +}
> > > > > +
> > > > > +int igt_dp_mst_sideband_msg_req_decode(void *unused)
> > > > > +{
> > > > > +	struct drm_dp_sideband_msg_req_body in = { 0 }, out = { 0 };
> > > > > +	u8 data[] = { 0xff, 0x0, 0xdd };
> > > > > +	int i;
> > > > > +
> > > > > +#define
> > > > > DO_TEST()                                                          \
> > > > > +	do
> > > > > {                                                               \
> > > > > +		if (__sideband_msg_req_encode_decode(__LINE__, &in,
> > > > > &out)) \
> > > > > +			return
> > > > > -EINVAL;                                    \
> > > > > +	} while (0)
> > > > 
> > > > I had a tiny wtf moment here until I realized this is a macro ... maybe
> > > > put the do on the first line and indent everything? Pure bikeshed to
> > > > help
> > > > the blind ...
> > > > 
> > > > > +
> > > > > +	in.req_type = DP_ENUM_PATH_RESOURCES;
> > > > > +	in.u.port_num.port_number = 5;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_POWER_UP_PHY;
> > > > > +	in.u.port_num.port_number = 5;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_POWER_DOWN_PHY;
> > > > > +	in.u.port_num.port_number = 5;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_ALLOCATE_PAYLOAD;
> > > > > +	in.u.allocate_payload.number_sdp_streams = 3;
> > > > > +	for (i = 0; i < in.u.allocate_payload.number_sdp_streams; i++)
> > > > > +		in.u.allocate_payload.sdp_stream_sink[i] = i + 1;
> > > > > +	DO_TEST();
> > > > > +	in.u.allocate_payload.port_number = 0xf;
> > > > > +	DO_TEST();
> > > > > +	in.u.allocate_payload.vcpi = 0x7f;
> > > > > +	DO_TEST();
> > > > > +	in.u.allocate_payload.pbn = U16_MAX;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_QUERY_PAYLOAD;
> > > > > +	in.u.query_payload.port_number = 0xf;
> > > > > +	DO_TEST();
> > > > > +	in.u.query_payload.vcpi = 0x7f;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_REMOTE_DPCD_READ;
> > > > > +	in.u.dpcd_read.port_number = 0xf;
> > > > > +	DO_TEST();
> > > > > +	in.u.dpcd_read.dpcd_address = 0xfedcb;
> > > > > +	DO_TEST();
> > > > > +	in.u.dpcd_read.num_bytes = U8_MAX;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_REMOTE_DPCD_WRITE;
> > > > > +	in.u.dpcd_write.port_number = 0xf;
> > > > > +	DO_TEST();
> > > > > +	in.u.dpcd_write.dpcd_address = 0xfedcb;
> > > > > +	DO_TEST();
> > > > > +	in.u.dpcd_write.num_bytes = ARRAY_SIZE(data);
> > > > > +	in.u.dpcd_write.bytes = data;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_REMOTE_I2C_READ;
> > > > > +	in.u.i2c_read.port_number = 0xf;
> > > > > +	DO_TEST();
> > > > > +	in.u.i2c_read.read_i2c_device_id = 0x7f;
> > > > > +	DO_TEST();
> > > > > +	in.u.i2c_read.num_transactions = 3;
> > > > > +	in.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3;
> > > > > +	for (i = 0; i < in.u.i2c_read.num_transactions; i++) {
> > > > > +		in.u.i2c_read.transactions[i].bytes = data;
> > > > > +		in.u.i2c_read.transactions[i].num_bytes =
> > > > > ARRAY_SIZE(data);
> > > > > +		in.u.i2c_read.transactions[i].i2c_dev_id = 0x7f & ~i;
> > > > > +		in.u.i2c_read.transactions[i].i2c_transaction_delay =
> > > > > 0xf &
> > > > > ~i;
> > > > > +	}
> > > > > +	DO_TEST();
> > > > > +
> > > > > +	in.req_type = DP_REMOTE_I2C_WRITE;
> > > > > +	in.u.i2c_write.port_number = 0xf;
> > > > > +	DO_TEST();
> > > > > +	in.u.i2c_write.write_i2c_device_id = 0x7f;
> > > > > +	DO_TEST();
> > > > > +	in.u.i2c_write.num_bytes = ARRAY_SIZE(data);
> > > > > +	in.u.i2c_write.bytes = data;
> > > > > +	DO_TEST();
> > > > > +
> > > > > +#undef DO_TEST
> > > > > +	return 0;
> > > > > +}
> > > > 
> > > > Extremely nice, more unit tests ftw!
> > > > 
> > > > With the nits somehow figured out: Reviewed-by: Daniel Vetter <
> > > > daniel.vetter@ffwll.ch>
> > > > 
> > > > > diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > > > > b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > > > > index 590bda35a683..0fcb8bbc6a1b 100644
> > > > > --- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > > > > +++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > > > > @@ -40,5 +40,6 @@ int igt_damage_iter_damage_one_outside(void
> > > > > *ignored);
> > > > >  int igt_damage_iter_damage_src_moved(void *ignored);
> > > > >  int igt_damage_iter_damage_not_visible(void *ignored);
> > > > >  int igt_dp_mst_calc_pbn_mode(void *ignored);
> > > > > +int igt_dp_mst_sideband_msg_req_decode(void *ignored);
> > > > >  
> > > > >  #endif
> > > > > diff --git a/include/drm/drm_dp_mst_helper.h
> > > > > b/include/drm/drm_dp_mst_helper.h
> > > > > index c01f3ea72756..4c8d177e83e5 100644
> > > > > --- a/include/drm/drm_dp_mst_helper.h
> > > > > +++ b/include/drm/drm_dp_mst_helper.h
> > > > > @@ -293,7 +293,7 @@ struct drm_dp_remote_dpcd_write {
> > > > >  struct drm_dp_remote_i2c_read {
> > > > >  	u8 num_transactions;
> > > > >  	u8 port_number;
> > > > > -	struct {
> > > > > +	struct drm_dp_remote_i2c_read_tx {
> > > > >  		u8 i2c_dev_id;
> > > > >  		u8 num_bytes;
> > > > >  		u8 *bytes;
> > > > > -- 
> > > > > 2.21.0
> > > > > 
> > > -- 
> > > Cheers,
> > > 	Lyude Paul
> > > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
