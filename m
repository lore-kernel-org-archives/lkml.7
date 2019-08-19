Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B954C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13AF22CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BxmwhJll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfHSQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:28:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43074 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:28:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so1200149pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dtollBZp7Cd+ev2dDovCVJwksY+nLROyjuudRVM9OKw=;
        b=BxmwhJllUMx6b1ZbOB0Bait3CD4aF8Nn7N71cUa/X450cNrv63L2ssIVE3JWtHagWE
         KMf79uArWdp5TpG5aurF+084leROU41Y0YRKJsgFfXB+X01NaQgX/UgLRy5iHzyIwQtl
         iNjLpw5NRpqOuli+PZSjJgLgxOYvTz5hhoRb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dtollBZp7Cd+ev2dDovCVJwksY+nLROyjuudRVM9OKw=;
        b=QCZt1nuUuTeguJZh9ucgtfbMPrao7OLRw93Hl+B4dz+jq7dXJxN7C+LmXHSYfkEW7F
         oRuGqk8fNYPEUnswa5V/biWkHLNYXKgV2pnFh8fGPbcki7VsJFK+eUpkJVlhakuSAQP5
         G6eeM6/R6Qs+v+B7m4RPj+8hWHNGN4OCQjpTqw7M/bizOWxPMrP1/0z94gs7p9W8RKf4
         vRK6UEYVy8/uPL7sQ7NAvZwZLoZU4MkHnKpMMD/ijNRimQmXMvDPE9F3g1Z0odlkKhNy
         bembBuCI4LuPi4Jn31C/CXyG1+K7DUwL9v2ByorHjAd82bozAVKjviwQp4HLgrKruVn1
         kziQ==
X-Gm-Message-State: APjAAAWGDAFv/xSb0+tiYGMYZBPOeKOr2KnXo6I/DoDHkiGMIbxW2MEh
        GyeDXYkL+K9WSK9Wz6xL1kbtuA==
X-Google-Smtp-Source: APXvYqz3swKpzU6/ulxtva6MdU20KzGqbm9MWaVfUX9EOYMl0e2vdxdyIjU27bv/Fze8Pmx0gRuQ8w==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr23853750pls.156.1566232085869;
        Mon, 19 Aug 2019 09:28:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x2sm16090710pja.22.2019.08.19.09.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 09:28:05 -0700 (PDT)
Date:   Mon, 19 Aug 2019 09:28:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org,
        Drew Davenport <ddavenport@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: don't use __WARN() for WARN_ON()
Message-ID: <201908190917.9C65E23D6A@keescook>
References: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:06:28PM +0000, Christophe Leroy wrote:
> __WARN() used to just call __WARN_TAINT(TAINT_WARN)
> 
> But a call to printk() has been added in the commit identified below
> to print a "---- cut here ----" line.
> 
> This change only applies to warnings using __WARN(), which means
> WARN_ON() where the condition is constant at compile time.
> For WARN_ON() with a non constant condition, the additional line is
> not printed.
> 
> In addition, adding a call to printk() forces GCC to add a stack frame
> and save volatile registers. Powerpc has been using traps to implement
> warnings in order to avoid that.
> 
> So, call __WARN_TAINT(TAINT_WARN) directly instead of using __WARN()
> in order to restore the previous behaviour.
> 
> If one day powerpc wants the decorative "---- cut here ----" line, it
> has to be done in the trap handler, not in the WARN_ON() macro.
> 
> Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Ah! Hmpf. Yeah, that wasn't an intended side-effect of this fix.

It seems PPC is not alone in this situation of making this code much
noisier. It looks like there needs to be a way to indicate to the trap
handler that a message was delivered or not. Perhaps we can add another
taint flag?

-kees

> ---
>  arch/powerpc/include/asm/bug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index fed7e6241349..3928fdaebb71 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -99,7 +99,7 @@
>  	int __ret_warn_on = !!(x);				\
>  	if (__builtin_constant_p(__ret_warn_on)) {		\
>  		if (__ret_warn_on)				\
> -			__WARN();				\
> +			__WARN_TAINT(TAINT_WARN);		\
>  	} else {						\
>  		__asm__ __volatile__(				\
>  		"1:	"PPC_TLNEI"	%4,0\n"			\
> -- 
> 2.13.3
> 

-- 
Kees Cook
