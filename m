Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174DAC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E5218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iN4t1Zn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392139AbfGWVg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:36:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41571 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfGWVg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:36:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so9708116pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sJ26+RBQ3ZFnOV9Aj98RtPTC8pHzaX0ptSijoUlQUkI=;
        b=iN4t1Zn1v2DmU8mvkldOApHG7952JwrdmCAzWP6t6fUn4mxwlrXdCrKhDBoYO+Kkks
         +rUONVweXqk57JOxOZq4HTSP1I+gj3kT41+v2kwK8PGg1PKElPlHUWQ4x0bobd6a76Jk
         mQvG6KpZ8nNo7er85VoQbqCLA5bcjdKb+zkNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJ26+RBQ3ZFnOV9Aj98RtPTC8pHzaX0ptSijoUlQUkI=;
        b=Kf7XbU5j7WOIpPDT4aRGjHHJl9BITpIpGElYmXgwSHTuiJQ5FmG6NiJNh7OuQRoj3D
         o/KmZWwSyDxj2zJhzhUCRtDXNXb/hlebguklAqF2ZeMfJZo5JooIAK0hdamOC8x3SKY5
         pSNNa7zk62xbROSsCwsjPB82X/m3Wc+h/az8o3pOvT7KIj+ZnIpM0rX9/d81oKrDSWf/
         nGvfbbBlM2u8+T1+BQZoKUWWdTZCURmouHnlnBDYuZNuoSpLR2yi8vzKUPiK6GE6+Uq4
         0ORY/w1FtrwvvR06IbFgO70tFwpJg7tE5hvzdttPIVoIj3TeY7/nXQWuT2XCf1o/5OXo
         jrtw==
X-Gm-Message-State: APjAAAWL8x7cyTWULYXkFqWFNY7eJI7W+srC/s8ddoQBddAS2lGt57cI
        +wY7MKtzTAf3vaTPaNdkE6IyNg==
X-Google-Smtp-Source: APXvYqyazzn/l0DUhiRHUd4km2uSqVHw+rh3+yfbkzQxFWclV2xeUZXtuW+YQtREN4gTjpXnJVwoaA==
X-Received: by 2002:a62:5487:: with SMTP id i129mr8031553pfb.69.1563917786927;
        Tue, 23 Jul 2019 14:36:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f88sm43170456pjg.5.2019.07.23.14.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 14:36:25 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:36:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Kitt <steve@sk2.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Message-ID: <201907231435.FABB1CC@keescook>
References: <cover.1563841972.git.joe@perches.com>
 <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:38:15PM -0700, Joe Perches wrote:
> Several uses of strlcpy and strscpy have had defects because the
> last argument of each function is misused or typoed.
> 
> Add macro mechanisms to avoid this defect.
> 
> stracpy (copy a string to a string array) must have a string
> array as the first argument (to) and uses sizeof(to) as the
> size.
> 
> These mechanisms verify that the to argument is an array of
> char or other compatible types like u8 or unsigned char.
> 
> A BUILD_BUG is emitted when the type of to is not compatible.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I think Rasmus's suggestion would make sense:

	BUILD_BUG_ON(!__same_type(typeof(to), char[]))

Either way, I think it should be fine:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/string.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4deb11f7976b..f80b0973f0e5 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -35,6 +35,47 @@ ssize_t strscpy(char *, const char *, size_t);
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
>  
> +/**
> + * stracpy - Copy a C-string into an array of char
> + * @to: Where to copy the string, must be an array of char and not a pointer
> + * @from: String to copy, may be a pointer or const char array
> + *
> + * Helper for strscpy.
> + * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination.
> + *
> + * Returns:
> + * * The number of characters copied (not including the trailing %NUL)
> + * * -E2BIG if @to is a zero size array.
> + */
> +#define stracpy(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\
> +	strscpy(to, from, size);				\
> +})
> +
> +/**
> + * stracpy_pad - Copy a C-string into an array of char with %NUL padding
> + * @to: Where to copy the string, must be an array of char and not a pointer
> + * @from: String to copy, may be a pointer or const char array
> + *
> + * Helper for strscpy_pad.
> + * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination
> + * and zero-pads the remaining size of @to
> + *
> + * Returns:
> + * * The number of characters copied (not including the trailing %NUL)
> + * * -E2BIG if @to is a zero size array.
> + */
> +#define stracpy_pad(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\
> +	strscpy_pad(to, from, size);				\
> +})
> +
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
>  #endif
> -- 
> 2.15.0
> 

-- 
Kees Cook
