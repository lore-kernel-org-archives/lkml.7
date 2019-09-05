Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084AFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8420640
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TinH6NpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbfIEWLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:11:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43023 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbfIEWLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:11:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so2213004pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/Kcu+TEnxemcLHPBIOR7W7oCWdQ6H+R16+eaD60thM=;
        b=TinH6NpUBURG6FRpa8HxppDuHhaOiMn0kcVvmKX/CJw73elJaPqag9mgbt/iahWZ6Q
         +o73xSbFrRrarG1hQq+0AQonEfCn8zDmJrn2vzuQKa24kmmekdqzzi0kdmQpMZ88ASZT
         JpCUzsQdGCkI4QFXo8+pbTN4xP8JWlROdrg7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/Kcu+TEnxemcLHPBIOR7W7oCWdQ6H+R16+eaD60thM=;
        b=KPJ3mtjfQ6jlCKuTc96ALiwlnaXqA0ldO94ej7eBdyVTiHLJcNg9hiwKR44WzWTdh/
         lDmftw5pk8sGG3OvS7vHkB5ERN13mY4j6ZSNQGcoTlROepDqwNAqlzTo1u7Z3hjdhczo
         EFrKThE8qYqL6CvoR4j+l0hq5mJ5csJqGINymgmWITBWWspOH4SVCvGoSByT9Ws6rUpy
         MuxGju+vYZSTGrNlUlpUT7MJ9hdINvsFnxjOV9OISXHqllQXi8gX3nxbulVKYXTTfy7G
         Xzdux2JHlC7WID+xufncToOS3H7OPJYwL5njpufMSVzsitspgWt3guc4ED2v1tfqBKQ9
         DiGQ==
X-Gm-Message-State: APjAAAXDSDpiNkYyQm5MRE9NEsX0gm+0ck96x0HI8dbw3qpcMRM6PtY5
        OoD//EI/8Up4NdcTRtxtCSgEwQ==
X-Google-Smtp-Source: APXvYqy185khK2qqfR3JxeV9WwUo02nEvBMioHwyGZ/tKK7i7ap8uRkmlwk9NRzc1F39R3us0Ac47A==
X-Received: by 2002:a62:cec4:: with SMTP id y187mr6647808pfg.84.1567721470669;
        Thu, 05 Sep 2019 15:11:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23sm3692997pfc.71.2019.09.05.15.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:11:09 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Eliminate unused ESCAPE_NULL, ESCAPE_SPACE flags
Message-ID: <201909051437.56B9B68@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-6-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-6-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:30PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> I can see how some finer-grained flags could be useful, but for now I'm
> trying to simplify, so let's just remove these unused ones.

I might change the Subject to "merge ESCAPE_{NULL,SPACE,SPECIAL}" or so.

> Note the trickiest part is actually the tests, and I still need to check
> them.

It looks correct to me, though I haven't run them myself yet. One
thing to add might be adding a NULL test with explicit calls to
string_escape_mem()?

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/proc/array.c                |  2 +-
>  include/linux/string_helpers.h |  6 ++--
>  lib/string_helpers.c           | 54 +++----------------------------
>  lib/test-string_helpers.c      | 58 ++++------------------------------
>  4 files changed, 14 insertions(+), 106 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 46dcb6f0eccf..982c95d09176 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -111,7 +111,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
>  	size = seq_get_buf(m, &buf);
>  	if (escape) {
>  		ret = string_escape_str(tcomm, buf, size,
> -					ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
> +					ESCAPE_SPECIAL, "\n\\");
>  		if (ret >= size)
>  			ret = -1;
>  	} else {
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 8a299a29b767..7bf0d137373d 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -41,15 +41,13 @@ static inline int string_unescape_any_inplace(char *buf)
>  	return string_unescape_any(buf, buf, 0);
>  }
>  
> -#define ESCAPE_SPACE		0x01
>  #define ESCAPE_SPECIAL		0x02
> -#define ESCAPE_NULL		0x04
>  #define ESCAPE_OCTAL		0x08
> -#define ESCAPE_ANY		\
> -	(ESCAPE_SPACE | ESCAPE_OCTAL | ESCAPE_SPECIAL | ESCAPE_NULL)
> +#define ESCAPE_ANY		(ESCAPE_OCTAL | ESCAPE_SPECIAL)
>  #define ESCAPE_NP		0x10
>  #define ESCAPE_ANY_NP		(ESCAPE_ANY | ESCAPE_NP)
>  #define ESCAPE_HEX		0x20
> +#define ESCAPE_FLAG_MASK	0x3a
>  
>  int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  		unsigned int flags, const char *only);
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 963050c0283e..ac72159d3980 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -310,7 +310,7 @@ static bool escape_passthrough(unsigned char c, char **dst, char *end)
>  	return true;
>  }
>  
> -static bool escape_space(unsigned char c, char **dst, char *end)
> +static bool escape_special(unsigned char c, char **dst, char *end)
>  {
>  	char *out = *dst;
>  	unsigned char to;
> @@ -331,27 +331,6 @@ static bool escape_space(unsigned char c, char **dst, char *end)
>  	case '\f':
>  		to = 'f';
>  		break;
> -	default:
> -		return false;
> -	}
> -
> -	if (out < end)
> -		*out = '\\';
> -	++out;
> -	if (out < end)
> -		*out = to;
> -	++out;
> -
> -	*dst = out;
> -	return true;
> -}
> -
> -static bool escape_special(unsigned char c, char **dst, char *end)
> -{
> -	char *out = *dst;
> -	unsigned char to;
> -
> -	switch (c) {
>  	case '\\':
>  		to = '\\';
>  		break;
> @@ -361,6 +340,9 @@ static bool escape_special(unsigned char c, char **dst, char *end)
>  	case '\e':
>  		to = 'e';
>  		break;
> +	case '\0':
> +		to = '0';
> +		break;
>  	default:
>  		return false;
>  	}
> @@ -376,24 +358,6 @@ static bool escape_special(unsigned char c, char **dst, char *end)
>  	return true;
>  }
>  
> -static bool escape_null(unsigned char c, char **dst, char *end)
> -{
> -	char *out = *dst;
> -
> -	if (c)
> -		return false;
> -
> -	if (out < end)
> -		*out = '\\';
> -	++out;
> -	if (out < end)
> -		*out = '0';
> -	++out;
> -
> -	*dst = out;
> -	return true;
> -}
> -
>  static bool escape_octal(unsigned char c, char **dst, char *end)
>  {
>  	char *out = *dst;
> @@ -465,17 +429,15 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   * destination buffer will not be NULL-terminated, thus caller have to append
>   * it if needs.   The supported flags are::
>   *
> - *	%ESCAPE_SPACE: (special white space, not space itself)
> + *	%ESCAPE_SPECIAL:
>   *		'\f' - form feed
>   *		'\n' - new line
>   *		'\r' - carriage return
>   *		'\t' - horizontal tab
>   *		'\v' - vertical tab
> - *	%ESCAPE_SPECIAL:
>   *		'\\' - backslash
>   *		'\a' - alert (BEL)
>   *		'\e' - escape
> - *	%ESCAPE_NULL:
>   *		'\0' - null
>   *	%ESCAPE_OCTAL:
>   *		'\NNN' - byte with octal value NNN (3 digits)
> @@ -519,15 +481,9 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  		    (is_dict && !strchr(only, c))) {
>  			/* do nothing */
>  		} else {
> -			if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
> -				continue;
> -
>  			if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
>  				continue;
>  
> -			if (flags & ESCAPE_NULL && escape_null(c, &p, end))
> -				continue;
> -
>  			/* ESCAPE_OCTAL and ESCAPE_HEX always go last */
>  			if (flags & ESCAPE_OCTAL && escape_octal(c, &p, end))
>  				continue;
> diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
> index 25b5cbfb7615..0da3c195a327 100644
> --- a/lib/test-string_helpers.c
> +++ b/lib/test-string_helpers.c
> @@ -124,20 +124,6 @@ struct test_string_2 {
>  
>  #define	TEST_STRING_2_DICT_0		NULL
>  static const struct test_string_2 escape0[] __initconst = {{
> -	.in = "\f\\ \n\r\t\v",
> -	.s1 = {{
> -		.out = "\\f\\ \\n\\r\\t\\v",
> -		.flags = ESCAPE_SPACE,
> -	},{
> -		.out = "\\f\\134\\040\\n\\r\\t\\v",
> -		.flags = ESCAPE_SPACE | ESCAPE_OCTAL,
> -	},{
> -		.out = "\\f\\x5c\\x20\\n\\r\\t\\v",
> -		.flags = ESCAPE_SPACE | ESCAPE_HEX,
> -	},{
> -		/* terminator */
> -	}},
> -},{
>  	.in = "\\h\\\"\a\e\\",
>  	.s1 = {{
>  		.out = "\\\\h\\\\\"\\a\\e\\\\",
> @@ -154,48 +140,26 @@ static const struct test_string_2 escape0[] __initconst = {{
>  },{
>  	.in = "\eb \\C\007\"\x90\r]",
>  	.s1 = {{
> -		.out = "\eb \\C\007\"\x90\\r]",
> -		.flags = ESCAPE_SPACE,
> -	},{
> -		.out = "\\eb \\\\C\\a\"\x90\r]",
> -		.flags = ESCAPE_SPECIAL,
> -	},{
>  		.out = "\\eb \\\\C\\a\"\x90\\r]",
> -		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL,
> +		.flags = ESCAPE_SPECIAL,
>  	},{
>  		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\015\\135",
>  		.flags = ESCAPE_OCTAL,
> -	},{
> -		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\r\\135",
> -		.flags = ESCAPE_SPACE | ESCAPE_OCTAL,
> -	},{
> -		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\015\\135",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
>  	},{
>  		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\r\\135",
> -		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_OCTAL,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
>  	},{
>  		.out = "\eb \\C\007\"\x90\r]",
>  		.flags = ESCAPE_NP,
> -	},{
> -		.out = "\eb \\C\007\"\x90\\r]",
> -		.flags = ESCAPE_SPACE | ESCAPE_NP,
> -	},{
> -		.out = "\\eb \\C\\a\"\x90\r]",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_NP,
>  	},{
>  		.out = "\\eb \\C\\a\"\x90\\r]",
> -		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NP,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_NP,
>  	},{
>  		.out = "\\033b \\C\\007\"\\220\\015]",
>  		.flags = ESCAPE_OCTAL | ESCAPE_NP,
> -	},{
> -		.out = "\\033b \\C\\007\"\\220\\r]",
> -		.flags = ESCAPE_SPACE | ESCAPE_OCTAL | ESCAPE_NP,
>  	},{
>  		.out = "\\eb \\C\\a\"\\220\\r]",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_SPACE | ESCAPE_OCTAL |
> -			 ESCAPE_NP,
> +		.flags = ESCAPE_SPECIAL ESCAPE_OCTAL | ESCAPE_NP,
>  	},{
>  		.out = "\\x1bb \\C\\x07\"\\x90\\x0d]",
>  		.flags = ESCAPE_NP | ESCAPE_HEX,
> @@ -247,9 +211,6 @@ static __init const char *test_string_find_match(const struct test_string_2 *s2,
>  	if (!flags)
>  		return s2->in;
>  
> -	/* Test cases are NULL-aware */
> -	flags &= ~ESCAPE_NULL;
> -
>  	/* ESCAPE_OCTAL has a higher priority */
>  	if (flags & ESCAPE_OCTAL)
>  		flags &= ~ESCAPE_HEX;
> @@ -290,13 +251,6 @@ static __init void test_string_escape(const char *name,
>  		const char *out;
>  		int len;
>  
> -		/* NULL injection */
> -		if (flags & ESCAPE_NULL) {
> -			in[p++] = '\0';
> -			out_test[q_test++] = '\\';
> -			out_test[q_test++] = '0';
> -		}
> -
>  		/* Don't try strings that have no output */
>  		out = test_string_find_match(s2, flags);
>  		if (!out)
> @@ -401,11 +355,11 @@ static int __init test_string_helpers_init(void)
>  			     get_random_int() % (UNESCAPE_ANY + 1), true);
>  
>  	/* Without dictionary */
> -	for (i = 0; i < (ESCAPE_ANY_NP | ESCAPE_HEX) + 1; i++)
> +	for (i = 0; i < ESCAPE_FLAG_MASK + 1; i++)
>  		test_string_escape("escape 0", escape0, i, TEST_STRING_2_DICT_0);
>  
>  	/* With dictionary */
> -	for (i = 0; i < (ESCAPE_ANY_NP | ESCAPE_HEX) + 1; i++)
> +	for (i = 0; i < ESCAPE_FLAG_MASK + 1; i++)
>  		test_string_escape("escape 1", escape1, i, TEST_STRING_2_DICT_1);
>  
>  	/* Test string_get_size() */
> -- 
> 2.21.0
> 

-- 
Kees Cook
