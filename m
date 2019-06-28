Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4407C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F9321726
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfF1LBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:01:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:11057 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfF1LA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:00:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 04:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="361035901"
Received: from ramaling-i9x.iind.intel.com (HELO intel.com) ([10.99.66.154])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2019 04:00:55 -0700
Date:   Fri, 28 Jun 2019 09:32:15 +0530
From:   Ramalingam C <ramalingam.c@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: connector: remove bogus NULL check
Message-ID: <20190628040215.GA24852@intel.com>
References: <20190628103925.2686249-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628103925.2686249-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-28 at 12:39:05 +0200, Arnd Bergmann wrote:
> mode->name is a character array in a structure, checking it's
> address is pointless and causes a warning with some compilers:
> 
> drivers/gpu/drm/drm_connector.c:144:15: error: address of array 'mode->name' will always evaluate to 'true'
>       [-Werror,-Wpointer-bool-conversion]
>                       mode->name ? mode->name : "",
>                       ~~~~~~^~~~ ~
> include/drm/drm_print.h:366:29: note: expanded from macro 'DRM_DEBUG_KMS'
>         drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
>                                    ^~~~~~~~~~~
> 
> Remove the check here.
> 
> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/drm_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 3afed5677946..b3f2cf7eae9c 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -141,7 +141,7 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
>  
>  	DRM_DEBUG_KMS("cmdline mode for connector %s %s %dx%d@%dHz%s%s%s\n",
>  		      connector->name,
> -		      mode->name ? mode->name : "",
> +		      mode->name,
Looks good to me.

Reviewed-by: Ramalingam C <ramlaingam.c@intel.com>
>  		      mode->xres, mode->yres,
>  		      mode->refresh_specified ? mode->refresh : 60,
>  		      mode->rb ? " reduced blanking" : "",
> -- 
> 2.20.0
> 
