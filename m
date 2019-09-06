Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31AFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744932173B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436531AbfIFSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:17:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:16000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404380AbfIFSRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:17:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 11:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="213231606"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 06 Sep 2019 11:17:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 06 Sep 2019 21:17:14 +0300
Date:   Fri, 6 Sep 2019 21:17:14 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: matrox: make array wtst_xlat static const, makes
 object smaller
Message-ID: <20190906181714.GU7482@intel.com>
References: <20190906181114.31414-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906181114.31414-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:11:14PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array wtst_xlat on the stack but instead make it
> static const. Makes the object code smaller by 89 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   14347	    840	      0	  15187	   3b53	fbdev/matrox/matroxfb_misc.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   14162	    936	      0	  15098	   3afa	fbdev/matrox/matroxfb_misc.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/fbdev/matrox/matroxfb_misc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/matrox/matroxfb_misc.c b/drivers/video/fbdev/matrox/matroxfb_misc.c
> index c7aaca12805e..feb0977c82eb 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_misc.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_misc.c
> @@ -673,7 +673,10 @@ static int parse_pins5(struct matrox_fb_info *minfo,
>  	if (bd->pins[115] & 4) {
>  		minfo->values.reg.mctlwtst_core = minfo->values.reg.mctlwtst;
>  	} else {
> -		u_int32_t wtst_xlat[] = { 0, 1, 5, 6, 7, 5, 2, 3 };
> +		static const u_int32_t wtst_xlat[] = {
> +			0, 1, 5, 6, 7, 5, 2, 3

All of those would easily fit in u8 as well.

> +		};
> +
>  		minfo->values.reg.mctlwtst_core = (minfo->values.reg.mctlwtst & ~7) |
>  						  wtst_xlat[minfo->values.reg.mctlwtst & 7];
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
