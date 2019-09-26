Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15FFC352AA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8140E222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wb3tv2Cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfIZOIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:08:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIZOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:08:52 -0400
Received: from zn.tnic (p200300EC2F0C9800AD9F87A1CF14B2BF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9800:ad9f:87a1:cf14:b2bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFE911EC064F;
        Thu, 26 Sep 2019 16:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569506930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XgMyhLCB3/0/URBCc/C1h2ku/+GkDrib3gJYGs9zt7Q=;
        b=Wb3tv2Cc8ExZ4mxRfqD0cFE6c4eSdRZE/Ldngch/EaP1yIunzhCZsLKV9DNjzmbCg+L27Q
        3UPsj7iYNdptJnH7y6+oznwWl3ETCjOFmrcXvBreoq8j1jXrvUFlDihyBbmDk9e+M+Ggll
        5j1un+P+AhR9oIn5yVKElRzoRhGGa6s=
Date:   Thu, 26 Sep 2019 16:08:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arthur Gautier <baloo@gandi.net>, Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20190926140850.GC18383@zn.tnic>
References: <20190215235901.23541-1-baloo@gandi.net>
 <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:15:44AM -0800, Andy Lutomirski wrote:
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 58eacd41526c..709d6efe0d42 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -10,12 +10,7 @@
>  #include <asm/byteorder.h>
>  #include <asm/word-at-a-time.h>
>  
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -#define IS_UNALIGNED(src, dst)	0
> -#else
> -#define IS_UNALIGNED(src, dst)	\
> -	(((long) dst | (long) src) & (sizeof(long) - 1))
> -#endif
> +#define IS_UNALIGNED(addr) (((long)(addr)) & (sizeof(long) - 1))
>  
>  /*
>   * Do a strncpy, return length of string without final '\0'.
> @@ -35,14 +30,39 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
>  	if (max > count)
>  		max = count;
>  
> -	if (IS_UNALIGNED(src, dst))
> +	/*
> +	 * First handle any unaligned prefix of src.
> +	 */
> +	while (max && IS_UNALIGNED(src+res)) {

put spaces around the '+', below too.

> +		char c;
> +
> +		unsafe_get_user(c, src+res, efault);
> +		dst[res] = c;
> +		if (!c)
> +			return res;
> +		res++;
> +		max--;
> +	}
> +
> +	/*
> +	 * Now we know that src + res is aligned.  If dst is unaligned and
> +	 * we don't have efficient unaligned access, then keep going one
> +	 * byte at a time.  (This could be optimized, but it would make
> +	 * the code more complicated.
> +	 */
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	if (IS_UNALIGNED(dst + res))
>  		goto byte_at_a_time;
> +#endif
>  
>  	while (max >= sizeof(unsigned long)) {
> +		/*
> +		 * src + res is aligned, so the reads in this loop will
> +		 * not cross a page boundary.
> +		 */
>  		unsigned long c, data;
>  
> -		/* Fall back to byte-at-a-time if we get a page fault */
> -		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
> +		unsafe_get_user(c, (unsigned long __user *)(src+res), efault);
>  
>  		*(unsigned long *)(dst+res) = c;
>  		if (has_zero(c, &data, &constants)) {
> @@ -54,7 +74,9 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
>  		max -= sizeof(unsigned long);
>  	}
>  
> -byte_at_a_time:

You can't remove that label - the ifndef above.

> +	/*
> +	 * Finish the job one byte at a time.
> +	 */
>  	while (max) {
>  		char c;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
