Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACBE206DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CVIIrQpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfIEWeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:34:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33741 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIEWeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:34:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so2080600plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dALbmXd8B2KRQsGHWDockZQmAxsIGJFCG+7TAhj6O5A=;
        b=CVIIrQpTBu4ZsGqnfmEBpZbLBuqSsbV8wc/RKcxa4Uy7Gnw+LyWGoVhgzXQRgr6IT0
         mp/CGLJj+FVYwjaNPHB0ePrWiVSNDRRFFdZNmKb6L+ko4Ai0g4tAip9joCjhA0vNwh6r
         eCGbe/YM8FxoUtRQmtkGB3Wn8ypxCuLpnk3jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dALbmXd8B2KRQsGHWDockZQmAxsIGJFCG+7TAhj6O5A=;
        b=azGoWV6edyIUO985AAbaB4Rl7lJbrngKmfEk453UW7yFbgJkbU0qmAu/NZdMupdgGX
         6S4AcNQB4ZoI/FUYHyLfSfEJhjHjc2yNkAKTpjXBaNTeX574/hwxN4tissmIH6zFDxkm
         XdiJnXkHHIvAGhr9B2NFlAK3o6E/i2HZsWCZAVx1tVZlIUoT3s/MWb0xTzxTjYBtV3gK
         T+yWsswqaYiWBKKQt+/nC9qSG75Mdn0ZOW5p4YrjAkrrt93o9+VaaqsN0kSF7ljCs9Iu
         AW9LkrBZLGYIqNhZNI+LAiHdjnDmY5qG5q4qLaX0q83gDlc5Am1IIjKzRhxkXJCTfgMy
         UPIw==
X-Gm-Message-State: APjAAAWmdLkRrg6lOAZap2+IKsKrqaEJM4FBuVwVFVzy3GC6ZKwVZFDd
        K8C+dHAfJZVzmlleUvt7cI2Vf+BuRkA=
X-Google-Smtp-Source: APXvYqxUdydbfTnj+0h6KV7oUwPV4Ut1OCxwGutgiWc3K+sVjYqAgl9cF8lJB26+v0oizqzYU51EcQ==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr6054222plb.23.1567722845519;
        Thu, 05 Sep 2019 15:34:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br18sm2581293pjb.20.2019.09.05.15.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:34:04 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:34:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] Remove string_escape_mem_ascii
Message-ID: <201909051532.3062C94A1@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-9-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-9-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:33PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> It's easier to do this in string_escape_mem now.
> 
> Might also consider non-ascii and quote-mark sprintf modifiers and then
> we might make do with seq_printk.

With '\' always handled, it can be dropped from the "esc" args below. I
wonder if ESCAPE_QUOTES is needed or if "esc" can just continue to be
used for that.

(Also, do we want to add the "hex escape" modifier back to snprintf's
%pE stuff?)

-Kees

> ---
>  fs/seq_file.c                  |  3 ++-
>  include/linux/string_helpers.h |  3 +--
>  lib/string_helpers.c           | 24 ++++--------------------
>  3 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 63e5a7c4dbf7..0e45a25523ad 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -390,7 +390,8 @@ void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
>  	size_t size = seq_get_buf(m, &buf);
>  	int ret;
>  
> -	ret = string_escape_mem_ascii(src, isz, buf, size);
> +	ret = string_escape_mem(src, isz, buf, size, ESCAPE_NP|ESCAPE_NONASCII|
> +				ESCAPE_STYLE_SLASH|ESCAPE_STYLE_HEX, "\"\\");
>  	seq_commit(m, ret < size ? ret : -1);
>  }
>  EXPORT_SYMBOL(seq_escape_mem_ascii);
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 5d350f7f6874..f3388591d83f 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -43,6 +43,7 @@ static inline int string_unescape_any_inplace(char *buf)
>  
>  #define ESCAPE_SPECIAL		0x01
>  #define ESCAPE_NP		0x02
> +#define ESCAPE_NONASCII		0x04
>  #define ESCAPE_ANY_NP		(ESCAPE_SPECIAL | ESCAPE_NP)
>  #define ESCAPE_STYLE_SLASH	0x20
>  #define ESCAPE_STYLE_OCTAL	0x40
> @@ -52,8 +53,6 @@ static inline int string_unescape_any_inplace(char *buf)
>  int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  		unsigned int flags, const char *only);
>  
> -int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
> -					size_t osz);
>  static inline int string_escape_str(const char *src, char *dst, size_t sz,
>  		unsigned int flags, const char *only)
>  {
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 6f553f893fda..1dacf76eada0 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -439,6 +439,8 @@ static bool is_special(char c)
>   *		'\a' - alert (BEL)
>   *		'\e' - escape
>   *		'\0' - null
> + *	%ESCAPE_NONASCII:
> + *		escape characters with the high bit set
>   *	%ESCAPE_NP:
>   *		escape only non-printable characters (checked by isprint)
>   *	%ESCAPE_ANY_NP:
> @@ -468,7 +470,8 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  
>  		if ((is_dict && strchr(esc, c)) ||
>  		    (flags & ESCAPE_NP && !isprint(c)) ||
> -		    (flags & ESCAPE_SPECIAL && is_special(c))) {
> +		    (flags & ESCAPE_SPECIAL && is_special(c)) ||
> +		    (flags & ESCAPE_NONASCII && !isascii(c))) {
>  
>  			if (flags & ESCAPE_STYLE_SLASH &&
>  					escape_special(c, &p, end))
> @@ -491,25 +494,6 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  }
>  EXPORT_SYMBOL(string_escape_mem);
>  
> -int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
> -					size_t osz)
> -{
> -	char *p = dst;
> -	char *end = p + osz;
> -
> -	while (isz--) {
> -		unsigned char c = *src++;
> -
> -		if (!isprint(c) || !isascii(c) || c == '"' || c == '\\')
> -			escape_hex(c, &p, end);
> -		else
> -			escape_passthrough(c, &p, end);
> -	}
> -
> -	return p - dst;
> -}
> -EXPORT_SYMBOL(string_escape_mem_ascii);
> -
>  /*
>   * Return an allocated string that has been escaped of special characters
>   * and double quotes, making it safe to log in quotes.
> -- 
> 2.21.0
> 

-- 
Kees Cook
