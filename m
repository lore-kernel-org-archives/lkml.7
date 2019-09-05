Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA4C206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QHaHB6B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390861AbfIEVcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:32:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42454 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIEVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:32:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id y1so1965511plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vRNjRaBgrEcA28yXy/tuVe9MnUsBGmzJhFU9ikOV9eo=;
        b=QHaHB6B5FI34tmx3VkIMzJOdIR92RMaEcEYnY1/89i418asdjF0GvCGLGjbSnEMrv2
         MnRukTsDK326An1WWCgOBFmCXwUETgmMvIsusWo6PVDw2TrsnVwRciOlGkpgjc7pS615
         dyexflUmvitNX/r+1n/a9gO6PNbZg2+H7v1bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRNjRaBgrEcA28yXy/tuVe9MnUsBGmzJhFU9ikOV9eo=;
        b=uPL40PltcGuwHrmr+VNlxqbBBTxFBdroA260AImvdzFhETChWMe6GO0SvVvqXjNei/
         g8YKePBWW74u4RRHkU43gUL0ZBm8eQTjjVJbwnMCs+6bCHI9OdGH1E7QOZhlJo2lbs1N
         imgXnh9AzEN8Ll+oslq/DqHplX/tj2mf3xILH3GsPSdbvA9YjVFiIjWxAm4NbX6OhDTh
         3bUfbvTdEW7wRD2HLoEM5BTHnw4QzCnCxY3OQ4XAMT2LTk4lAiqy7yXvme9DLkH2EOLs
         HNGpk8mwuiQ7kWp0ibDtHzwCkkMAPWTuSkAOZG/J2ZPUMnz0C1dTWesa6Uz99mwH86J2
         VjNw==
X-Gm-Message-State: APjAAAU1QVMObVp7F6Y0oLlvQsaeN+2CmzBW8IR0UX2WMNnzVZz8TBL6
        BVlNFFBAxfA4zDWwP6/RJBrVmR8J1BQ=
X-Google-Smtp-Source: APXvYqzJtOjlOZplqY+0sDOlzqLnIPjkscus3hVmi+qHYCLN8howJE2ki3XUK0Cje3zpmJ6EoRnKOA==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr5966320plo.278.1567719171736;
        Thu, 05 Sep 2019 14:32:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r18sm2923395pfc.3.2019.09.05.14.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 14:32:50 -0700 (PDT)
Date:   Thu, 5 Sep 2019 14:32:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] Remove unused string_escape_*_any_np
Message-ID: <201909051431.65AE98363@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-4-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-4-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:28PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> These aren't called anywhere.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  include/linux/string_helpers.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index c28955132234..8a299a29b767 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -56,25 +56,12 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  
>  int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
>  					size_t osz);
> -
> -static inline int string_escape_mem_any_np(const char *src, size_t isz,
> -		char *dst, size_t osz, const char *only)
> -{
> -	return string_escape_mem(src, isz, dst, osz, ESCAPE_ANY_NP, only);
> -}
> -
>  static inline int string_escape_str(const char *src, char *dst, size_t sz,
>  		unsigned int flags, const char *only)
>  {
>  	return string_escape_mem(src, strlen(src), dst, sz, flags, only);
>  }
>  
> -static inline int string_escape_str_any_np(const char *src, char *dst,
> -		size_t sz, const char *only)
> -{
> -	return string_escape_str(src, dst, sz, ESCAPE_ANY_NP, only);
> -}
> -
>  char *kstrdup_quotable(const char *src, gfp_t gfp);
>  char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
>  char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
> -- 
> 2.21.0
> 

-- 
Kees Cook
