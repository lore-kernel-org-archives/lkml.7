Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69924C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8FF20820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfIBM3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:29:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:4185 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfIBM3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:29:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 05:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="176308892"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 02 Sep 2019 05:28:59 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 02 Sep 2019 15:28:58 +0300
Date:   Mon, 2 Sep 2019 15:28:58 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20190902122858.GU7482@intel.com>
References: <20190831172546.GA1972@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190831172546.GA1972@raspberrypi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 06:25:46PM +0100, Sidong Yang wrote:
> Use alpha value to blend source value and destination value Instead of
> just overwrite with source value.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index d5585695c64d..b776185e5cb5 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -75,6 +75,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
>  	int y_limit = y_src + h_dst;
>  	int x_limit = x_src + w_dst;
>  
> +	u8 *src, *dst;
> +	u32 alpha, inv_alpha;

These could all live in a tighter scope.

Apart from that lgtm
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +
>  	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
>  		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
>  			offset_dst = dest_composer->offset
> @@ -84,8 +87,14 @@ static void blend(void *vaddr_dst, void *vaddr_src,
>  				     + (i * src_composer->pitch)
>  				     + (j * src_composer->cpp);
>  
> -			memcpy(vaddr_dst + offset_dst,
> -			       vaddr_src + offset_src, sizeof(u32));
> +			src = vaddr_src + offset_src;
> +			dst = vaddr_dst + offset_dst;
> +			alpha = src[3] + 1;
> +			inv_alpha = 256 - src[3];
> +			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
> +			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
> +			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
> +			dst[3] = 0xff;
>  		}
>  		i_dst++;
>  	}
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
