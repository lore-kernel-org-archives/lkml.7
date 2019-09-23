Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E64EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560A920665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Zm3mOYaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfIWNkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:40:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45221 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfIWNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:40:24 -0400
Received: by mail-yw1-f66.google.com with SMTP id x82so5184849ywd.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1MqwgCYvbJu6IValUwEPFrYJOmBGkhRNlZvnEbWcYg=;
        b=Zm3mOYazo3XedQz6SPylC8Ylq9rfusxgBmYG5CjcLe9HBssqdZod3KYjsqQEc2SjSH
         VY9GjpK8SEfAaSiiM+UNtW9zAFktHUGsjkF61ejpHhEUsSkS+q30aTwpNOK8mWMT20G/
         t38KbTxznENZbAls0bIDKUWw8Al+B8sV0+wOFQcQmJuqJFPPfZPXjbA581UW8rRNtbFV
         Y2yLgUnTU67vYXYcNlvFxrsoq+DnRk14/X2+HX0L9zMjrYow+mxgd3q/l0JtQHiocRRQ
         pz+eP4A0vfnFDAehD6vY9kNEgWFAU30VG70KWlKvjwy1eLsRnV+hvwBeGyAfQirPCtN6
         +tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1MqwgCYvbJu6IValUwEPFrYJOmBGkhRNlZvnEbWcYg=;
        b=pqqwoGnWEXF1zzlecRb/IgOnujlPWz1q93poS9KSssDU6dGENTRan8W3tuzSJs6J7t
         iNfMRYVKcikCn3Mw/x6+kXqnhsv/ZSFeel5aWRaXnGZbHDA+BNrT71ntCXeMLFEFsAte
         Qq9d9AJTuDnfUsZcHcVVjck5gDBywJY91D+uKLP8jBqKlabhZhy7KQ7rnvMISK02H1ya
         y2P3Cz0f/hkr+h73Okd8225FtAHcc6qSufdyCxy2wcdjK8EjUAQ8digW1IU30HtIbkFL
         ZpWtzvEqPDXYGBBYxppfY3rtWStqusHkYdtS35IsNqv27fbDfjdCOv26j2Nro1D55wo6
         66jw==
X-Gm-Message-State: APjAAAUhICxh3R8srK7JRg8fzv+tn7dCp9HLIQG9WSN+ZdWWhHn+LdJe
        qBS6CmpCcRWOzyaMFezb5YAlTA==
X-Google-Smtp-Source: APXvYqzMxqWf5Uy8S6G/gRL1UlXLckbkGLxbW91WuAFX18N1ZuXEoeMIiMarfVDeq9yCRajedp/9og==
X-Received: by 2002:a0d:d891:: with SMTP id a139mr22398928ywe.52.1569246023080;
        Mon, 23 Sep 2019 06:40:23 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id v62sm2589761ywc.105.2019.09.23.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 06:40:22 -0700 (PDT)
Date:   Mon, 23 Sep 2019 09:40:22 -0400
From:   Sean Paul <sean@poorly.run>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        jani.nikula@linux.intel.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm: tweak drm_print_bits()
Message-ID: <20190923134022.GZ218215@art_vandelay>
References: <20190923065814.4797-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923065814.4797-1-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:58:14AM +0200, Gerd Hoffmann wrote:
> There is little reason for the from/to logic, printing a subset of
> the bits can be done by simply shifting/masking value if needed.
> 
> Also use for_each_set_bit().
> 
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Acked-by: Sean Paul <sean@poorly.run>

> ---
>  include/drm/drm_print.h              |  5 ++---
>  drivers/gpu/drm/drm_gem_ttm_helper.c |  4 ++--
>  drivers/gpu/drm/drm_print.c          | 20 +++++++++-----------
>  3 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 12d4916254b4..89d38d07316c 100644
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
> +		    const char * const bits[], unsigned int nbits);
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
> index dfa27367ebb8..52cc7b38eb12 100644
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
> +		    const char * const bits[], unsigned int nbits)
>  {
>  	bool first = true;
>  	unsigned int i;
>  
> -	for (i = from; i < to; i++) {
> -		if (!(value & (1 << i)))
> -			continue;
> -		if (WARN_ON_ONCE(!bits[i-from]))
> +	if (WARN_ON_ONCE(nbits > BITS_PER_TYPE(value)))
> +		nbits = BITS_PER_TYPE(value);
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
> -- 
> 2.18.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
