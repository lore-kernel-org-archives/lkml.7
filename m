Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB23C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F4421655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2WlU1yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfG2QeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:34:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfG2QeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so22304785pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ca+YSd8mbC6/QP7bucgP0RJlJ7s9mNS/b3WYrRyYNxU=;
        b=C2WlU1yyqjL71V6kYoq5pfDYgiupYLoaryJQzFrERxCtl8dzx4LENMCf5NpqhOY66Z
         OL/iIv/XfZHiho9OuRY6/jKyuDN8Xp3PYswuMXE8xvg8SeBOQRnXEpmmem3h6GQTnSaR
         lspoxVEtOP7JJUfXUw+sOhtIO43IZP6jnlFdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ca+YSd8mbC6/QP7bucgP0RJlJ7s9mNS/b3WYrRyYNxU=;
        b=Luew/N25K6VoZ/fjOT8PKKmJFE0Fsx/NGw/X3zHXL+ms1aJnjFz9unW5J6DogUDshu
         Gd54Bnjo8vDOYGc/1TQxeO2pqwmUD99UVKcrh9nm+4UnYIP/7Kgh7e8wEcrQXWW6clHm
         sz2Ywut/s1ZMwUO303tpgrQoDiVwIlUXA3l4J9F0aZjW7sMsmxpRU4OtTP7jCBsaAgqW
         8+S25ILIXGC2TmJA4DGshHUQcrAu2paNyzTV+cJM+FBK0W4NuBukTJFAaaqHD+JTqKfj
         o7NDkECPo7uxFJ5DkFeS2MHYS+cmA5+75ZqD+q1ifOrnzHS3VTPy4FBGzoTEFlgO0/5u
         ZiJg==
X-Gm-Message-State: APjAAAUY3T8qbsDrxhuvt4uyWoosI2kgL2TBIWX7fo3HL/nVLXmmxfaX
        HKhx8Lym9r7f4m+mgLdKiuMRDQ==
X-Google-Smtp-Source: APXvYqyIayTp3rVKZYtqsF3Mjt/igbA32g+weE6tcF1VgFU4F/YQAN4kZpUcLtbNEwET5wPs8Wk2yg==
X-Received: by 2002:a63:1723:: with SMTP id x35mr6763433pgl.442.1564418063762;
        Mon, 29 Jul 2019 09:34:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i14sm96530950pfk.0.2019.07.29.09.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:34:23 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:34:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ARM: alignment: Mark expected switch fall-throughs
Message-ID: <201907290934.7C7C914@keescook>
References: <20190728231920.GA22247@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728231920.GA22247@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:19:20PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> arch/arm/mm/alignment.c: In function 'thumb2arm':
> arch/arm/mm/alignment.c:688:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if ((tinstr & (3 << 9)) == 0x0400) {
>       ^
> arch/arm/mm/alignment.c:700:2: note: here
>   default:
>   ^~~~~~~
> arch/arm/mm/alignment.c: In function 'do_alignment_t32_to_handler':
> arch/arm/mm/alignment.c:753:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    poffset->un = (tinst2 & 0xff) << 2;
>    ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
> arch/arm/mm/alignment.c:754:2: note: here
>   case 0xe940:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/mm/alignment.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 8cdb78642e93..04b36436cbc0 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -695,7 +695,7 @@ thumb2arm(u16 tinstr)
>  			return subset[(L<<1) | ((tinstr & (1<<8)) >> 8)] |
>  			    (tinstr & 255);		/* register_list */
>  		}
> -		/* Else fall through for illegal instruction case */
> +		/* Else, fall through - for illegal instruction case */
>  
>  	default:
>  		return BAD_INSTR;
> @@ -751,6 +751,8 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
>  	case 0xe8e0:
>  	case 0xe9e0:
>  		poffset->un = (tinst2 & 0xff) << 2;
> +		/* Fall through */
> +
>  	case 0xe940:
>  	case 0xe9c0:
>  		return do_alignment_ldrdstrd;
> -- 
> 2.22.0
> 

-- 
Kees Cook
