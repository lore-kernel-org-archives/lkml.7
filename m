Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDCC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7F720679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTsxU1jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfG3RLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:11:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34789 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbfG3RLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:11:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so30174250pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DURkbxYpSyevpsa6R/8i8qyLSR7ch0xiZqDHE2fEsfE=;
        b=ZTsxU1jwWrAv6PbXiIIik3jf5/ft7LKcFvGYgVLnB4fPoQ3tvi3MKpyNrOPU21KDrh
         H5kP39SwZlpO3Akh/BlFqzi/NdJPb6xW6HfYfGoqkDiClLFgKYZab/gbg4ySHMYlMKkg
         D2KgzDmfBTZVzANTQ9UhE3pVRe6CTUc9yL+7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DURkbxYpSyevpsa6R/8i8qyLSR7ch0xiZqDHE2fEsfE=;
        b=ljTrxBwZK590dyKserf3RXd73fHrK04IYz+KXt+0Gj7HbnpCzufuAUV/lz1LJTTpkA
         QdjNVwdRI81Wh1STYTAG4Qmv49PsJkmt17vdkGf3WTmIFiGgyum9UgYrUrJrfxai1h2m
         nvEfIwmrHTaQqtSl2M78qEO1pyFgX5Hl8mv1UmyXmX2oAIcv3rgLceuQXDuKcRgj31/m
         5MgSaPU/LB0GhABNQj2vrGXpTnCPHpXXfnDE0tUKESxw5P8DrUAN7xVGpPj0PZWtqmPG
         D+ILBqxcJTI3oCj4rhnPQrrBZrT2l94Z9kN/5VY1tFDCfPLCVWRj6yrMvCLW01r180he
         qCfg==
X-Gm-Message-State: APjAAAXxQp50aeJD5tLbNzkGxbVsKVgnMCH3kVVCMYJjTEv5otBiM2KZ
        rnPiY5zL6Nlfg11o+O19qLm3Bw==
X-Google-Smtp-Source: APXvYqwHgmNOnBJ+nNiMj7wuTK/9aMk3slfx8ycNwvFhZErCqiyZqyD06IveEHQuUMtNtFe1ybumrw==
X-Received: by 2002:a62:7890:: with SMTP id t138mr34060209pfc.238.1564506681840;
        Tue, 30 Jul 2019 10:11:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r61sm80360776pjb.7.2019.07.30.10.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 10:11:21 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:11:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joonwon Kang <kjw1627@gmail.com>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] randstruct: fix a bug in is_pure_ops_struct()
Message-ID: <201907301008.622218EE5@keescook>
References: <20190727155841.GA13586@host>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727155841.GA13586@host>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:58:41AM +0900, Joonwon Kang wrote:
> Before this, there were false negatives in the case where a struct
> contains other structs which contain only function pointers because
> of unreachable code in is_pure_ops_struct().

Ah, very true. Something like:

struct internal {
	void (*callback)(void);
};

struct wrapper {
	struct internal foo;
	void (*other_callback)(void);
};

would have not been detected as is_pure_ops_struct()?

How did you notice this? (Are there cases of this in the kernel?)

> Signed-off-by: Joonwon Kang <kjw1627@gmail.com>

Applied; thanks!

-Kees

> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 6d5bbd31db7f..a123282a4fcd 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -443,13 +443,12 @@ static int is_pure_ops_struct(const_tree node)
>  		if (node == fieldtype)
>  			continue;
>  
> -		if (!is_fptr(fieldtype))
> -			return 0;
> -
> -		if (code != RECORD_TYPE && code != UNION_TYPE)
> -			continue;
> +		if (code == RECORD_TYPE || code == UNION_TYPE) {
> +			if (!is_pure_ops_struct(fieldtype))
> +				return 0;
> +		}
>  
> -		if (!is_pure_ops_struct(fieldtype))
> +		if (!is_fptr(fieldtype))
>  			return 0;
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
