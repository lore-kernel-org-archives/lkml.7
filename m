Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0517C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B220F2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9GjnNkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408032AbfIWX17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:27:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46251 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405653AbfIWX17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:27:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so8082plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ek1rHKvIxnb2UIDgsu3sEH7JsFpsFFhSgevAuIe10VY=;
        b=S9GjnNkC5rUxpuhN3F2gSy/QhL5hSGawf2mdlJOwjcUcUQWEhkhY4W5ciQCwO+E1mV
         H90/QyuefsOIVQ7nKIw8M+DDQqfluagS2MGNr7Bsu2I15DNIFnhgfdPBhxF91o7eDTek
         YCPGhNl6EVJ5QOokBoo8dsy4QZmXcus4hj9JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ek1rHKvIxnb2UIDgsu3sEH7JsFpsFFhSgevAuIe10VY=;
        b=kaEWOhqpoga4kRe5oQeltfhNRCxo3k8Ueir8W8QODH13TZRmXtJXXeyKculnuAhB4E
         AhPHlius6HASP85YJjAV5aCzKLxHyvCRBB9FIJA7zJQOvX4DtXbZj64bbzwjBDk8ZxVd
         rXx/RAt2jemfu9afFMYsiAcpVKuXhAb9Bu35U0LpFPrBRqveWbalRS4qMsB0t/MlfBcD
         eUGuhhwIA/oEkvuf0mljj8IIiJ1Z7K9MoL+sY86M0LcyhgbOTn9BZgQaBEnW3BIVZLSY
         d2jhOwLa+JwSzyQy+0heWh1NUZ7/Jmv1ZpM3d61F2Hn/4fTwMMck8g4RGD98gvc36vQJ
         iUEw==
X-Gm-Message-State: APjAAAW+ZLu2F9c2AUGWonRwltlU5HteBK1WT7GWHWHEo90Xhdfg6m6B
        n+gVhFjQKNtt9I+1pHafUIEETQ==
X-Google-Smtp-Source: APXvYqwpTFEQ467lAX3Wdu9BYCSf5AkPzwabhVyj3VDGQXE0bAsaJwtBG60WqllW4yTXQtFEoMK6ww==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr2222127plq.76.1569281278812;
        Mon, 23 Sep 2019 16:27:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r1sm10437850pgv.70.2019.09.23.16.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 16:27:57 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:27:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: use the correct function type for native_set_fixmap
Message-ID: <201909231626.A912664DA1@keescook>
References: <20190913211402.193018-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913211402.193018-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:14:02PM -0700, Sami Tolvanen wrote:
> We call native_set_fixmap indirectly through the function pointer
> struct pv_mmu_ops::set_fixmap, which expects the first parameter to be
> 'unsigned' instead of 'enum fixed_addresses'. This patch changes the
> function type for native_set_fixmap to match the pointer, which fixes
> indirect call mismatches with Control-Flow Integrity (CFI) checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Is it correct that pv_mmu_ops can't be changed since this is an external
API?

Assuming so, then:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/fixmap.h | 2 +-
>  arch/x86/mm/pgtable.c         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index 9da8cccdf3fb..6a295acd3de6 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -157,7 +157,7 @@ extern pte_t *kmap_pte;
>  extern pte_t *pkmap_page_table;
>  
>  void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
> -void native_set_fixmap(enum fixed_addresses idx,
> +void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>  		       phys_addr_t phys, pgprot_t flags);
>  
>  #ifndef CONFIG_PARAVIRT_XXL
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 44816ff6411f..d0ad35e3de74 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -647,8 +647,8 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
>  	fixmaps_set++;
>  }
>  
> -void native_set_fixmap(enum fixed_addresses idx, phys_addr_t phys,
> -		       pgprot_t flags)
> +void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
> +		       phys_addr_t phys, pgprot_t flags)
>  {
>  	/* Sanitize 'prot' against any unsupported bits: */
>  	pgprot_val(flags) &= __default_kernel_pte_mask;
> -- 
> 2.23.0.237.gc6a4ce50a0-goog
> 

-- 
Kees Cook
