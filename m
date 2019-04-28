Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A37C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B3520679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ConQIFHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfD1S6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:58:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36743 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1S6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:58:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so5253332edx.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+ILODwvOV/xXnzT6a1LEcZLC+Vx0+d8amE4WNJPmME=;
        b=ConQIFHBjJQwx/98RMH7MzUPGjK0lA8m4ZsXojEZRDzlMwf83bnbCPUXE1cajwr3nD
         SOjNwlpPzGuk9pUj9Fc2u/F2A6CtZ011C6TbPsttKkJN3TSW7TAyzB//5pZ3Uk9KVeyC
         kW++MS5qu+VZyOaJcAZ14QNUIX8sdjTGj4wkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+ILODwvOV/xXnzT6a1LEcZLC+Vx0+d8amE4WNJPmME=;
        b=YULiKLx4uMoDM8vmoaHSaq83Uv7at6NdwBjmpXK1wLLli3AzpV/PwMFb/qCHzNtvqs
         +Hp+sHR9JFV/6sFjKzpUCO1Y6HfpOxwJOeHb8tLGzN9dKzYEd6dwET+g2LqyPCXV0i87
         5+rZmqLZYOQGUOFOmyURAcFHdEh1goDstQc9M0X9/Ihqp/SDIJ1JDkZd4nK3xju0k+Pe
         ku9eK73gwgZ5q2oeygDulrpG1z9bLFEirl048bRMGe2CyUUHy23FJ3yy+X5J03XdAqAH
         OLhg1lyM5f/J62xcDbVooXMbQJYzeFm0WF47G40+O8fH73yz9sj+WpTXk6OsYXjoCuEp
         8u+g==
X-Gm-Message-State: APjAAAXFPjUNZEMYL+4IpH+gk+687g6EKkDR2cMNagGBCX+Xli3JKsia
        aSZNCLUpGXsSNEgWv1QEJWkc+w==
X-Google-Smtp-Source: APXvYqxCFil31gzBSBPCjqfStbaIP5WXyME6cGWlT+NEyVyCeMBXc9OJA96ZVLt1VdbypvDO6LLLCQ==
X-Received: by 2002:a17:906:5809:: with SMTP id m9mr4215620ejq.223.1556477931438;
        Sun, 28 Apr 2019 11:58:51 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i41sm7011653ede.36.2019.04.28.11.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 11:58:50 -0700 (PDT)
Subject: Re: [PATCH 1/6] lib/string: add strnchrnul()
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
 <20190428032936.1317-2-ynorov@marvell.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e23d695b-8cd1-9e22-af14-fe6fabb72efe@rasmusvillemoes.dk>
Date:   Sun, 28 Apr 2019 20:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428032936.1317-2-ynorov@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2019 05.29, Yury Norov wrote:
> New function works like strchrnul() with a length limited strings.
> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  include/linux/string.h |  3 +++
>  lib/string.c           | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4deb11f7976b..69e8df51b630 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -62,6 +62,9 @@ extern char * strchr(const char *,int);
>  #ifndef __HAVE_ARCH_STRCHRNUL
>  extern char * strchrnul(const char *,int);
>  #endif
> +#ifndef __HAVE_ARCH_STRNCHRNUL

I find it unlikely this would ever be performance-critical, so an arch
would want to implement its own. Please let's avoid adding redundant
ifdeffery (and yes, there's probably quite a few of the existing ones
that should go away).

>  
> +#ifndef __HAVE_ARCH_STRNCHRNUL
> +/**
> + * strnchrnul - Find and return a character in a length limited string,
> + * or end of string
> + * @s: The string to be searched
> + * @count: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Returns pointer to first occurrence of 'c' in s. If c is not found,
> + * then return a pointer to the null byte at the end of s.

Pet peeve: nul, not null. Especially important when this is in contrast
to returning a NULL pointer. Also, the description is inaccurate; the
whole point of the n-variant is that there is not necessarily any nul
terminator.

> + */
> +char *strnchrnul(const char *s, int count, int c)
> +{

Yes, make count size_t so it's easier to distinguish from the c, and
keep this parameter ordering (that matches the str n chr name).

> +	while (count-- && *s && *s != (char)c)
> +		s++;
> +	return (char *)s;
> +}
> +EXPORT_SYMBOL(strnchrnul);

This can be added if a modular user shows up. No reason to add that
bloat to the kernel image immediately.

Rasmus
