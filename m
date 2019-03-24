Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10774C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD81B2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIszMrem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCXDb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 23:31:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33260 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfCXDb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 23:31:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id q3so4781972edg.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AqWwPpOhsA2o26o2fmZIc6acNEKi6Y6NFEG4S68lPUs=;
        b=KIszMremumzSDdJ3xuPEGgEipEtkj5zt6+55g2FJIl2mwoAqyD0quhSBjPAXzlMaJS
         hX1N5PRsNxPeqPQZ8sMOjEEkTVgXxvk+KOpAawLWerSoFL8/z67AP1aJndttHKaykzEx
         B+Cn6IRvyxl2GD5uyBciK0KzNyOjjqHNiQR7Ww5z+E3zWS4YTfF7AziChKCJC7FetjQj
         XhrCxTJyFk87PXXrI1Fj4mpw4zGmlxziTQg8/hKu6ZfsOkmB9ePDmxGFNw1kIrAPWGLH
         leua/G9u8yWmGmDvmpEEWrPYDLJjQf2cJXvtLAYgUcmaFlB+D1TTDGqLzpjvqwjuzIyp
         iWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqWwPpOhsA2o26o2fmZIc6acNEKi6Y6NFEG4S68lPUs=;
        b=mqRvAvCVNonyegJQ/aCZy9myT0paHvIhQ26SgSG3PpCzcL0rH2dReGMWu8KjBtSF3L
         bBRMj59NEITlXWvJM8FYQQAngjZ/LgvVpiYr8AHhtBwzof7SErerrRrauRhwIsS1qWI6
         tYwBUHI1AtyH+2UyeLEbj0RSP1IfgJlTrhCUVhsqLWE4s8DPdskVV9VYXs6Focd0nKXC
         ZKNl6amZom7Ry0QjlH7H5kkgv5b7ArMycI9r3zsBjZ1j15R9XpYS+Pz3ixF3ePGNyjIR
         Si2geBszghDWog0h6u1cDJXMAPuWmxS34ZhJMet7ybTCajIB4E/X5FoZlCLqOIW8fJTZ
         qwZw==
X-Gm-Message-State: APjAAAUEudd4RVeVqFvs0ENSa7G4LEAi0PFO/vi5dCPuYxKpyCW74Q3C
        dyLxDSzHFN0y4WkiSESUjBU=
X-Google-Smtp-Source: APXvYqw5/MMKSmr+0EO5r5Lpx64jOIzYSkiixFWRORRjiKJsnpDQ60OlL/Sam/GH6eulbPVQJvsiAA==
X-Received: by 2002:a17:906:924e:: with SMTP id c14mr9851030ejx.230.1553398316876;
        Sat, 23 Mar 2019 20:31:56 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id d61sm4025148edd.96.2019.03.23.20.31.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 23 Mar 2019 20:31:55 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:31:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, linux@rasmusvillemoes.dk,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
Message-ID: <20190324033153.GA15815@archlinux-ryzen>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324022406.GA18988@sultan-box.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 07:24:06PM -0700, Sultan Alsawaf wrote:
> I messed up the return value for strcat in the first patch. Here's a fixed
> version, ready for some scathing reviews.
> 
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> When strcpy, strcat, and strcmp are used with a literal string, they can
> be optimized to memcpy or memcmp calls. These alternatives are faster
> since knowing the length of a string argument beforehand allows
> traversal through the string word at a time without being concerned
> about looking for the terminating zero character. In some cases, the
> replaced calls to memcpy or memcmp can even be optimized out completely
> for a significant speed up.
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  include/linux/string.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f..59c301c0e 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -476,4 +476,34 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
>  	return strncmp(str, prefix, len) == 0 ? len : 0;
>  }
>  
> +/*
> + * Replace some common string helpers with faster alternatives when one of the
> + * arguments is a constant (i.e., literal string). This uses strlen instead of
> + * sizeof for calculating the string length in order to silence compiler
> + * warnings that may arise due to what the compiler thinks is incorrect sizeof
> + * usage. The strlen calls on constants are folded into scalar values at compile
> + * time, so performance is not reduced by using strlen.
> + */
> +#define strcpy(dest, src)							\
> +	__builtin_choose_expr(__builtin_constant_p(src),			\
> +		memcpy((dest), (src), strlen(src) + 1),				\
> +		(strcpy)((dest), (src)))
> +
> +#define strcat(dest, src)							\
> +	__builtin_choose_expr(__builtin_constant_p(src),			\
> +		({								\
> +			memcpy(strchr((dest), '\0'), (src), strlen(src) + 1);	\
> +			(dest);							\
> +		}),								\
> +		(strcat)((dest), (src)))
> +
> +#define strcmp(dest, src)							\
> +	__builtin_choose_expr(__builtin_constant_p(dest),			\
> +		__builtin_choose_expr(__builtin_constant_p(src),		\
> +			(strcmp)((dest), (src)),				\
> +			memcmp((dest), (src), strlen(dest) + 1)),		\
> +		__builtin_choose_expr(__builtin_constant_p(src),		\
> +			memcmp((dest), (src), strlen(src) + 1),			\
> +			(strcmp)((dest), (src))))
> +
>  #endif /* _LINUX_STRING_H_ */
> -- 
> 2.21.0
> 

Explicitly cc'ing some folks who have touched include/linux/string.h in
the past and might want to take a look at this.

Nathan
