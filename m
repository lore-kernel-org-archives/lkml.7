Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD6FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5D32147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfDDPl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:41:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:23603 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:41:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 08:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="131457121"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 04 Apr 2019 08:40:18 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 04 Apr 2019 18:40:17 +0300
Date:   Thu, 4 Apr 2019 18:40:17 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     VenkataRajesh.Kalakodima@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
Subject: Re: [PATCH 5/8] drm: rcar-du: Implement interfaces to set clu and
 lut using drm data structures
Message-ID: <20190404154017.GG3888@intel.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <1554297284-14009-6-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <20190404075047.GP2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404075047.GP2665@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 09:50:47AM +0200, Daniel Vetter wrote:
> On Wed, Apr 03, 2019 at 06:44:41PM +0530, VenkataRajesh.Kalakodima@in.bosch.com wrote:
> > From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> > 
> > Impelement interfaces in cmm to set clu and lut tables using standard
> > drm data structures as input.
> > 
> > Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
> > 
> >       - Resolved checkpatch errors
> >       - Resolved merge conflicts according to latest version
> > 
> > Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_du_cmm.c  | 256 +++++++++++++++++++++++++++++++--
> >  drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  11 ++
> >  2 files changed, 254 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > index 7983039..af4668f 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> > @@ -114,6 +114,8 @@ struct rcar_du_cmm_pending_event {
> >  	struct drm_gem_object *gem_obj;
> >  	struct rcar_du_cmm *du_cmm;
> >  	struct rcar_du_cmm_file_priv *fpriv;
> > +	unsigned int *lut_buf;
> > +	unsigned int *clu_buf;
> >  };
> >  
> >  struct cmm_module_t {
> > @@ -238,14 +240,6 @@ static long long diff_timevals(struct timeval *start, struct timeval *end)
> >  }
> >  #endif
> >  
> > -static void du_cmm_clk(struct rcar_du_cmm *du_cmm, bool on)
> > -{
> > -	if (on)
> > -		clk_prepare_enable(du_cmm->clock);
> > -	else
> > -		clk_disable_unprepare(du_cmm->clock);
> > -}
> > -
> >  static void rcar_du_cmm_queue_lut_update(struct rcar_du_cmm_pending_event *p)
> >  {
> >  	mutex_lock(&cmm_event_lock);
> > @@ -284,6 +278,223 @@ static void rcar_du_cmm_queue_clu_update(struct rcar_du_cmm_pending_event *p)
> >  	drm_crtc_vblank_get(&p->du_cmm->rcrtc->crtc);
> >  }
> >  
> > +static s64 rcar_du_cmm_multiply_coeff(unsigned int color, s64 coeff)
> > +{
> > +	s64 r_val;
> > +	bool is_neg = false;
> > +
> > +	if (coeff & BIT_ULL(63)) {
> > +		is_neg = true;
> > +		coeff &= ~BIT_ULL(63);
> > +	}
> > +
> > +	r_val = DIV_ROUND_CLOSEST(((s64)(color * coeff)), BIT_ULL(32));
> > +
> > +	if (is_neg)
> > +		return -r_val;
> > +
> > +	return r_val;
> > +}
> > +
> > +static unsigned int rcar_du_cmm_scalar_product(unsigned int r, unsigned int g,
> > +					       unsigned int b, s64 coeff1,
> > +					       s64 coeff2, s64 coeff3)
> > +{
> > +	s64 product;
> > +
> > +	product = rcar_du_cmm_multiply_coeff(r, coeff1)
> > +			+ rcar_du_cmm_multiply_coeff(g, coeff2)
> > +			+ rcar_du_cmm_multiply_coeff(b, coeff3);
> > +
> > +	return (unsigned int)clamp_val(product, 0, U8_MAX);
> > +}
> > +
> > +#ifdef DEBUG_PROCE_TIME
> > +static long long diff_timevals(struct timeval *start, struct timeval *end)
> > +{
> > +	return (end->tv_sec * 1000000LL + end->tv_usec) -
> > +		(start->tv_sec * 1000000LL + start->tv_usec);
> > +}
> > +#endif
> > +
> > +void *rcar_du_cmm_alloc_lut(void *cmm_handle)
> > +{
> > +	struct rcar_du_cmm_pending_event *p;
> > +
> > +	if (!cmm_handle)
> > +		return NULL;
> > +
> > +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +	if (!p)
> > +		return NULL;
> > +
> > +	p->gem_obj = NULL;
> > +	p->event = CMM_EVENT_LUT_DONE;
> > +	p->stat = QUE_STAT_PENDING;
> > +	p->callback_data = 0;
> > +	p->du_cmm = cmm_handle;
> > +	p->fpriv = NULL;
> > +	p->lut_buf = kmalloc(CMM_LUT_NUM * 4, GFP_KERNEL);
> > +	if (!p->lut_buf) {
> > +		kfree(p);
> > +		return NULL;
> > +	}
> > +
> > +	return p;
> > +}
> > +
> > +void rcar_du_cmm_free_lut(void *lut_handle)
> > +{
> > +	struct rcar_du_cmm_pending_event *p =
> > +			(struct rcar_du_cmm_pending_event *)lut_handle;
> > +
> > +	kfree(p->lut_buf);
> > +	kfree(p);
> > +}
> > +
> > +int rcar_du_cmm_lut_valid(unsigned int lut_length)
> > +{
> > +	return (lut_length == CMM_LUT_NUM) ? 0 : -EINVAL;
> > +}
> > +
> > +void rcar_du_cmm_update_lut_and_free(void *lut_handle,
> > +				     struct drm_color_lut *lut,
> > +				     unsigned int lut_length)
> > +{
> > +	struct rcar_du_cmm_pending_event *p =
> > +			(struct rcar_du_cmm_pending_event *)lut_handle;
> > +	unsigned int color;
> > +
> > +	if (!p)
> > +		return;
> > +
> > +	if (rcar_du_cmm_lut_valid(lut_length))
> > +		return;
> > +
> > +	/* Convert drm_color_lut to the format handled by hardware */
> > +	for (color = 0; color < lut_length; color++) {
> > +		p->lut_buf[color] = 0;
> > +		p->lut_buf[color] |= drm_color_lut_extract(lut[color].red, 8)
> > +					<< 16;
> > +		p->lut_buf[color] |= drm_color_lut_extract(lut[color].green, 8)
> > +					<< 8;
> > +		p->lut_buf[color] |= drm_color_lut_extract(lut[color].blue, 8);
> > +	}
> > +	rcar_du_cmm_queue_lut_update(p);
> > +}
> > +
> > +void *rcar_du_cmm_alloc_clu(void *cmm_handle)
> > +{
> > +	struct rcar_du_cmm_pending_event *p;
> > +
> > +	if (!cmm_handle)
> > +		return NULL;
> > +
> > +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +	if (!p)
> > +		return NULL;
> > +
> > +	p->gem_obj = NULL;
> > +	p->event = CMM_EVENT_CLU_DONE;
> > +	p->stat = QUE_STAT_PENDING;
> > +	p->callback_data = 0;
> > +	p->du_cmm = cmm_handle;
> > +	p->fpriv = NULL;
> > +	p->clu_buf = kmalloc(CMM_CLU_NUM * 4, GFP_KERNEL);
> > +	if (!p->clu_buf) {
> > +		kfree(p);
> > +		return NULL;
> > +	}
> > +
> > +	return p;
> > +}
> > +
> > +void rcar_du_cmm_free_clu(void *clu_handle)
> > +{
> > +	struct rcar_du_cmm_pending_event *p =
> > +			(struct rcar_du_cmm_pending_event *)clu_handle;
> > +
> > +	kfree(p->clu_buf);
> > +	kfree(p);
> > +}
> > +
> > +void rcar_du_cmm_update_clu_and_free(void *clu_handle,
> > +				     struct drm_color_ctm *ctm)
> > +{
> > +	struct rcar_du_cmm_pending_event *p =
> > +			(struct rcar_du_cmm_pending_event *)clu_handle;
> > +	unsigned int r_loop;
> > +	unsigned int g_loop;
> > +	unsigned int b_loop;
> > +	unsigned int step_size;
> > +	unsigned int step_fraction;
> > +	unsigned int clu_index = 0;
> > +
> > +	if (!p)
> > +		return;
> > +
> > +	step_size = U8_MAX / (CMM_CLU_SAMPLES - 1);
> > +	step_fraction = U8_MAX % (CMM_CLU_SAMPLES - 1);
> > +
> > +	/*Update clu table*/
> > +	for (b_loop = 0; b_loop < CMM_CLU_SAMPLES; b_loop++) {
> > +		unsigned int b;
> > +
> > +		b = (b_loop * step_size) +
> > +		    DIV_ROUND_CLOSEST((b_loop * step_fraction),
> > +				      (CMM_CLU_SAMPLES - 1));
> > +
> > +		for (g_loop = 0; g_loop < CMM_CLU_SAMPLES; g_loop++) {
> > +			unsigned int g;
> > +
> > +			g = (g_loop * step_size) +
> > +			    DIV_ROUND_CLOSEST((g_loop * step_fraction),
> > +					      (CMM_CLU_SAMPLES - 1));
> > +
> > +			for (r_loop = 0; r_loop < CMM_CLU_SAMPLES; r_loop++) {
> > +				unsigned int r;
> > +				unsigned int r_val;
> > +				unsigned int g_val;
> > +				unsigned int b_val;
> > +
> > +				r = (r_loop * step_size) +
> > +				    DIV_ROUND_CLOSEST((r_loop * step_fraction),
> > +						      (CMM_CLU_SAMPLES - 1));
> > +
> > +				p->clu_buf[clu_index] = 0;
> > +
> > +				r_val =	rcar_du_cmm_scalar_product
> > +						(r, g, b,
> > +						 ctm->matrix[0], ctm->matrix[1],
> > +						 ctm->matrix[2]);
> > +
> > +				g_val =	rcar_du_cmm_scalar_product
> > +						(r, g, b,
> > +						 ctm->matrix[3], ctm->matrix[4],
> > +						 ctm->matrix[5]);
> > +
> > +				b_val =	rcar_du_cmm_scalar_product
> > +						(r, g, b,
> > +						 ctm->matrix[6], ctm->matrix[7],
> > +						 ctm->matrix[8]);
> > +
> > +				p->clu_buf[clu_index++] = (r_val << 16) |
> > +							  (g_val << 8) | b_val;
> > +			}
> > +		}
> > +	}
> > +
> > +	rcar_du_cmm_queue_clu_update(p);
> > +}
> 
> Just quick drive-by: I think there's some interested (definitely from
> intel, I pinged the relevant people from our team) to expose a 3D LUT
> directly to userspace. I'm not sure whether we can do both 3D-LUT and
> color matrix, and I'm also not sure whether remapping the ctm to a 3d-lut
> is the best thing to do. Otoh adding new uapi is always a bunch more work.

We're already thinking about extending the uapi a bit, so I
don't think including a 3D LUT in there would be too hard.

Couple of things we'd need to figure out:
- is a single 3D LUT attachment point sufficient? On our hw I
  believe the 3D LUT sits after the gamma LUT in the pipeline
- is a cube sufficient or would some hardware have different
  number of entries for each dimension (not sure why that would be)?
- need to agree in which order the entries would be stored in the
  blob
- and of course the big question: is anyone going to work on
  userspace that would make use of this?

-- 
Ville Syrjälä
Intel
