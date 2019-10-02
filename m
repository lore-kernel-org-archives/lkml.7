Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF6ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829C121A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfJBQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:18:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:47525 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfJBQS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:18:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 09:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="203644059"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 02 Oct 2019 09:18:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 02 Oct 2019 19:18:22 +0300
Date:   Wed, 2 Oct 2019 19:18:22 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        kernel@collabora.com, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: Fix comment doc for format_modifiers
Message-ID: <20191002161822.GA1208@intel.com>
References: <20191002154349.26895-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002154349.26895-1-andrzej.p@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:43:49PM +0200, Andrzej Pietrasiewicz wrote:
> To human readers
> 
> "array of struct drm_format modifiers" is almost indistinguishable from
> "array of struct drm_format_modifiers",

Unless I'm blind those two *are* indistinguishable :P

> especially given that
> struct drm_format_modifier does exist.
> 
> And indeed the parameter passes an array of uint64_t rather than an array
> of structs, but the first words of the comment suggest that it passes
> an array of structs.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index d6ad60ab0d38..df05d8a0dd63 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane

Looks like you have a broken version of git.

>   * @funcs: callbacks for the new plane
>   * @formats: array of supported formats (DRM_FORMAT\_\*)
>   * @format_count: number of elements in @formats
> - * @format_modifiers: array of struct drm_format modifiers terminated by
> + * @format_modifiers: array of modifiers of struct drm_format terminated by

Now it seems to be saying it's passing in struct drm_format foo[].
That doesn't seem right either.

>   *                    DRM_FORMAT_MOD_INVALID
>   * @type: type of plane (overlay, primary, cursor)
>   * @name: printf style format string for the plane name, or NULL for default name
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
