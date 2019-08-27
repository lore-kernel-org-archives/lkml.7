Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF7421883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfH0Qnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfH0Qnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:43:41 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07758796E6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:43:39 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id f28so21374704qtg.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Kc/zyAaj0GQWHI4LA1cD6ct1AQMvRBuLM7N03jjZUDI=;
        b=jyFNdtYa0JybxU9ij5+V1T/hYuWzID8Aljn8KYTZbYUh2KtcLCtUOt2r9bRnkKKvWJ
         MgVmdUJ3ulJbCsK0KIwwRpgW0zYWh5KXzDPXU/dK+szEEMQhwrzzrtK78L2RWJvLX6c8
         H7aFuRehAEgSqV4Ic6PI5tYcHkRle7Dagk/AgZo8CTdFH2HOO6dYA0JqrpV60mL81yzv
         ojGLLQ07RWMSsX3AtMVOM807hQBw44zRfwYx6Wi2Pm92nVGnGtg8/VuAzP7TBVBIM7TL
         Tgr9AVMnQxj9bR5DnLmmw/b8AIiPrJS+Y13mQ9mMvgZtPi/oG9p0YthagaYkuQF0j5wW
         E4Ww==
X-Gm-Message-State: APjAAAVQQ1W/ykA3K5gBofvb9+GBki+LzRChupymlnW1ljMf68DesCcF
        MO+pku4ufi6bNJL/UHKicFUC+m4PZK5tsf+NEehYoNsObEpVTbPxP7WWPbY2/KHa/PIbxwbxxaD
        u6/CQfc5QZSbtvDYJglcwTMXW
X-Received: by 2002:ac8:19fa:: with SMTP id s55mr23834022qtk.155.1566924214799;
        Tue, 27 Aug 2019 09:43:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzO4MMWDQd19ANoyHeH0jnhkd3Yq5FHaX+67v9bOXrLIwlZB6zWtuIALhsWZw1iOuidX8ujBg==
X-Received: by 2002:ac8:19fa:: with SMTP id s55mr23833890qtk.155.1566924213239;
        Tue, 27 Aug 2019 09:43:33 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id q42sm10872415qtc.52.2019.08.27.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:43:32 -0700 (PDT)
Message-ID: <2c728691a6fd04c2e05676eafc664b8e0b707f75.camel@redhat.com>
Subject: Re: [PATCH 05/26] drm/dp_mst: Add sideband down request tracing +
 selftests
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Deepak Rawat <drawat@vmware.com>, linux-kernel@vger.kernel.org
Date:   Tue, 27 Aug 2019 12:43:31 -0400
In-Reply-To: <20190813145048.GV7444@phenom.ffwll.local>
References: <20190718014329.8107-1-lyude@redhat.com>
         <20190718014329.8107-6-lyude@redhat.com>
         <20190813145048.GV7444@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-13 at 16:50 +0200, Daniel Vetter wrote:
> On Wed, Jul 17, 2019 at 09:42:28PM -0400, Lyude Paul wrote:
> > Unfortunately the DP MST helpers do not have much in the way of
> > debugging utilities. So, let's add some!
> > 
> > This adds basic debugging output for down sideband requests that we send
> > from the driver, so that we can actually discern what's happening when
> > sideband requests timeout. Note that with this commit, we'll be dumping
> > out sideband requests under both of the following conditions:
> > 
> > - When the user has enabled DRM_UT_DP output, of course.
> > - When the user has enabled DRM_UT_KMS or DRM_UT_DP, and a sideband
> >   request has failed in some way. This will allow for developers to get
> >   a basic idea of what's actually happening with failed modesets on MST,
> >   without needing to have DRM_UT_DP explicitly enabled.
> > 
> > Since there wasn't really a good way of testing that any of this worked,
> > I ended up writing simple selftests that lightly test sideband message
> > encoding and decoding as well. Enjoy!
> > 
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c         | 308 +++++++++++++++++-
> >  .../gpu/drm/drm_dp_mst_topology_internal.h    |  24 ++
> >  .../gpu/drm/selftests/drm_modeset_selftests.h |   1 +
> >  .../drm/selftests/test-drm_dp_mst_helper.c    | 212 ++++++++++++
> >  .../drm/selftests/test-drm_modeset_common.h   |   1 +
> >  include/drm/drm_dp_mst_helper.h               |   2 +-
> >  6 files changed, 543 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 9e382117896d..defc5e09fb9a 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -36,6 +36,8 @@
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_probe_helper.h>
> >  
> > +#include "drm_dp_mst_topology_internal.h"
> > +
> >  /**
> >   * DOC: dp mst helper
> >   *
> > @@ -68,6 +70,8 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_aux
> > *aux);
> >  static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_aux *aux);
> >  static void drm_dp_mst_kick_tx(struct drm_dp_mst_topology_mgr *mgr);
> >  
> > +#define DBG_PREFIX "[dp_mst]"
> > +
> >  #define DP_STR(x) [DP_ ## x] = #x
> >  
> >  static const char *drm_dp_mst_req_type_str(u8 req_type)
> > @@ -124,6 +128,43 @@ static const char *drm_dp_mst_nak_reason_str(u8
> > nak_reason)
> >  }
> >  
> >  #undef DP_STR
> > +#define DP_STR(x) [DRM_DP_SIDEBAND_TX_ ## x] = #x
> > +
> > +static const char *drm_dp_mst_sideband_tx_state_str(int state)
> > +{
> > +	static const char * const sideband_reason_str[] = {
> > +		DP_STR(QUEUED),
> > +		DP_STR(START_SEND),
> > +		DP_STR(SENT),
> > +		DP_STR(RX),
> > +		DP_STR(TIMEOUT),
> > +	};
> > +
> > +	if (state >= ARRAY_SIZE(sideband_reason_str) ||
> > +	    !sideband_reason_str[state])
> > +		return "unknown";
> > +
> > +	return sideband_reason_str[state];
> > +}
> > +
> > +static int
> > +drm_dp_mst_rad_to_str(const u8 rad[8], u8 lct, char *out, size_t len)
> > +{
> > +	int i;
> > +	u8 unpacked_rad[16];
> > +
> > +	for (i = 0; i < lct; i++) {
> > +		if (i % 2)
> > +			unpacked_rad[i] = rad[i / 2] >> 4;
> > +		else
> > +			unpacked_rad[i] = rad[i / 2] & BIT_MASK(4);
> > +	}
> > +
> > +	/* TODO: Eventually add something to printk so we can format the rad
> > +	 * like this: 1.2.3
> > +	 */
> 
> 	lct *=2;
> 
> missing here? And yeah the todo would be sweet, but quite a bit more
> typing I guess.

Nope-although I see why one might assume that. lct == Link Count Total, e.g.
how many nodes we have to hop until we reach our destination. Each segment of
the RAD is packed as 4 bits, but the LCT is just stored as a plain value.
> 
> > +	return snprintf(out, len, "%*phC", lct, unpacked_rad);
> > +}
> >  
> >  /* sideband msg handling */
> >  static u8 drm_dp_msg_header_crc4(const uint8_t *data, size_t num_nibbles)
> > @@ -256,8 +297,9 @@ static bool drm_dp_decode_sideband_msg_hdr(struct
> > drm_dp_sideband_msg_hdr *hdr,
> >  	return true;
> >  }
> >  
> > -static void drm_dp_encode_sideband_req(struct
> > drm_dp_sideband_msg_req_body *req,
> > -				       struct drm_dp_sideband_msg_tx *raw)
> > +void
> > +drm_dp_encode_sideband_req(const struct drm_dp_sideband_msg_req_body
> > *req,
> > +			   struct drm_dp_sideband_msg_tx *raw)
> >  {
> >  	int idx = 0;
> >  	int i;
> > @@ -362,6 +404,249 @@ static void drm_dp_encode_sideband_req(struct
> > drm_dp_sideband_msg_req_body *req,
> >  	}
> >  	raw->cur_len = idx;
> >  }
> > +EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_encode_sideband_req);
> > +
> > +/* Decode a sideband request we've encoded, mainly used for debugging */
> > +int
> > +drm_dp_decode_sideband_req(const struct drm_dp_sideband_msg_tx *raw,
> > +			   struct drm_dp_sideband_msg_req_body *req)
> > +{
> > +	const u8 *buf = raw->msg;
> > +	int i, idx = 0;
> > +
> > +	req->req_type = buf[idx++] & 0x7f;
> > +	switch (req->req_type) {
> > +	case DP_ENUM_PATH_RESOURCES:
> > +	case DP_POWER_DOWN_PHY:
> > +	case DP_POWER_UP_PHY:
> 
> OCD warning: the enum isn't ordered the same way here and in
> drm_dp_encode_sideband_req().
> 
> > +		req->u.port_num.port_number = (buf[idx] >> 4) & 0xf;
> > +		break;
> > +	case DP_ALLOCATE_PAYLOAD:
> > +		{
> > +			struct drm_dp_allocate_payload *a =
> > +				&req->u.allocate_payload;
> > +
> > +			a->number_sdp_streams = buf[idx] & 0xf;
> > +			a->port_number = (buf[idx] >> 4) & 0xf;
> > +
> > +			a->vcpi = buf[++idx] & 0x7f;
> 
> Complain here if 0x80 is set?
> 
> > +
> > +			a->pbn = buf[++idx] << 8;
> > +			a->pbn |= buf[++idx];
> > +
> > +			idx++;
> > +			for (i = 0; i < a->number_sdp_streams; i++) {
> > +				a->sdp_stream_sink[i] =
> > +					(buf[idx + (i / 2)] >> ((i % 2) ? 0 :
> > 4)) & 0xf;
> > +			}
> > +		}
> > +		break;
> > +	case DP_QUERY_PAYLOAD:
> > +		req->u.query_payload.port_number = (buf[idx] >> 4) & 0xf;
> > +		req->u.query_payload.vcpi = buf[++idx] & 0x7f;
> 
> Same here for the highest bit?
> 
> > +		break;
> > +	case DP_REMOTE_DPCD_READ:
> > +		{
> > +			struct drm_dp_remote_dpcd_read *r = &req->u.dpcd_read;
> > +
> > +			r->port_number = (buf[idx] >> 4) & 0xf;
> > +
> > +			r->dpcd_address = (buf[idx] << 16) & 0xf0000;
> > +			r->dpcd_address |= (buf[++idx] << 8) & 0xff00;
> > +			r->dpcd_address |= buf[++idx] & 0xff;
> > +
> > +			r->num_bytes = buf[++idx];
> > +		}
> > +		break;
> > +	case DP_REMOTE_DPCD_WRITE:
> > +		{
> > +			struct drm_dp_remote_dpcd_write *w =
> > +				&req->u.dpcd_write;
> > +
> > +			w->port_number = (buf[idx] >> 4) & 0xf;
> > +
> > +			w->dpcd_address = (buf[idx] << 16) & 0xf0000;
> > +			w->dpcd_address |= (buf[++idx] << 8) & 0xff00;
> > +			w->dpcd_address |= buf[++idx] & 0xff;
> > +
> > +			w->num_bytes = buf[++idx];
> > +
> > +			w->bytes = kmemdup(&buf[++idx], w->num_bytes,
> > +					   GFP_KERNEL);
> 
> But if we go really strict on validation we'd need to make sure we don't
> walk past raw->cur_len ... probably not worth it?
> 
> > +			if (!w->bytes)
> > +				return -ENOMEM;
> > +		}
> > +		break;
> > +	case DP_REMOTE_I2C_READ:
> > +		{
> > +			struct drm_dp_remote_i2c_read *r = &req->u.i2c_read;
> > +			struct drm_dp_remote_i2c_read_tx *tx;
> > +			bool failed = false;
> > +
> > +			r->num_transactions = buf[idx] & 0x3;
> > +			r->port_number = (buf[idx] >> 4) & 0xf;
> > +			for (i = 0; i < r->num_transactions; i++) {
> > +				tx = &r->transactions[i];
> > +
> > +				tx->i2c_dev_id = buf[++idx] & 0x7f;
> > +				tx->num_bytes = buf[++idx];
> > +				tx->bytes = kmemdup(&buf[++idx],
> > +						    tx->num_bytes,
> > +						    GFP_KERNEL);
> > +				if (!tx->bytes) {
> > +					failed = true;
> > +					break;
> > +				}
> > +				idx += tx->num_bytes;
> > +				tx->no_stop_bit = (buf[idx] >> 5) & 0x1;
> > +				tx->i2c_transaction_delay = buf[idx] & 0xf;
> > +			}
> > +
> > +			if (failed) {
> > +				for (i = 0; i < r->num_transactions; i++)
> > +					kfree(tx->bytes);
> > +				return -ENOMEM;
> > +			}
> > +
> > +			r->read_i2c_device_id = buf[++idx] & 0x7f;
> > +			r->num_bytes_read = buf[++idx];
> > +		}
> > +		break;
> > +	case DP_REMOTE_I2C_WRITE:
> > +		{
> > +			struct drm_dp_remote_i2c_write *w = &req->u.i2c_write;
> > +
> > +			w->port_number = (buf[idx] >> 4) & 0xf;
> > +			w->write_i2c_device_id = buf[++idx] & 0x7f;
> > +			w->num_bytes = buf[++idx];
> > +			w->bytes = kmemdup(&buf[++idx], w->num_bytes,
> > +					   GFP_KERNEL);
> > +			if (!w->bytes)
> > +				return -ENOMEM;
> > +		}
> > +		break;
> > +	}
> 
> For safety: Should we validate cur_len here? Or return it, and let the
> caller deal with any mismatches.
> 
> But I'm kinda leaning towards no safety here, since it's not dealing with
> any replies we get from the hw/externally, which might be used for
> attacking us. If we later on have the same thing but for
> drm_dp_sideband_parse_reply() then a lot more fun.

Yeah-this was my thinking as well. Additionally, I should probably note the
next batch of patches I'm going to try getting in afterwards actually adds
selftests for our length checking :)

(fun fact: so far, those selftests seem to indicate we're actually doing quite
well at verifying length. Mostly.)

> 
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_decode_sideband_req);
> > +
> > +void
> > +drm_dp_dump_sideband_msg_req_body(const struct
> > drm_dp_sideband_msg_req_body *req,
> > +				  int indent, struct drm_printer *printer)
> > +{
> > +	int i;
> > +
> > +#define P(f, ...) drm_printf_indent(printer, indent, f, ##__VA_ARGS__)
> > +	if (req->req_type == DP_LINK_ADDRESS) {
> > +		/* No contents to print */
> > +		P("type=%s\n", drm_dp_mst_req_type_str(req->req_type));
> > +		return;
> > +	}
> > +
> > +	P("type=%s contents:\n", drm_dp_mst_req_type_str(req->req_type));
> > +	indent++;
> > +
> > +	switch (req->req_type) {
> > +	case DP_ENUM_PATH_RESOURCES:
> > +	case DP_POWER_DOWN_PHY:
> > +	case DP_POWER_UP_PHY:
> > +		P("port=%d\n", req->u.port_num.port_number);
> > +		break;
> > +	case DP_ALLOCATE_PAYLOAD:
> > +		P("port=%d vcpi=%d pbn=%d sdp_streams=%d %*ph\n",
> > +		  req->u.allocate_payload.port_number,
> > +		  req->u.allocate_payload.vcpi, req->u.allocate_payload.pbn,
> > +		  req->u.allocate_payload.number_sdp_streams,
> > +		  req->u.allocate_payload.number_sdp_streams,
> > +		  req->u.allocate_payload.sdp_stream_sink);
> > +		break;
> > +	case DP_QUERY_PAYLOAD:
> > +		P("port=%d vcpi=%d\n",
> > +		  req->u.query_payload.port_number,
> > +		  req->u.query_payload.vcpi);
> > +		break;
> > +	case DP_REMOTE_DPCD_READ:
> > +		P("port=%d dpcd_addr=%05x len=%d\n",
> > +		  req->u.dpcd_read.port_number, req->u.dpcd_read.dpcd_address,
> > +		  req->u.dpcd_read.num_bytes);
> > +		break;
> > +	case DP_REMOTE_DPCD_WRITE:
> > +		P("port=%d addr=%05x len=%d: %*ph\n",
> > +		  req->u.dpcd_write.port_number,
> > +		  req->u.dpcd_write.dpcd_address,
> > +		  req->u.dpcd_write.num_bytes, req->u.dpcd_write.num_bytes,
> > +		  req->u.dpcd_write.bytes);
> > +		break;
> > +	case DP_REMOTE_I2C_READ:
> > +		P("port=%d num_tx=%d id=%d size=%d:\n",
> > +		  req->u.i2c_read.port_number,
> > +		  req->u.i2c_read.num_transactions,
> > +		  req->u.i2c_read.read_i2c_device_id,
> > +		  req->u.i2c_read.num_bytes_read);
> > +
> > +		indent++;
> > +		for (i = 0; i < req->u.i2c_read.num_transactions; i++) {
> > +			const struct drm_dp_remote_i2c_read_tx *rtx =
> > +				&req->u.i2c_read.transactions[i];
> > +
> > +			P("%d: id=%03d size=%03d no_stop_bit=%d tx_delay=%03d:
> > %*ph\n",
> > +			  i, rtx->i2c_dev_id, rtx->num_bytes,
> > +			  rtx->no_stop_bit, rtx->i2c_transaction_delay,
> > +			  rtx->num_bytes, rtx->bytes);
> > +		}
> > +		break;
> > +	case DP_REMOTE_I2C_WRITE:
> > +		P("port=%d id=%d size=%d: %*ph\n",
> > +		  req->u.i2c_write.port_number,
> > +		  req->u.i2c_write.write_i2c_device_id,
> > +		  req->u.i2c_write.num_bytes, req->u.i2c_write.num_bytes,
> > +		  req->u.i2c_write.bytes);
> > +		break;
> > +	default:
> > +		P("???\n");
> > +		break;
> > +	}
> > +#undef P
> > +}
> > +EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_dump_sideband_msg_req_body);
> > +
> > +static inline void
> > +drm_dp_mst_dump_sideband_msg_tx(struct drm_printer *p,
> > +				const struct drm_dp_sideband_msg_tx *txmsg)
> > +{
> > +	struct drm_dp_sideband_msg_req_body req;
> > +	char buf[64];
> > +	int ret;
> > +	int i;
> > +
> > +	drm_dp_mst_rad_to_str(txmsg->dst->rad, txmsg->dst->lct, buf,
> > +			      sizeof(buf));
> > +	drm_printf(p, "txmsg cur_offset=%x cur_len=%x seqno=%x state=%s
> > path_msg=%d dst=%s\n",
> > +		   txmsg->cur_offset, txmsg->cur_len, txmsg->seqno,
> > +		   drm_dp_mst_sideband_tx_state_str(txmsg->state),
> > +		   txmsg->path_msg, buf);
> > +
> > +	ret = drm_dp_decode_sideband_req(txmsg, &req);
> > +	if (ret) {
> > +		drm_printf(p, "<failed to decode sideband req: %d>\n", ret);
> > +		return;
> > +	}
> > +	drm_dp_dump_sideband_msg_req_body(&req, 1, p);
> > +
> > +	switch (req.req_type) {
> > +	case DP_REMOTE_DPCD_WRITE:
> > +		kfree(req.u.dpcd_write.bytes);
> > +		break;
> > +	case DP_REMOTE_I2C_READ:
> > +		for (i = 0; i < req.u.i2c_read.num_transactions; i++)
> > +			kfree(req.u.i2c_read.transactions[i].bytes);
> > +		break;
> > +	case DP_REMOTE_I2C_WRITE:
> > +		kfree(req.u.i2c_write.bytes);
> > +		break;
> > +	}
> > +}
> >  
> >  static void drm_dp_crc_sideband_chunk_req(u8 *msg, u8 len)
> >  {
> > @@ -893,6 +1178,11 @@ static int drm_dp_mst_wait_tx_reply(struct
> > drm_dp_mst_branch *mstb,
> >  		}
> >  	}
> >  out:
> > +	if (unlikely(ret == -EIO && drm_debug & (DRM_UT_DP | DRM_UT_KMS))) {
> 
> Hm I'd only check for DRM_UT_DP here.
> 
> > +		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > +
> > +		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > +	}
> >  	mutex_unlock(&mgr->qlock);
> >  
> >  	return ret;
> > @@ -1927,8 +2217,11 @@ static int process_single_tx_qlock(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  	idx += tosend + 1;
> >  
> >  	ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
> > -	if (ret) {
> > -		DRM_DEBUG_KMS("sideband msg failed to send\n");
> > +	if (ret && unlikely(drm_debug & (DRM_UT_DP | DRM_UT_KMS))) {
> 
> Same.
> 
> > +		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > +
> > +		drm_printf(&p, "sideband msg failed to send\n");
> > +		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> >  		return ret;
> >  	}
> >  
> > @@ -1990,6 +2283,13 @@ static void drm_dp_queue_down_tx(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  {
> >  	mutex_lock(&mgr->qlock);
> >  	list_add_tail(&txmsg->next, &mgr->tx_msg_downq);
> > +
> > +	if (unlikely(drm_debug & DRM_UT_DP)) {
> 
> Like you do here.
> 
> > +		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > +
> > +		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > +	}
> > +
> >  	if (list_is_singular(&mgr->tx_msg_downq))
> >  		process_single_down_tx_qlock(mgr);
> >  	mutex_unlock(&mgr->qlock);
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > b/drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > new file mode 100644
> > index 000000000000..eeda9a61c657
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology_internal.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> > + * Declarations for DP MST related functions which are only used in
> > selftests
> > + *
> > + * Copyright © 2018 Red Hat
> > + * Authors:
> > + *     Lyude Paul <lyude@redhat.com>
> > + */
> > +
> > +#ifndef _DRM_DP_MST_HELPER_INTERNAL_H_
> > +#define _DRM_DP_MST_HELPER_INTERNAL_H_
> > +
> > +#include <drm/drm_dp_mst_helper.h>
> > +
> > +void
> > +drm_dp_encode_sideband_req(const struct drm_dp_sideband_msg_req_body
> > *req,
> > +			   struct drm_dp_sideband_msg_tx *raw);
> > +int drm_dp_decode_sideband_req(const struct drm_dp_sideband_msg_tx *raw,
> > +			       struct drm_dp_sideband_msg_req_body *req);
> > +void
> > +drm_dp_dump_sideband_msg_req_body(const struct
> > drm_dp_sideband_msg_req_body *req,
> > +				  int indent, struct drm_printer *printer);
> > +
> > +#endif /* !_DRM_DP_MST_HELPER_INTERNAL_H_ */
> > diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > index dec3ee3ec96f..1898de0b4a4d 100644
> > --- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > +++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> > @@ -33,3 +33,4 @@ selftest(damage_iter_damage_one_outside,
> > igt_damage_iter_damage_one_outside)
> >  selftest(damage_iter_damage_src_moved, igt_damage_iter_damage_src_moved)
> >  selftest(damage_iter_damage_not_visible,
> > igt_damage_iter_damage_not_visible)
> >  selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
> > +selftest(dp_mst_sideband_msg_req_decode,
> > igt_dp_mst_sideband_msg_req_decode)
> > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > index 51b2486ec917..ceca89babd65 100644
> > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > @@ -8,6 +8,7 @@
> >  #include <drm/drm_dp_mst_helper.h>
> >  #include <drm/drm_print.h>
> >  
> > +#include "../drm_dp_mst_topology_internal.h"
> >  #include "test-drm_modeset_common.h"
> >  
> >  int igt_dp_mst_calc_pbn_mode(void *ignored)
> > @@ -34,3 +35,214 @@ int igt_dp_mst_calc_pbn_mode(void *ignored)
> >  
> >  	return 0;
> >  }
> > +
> > +static bool
> > +sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> > +		       const struct drm_dp_sideband_msg_req_body *out)
> > +{
> > +	const struct drm_dp_remote_i2c_read_tx *txin, *txout;
> > +	int i;
> > +
> > +	if (in->req_type != out->req_type)
> > +		return false;
> > +
> > +	switch (in->req_type) {
> > +	case DP_ENUM_PATH_RESOURCES:
> > +	case DP_POWER_UP_PHY:
> > +	case DP_POWER_DOWN_PHY:
> > +	case DP_ALLOCATE_PAYLOAD:
> > +	case DP_QUERY_PAYLOAD:
> > +	case DP_REMOTE_DPCD_READ:
> > +		return memcmp(in, out, sizeof(*in)) == 0;
> 
> Just memcmp the entire thing for everyrone (we assume kzalloc anyway), and
> then only have the additional checks for the few cases we need it? Would
> slightly reduce the code.
> 
> > +
> > +	case DP_REMOTE_I2C_READ:
> > +#define IN in->u.i2c_read
> > +#define OUT out->u.i2c_read
> > +		if (IN.num_bytes_read != OUT.num_bytes_read ||
> > +		    IN.num_transactions != OUT.num_transactions ||
> > +		    IN.port_number != OUT.port_number ||
> > +		    IN.read_i2c_device_id != OUT.read_i2c_device_id)
> > +			return false;
> > +
> > +		for (i = 0; i < IN.num_transactions; i++) {
> > +			txin = &IN.transactions[i];
> > +			txout = &OUT.transactions[i];
> > +
> > +			if (txin->i2c_dev_id != txout->i2c_dev_id ||
> > +			    txin->no_stop_bit != txout->no_stop_bit ||
> > +			    txin->num_bytes != txout->num_bytes ||
> > +			    txin->i2c_transaction_delay !=
> > +			    txout->i2c_transaction_delay)
> > +				return false;
> > +
> > +			if (memcmp(txin->bytes, txout->bytes,
> > +				   txin->num_bytes) != 0)
> > +				return false;
> > +		}
> > +		break;
> > +#undef IN
> > +#undef OUT
> > +
> > +	case DP_REMOTE_DPCD_WRITE:
> > +#define IN in->u.dpcd_write
> > +#define OUT out->u.dpcd_write
> > +		if (IN.dpcd_address != OUT.dpcd_address ||
> > +		    IN.num_bytes != OUT.num_bytes ||
> > +		    IN.port_number != OUT.port_number)
> > +			return false;
> > +
> > +		return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
> > +#undef IN
> > +#undef OUT
> > +
> > +	case DP_REMOTE_I2C_WRITE:
> > +#define IN in->u.i2c_write
> > +#define OUT out->u.i2c_write
> > +		if (IN.port_number != OUT.port_number ||
> > +		    IN.write_i2c_device_id != OUT.write_i2c_device_id ||
> > +		    IN.num_bytes != OUT.num_bytes)
> > +			return false;
> > +
> > +		return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
> > +#undef IN
> > +#undef OUT
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int
> > +__sideband_msg_req_encode_decode(int line,
> > +				 struct drm_dp_sideband_msg_req_body *in,
> > +				 struct drm_dp_sideband_msg_req_body *out)
> > +{
> > +	struct drm_printer p = drm_err_printer(pr_fmt());
> > +	struct drm_dp_sideband_msg_tx txmsg;
> > +	int i, ret;
> > +	bool eq;
> > +
> > +	drm_dp_encode_sideband_req(in, &txmsg);
> > +	ret = drm_dp_decode_sideband_req(&txmsg, out);
> > +	if (ret < 0) {
> > +		pr_err(pr_fmt("Failed to decode sideband request @ line %d:
> > %d\n"),
> > +		       line, ret);
> > +		return ret;
> > +	}
> > +
> > +	eq = sideband_msg_req_equal(in, out);
> > +	if (!eq) {
> > +		pr_err(pr_fmt("Encode/decode @ line %d failed, expected:\n"),
> > +		       line);
> > +		drm_dp_dump_sideband_msg_req_body(in, 1, &p);
> > +		pr_err(pr_fmt("Got:\n"));
> > +		drm_dp_dump_sideband_msg_req_body(out, 1, &p);
> > +	}
> > +
> > +	switch (in->req_type) {
> > +	case DP_REMOTE_DPCD_WRITE:
> > +		kfree(out->u.dpcd_write.bytes);
> > +		break;
> > +	case DP_REMOTE_I2C_READ:
> > +		for (i = 0; i < out->u.i2c_read.num_transactions; i++)
> > +			kfree(out->u.i2c_read.transactions[i].bytes);
> > +		break;
> > +	case DP_REMOTE_I2C_WRITE:
> > +		kfree(out->u.i2c_write.bytes);
> > +		break;
> > +	}
> > +
> > +	/* Clear everything but the req_type for the input */
> > +	memset(&in->u, 0, sizeof(in->u));
> > +
> > +	/* Clear the output entirely */
> > +	memset(out, 0, sizeof(*out));
> > +
> > +	return eq ? 0 : -EINVAL;
> > +}
> > +
> > +int igt_dp_mst_sideband_msg_req_decode(void *unused)
> > +{
> > +	struct drm_dp_sideband_msg_req_body in = { 0 }, out = { 0 };
> > +	u8 data[] = { 0xff, 0x0, 0xdd };
> > +	int i;
> > +
> > +#define
> > DO_TEST()                                                          \
> > +	do {                                                               \
> > +		if (__sideband_msg_req_encode_decode(__LINE__, &in, &out)) \
> > +			return -EINVAL;                                    \
> > +	} while (0)
> 
> I had a tiny wtf moment here until I realized this is a macro ... maybe
> put the do on the first line and indent everything? Pure bikeshed to help
> the blind ...

Yeah this was kind of silly, in the other round of selftests I've got a
cleaner way of doing this - just define DO_TEST() like so:

/* note: I realized, we also don't need to specify an out (just store it on
the stack) */

static inline bool sideband_msg_req_encode_decode(in) {
	...
}

static void actual_test(...) {
	...
	#define DO_TEST() FAIL_ON(!sideband_msg_req_encode_decode(in))
	...
}

Will do the same thing for these selftests

> 
> > +
> > +	in.req_type = DP_ENUM_PATH_RESOURCES;
> > +	in.u.port_num.port_number = 5;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_POWER_UP_PHY;
> > +	in.u.port_num.port_number = 5;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_POWER_DOWN_PHY;
> > +	in.u.port_num.port_number = 5;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_ALLOCATE_PAYLOAD;
> > +	in.u.allocate_payload.number_sdp_streams = 3;
> > +	for (i = 0; i < in.u.allocate_payload.number_sdp_streams; i++)
> > +		in.u.allocate_payload.sdp_stream_sink[i] = i + 1;
> > +	DO_TEST();
> > +	in.u.allocate_payload.port_number = 0xf;
> > +	DO_TEST();
> > +	in.u.allocate_payload.vcpi = 0x7f;
> > +	DO_TEST();
> > +	in.u.allocate_payload.pbn = U16_MAX;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_QUERY_PAYLOAD;
> > +	in.u.query_payload.port_number = 0xf;
> > +	DO_TEST();
> > +	in.u.query_payload.vcpi = 0x7f;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_REMOTE_DPCD_READ;
> > +	in.u.dpcd_read.port_number = 0xf;
> > +	DO_TEST();
> > +	in.u.dpcd_read.dpcd_address = 0xfedcb;
> > +	DO_TEST();
> > +	in.u.dpcd_read.num_bytes = U8_MAX;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_REMOTE_DPCD_WRITE;
> > +	in.u.dpcd_write.port_number = 0xf;
> > +	DO_TEST();
> > +	in.u.dpcd_write.dpcd_address = 0xfedcb;
> > +	DO_TEST();
> > +	in.u.dpcd_write.num_bytes = ARRAY_SIZE(data);
> > +	in.u.dpcd_write.bytes = data;
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_REMOTE_I2C_READ;
> > +	in.u.i2c_read.port_number = 0xf;
> > +	DO_TEST();
> > +	in.u.i2c_read.read_i2c_device_id = 0x7f;
> > +	DO_TEST();
> > +	in.u.i2c_read.num_transactions = 3;
> > +	in.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3;
> > +	for (i = 0; i < in.u.i2c_read.num_transactions; i++) {
> > +		in.u.i2c_read.transactions[i].bytes = data;
> > +		in.u.i2c_read.transactions[i].num_bytes = ARRAY_SIZE(data);
> > +		in.u.i2c_read.transactions[i].i2c_dev_id = 0x7f & ~i;
> > +		in.u.i2c_read.transactions[i].i2c_transaction_delay = 0xf &
> > ~i;
> > +	}
> > +	DO_TEST();
> > +
> > +	in.req_type = DP_REMOTE_I2C_WRITE;
> > +	in.u.i2c_write.port_number = 0xf;
> > +	DO_TEST();
> > +	in.u.i2c_write.write_i2c_device_id = 0x7f;
> > +	DO_TEST();
> > +	in.u.i2c_write.num_bytes = ARRAY_SIZE(data);
> > +	in.u.i2c_write.bytes = data;
> > +	DO_TEST();
> > +
> > +#undef DO_TEST
> > +	return 0;
> > +}
> 
> Extremely nice, more unit tests ftw!
> 
> With the nits somehow figured out: Reviewed-by: Daniel Vetter <
> daniel.vetter@ffwll.ch>
> 
> > diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > index 590bda35a683..0fcb8bbc6a1b 100644
> > --- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > +++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> > @@ -40,5 +40,6 @@ int igt_damage_iter_damage_one_outside(void *ignored);
> >  int igt_damage_iter_damage_src_moved(void *ignored);
> >  int igt_damage_iter_damage_not_visible(void *ignored);
> >  int igt_dp_mst_calc_pbn_mode(void *ignored);
> > +int igt_dp_mst_sideband_msg_req_decode(void *ignored);
> >  
> >  #endif
> > diff --git a/include/drm/drm_dp_mst_helper.h
> > b/include/drm/drm_dp_mst_helper.h
> > index c01f3ea72756..4c8d177e83e5 100644
> > --- a/include/drm/drm_dp_mst_helper.h
> > +++ b/include/drm/drm_dp_mst_helper.h
> > @@ -293,7 +293,7 @@ struct drm_dp_remote_dpcd_write {
> >  struct drm_dp_remote_i2c_read {
> >  	u8 num_transactions;
> >  	u8 port_number;
> > -	struct {
> > +	struct drm_dp_remote_i2c_read_tx {
> >  		u8 i2c_dev_id;
> >  		u8 num_bytes;
> >  		u8 *bytes;
> > -- 
> > 2.21.0
> > 
-- 
Cheers,
	Lyude Paul

