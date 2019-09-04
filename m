Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5004622CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfIDPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:48:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:21768 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbfIDPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:48:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 08:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194775097"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 04 Sep 2019 08:48:01 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 04 Sep 2019 18:48:00 +0300
Date:   Wed, 4 Sep 2019 18:48:00 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20190904154800.GD7482@intel.com>
References: <20190831172546.GA1972@raspberrypi>
 <20190902122858.GU7482@intel.com>
 <20190904072707.GA29211@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904072707.GA29211@raspberrypi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:27:07AM +0100, Sidong Yang wrote:
> On Mon, Sep 02, 2019 at 03:28:58PM +0300, Ville Syrjälä wrote:
> > On Sat, Aug 31, 2019 at 06:25:46PM +0100, Sidong Yang wrote:
> > > Use alpha value to blend source value and destination value Instead of
> > > just overwrite with source value.
> > > 
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_composer.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > > index d5585695c64d..b776185e5cb5 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > > @@ -75,6 +75,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> > >  	int y_limit = y_src + h_dst;
> > >  	int x_limit = x_src + w_dst;
> > >  
> > > +	u8 *src, *dst;
> > > +	u32 alpha, inv_alpha;
> > 
> > These could all live in a tighter scope.
> 
> Hi, Ville.
> 
> Thank you for reviewing my patch.
> I think that's good idea and I'll do that in next version.
> I found some patch in mailing list that is similar with this patch.
> So should I drop this patch and find other thing?

Probably best if you discuss that with whoever sent that other patch.

> 
> Sidong.
> 
> > 
> > Apart from that lgtm
> > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > > +
> > >  	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
> > >  		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
> > >  			offset_dst = dest_composer->offset
> > > @@ -84,8 +87,14 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> > >  				     + (i * src_composer->pitch)
> > >  				     + (j * src_composer->cpp);
> > >  
> > > -			memcpy(vaddr_dst + offset_dst,
> > > -			       vaddr_src + offset_src, sizeof(u32));
> > > +			src = vaddr_src + offset_src;
> > > +			dst = vaddr_dst + offset_dst;
> > > +			alpha = src[3] + 1;
> > > +			inv_alpha = 256 - src[3];
> > > +			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
> > > +			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
> > > +			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
> > > +			dst[3] = 0xff;
> > >  		}
> > >  		i_dst++;
> > >  	}
> > > -- 
> > > 2.20.1
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > -- 
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel
