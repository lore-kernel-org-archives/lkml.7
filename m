Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811A4208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2TKDuN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfJaSvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:51:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJaSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:51:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id f19so4601953pgn.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XLz57lIGfqKC3M6vFm45BqnBpRbJgKKmWPNYd03gHyA=;
        b=U2TKDuN0RJmVAnuvG7Px5NI6yW31xNfitR+DvSRcuEo5LiNb1Uc0TjnEQoBYpL89In
         PMO11+PznOEDVzggBnrEOQBNo+Of9EO+hD1mPT70iqm/4Jos47wL6/oQvFtLUA3rGY0v
         ZkbaqfaS9F6hE8KYe0TrXClhTCqM2mdOESFW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLz57lIGfqKC3M6vFm45BqnBpRbJgKKmWPNYd03gHyA=;
        b=KO7Q6XELE/wtvLpe4xyg2pHgFkBFoNFLOtwA+/iyiBl+E1rqRq5aJQilC9erWoXN9d
         XVv88uo0T9UBUUXwEF30O1tQA2cA4smkKYat1u9T7JT3mLIMPP4meUt6QyzrAbdfaAA/
         j9BOhYB7xLXg65XgBmBDQ+iLTGckc3mhMWnbr0ScLFh8jx48YarsQTnfxf79XNyXkPem
         jkQQUaTVyTfejWlWt9De4m6xUzOX5TP09tqplwnyUJwXijHDwEMDvUtMzPQyVurUJ1Yc
         Um6acgwXdfpIQiPMbHNkaNw68KI1ccz3K8xFNiZT+OkUrYgU56CcBRugr0Sc76LKgVWG
         Vg+g==
X-Gm-Message-State: APjAAAVwjsuv2FHLTPW+G/lB31owKOFlvmDUVZ7f4cxIYpQzcT/RXBem
        +jVjn6yNpk3bfieDkwtNcnOvzg==
X-Google-Smtp-Source: APXvYqy6Rf9fLSwdIeGxw8kzB8nNEzmnFTm4ZIojbb8zLzUa2oSwwGyY1z7HPIyiiZQuSZXZ/iUObg==
X-Received: by 2002:a17:90a:b942:: with SMTP id f2mr9189734pjw.83.1572547860187;
        Thu, 31 Oct 2019 11:51:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm5009461pja.30.2019.10.31.11.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:50:59 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:50:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <201910311147.FA6A822@keescook>
References: <20191024224631.118656-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024224631.118656-1-davidgow@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 03:46:31PM -0700, David Gow wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ef985e01457..f3d0c6e42b97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9504,6 +9504,13 @@ F:	Documentation/misc-devices/lis3lv02d.rst
>  F:	drivers/misc/lis3lv02d/
>  F:	drivers/platform/x86/hp_accel.c
>  
> +LIST KUNIT TEST
> +M:	David Gow <davidgow@google.com>
> +L:	linux-kselftest@vger.kernel.org
> +L:	kunit-dev@googlegroups.com
> +S:	Maintained
> +F:	lib/list-test.c

Should KUnit be the first name here? Then all KUnit tests appear in the
same location in the MAINTAINERS file, or should it be like it is here,
so that KUnit tests are close to the same-named area?

> +
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..6c1be6181e38 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,24 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_KUNIT_TEST

Similarly for the Kconfig name. (Also aren't KUNIT and TEST redundant?)

config KUNIT_LIST

?

config LIST_KUNIT

> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
> +
> +# KUnit tests
> +obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o

And again, list-kunit.o? Other things have -test (or more commonly
_test) suffixes. (So maybe list_kunit.o?)

But as I said last time, I'll live with whatever, I'd just like a
documented best-practice with a reasonable rationale. :)

-- 
Kees Cook
