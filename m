Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36428C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0010920830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551635770;
	bh=1ShLwx1c+sYNXfccvnyUjcPJ6Vmwf8Uy27kwYsibyEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GYamLpChEJNREDR5hgH3jf65y1c62TvuAPIDldUgOkNZiSy7Mh3XZdIthX0n0Y6wv
	 F+4fowgYCqSJhURNh7QEkj/yLol+GhuArLO9WffefInruovyJdmvxKiVcUbXe9u90L
	 ZynTcr8pk3HVnWdf4V/hKMvaIAnu5oZyefVLmVAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCCRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfCCRzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:55:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EEF20830;
        Sun,  3 Mar 2019 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551635717;
        bh=1ShLwx1c+sYNXfccvnyUjcPJ6Vmwf8Uy27kwYsibyEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHHXI3uQXKDdjW2ksxABAN/8od1ZMcfjmUWshxzmcSpkuS+FzTtHriU79YSL1SqbV
         O5C2y3H519MTrXZssXeCyEGlLXqoPtTd76SsLy+pup/sxcgOmXJxjyzeMG+crsvGb6
         ZOM7V3WDBmiDMLW9fEn+8w4LBCSicU77zeTWnjXU=
Date:   Sun, 3 Mar 2019 18:55:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
Message-ID: <20190303175514.GA16636@kroah.com>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
> I submitted this through the netdev tree, maybe relevant for you as well.
> See also here: https://marc.info/?t=155103900100003&r=1&w=2
> 
> -------- Forwarded Message --------
> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
> Date: Sun, 3 Mar 2019 18:20:50 +0100
> From: Heiner Kallweit <hkallweit1@gmail.com>
> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
> 
> Add a new function strreplace_nonalnum that replaces all
> non-alphanumeric characters. Such functionality is needed e.g. when a
> string is supposed to be used in a sysfs file name. If '\0' is given
> as new character then non-alphanumeric characters are cut. 

sysfs doesn't have any such requirements, it can use whatever you want
to give it for a filename.

So don't create a random kernel function for sysfs please.

> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f..d827b0b0f 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -169,6 +169,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>  #endif
>  void *memchr_inv(const void *s, int c, size_t n);
>  char *strreplace(char *s, char old, char new);
> +char *strreplace_nonalnum(char *s, char new);
>  
>  extern void kfree_const(const void *x);
>  
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e..f2b1baf96 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -1047,6 +1047,33 @@ char *strreplace(char *s, char old, char new)
>  }
>  EXPORT_SYMBOL(strreplace);
>  
> +/**
> + * strreplace_nonalnum - Replace all non-alphanumeric characters in a string.
> + * @s: The string to operate on.
> + * @new: The character non-alphanumeric characters are replaced with.
> + *
> + * If new is '\0' then non-alphanumeric characters are cut.
> + *
> + * Returns pointer to the nul byte at the end of the modified string.

Why do you need to point to the end of the string?


> + */
> +char *strreplace_nonalnum(char *s, char new)
> +{
> +	char *p = s;
> +
> +	for (; *s; ++s)
> +		if (isalnum(*s)) {
> +			if (p != s)
> +				*p = *s;
> +			++p;
> +		} else if (new) {
> +			*p++ = new;
> +		}
> +	*p = '\0';

No max length?  No error checking?  Surely we can do better, see the
long thread on the kernel-hardnening list about string functions please.

greg k-h
