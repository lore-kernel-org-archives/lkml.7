Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36662067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbfISOKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:10:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:25539 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732274AbfISOKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:10:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 07:10:37 -0700
X-IronPort-AV: E=Sophos;i="5.64,523,1559545200"; 
   d="scan'208";a="271225817"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 07:10:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: tweak drm_print_bits()
In-Reply-To: <20190919131412.25602-1-kraxel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190919131412.25602-1-kraxel@redhat.com>
Date:   Thu, 19 Sep 2019 17:10:29 +0300
Message-ID: <8736gswf56.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019, Gerd Hoffmann <kraxel@redhat.com> wrote:
> There is little reason for the from/to logic, printing a subset of
> the bits can be done by simply shifting/masking value if needed.
>
> Also use for_each_set_bit().

Oh, I don't know why I stumbled upon and reviewed a patch that had
already been merged. Can't keep track of everything it seems...

>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_print.h              |  5 ++---
>  drivers/gpu/drm/drm_gem_ttm_helper.c |  4 ++--
>  drivers/gpu/drm/drm_print.c          | 20 +++++++++-----------
>  3 files changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 12d4916254b4..5b9947d157f4 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -89,9 +89,8 @@ __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
>  void drm_puts(struct drm_printer *p, const char *str);
>  void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
> -void drm_print_bits(struct drm_printer *p,
> -		    unsigned long value, const char *bits[],
> -		    unsigned int from, unsigned int to);
> +void drm_print_bits(struct drm_printer *p, unsigned long value,
> +		    const char * const bits[], int nbits);
>  
>  __printf(2, 0)
>  /**
> diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
> index 9a4bafcf20df..a534104d8bee 100644
> --- a/drivers/gpu/drm/drm_gem_ttm_helper.c
> +++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
> @@ -23,7 +23,7 @@
>  void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
>  			    const struct drm_gem_object *gem)
>  {
> -	static const char const *plname[] = {
> +	static const char * const plname[] = {
>  		[ TTM_PL_SYSTEM ] = "system",
>  		[ TTM_PL_TT     ] = "tt",
>  		[ TTM_PL_VRAM   ] = "vram",
> @@ -40,7 +40,7 @@ void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
>  	const struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
>  
>  	drm_printf_indent(p, indent, "placement=");
> -	drm_print_bits(p, bo->mem.placement, plname, 0, ARRAY_SIZE(plname));
> +	drm_print_bits(p, bo->mem.placement, plname, ARRAY_SIZE(plname));
>  	drm_printf(p, "\n");
>  
>  	if (bo->mem.bus.is_iomem) {
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index dfa27367ebb8..a495fe3ad909 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -189,28 +189,26 @@ EXPORT_SYMBOL(drm_printf);
>   * drm_print_bits - print bits to a &drm_printer stream
>   *
>   * Print bits (in flag fields for example) in human readable form.
> - * The first name in the @bits array is for the bit indexed by @from.
>   *
>   * @p: the &drm_printer
>   * @value: field value.
>   * @bits: Array with bit names.
> - * @from: start of bit range to print (inclusive).
> - * @to: end of bit range to print (exclusive).
> + * @nbits: Size of bit names array.
>   */
> -void drm_print_bits(struct drm_printer *p,
> -		    unsigned long value, const char *bits[],
> -		    unsigned int from, unsigned int to)
> +void drm_print_bits(struct drm_printer *p, unsigned long value,
> +		    const char * const bits[], int nbits)
>  {
>  	bool first = true;
>  	unsigned int i;
>  
> -	for (i = from; i < to; i++) {
> -		if (!(value & (1 << i)))
> -			continue;
> -		if (WARN_ON_ONCE(!bits[i-from]))
> +	if (WARN_ON_ONCE(nbits > sizeof(unsigned long) * 8))
> +		nbits = sizeof(unsigned long) * 8;

Might be neater with BITS_PER_TYPE(value) instead of open coding, but
either way,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> +
> +	for_each_set_bit(i, &value, nbits) {
> +		if (WARN_ON_ONCE(!bits[i]))
>  			continue;
>  		drm_printf(p, "%s%s", first ? "" : ",",
> -			   bits[i-from]);
> +			   bits[i]);
>  		first = false;
>  	}
>  	if (first)

-- 
Jani Nikula, Intel Open Source Graphics Center
