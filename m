Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94607C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF94208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJBn19UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfFTCzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:55:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44801 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:55:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so2259101edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZ+ejxndkdfy6SmQH0Sb4mkugBsvHzjhSLcNChrvWio=;
        b=nJBn19UPynmT3Ibyor9XDF2WMVfWpTauLfl98pZIsfjouBRoiw9pMuKnW9NeN//I9D
         SfSaxQVpHRX0Kmnf/Z5QFl4Rk1qIJ3mxWyo088XCIDQnmhoBZu6czXrDsLnWVSiCT1IX
         ooigmZ+JzHGbsJCqePRHhWSEbKUXii/v88oKZAqyOyFCatttqhOkMAMinBoyxk0km5Xb
         CfqlC7gpsHj/coBMOtjtRb9Iyz7dPT5sa2rb0FY9EnCmWHWStZ1SbXN3tR0lV05TjlY1
         HfkqvRTyIREla9LCGaU0siybl63bMNuLha/fzqenKQf6JfqFeWlxDPYeyx18yTWttQxO
         wsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZ+ejxndkdfy6SmQH0Sb4mkugBsvHzjhSLcNChrvWio=;
        b=neAK8Jed/AWgC8v5lW66XvLByxhQgwvcjMGTOjix3fRgeMAvVcUvu6ct6N5YDd+hbA
         Sx+62Yj7bkONSrTpVdufCHoBO0uCV2FNZRdT9NQjvdKqhN5NIaL6P0QCsxjhYnRlVAPo
         48TKGHaLo3JR9dI87CPSN8xMRrIkrlCXNMUVf4fLc90+FgQa+BqCXLr2iDenrpUz5NsQ
         bfgim+A1nabx48JQ4B+nNYTvkVQHmBl8WcgAkFEFrViNMl/fGTYBntQL6ZzOJ7xWubJB
         sJ69XZHxPEa6n3/5VDFpSopoY7GWzf7KgiA5UJrSTLEZcrFyT7cNu8Bfb5meZaRwyIC9
         NnQg==
X-Gm-Message-State: APjAAAVE8+92IoNS/vq4bOjycrvyCYsDWsP9i6WQ6V8yiCg517sH6/Nk
        3JXJKqFZWw/pw1R1a/Ecvmc=
X-Google-Smtp-Source: APXvYqwPRevbrgfSt4uDPXCliMqeMhgRwXbGEHZx81KfOtD6/K0ijJQWfwx9EbJnA7PP7TcFHRmjmw==
X-Received: by 2002:a17:906:e204:: with SMTP id gf4mr66672835ejb.302.1560999301295;
        Wed, 19 Jun 2019 19:55:01 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id n7sm3557068ejl.58.2019.06.19.19.55.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 19:55:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:54:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, clang-built-linux@googlegroups.com,
        joe@perches.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
Message-ID: <20190620025459.GB5669@archlinux-epyc>
References: <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
 <20190620001907.255803-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620001907.255803-1-ndesaulniers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 05:19:07PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> Add keyword support so that our mailing list gets cc'ed for clang/llvm
> patches. We're pretty active on our mailing list so far as code review.
> There are numerous Googlers like myself that are paid to support
> building the Linux kernel with Clang and LLVM.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

FWIW, if it is not too late:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Changes V1 -> V2:
> - tabs vs spaces as per Joe Perches
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef58d9a881ee..f92432452f46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3940,6 +3940,14 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>  S:	Maintained
>  F:	.clang-format
>  
> +CLANG/LLVM BUILD SUPPORT
> +L:	clang-built-linux@googlegroups.com
> +W:	https://clangbuiltlinux.github.io/
> +B:	https://github.com/ClangBuiltLinux/linux/issues
> +C:	irc://chat.freenode.net/clangbuiltlinux
> +S:	Supported
> +K:	\b(?i:clang|llvm)\b
> +
>  CLEANCACHE API
>  M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
