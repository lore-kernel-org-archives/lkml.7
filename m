Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F8C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4521850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="cd+9O1az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfDEIj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:39:58 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:38564 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729792AbfDEIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:39:54 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 44bCtD43qFz7KJ;
        Fri,  5 Apr 2019 10:39:48 +0200 (CEST)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 44bCtB2Vk3z1XLG6y;
        Fri,  5 Apr 2019 10:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554453586;
        bh=3KZAh89Q4h0uf09Dbqnl8a8Lh0mT96mmFNzcY11Rw4o=; l=10;
        h=From:From:Reply-To:Sender;
        b=cd+9O1azObI5SRObcouy06Fd6nSwauukHuB38h5WPLDEpNc9rHMINHzG24d4b/vzs
         eDRZI1F0n1ccCY1kPdd4kO/GmWdpOVwApeWySyYlfORG77W8J434/HeJSuv4qv/3L7
         bfAP8dth1txLhVdwj0SfOzne0OWOMv6mhIa7KbU8=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 44bCtB26fDz1CQ;
        Fri,  5 Apr 2019 10:39:46 +0200 (CEST)
X-AuditID: 0a3aad0c-d01ff700000039d6-a5-5ca7145178a6
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 06.9D.14806.15417AC5; Fri,  5 Apr 2019 10:39:45 +0200 (CEST)
Received: from FE-MBX2041.de.bosch.com (fe-mbx2041.de.bosch.com [10.3.231.51])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 44bCt95ZMYz523;
        Fri,  5 Apr 2019 10:39:45 +0200 (CEST)
Received: from SGPMBX2021.APAC.bosch.com (10.187.56.83) by
 FE-MBX2041.de.bosch.com (10.3.231.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 10:39:45 +0200
Received: from SGPMBX2027.APAC.bosch.com (10.187.56.91) by
 SGPMBX2021.APAC.bosch.com (10.187.56.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 16:39:42 +0800
Received: from SGPMBX2027.APAC.bosch.com ([fe80::bc7a:811a:edb8:a221]) by
 SGPMBX2027.APAC.bosch.com ([fe80::bc7a:811a:edb8:a221%5]) with mapi id
 15.01.1713.004; Fri, 5 Apr 2019 16:39:42 +0800
From:   "Harsha Manjula Mallikarjun (RBEI/ECF3)" 
        <Harsha.ManjulaMallikarjun@in.bosch.com>
To:     =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        "Kalakodima Venkata Rajesh (RBEI/ECF3)" 
        <VenkataRajesh.Kalakodima@in.bosch.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "Friedrich Eugen (ADITG/ESB)" <EFriedrich@de.adit-jv.com>,
        "Ucan Ahmet Emre (ADITG/ESB)" <eucan@de.adit-jv.com>
Subject: RE: [PATCH 5/8] drm: rcar-du: Implement interfaces to set clu and lut
 using drm data structures
Thread-Topic: [PATCH 5/8] drm: rcar-du: Implement interfaces to set clu and
 lut using drm data structures
Thread-Index: AQHU6h9flxmpnuLOkUeH1esNC5LTN6YrG9+AgACDLYCAAZStQA==
Date:   Fri, 5 Apr 2019 08:39:42 +0000
Message-ID: <38922e58fd924afabce5f27a4c1144ec@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <1554297284-14009-6-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <20190404075047.GP2665@phenom.ffwll.local> <20190404154017.GG3888@intel.com>
In-Reply-To: <20190404154017.GG3888@intel.com>
Accept-Language: en-US, en-SG
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.56.212]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TbUxbVRjHe3rbu9umV28vlD52MLNOP6ih61BjN5AQXzJGNAx1GkyNFrm0
        dX0hvS2DGRe+gEuxG06mDIGuMEBxyga4EEQHdZvpdIONToEoZLwsthIoIG9Op71rWfvBLyf/
        8/zP73me85wcAqN9hIIwWuyMzaIzKXGxQLzry5TUvMQ2rfrbqac07gtXhRr/8jyuWfhgXKgZ
        7q3HNV8H5via1Tsefhae3ejLy56o+oGfvdS5ZS/2ujijkDEZSxjb9sy3xIbqj6dRceXLpYvO
        Zn45Gst0IhEB1BMQ+PlHgROJCZo6wYeR6RnEGTT1DYJQV3rEmEfQfrojemoRwRfdQ3hk8z2C
        1t7muwhO5cNgRQ/GGYnULQwqZ2dwzsAoB1zpWxNyOoF6B87+5hVwOpHaDx/516P6GaifDIXP
        E4SAeghaPBouTFLpcL6hNlo5hOD2YvcmzhBRKqgJVN7ViEqBptFjgkgtOYxNu/mRy1Fwqm8Q
        i2gZBKbuCCN6K7j+qYr2poKR4zVR/Ri0ev7AIoWl4DsxLahGUBeXti4OqYtD6uKQk0jQjpKK
        GHWJWZ22U61W2QoY9qB6h+ptq7kTRd5U0oMuntJ7EUUgpYS8wWvT0kJdCVtm9qInCb5SRu79
        pFVL31dgLSwz6FjDmzaHiWGVCjJ5KEdLJ9wLs44Cs5FljVaLFwGBKRPJLZ+HObJQV3aQsVkj
        mBdtJgRKOakncrU0pdfZmf0MU8zYNtx0glAC+XBCuAepjdEzpUVGk33DVqaQiMfj0UnxTnxZ
        PiHyoscJSbj2i1wKki3WmVmjPoo/EMHpjWgMvYxyif6mmw0YMbDKrT5upQUWq4VRyEnE5aI4
        yuCw3OtGkUzyZhq1tCzOiGUMohsoPM8EMoeDJeFvFOsDyM3c6KTRYAxK84QZalgOHeu7IRDc
        A12Tr4Lv1/cg8H55+O2vNSJo7FlGUDNxkw+fuvwYhH6/JISW/gocFgYO41B/5jYO13vrNkHw
        3xABs0tdIpgYPSeC8cUxMZyeOCqB4eBfEgh95iLBPbJGQuPaL/fDwqqHgnVXgxQm531SqO72
        09DnOZIA3cGfZOB0jctgqWVWBt3Or5KC4QHzwwPWONzcgO06+/8MOBqN3UxRjkrxigNvbHtt
        fuWkrPy7fW3uleSMnc1+XVNW6rudy9fmrkxd6Ov3zrUbcksHOju2Hz227dn0q2mZz+cN5dfv
        OV/QkD9aa078u6LzkYwB+SHTmcHmJdfTpg93eR584dDhc1mq/Lnnzqb92XIkNaXW2Xpp6/WV
        l46/UnX5Yu6B6pzdrf2ufUW3lALWoNvxKGZjdf8B5TDgztwEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Thu, Apr 04, 2019 at 09:50:47AM +0200, Daniel Vetter wrote:
> > On Wed, Apr 03, 2019 at 06:44:41PM +0530,
> VenkataRajesh.Kalakodima@in.bosch.com wrote:
> > > From: kalakodima venkata rajesh
> > > <venkatarajesh.kalakodima@in.bosch.com>
> > >
> > > Impelement interfaces in cmm to set clu and lut tables using
> > > standard drm data structures as input.
> > >
> > > Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
> > >
> > >       - Resolved checkpatch errors
> > >       - Resolved merge conflicts according to latest version
> > >
> > > Signed-off-by: kalakodima venkata rajesh
> > > <venkatarajesh.kalakodima@in.bosch.com>
> > > ---
> > >  drivers/gpu/drm/rcar-du/rcar_du_cmm.c  | 256
> > > +++++++++++++++++++++++++++++++--
> > > drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  11 ++
> > >  2 files changed, 254 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > > b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > > index 7983039..af4668f 100644
> > > --- a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > > +++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > > @@ -114,6 +114,8 @@ struct rcar_du_cmm_pending_event {
> > >  	struct drm_gem_object *gem_obj;
> > >  	struct rcar_du_cmm *du_cmm;
> > >  	struct rcar_du_cmm_file_priv *fpriv;
> > > +	unsigned int *lut_buf;
> > > +	unsigned int *clu_buf;
> > >  };
> > >
> > >  struct cmm_module_t {
> > > @@ -238,14 +240,6 @@ static long long diff_timevals(struct timeval
> > > *start, struct timeval *end)  }  #endif
> > >
> > > -static void du_cmm_clk(struct rcar_du_cmm *du_cmm, bool on) -{
> > > -	if (on)
> > > -		clk_prepare_enable(du_cmm->clock);
> > > -	else
> > > -		clk_disable_unprepare(du_cmm->clock);
> > > -}
> > > -
> > >  static void rcar_du_cmm_queue_lut_update(struct
> > > rcar_du_cmm_pending_event *p)  {
> > >  	mutex_lock(&cmm_event_lock);
> > > @@ -284,6 +278,223 @@ static void rcar_du_cmm_queue_clu_update(struct
> rcar_du_cmm_pending_event *p)
> > >  	drm_crtc_vblank_get(&p->du_cmm->rcrtc->crtc);
> > >  }
> > >
> > > +static s64 rcar_du_cmm_multiply_coeff(unsigned int color, s64
> > > +coeff) {
> > > +	s64 r_val;
> > > +	bool is_neg =3D false;
> > > +
> > > +	if (coeff & BIT_ULL(63)) {
> > > +		is_neg =3D true;
> > > +		coeff &=3D ~BIT_ULL(63);
> > > +	}
> > > +
> > > +	r_val =3D DIV_ROUND_CLOSEST(((s64)(color * coeff)), BIT_ULL(32));
> > > +
> > > +	if (is_neg)
> > > +		return -r_val;
> > > +
> > > +	return r_val;
> > > +}
> > > +
> > > +static unsigned int rcar_du_cmm_scalar_product(unsigned int r, unsig=
ned int
> g,
> > > +					       unsigned int b, s64 coeff1,
> > > +					       s64 coeff2, s64 coeff3) {
> > > +	s64 product;
> > > +
> > > +	product =3D rcar_du_cmm_multiply_coeff(r, coeff1)
> > > +			+ rcar_du_cmm_multiply_coeff(g, coeff2)
> > > +			+ rcar_du_cmm_multiply_coeff(b, coeff3);
> > > +
> > > +	return (unsigned int)clamp_val(product, 0, U8_MAX); }
> > > +
> > > +#ifdef DEBUG_PROCE_TIME
> > > +static long long diff_timevals(struct timeval *start, struct
> > > +timeval *end) {
> > > +	return (end->tv_sec * 1000000LL + end->tv_usec) -
> > > +		(start->tv_sec * 1000000LL + start->tv_usec); } #endif
> > > +
> > > +void *rcar_du_cmm_alloc_lut(void *cmm_handle) {
> > > +	struct rcar_du_cmm_pending_event *p;
> > > +
> > > +	if (!cmm_handle)
> > > +		return NULL;
> > > +
> > > +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> > > +	if (!p)
> > > +		return NULL;
> > > +
> > > +	p->gem_obj =3D NULL;
> > > +	p->event =3D CMM_EVENT_LUT_DONE;
> > > +	p->stat =3D QUE_STAT_PENDING;
> > > +	p->callback_data =3D 0;
> > > +	p->du_cmm =3D cmm_handle;
> > > +	p->fpriv =3D NULL;
> > > +	p->lut_buf =3D kmalloc(CMM_LUT_NUM * 4, GFP_KERNEL);
> > > +	if (!p->lut_buf) {
> > > +		kfree(p);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	return p;
> > > +}
> > > +
> > > +void rcar_du_cmm_free_lut(void *lut_handle) {
> > > +	struct rcar_du_cmm_pending_event *p =3D
> > > +			(struct rcar_du_cmm_pending_event *)lut_handle;
> > > +
> > > +	kfree(p->lut_buf);
> > > +	kfree(p);
> > > +}
> > > +
> > > +int rcar_du_cmm_lut_valid(unsigned int lut_length) {
> > > +	return (lut_length =3D=3D CMM_LUT_NUM) ? 0 : -EINVAL; }
> > > +
> > > +void rcar_du_cmm_update_lut_and_free(void *lut_handle,
> > > +				     struct drm_color_lut *lut,
> > > +				     unsigned int lut_length)
> > > +{
> > > +	struct rcar_du_cmm_pending_event *p =3D
> > > +			(struct rcar_du_cmm_pending_event *)lut_handle;
> > > +	unsigned int color;
> > > +
> > > +	if (!p)
> > > +		return;
> > > +
> > > +	if (rcar_du_cmm_lut_valid(lut_length))
> > > +		return;
> > > +
> > > +	/* Convert drm_color_lut to the format handled by hardware */
> > > +	for (color =3D 0; color < lut_length; color++) {
> > > +		p->lut_buf[color] =3D 0;
> > > +		p->lut_buf[color] |=3D drm_color_lut_extract(lut[color].red, 8)
> > > +					<< 16;
> > > +		p->lut_buf[color] |=3D drm_color_lut_extract(lut[color].green, 8)
> > > +					<< 8;
> > > +		p->lut_buf[color] |=3D drm_color_lut_extract(lut[color].blue, 8);
> > > +	}
> > > +	rcar_du_cmm_queue_lut_update(p);
> > > +}
> > > +
> > > +void *rcar_du_cmm_alloc_clu(void *cmm_handle) {
> > > +	struct rcar_du_cmm_pending_event *p;
> > > +
> > > +	if (!cmm_handle)
> > > +		return NULL;
> > > +
> > > +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> > > +	if (!p)
> > > +		return NULL;
> > > +
> > > +	p->gem_obj =3D NULL;
> > > +	p->event =3D CMM_EVENT_CLU_DONE;
> > > +	p->stat =3D QUE_STAT_PENDING;
> > > +	p->callback_data =3D 0;
> > > +	p->du_cmm =3D cmm_handle;
> > > +	p->fpriv =3D NULL;
> > > +	p->clu_buf =3D kmalloc(CMM_CLU_NUM * 4, GFP_KERNEL);
> > > +	if (!p->clu_buf) {
> > > +		kfree(p);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	return p;
> > > +}
> > > +
> > > +void rcar_du_cmm_free_clu(void *clu_handle) {
> > > +	struct rcar_du_cmm_pending_event *p =3D
> > > +			(struct rcar_du_cmm_pending_event *)clu_handle;
> > > +
> > > +	kfree(p->clu_buf);
> > > +	kfree(p);
> > > +}
> > > +
> > > +void rcar_du_cmm_update_clu_and_free(void *clu_handle,
> > > +				     struct drm_color_ctm *ctm) {
> > > +	struct rcar_du_cmm_pending_event *p =3D
> > > +			(struct rcar_du_cmm_pending_event *)clu_handle;
> > > +	unsigned int r_loop;
> > > +	unsigned int g_loop;
> > > +	unsigned int b_loop;
> > > +	unsigned int step_size;
> > > +	unsigned int step_fraction;
> > > +	unsigned int clu_index =3D 0;
> > > +
> > > +	if (!p)
> > > +		return;
> > > +
> > > +	step_size =3D U8_MAX / (CMM_CLU_SAMPLES - 1);
> > > +	step_fraction =3D U8_MAX % (CMM_CLU_SAMPLES - 1);
> > > +
> > > +	/*Update clu table*/
> > > +	for (b_loop =3D 0; b_loop < CMM_CLU_SAMPLES; b_loop++) {
> > > +		unsigned int b;
> > > +
> > > +		b =3D (b_loop * step_size) +
> > > +		    DIV_ROUND_CLOSEST((b_loop * step_fraction),
> > > +				      (CMM_CLU_SAMPLES - 1));
> > > +
> > > +		for (g_loop =3D 0; g_loop < CMM_CLU_SAMPLES; g_loop++) {
> > > +			unsigned int g;
> > > +
> > > +			g =3D (g_loop * step_size) +
> > > +			    DIV_ROUND_CLOSEST((g_loop * step_fraction),
> > > +					      (CMM_CLU_SAMPLES - 1));
> > > +
> > > +			for (r_loop =3D 0; r_loop < CMM_CLU_SAMPLES; r_loop++)
> {
> > > +				unsigned int r;
> > > +				unsigned int r_val;
> > > +				unsigned int g_val;
> > > +				unsigned int b_val;
> > > +
> > > +				r =3D (r_loop * step_size) +
> > > +				    DIV_ROUND_CLOSEST((r_loop *
> step_fraction),
> > > +						      (CMM_CLU_SAMPLES - 1));
> > > +
> > > +				p->clu_buf[clu_index] =3D 0;
> > > +
> > > +				r_val =3D	rcar_du_cmm_scalar_product
> > > +						(r, g, b,
> > > +						 ctm->matrix[0], ctm->matrix[1],
> > > +						 ctm->matrix[2]);
> > > +
> > > +				g_val =3D	rcar_du_cmm_scalar_product
> > > +						(r, g, b,
> > > +						 ctm->matrix[3], ctm->matrix[4],
> > > +						 ctm->matrix[5]);
> > > +
> > > +				b_val =3D	rcar_du_cmm_scalar_product
> > > +						(r, g, b,
> > > +						 ctm->matrix[6], ctm->matrix[7],
> > > +						 ctm->matrix[8]);
> > > +
> > > +				p->clu_buf[clu_index++] =3D (r_val << 16) |
> > > +							  (g_val << 8) | b_val;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	rcar_du_cmm_queue_clu_update(p);
> > > +}
> >
> > Just quick drive-by: I think there's some interested (definitely from
> > intel, I pinged the relevant people from our team) to expose a 3D LUT
> > directly to userspace.=20
[Harsha Manjula Mallikarjun (RBEI/ECF3)]=20
Thanks Daniel for mentioning this.
>> I'm not sure whether we can do both 3D-LUT and
> > color matrix, and I'm also not sure whether remapping the ctm to a
> > 3d-lut is the best thing to do.
[Harsha Manjula Mallikarjun (RBEI/ECF3)] :=20
It is not the best thing to do compared to the HW (e.g. i.Mx6) which readil=
y supports CTM matrix.
Also remapping limits the flexibility with which user space can make use of=
 3D LUT.
Our use case was to apply hue, saturation and brightness properties to disp=
lay out.
Conversion between RGB and HSV color space is non-linear. However, a close =
linear approximation
can be done and this can be applied via CTM. I do not know about other use =
cases where
3D LUT can be made use of.

>> Otoh adding new uapi is always a bunch more
[Harsha Manjula Mallikarjun (RBEI/ECF3)]=20
I think adding a 3D LUT property blob, is better than re-mapping. Then user=
 space can make full use of it.

> work.
>=20
> We're already thinking about extending the uapi a bit, so I don't think i=
ncluding a
> 3D LUT in there would be too hard.
>=20
> Couple of things we'd need to figure out:
> - is a single 3D LUT attachment point sufficient? On our hw I
>   believe the 3D LUT sits after the gamma LUT in the pipeline
> - is a cube sufficient or would some hardware have different
>   number of entries for each dimension (not sure why that would be)?
> - need to agree in which order the entries would be stored in the
>   blob
> - and of course the big question: is anyone going to work on
>   userspace that would make use of this?
>=20
[Harsha Manjula Mallikarjun (RBEI/ECF3)]=20
Following patch adds CTM support to Weston. I am planning to fix review com=
ments.=20
https://patchwork.freedesktop.org/patch/233391/
If 3D LUT interface is available, similar support can be added in Weston. I=
f CTM is not supported,
Instead 3D LUT is supported, similar functionality can be realized using 3D=
 LUT. User space can
decide this.

> --
> Ville Syrj=E4l=E4
> Intel

Regards,
Harsha
