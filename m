Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E93DC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B825898
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3wzQz5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfEaCEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:04:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32887 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:04:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so3105948pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 19:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TL52Gmz6SngGLbkmOVeJjIMB//nPEreA8+KZe6jZL2E=;
        b=m3wzQz5v9QbCfV14C68ip2i+UQ6JIrVLE0AyruLAuUG1goBSkvvyFwL+XF154+9ach
         G4OhLOuESbU3ejVGt5EJJoxx9Ojaej/rZLoFXVZwMjLEoSgsVnimom6v/ruCHKJyW8Hu
         vTiHn6WvJQPW2zALLs91xf81yx0UjHlG0u/yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TL52Gmz6SngGLbkmOVeJjIMB//nPEreA8+KZe6jZL2E=;
        b=C5XLQ9qvKYWDkNXVW3IUiLsY1b9KaFeIdj3LO1wDBecZROM7ma7bXSaBT+btSzOATt
         bIc95s4HIB6V6g4kFXR6B8cgJGuVXiisWn3XOn7BoxdoI4qkn+kxBLWCq9SKKkjWD4zV
         ybcCOMJOxOi5Vv6sbh0VVmPXvbJapwaMlkLwF0wNQ++ZkhH7AtoZzw3s0nBNp0qZZ+gt
         Uo/QnShfCWk2W/MKNBxhRl6Cuj8qubrv5zpu1tJ685WOBCV+wa5vA84iBsMiCVdYKuXc
         Y3o51IRzsGbWYghrdDJSQG02HJJiwUY40NzdEW0hHpFLsg2YcgkYszvucjdvPKYKdliC
         giAw==
X-Gm-Message-State: APjAAAW9ONpGA40tMs44ZuSPUbBpjTg9Ny/jb1pk8Z+/9XdInqNWFxhZ
        5hRecmd40r/s3ssP8AHYUy6jag==
X-Google-Smtp-Source: APXvYqx9Bj53LGeQyS7ZljShu2NWqejgsPdXSGw/3IvUj1juYLbm+ON5ujQnjt4elN7fVHreM1NhAw==
X-Received: by 2002:a17:90a:c38a:: with SMTP id h10mr6436167pjt.124.1559268276841;
        Thu, 30 May 2019 19:04:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm6485774pfj.17.2019.05.30.19.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 19:04:35 -0700 (PDT)
Date:   Thu, 30 May 2019 19:04:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] checkpatch.pl: Warn on duplicate sysctl local variable
Message-ID: <201905301904.D8D90210@keescook>
References: <20190531011227.21181-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531011227.21181-1-mcroce@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 03:12:27AM +0200, Matteo Croce wrote:
> Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> adds some shared const variables to be used instead of a local copy in
> each source file.
> Warn when a chunk duplicates one of these values in a ctl_table struct:
> 
>     $ scripts/checkpatch.pl 0001-test-commit.patch
>     WARNING: duplicated sysctl range checking value 'zero', consider using the shared one in include/linux/sysctl.h
>     #27: FILE: arch/arm/kernel/isa.c:48:
>     +               .extra1         = &zero,
> 
>     WARNING: duplicated sysctl range checking value 'int_max', consider using the shared one in include/linux/sysctl.h
>     #28: FILE: arch/arm/kernel/isa.c:49:
>     +               .extra2         = &int_max,
> 
>     total: 0 errors, 2 warnings, 14 lines checked
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 342c7c781ba5..629c31435487 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6639,6 +6639,12 @@ sub process {
>  				     "unknown module license " . $extracted_string . "\n" . $herecurr);
>  			}
>  		}
> +
> +# check for sysctl duplicate constants
> +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> +			WARN("DUPLICATED_SYSCTL_CONST",
> +				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
> +		}
>  	}
>  
>  	# If we have no input at all, then there is nothing to report on
> -- 
> 2.21.0
> 

-- 
Kees Cook
