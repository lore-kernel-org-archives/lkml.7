Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F70224135
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrzLaKA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfE2UMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:12:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41359 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2UMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:12:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so2338191pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0aft1pCaWtRYtnkCVrHz1gsURga5CiN4SjNK2Yoiqfs=;
        b=XrzLaKA5MBHx0xlQKOcw3TIc85QvkhgJkO2JlDacDh+XCgUjABQyymyiZ/G560P5jJ
         HkAij558NkgyQQddecvDdQLSq5ZIicJMj+V7FdjS/5Qp/CTG9jIYFMaRFN3A7NFwUjgi
         FNTYdjrs48vkuDxAgacSirUU/cz2L2J9fobnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aft1pCaWtRYtnkCVrHz1gsURga5CiN4SjNK2Yoiqfs=;
        b=gX6fb4grNopRzpAxZbk2Qk/qEPbnTHYdH3dt+woH2oPE/zzsQOy54JVLSu81+U2+Tw
         0EawgyRyGwz7Cz9yZGZnSmqZwSsxjSBDUyeCFnfCcQE9QEDCLaVXPvJo8zGHBI431/h2
         NSVZI6J8YK2xRPupLDuHeFf20GoOd1CCq/nSGbuTeeQSOZ/W2ougyfH0aM7NcK4bp9pE
         ntbQTsekWoF/cXEY/w1oS3bhCc9v04lg6EEd3Q6pd9Rl6vGczQOgQJHTsK2TsgpqnNtC
         70UJ2K8iwSdj8Od551E49yaUEHKbSb/ThkXtMm9bLiu+Lw2sX8wTVx5evEH2xJQ412AX
         Zfng==
X-Gm-Message-State: APjAAAX3jZsLLVavsx6HBD90GWe63/ENOlI+QH1ZukrE9ASkeX5nvV8F
        PfbZ09jlB0W91VHtH1CunYnMdA==
X-Google-Smtp-Source: APXvYqwc7/sGYBIou0XJOLY+/Ol3XK8SIbVohsGySQ6NBMh2dCNE0NA9cvRsEXWPqWrlHnSoWF5LlQ==
X-Received: by 2002:aa7:8d81:: with SMTP id i1mr126561827pfr.244.1559160746780;
        Wed, 29 May 2019 13:12:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm220941pgj.34.2019.05.29.13.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:12:25 -0700 (PDT)
Date:   Wed, 29 May 2019 13:12:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 12/14] mips: Replace arch specific way to determine
 32bit task with generic version
Message-ID: <201905291312.7B8EBE955@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-13-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-13-alex@ghiti.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:44AM -0400, Alexandre Ghiti wrote:
> Mips uses TASK_IS_32BIT_ADDR to determine if a task is 32bit, but
> this define is mips specific and other arches do not have it: instead,
> use !IS_ENABLED(CONFIG_64BIT) || is_compat_task() condition.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/mm/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index c052565b76fb..900670ea8531 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sizes.h>
> +#include <linux/compat.h>
>  
>  unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>  EXPORT_SYMBOL(shm_align_mask);
> @@ -191,7 +192,7 @@ static inline unsigned long brk_rnd(void)
>  
>  	rnd = rnd << PAGE_SHIFT;
>  	/* 32MB for 32bit, 1GB for 64bit */
> -	if (TASK_IS_32BIT_ADDR)
> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
>  		rnd = rnd & SZ_32M;
>  	else
>  		rnd = rnd & SZ_1G;
> -- 
> 2.20.1
> 

-- 
Kees Cook
