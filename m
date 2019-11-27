Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68020C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473E3206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK0PRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:17:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:3353 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0PRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:17:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 07:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="221009990"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 27 Nov 2019 07:17:03 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 27 Nov 2019 17:17:03 +0200
Date:   Wed, 27 Nov 2019 17:17:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Uma Shankar <uma.shankar@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] drm: fix HDR static metadata type field numbering
Message-ID: <20191127151703.GJ1208@intel.com>
References: <1574865719-24490-1-git-send-email-laurentiu.palcu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574865719-24490-1-git-send-email-laurentiu.palcu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:42:35PM +0000, Laurentiu Palcu wrote:
> According to CTA-861 specification, HDR static metadata data block allows a
> sink to indicate which HDR metadata types it supports by setting the SM_0 to
> SM_7 bits. Currently, only Static Metadata Type 1 is supported and this is
> indicated by setting the SM_0 bit to 1.
> 
> However, the connector->hdr_sink_metadata.hdmi_type1.metadata_type is always
> 0, because hdr_metadata_type() in drm_edid.c checks the wrong bit.
> 
> This patch corrects the HDMI_STATIC_METADATA_TYPE1 bit position.

Was confused for a while why this has even been workning, but I guess 
that's due to userspace populating the metadata infoframe blob correctly
even if we misreported the metadata types in the parsed EDID metadata
blob.

Hmm. Actually on further inspection this all seems to be dead code. The
only thing we seem to use from the parsed EDID metadata stuff is
eotf bitmask. We check that in drm_hdmi_infoframe_set_hdr_metadata()
but we don't check the metadata type.

Maybe we should just nuke this EDID parsing stuff entirely? Seems
pretty much pointless.

> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
>  include/linux/hdmi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index 9918a6c..216e25e 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -155,7 +155,7 @@ enum hdmi_content_type {
>  };
>  
>  enum hdmi_metadata_type {
> -	HDMI_STATIC_METADATA_TYPE1 = 1,
> +	HDMI_STATIC_METADATA_TYPE1 = 0,
>  };
>  
>  enum hdmi_eotf {
> -- 
> 2.7.4

-- 
Ville Syrjälä
Intel
