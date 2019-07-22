Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC776C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8073F21903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZowcOjJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfGVRdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:33:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43712 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGVRdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:33:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so12498909pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ax8I1mb7UwIFxfCmMJfuzkJQZA4WbZ7Ek1Ds9PvMQYU=;
        b=ZowcOjJMdxosv2QSzqf2eI08qVemvBx1XFUBmEfS4sU/PraJBWF671A5zObKnz4TfD
         zk/CQmr2CoQ/bq7hFwV/jk7C4Zl+sLHE/NGWoR8qwxKIwHpxQQ4RjoUJThjmRHvGEZgo
         CUZMefdwNypT9GNU3PI/XXImbp4GU9RlYE3TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ax8I1mb7UwIFxfCmMJfuzkJQZA4WbZ7Ek1Ds9PvMQYU=;
        b=KVo+nXE+hp5FPOScIxMKTnRSVG73khxbi/wVvjfMEBRR9D4Lr+Mpv9PfKHRlUNKZ2I
         zxQ48c0hjrislQJ8ae153p92TUj3BTUSyYtJhmKB/Ar8PC/vH2zXUj4Vpc/lDfTBecPw
         T0Ljz75HDmV8f6st7NAXUQdvvo5Kq9HPPoBnjZ7Oo6bWZK3fDgeg66xzOLshG/C73BSU
         +e2Zq/fHHW+vumHA3eYElKKoe60VZh2IoRiDFQ39DUh3Kt6vUyljRkOvdfM8PbJ0e/yb
         2zz8ldQt5c8ATV+jiTF/1t3sfPbQv220htnxXZUuCWNDrPC96g7xWSAy7zMeXfN+iIbP
         LXLw==
X-Gm-Message-State: APjAAAVJBR/EZ8lrFhP+T8JMS+5SzuVQegD6nP11YnQ8+TD3tZOiNPII
        FSqjlvW0bFTyel4xaQ1s458Z2g==
X-Google-Smtp-Source: APXvYqyX5Rkq79yH7MiGBYeJZggeb9zVsBWnRCFtyBj046jkmfMHzDiZGrpNESNeWOyNSE0LXKj3OA==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr48081374plt.10.1563816821309;
        Mon, 22 Jul 2019 10:33:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n98sm41097264pjc.26.2019.07.22.10.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:33:40 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:33:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nitin Gote <nitin.r.gote@intel.com>, akpm@linux-foundation.org,
        corbet@lwn.net, apw@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [RFC PATCH] string.h: Add stracpy/stracpy_pad (was: Re: [PATCH]
 checkpatch: Added warnings in favor of strscpy().)
Message-ID: <201907221031.8B87A9DE@keescook>
References: <1562219683-15474-1-git-send-email-nitin.r.gote@intel.com>
 <f6a4c2b601bb59179cb2e3b8f4d836a1c11379a3.camel@perches.com>
 <d1524130f91d7cfd61bc736623409693d2895f57.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1524130f91d7cfd61bc736623409693d2895f57.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 05:15:57PM -0700, Joe Perches wrote:
> On Thu, 2019-07-04 at 13:46 -0700, Joe Perches wrote:
> > On Thu, 2019-07-04 at 11:24 +0530, Nitin Gote wrote:
> > > Added warnings in checkpatch.pl script to :
> > > 
> > > 1. Deprecate strcpy() in favor of strscpy().
> > > 2. Deprecate strlcpy() in favor of strscpy().
> > > 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> > > 
> > > Updated strncpy() section in Documentation/process/deprecated.rst
> > > to cover strscpy_pad() case.
> 
> []
> 
> I sent a patch series for some strscpy/strlcpy misuses.
> 
> How about adding a macro helper to avoid the misuses like:
> ---
>  include/linux/string.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4deb11f7976b..ef01bd6f19df 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -35,6 +35,22 @@ ssize_t strscpy(char *, const char *, size_t);
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
>  
> +#define stracpy(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\
> +	strscpy(to, from, size);				\
> +})
> +
> +#define stracpy_pad(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\
> +	strscpy_pad(to, from, size);				\
> +})
> +
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
>  #endif

This seems like a reasonable addition, yes. I think Coccinelle might
actually be able to find all the existing strscpy(dst, src, sizeof(dst))
cases to jump-start this conversion.

Devil's advocate: this adds yet more string handling functions... will
this cause even more confusion?

-- 
Kees Cook
