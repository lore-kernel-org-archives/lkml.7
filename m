Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BABBC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72406214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lI/F+evG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfGaT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:59:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44533 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbfGaT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:59:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so32590660pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wj8UI6KcdGWx7+DqBC4UilgyG1YpNkyj7/yhX7S5938=;
        b=lI/F+evGDUwaa/3jWG9s/L6Rki0XodRNIvovJ41k7O3gJBlhooGZWa8zk7zoZxPi3K
         2TLyWEVqGdpi3hnVGLBr1Oc4gUGjDuX/e0ynTnQkvdvYvby6ThNgqwr5+OlxOfckAHXE
         mdPb+Iuv8GNJU7luiqE0KFaafHR7acsFoLCvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wj8UI6KcdGWx7+DqBC4UilgyG1YpNkyj7/yhX7S5938=;
        b=tvpZsj5ELCB3uyQ+PpZ+blXLQ470tByqZLVYYtFbUOO8UMDty2WpGQtpFCiO5S8WHY
         bf4bNk3mPFEPE8Xod6bfaRPWu7YLhynfcRYv6kZ9C3FM6s9nOfiM9EEcI3l1w8dFYD0v
         u1r91ep8mTY3Jp6GCZdT6DgkgK372lSASD+0UjEwwZbj1yz7aAlEywFC5C1XaISU4wXW
         TSC8Ho1uifol+OnKxQsLReAwtUNgBl6InvPCSramqnh1YK7DpWUDh7s+ItwuEvgTMgxN
         ttsHABwd7WamN/OOOII4EMJNbeVeFPkbu1+SlzylmGhZE8rOT8EaQ//WA0xAj6LTI6Ot
         z1zw==
X-Gm-Message-State: APjAAAUMHFdThIX9i1M18jS6hB9YLmj5pTkotGFgLaEL1GihrnreITH/
        Usj9cRi1kOrE5/9tSnieun4HDQ==
X-Google-Smtp-Source: APXvYqyo7YtH0z/PjARx5H0oYP8eGymkvm90XLND0TLR+aFSRTYIsvGT3FPVBy4eGu5XU4G+pWeBtQ==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr4440377pjb.138.1564603172224;
        Wed, 31 Jul 2019 12:59:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15sm99294412pfn.150.2019.07.31.12.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 12:59:31 -0700 (PDT)
Date:   Wed, 31 Jul 2019 12:59:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joonwon Kang <kjw1627@gmail.com>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        jinb.park7@gmail.com
Subject: Re: [PATCH 2/2] randstruct: remove dead code in is_pure_ops_struct()
Message-ID: <201907311259.D485EED2B7@keescook>
References: <cover.1564595346.git.kjw1627@gmail.com>
 <281a65cc361512e3dc6c5deffa324f800eb907be.1564595346.git.kjw1627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281a65cc361512e3dc6c5deffa324f800eb907be.1564595346.git.kjw1627@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:01:49AM +0900, Joonwon Kang wrote:
> Recursive declaration for struct which has member of the same struct
> type, for example,
> 
> struct foo {
>     struct foo f;
>     ...
> };
> 
> is not allowed. So, it is unnecessary to check if a struct has this
> kind of member.

Is that the only case where this loop could happen? Seems also safe to
just leave it as-is...

-Kees

> 
> Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index bd29e4e7a524..e14efe23e645 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -440,9 +440,6 @@ static int is_pure_ops_struct(const_tree node)
>  		const_tree fieldtype = get_field_type(field);
>  		enum tree_code code = TREE_CODE(fieldtype);
>  
> -		if (node == fieldtype)
> -			continue;
> -
>  		if (code == RECORD_TYPE || code == UNION_TYPE) {
>  			if (!is_pure_ops_struct(fieldtype))
>  				return 0;
> -- 
> 2.17.1
> 

-- 
Kees Cook
