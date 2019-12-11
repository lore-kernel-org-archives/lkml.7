Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE842C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DBB21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbfLKPku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:40:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:59322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733115AbfLKPkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:40:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 07:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="245326651"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 11 Dec 2019 07:40:38 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 11 Dec 2019 17:40:37 +0200
Date:   Wed, 11 Dec 2019 17:40:37 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Thomas Anderson <thomasanderson@google.com>
Cc:     Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Pau <sean@poorly.run>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: Increase size of VDB and CMDB bitmaps to 256
 bits
Message-ID: <20191211154037.GI1208@intel.com>
References: <20191210221048.83628-1-thomasanderson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210221048.83628-1-thomasanderson@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:10:48PM -0800, Thomas Anderson wrote:
> CEA-861-G adds modes up to 219, so increase the size of the
> maps in preparation for adding the new modes to drm_edid.c.
> 
> Signed-off-by: Thomas Anderson <thomasanderson@google.com>

Thanks. lgtm. Pushed to drm-misc-next.

PS. I do wonder a bit if we should consider a more economical way to
track this stuff. Not really sure how many bits we can realistically
expect to be set in these bitmasks...

> ---
>  include/drm/drm_connector.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 5f8c3389d46f..17b728d9c73d 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -188,19 +188,19 @@ struct drm_hdmi_info {
>  
>  	/**
>  	 * @y420_vdb_modes: bitmap of modes which can support ycbcr420
> -	 * output only (not normal RGB/YCBCR444/422 outputs). There are total
> -	 * 107 VICs defined by CEA-861-F spec, so the size is 128 bits to map
> -	 * upto 128 VICs;
> +	 * output only (not normal RGB/YCBCR444/422 outputs). The max VIC
> +	 * defined by the CEA-861-G spec is 219, so the size is 256 bits to map
> +	 * up to 256 VICs.
>  	 */
> -	unsigned long y420_vdb_modes[BITS_TO_LONGS(128)];
> +	unsigned long y420_vdb_modes[BITS_TO_LONGS(256)];
>  
>  	/**
>  	 * @y420_cmdb_modes: bitmap of modes which can support ycbcr420
> -	 * output also, along with normal HDMI outputs. There are total 107
> -	 * VICs defined by CEA-861-F spec, so the size is 128 bits to map upto
> -	 * 128 VICs;
> +	 * output also, along with normal HDMI outputs. The max VIC defined by
> +	 * the CEA-861-G spec is 219, so the size is 256 bits to map up to 256
> +	 * VICs.
>  	 */
> -	unsigned long y420_cmdb_modes[BITS_TO_LONGS(128)];
> +	unsigned long y420_cmdb_modes[BITS_TO_LONGS(256)];
>  
>  	/** @y420_cmdb_map: bitmap of SVD index, to extraxt vcb modes */
>  	u64 y420_cmdb_map;
> -- 
> 2.24.0.525.g8f36a354ae-goog

-- 
Ville Syrjälä
Intel
