Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778ACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0C6217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aX3gEPe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfICKyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:54:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41721 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:54:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id z9so12843363edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfolOzk1BxHRrQFKBBtT+6uQRmEmOb3P6qDOK43OCow=;
        b=aX3gEPe/z4TuMjilqqC8NAae5WbmK/CindbAF5loLBCRbttVeiajRY2Xs+DOm7OrLF
         n79DhqQjif/rkDQbW0w8cLEFGNSwV6/UtLlFBj9ACTBU52tywKKzmrxgi2aJCUzEw22w
         SyjbC+XrsnGLmTuOdKIJBMmPYQ/9NzPExDptE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LfolOzk1BxHRrQFKBBtT+6uQRmEmOb3P6qDOK43OCow=;
        b=bPMApD15F9FMvvDXX3ZHnJvaONBz9h7w8WuR0qrQ3uRg6AvGAGymhCvKDxqmd0s2uF
         Lf5thkt5ZXRFXwkMAKJCdQ7siEjAWveXiMxjlPmtU40C3orgR+ivd4wA6yfw8Tj0OCv8
         +nUioCQclPgH0xMEAzRO8uWLWRAPL78th2foGKdbrD9EyAgBTKg9RlxAv5PlMdxWTrOv
         cOkdxoJ+NxoDkCQFABR3MJOqhfII0uM1MAH0PeDPth/lHzSKGQvpZX6iiUT56csHVt1K
         JPCotfhRpu9eldC9awe1NyGMxr019cVa4rLVLra7gaYHXd7AZMbw+LVDcn+aiTlUgWCw
         EiDA==
X-Gm-Message-State: APjAAAXmHvxFV85fAlC0u02CiNmkoaN5JdNeZVFT9yh6CldmwLM302f+
        MxTzFAZjSs83PFcHKYBUyWI7dA==
X-Google-Smtp-Source: APXvYqxn+sgzqZEKUCgBAeWqjRi9d86KwWrO+JZVushfmeaH5LiRugOcZfrT4QxVnrLzFtceUxvihg==
X-Received: by 2002:a17:906:a957:: with SMTP id hh23mr19832335ejb.82.1567508079238;
        Tue, 03 Sep 2019 03:54:39 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u14sm3435231edy.55.2019.09.03.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 03:54:38 -0700 (PDT)
Date:   Tue, 3 Sep 2019 12:54:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] drm: add drm_print_bits
Message-ID: <20190903105436.GU2112@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190903101248.12879-1-kraxel@redhat.com>
 <20190903101248.12879-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903101248.12879-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:12:43PM +0200, Gerd Hoffmann wrote:
> New helper to print named bits of some value (think flags fields).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_print.h     |  3 +++
>  drivers/gpu/drm/drm_print.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index a5d6f2f3e430..8658c1da1c7d 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -88,6 +88,9 @@ __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
>  void drm_puts(struct drm_printer *p, const char *str);
>  void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
> +void drm_print_bits(struct drm_printer *p, unsigned int indent,
> +		    const char *label, unsigned int value,
> +		    const char *bits[], unsigned int nbits);
>  
>  __printf(2, 0)
>  /**
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index a17c8a14dba4..7f7aba920f51 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -179,6 +179,42 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
>  }
>  EXPORT_SYMBOL(drm_printf);
>  
> +/**
> + * drm_print_bits - print bits to a &drm_printer stream
> + *
> + * Print bits (in flag fields for example) in human readable form.
> + *
> + * @p: the &drm_printer
> + * @indent: Tab indentation level (max 5)
> + * @label: field label.
> + * @value: field value.
> + * @bits: Array with bit names.
> + * @nbits: bit name array size.
> + */
> +void drm_print_bits(struct drm_printer *p, unsigned int indent,
> +		    const char *label, unsigned int value,
> +		    const char *bits[], unsigned int nbits)
> +{
> +	bool first = true;
> +	unsigned int i;
> +
> +	for (i = 0; i < nbits; i++) {
> +		if (!(value & (1 << i)))
> +			continue;
> +		if (!bits[i])

I think this should be a WARN_ON, indicates a programming error?

> +			continue;
> +		if (first) {
> +			first = false;
> +			drm_printf_indent(p, indent, "%s=%s",
> +					  label, bits[i]);

Hm, to make this a bit more flexible to use I'd drop the label= printing
...

> +		} else
> +			drm_printf(p, ",%s", bits[i]);
> +	}
> +	if (!first)
> +		drm_printf(p, "\n");

... and also the newline. Then you could also use this for bit-fields
which just a few bits. Also, should we print anything if no bit is set?

If you prefer the label= + \n then pls add that to the kerneldoc, that it
prints this as a line of its own.
-Daniel

> +}
> +EXPORT_SYMBOL(drm_print_bits);
> +
>  void drm_dev_printk(const struct device *dev, const char *level,
>  		    const char *format, ...)
>  {
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
