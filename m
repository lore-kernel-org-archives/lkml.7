Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BEC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032C421738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XycpPK1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfF0Pxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:53:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37047 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0Px3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:53:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id 25so1215121pgy.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IB0Lsqqxe3Za1ul6K6Pq1h1ixj5UtpjRHMz7zj1j1YM=;
        b=XycpPK1CI5JMKTpIwljMWofpXCFUnjuMSbTxvj3tSwU+N6pesTsiguF6tXP2YOv/RK
         0SV0Pc++fA7yQT4iMOsmk5EaUwppi2O0YX2prmAFBNEKsX2gYDmiJ5Ry7PHA3n5rVq31
         kbGxWSIcc0U2t95vEEjJWLkRnyUBsNj/UQg2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IB0Lsqqxe3Za1ul6K6Pq1h1ixj5UtpjRHMz7zj1j1YM=;
        b=hZJvvEqlWbwt69UpFmwHb1lVWK7Y8telKfn2Zv60X9VPsYsQLJscfPduIlFmLXTuFU
         bjs4YUvoIkv3yULFOLqyvdw8JJstkWxV9bmNWV2Wa5/XB0/5Tkptti6RJXjRHAf+mln8
         yvlwzE62Yf4nD5yFJjvQ8W3LPu7ndNK9C7EI59Dsm3KV41hjIhBbS1XkPk5+UypXmhOM
         o5aTjT7U/18tcDjoyPiZb0fCde/88m5fFcPC3rRPw/qu3fq/GE5P01RO8qGprTs4IwtO
         n14tSWdD8iqfufcRz0XZfmkwDntDzELNJpFpK5mnBnY2vmFcfDMEGA8Hql56Nwtf4eKH
         uhYQ==
X-Gm-Message-State: APjAAAXMjX7dKAwhordMpojYC16DMGWZ1dVVWdlPUyiS5uyRdBpgJkPC
        Gfj6yfP0lfEMCgk8hmLjREh3LQ==
X-Google-Smtp-Source: APXvYqzyQ8VhCfbGmiP5t6hfyuPjbzTLkDZwV/chxJREBt2vwgawqo7kscJ4w+dvLcJmYjU/wFp1aw==
X-Received: by 2002:a17:90a:ad41:: with SMTP id w1mr6845225pjv.52.1561650808121;
        Thu, 27 Jun 2019 08:53:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8sm8013075pff.20.2019.06.27.08.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 08:53:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 08:53:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm/gup: Remove some BUG_ONs from get_gate_page()
Message-ID: <201906270853.CB6DA7BC8@keescook>
References: <a1d9f4efb75b9d464e59fd6af00104b21c58f6f7.1561610798.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1d9f4efb75b9d464e59fd6af00104b21c58f6f7.1561610798.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:47:30PM -0700, Andy Lutomirski wrote:
> If we end up without a PGD or PUD entry backing the gate area, don't
> BUG -- just fail gracefully.
> 
> It's not entirely implausible that this could happen some day on
> x86.  It doesn't right now even with an execute-only emulated
> vsyscall page because the fixmap shares the PUD, but the core mm
> code shouldn't rely on that particular detail to avoid OOPSing.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/gup.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..9883b598fd6f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -585,11 +585,14 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>  		pgd = pgd_offset_k(address);
>  	else
>  		pgd = pgd_offset_gate(mm, address);
> -	BUG_ON(pgd_none(*pgd));
> +	if (pgd_none(*pgd))
> +		return -EFAULT;
>  	p4d = p4d_offset(pgd, address);
> -	BUG_ON(p4d_none(*p4d));
> +	if (p4d_none(*p4d))
> +		return -EFAULT;
>  	pud = pud_offset(p4d, address);
> -	BUG_ON(pud_none(*pud));
> +	if (pud_none(*pud))
> +		return -EFAULT;
>  	pmd = pmd_offset(pud, address);
>  	if (!pmd_present(*pmd))
>  		return -EFAULT;
> -- 
> 2.21.0
> 

-- 
Kees Cook
