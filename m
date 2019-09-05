Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E992C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEAB206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hOjYQuRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbfIEVfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:35:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbfIEVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:34:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so2183840pgo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RsLIl5K0jrZTsTxRJpmmFtsgDYlViFV+NPvDwNC4j0=;
        b=hOjYQuRXhj8BvSViKqLnOIVjSzPtQ2tvajLEdY9gUXizUFvwdyMxZUB2ULjHRxtGte
         eExvAF435vdi5QxIFwH6dneEgDjYg2NnYkGC5L2gKjYiTwGj1z6sOhu1espJgf/Fo405
         FMEQ3ca8pe/C9m+h3nN5v6HbSAS8BuIPEzKrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RsLIl5K0jrZTsTxRJpmmFtsgDYlViFV+NPvDwNC4j0=;
        b=sgTRGBQ+z4tA9+ZmoZq9B565Og9K7AT104V+c4zGKvwhfUkY8flzgPWJclFrll1TSA
         WURX+TAHdX1143+hbOcPKEu3uUFNJZKCIMtHSUNx/UywhrAz6wGMpE4mL6z9jzT1Z5Oq
         0aZg++Vs2FUoJDS8ytJxx0h6oEfW9iNqehoNrdGc9/gEhfIUYTbcFvBShLNOyo2+U8cl
         J2+eOAeo5Si+GKrSrIzPemv3S+5XsZET45WsyBIcQnl5v0ljCptOzNyUt+jW0IKeC19c
         xd+hrY47uhDWuZyVdfgK/EfJ0W3NW7kQ0FkwKc6BpTCXnt4Ofrx2E1zyW4/Itz15ecm5
         qnWw==
X-Gm-Message-State: APjAAAVQQ46FaTsvaYSrkVHhfEL+q0HGj/zlM3Zi+I0wjFuloTz1GI+s
        Xx4qC6qQNHw+fkMlRzRj5JbvNg==
X-Google-Smtp-Source: APXvYqwj77WtBTkqXYqrNSXC6Jn8HrrBsqnllRg6nXZzZ3oCqC97/sUAUyO1o0aO+MXP1EWaV/HrpQ==
X-Received: by 2002:a17:90a:e654:: with SMTP id ep20mr6139880pjb.65.1567719298875;
        Thu, 05 Sep 2019 14:34:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n66sm5364048pfn.90.2019.09.05.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 14:34:57 -0700 (PDT)
Date:   Thu, 5 Sep 2019 14:34:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] Remove unused %*pE[achnops] formats
Message-ID: <201909051433.33DE38C2@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-5-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-5-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:29PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> The [achnops] are confusing, and in practice the only one anyone seems
> to need is the bare %*pE.
> 
> I think some set of modifiers here might actually be useful, but the
> ones we have are confusing and unused, so let's just toss these out and
> then rethink what we might want to add back later.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

Typo below...

> ---
>  Documentation/core-api/printk-formats.rst | 23 ++---------
>  lib/vsprintf.c                            | 50 ++---------------------
>  2 files changed, 7 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index c6224d039bcb..4f9d20dfb342 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -180,35 +180,20 @@ Raw buffer as an escaped string
>  
>  ::
>  
> -	%*pE[achnops]
> +	%*pE
>  
>  For printing raw buffer as an escaped string. For the following buffer::
>  
>  		1b 62 20 5c 43 07 22 90 0d 5d
>  
> -A few examples show how the conversion would be done (excluding surrounding
> +An example shows how the conversion would be done (excluding surrounding
>  quotes)::
>  
>  		%*pE		"\eb \C\a"\220\r]"
> -		%*pEhp		"\x1bb \C\x07"\x90\x0d]"
> -		%*pEa		"\e\142\040\\\103\a\042\220\r\135"
>  
> -The conversion rules are applied according to an optional combination
> -of flags (see :c:func:`string_escape_mem` kernel documentation for the
> -details):
> +See :c:func:`string_escape_mem` kernel documentation for the details.
>  
> -	- a - ESCAPE_ANY
> -	- c - ESCAPE_SPECIAL
> -	- h - ESCAPE_HEX
> -	- n - ESCAPE_NULL
> -	- o - ESCAPE_OCTAL
> -	- p - ESCAPE_NP
> -	- s - ESCAPE_SPACE
> -
> -By default ESCAPE_ANY_NP is used.
> -
> -ESCAPE_ANY_NP is the sane choice for many cases, in particularly for
> -printing SSIDs.
> +This is used, for example, for printing SSIDs.
>  
>  If field width is omitted then 1 byte only will be escaped.
>  
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b0967cf17137..5522d2a052e1 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1537,9 +1537,6 @@ static noinline_for_stack
>  char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  		     const char *fmt)
>  {
> -	bool found = true;
> -	int count = 1;
> -	unsigned int flags = 0;
>  	int len;
>  
>  	if (spec.field_width == 0)
> @@ -1548,38 +1545,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  	if (check_pointer(&buf, end, addr, spec))
>  		return buf;
>  
> -	do {
> -		switch (fmt[count++]) {
> -		case 'a':
> -			flags |= ESCAPE_ANY;
> -			break;
> -		case 'c':
> -			flags |= ESCAPE_SPECIAL;
> -			break;
> -		case 'h':
> -			flags |= ESCAPE_HEX;
> -			break;
> -		case 'n':
> -			flags |= ESCAPE_NULL;
> -			break;
> -		case 'o':
> -			flags |= ESCAPE_OCTAL;
> -			break;
> -		case 'p':
> -			flags |= ESCAPE_NP;
> -			break;
> -		case 's':
> -			flags |= ESCAPE_SPACE;
> -			break;
> -		default:
> -			found = false;
> -			break;
> -		}
> -	} while (found);
> -
> -	if (!flags)
> -		flags = ESCAPE_ANY_NP;
> -
>  	len = spec.field_width < 0 ? 1 : spec.field_width;
>  
>  	/*
> @@ -1587,7 +1552,8 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  	 * the given buffer, and returns the total size of the output
>  	 * had the buffer been big enough.
>  	 */
> -	buf += string_escape_mem(addr, len, buf, buf < end ? end - buf : 0, flags, NULL);
> +	buf += string_escape_mem(addr, len, buf, buf < end ? end - buf : 0,
> +				 ESCAPE_ANY_NP, NULL);
>  
>  	return buf;
>  }
> @@ -2038,17 +2004,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
>   * - '[Ii][4S][hnbl]' IPv4 addresses in host, network, big or little endian order
>   * - 'I[6S]c' for IPv6 addresses printed as specified by
>   *       http://tools.ietf.org/html/rfc5952
> - * - 'E[achnops]' For an escaped buffer, where rules are defined by combination
> - *                of the following flags (see string_escape_mem() for the
> - *                details):
> - *                  a - ESCAPE_ANY
> - *                  c - ESCAPE_SPECIAL
> - *                  h - ESCAPE_HEX
> - *                  n - ESCAPE_NULL
> - *                  o - ESCAPE_OCTAL
> - *                  p - ESCAPE_NP
> - *                  s - ESCAPE_SPACE
> - *                By default ESCAPE_ANY_NP is used.
> + * - 'E[achnops]' For an escaped buffer (see string_escape_mem()

This line should be like this; no more suboptions and add missed final ")":

 * - 'E' For an escaped buffer (see string_escape_mem())

-Kees

>   * - 'U' For a 16 byte UUID/GUID, it prints the UUID/GUID in the form
>   *       "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
>   *       Options for %pU are:
> -- 
> 2.21.0
> 

-- 
Kees Cook
