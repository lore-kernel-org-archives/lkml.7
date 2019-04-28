Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731472075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sXz89DjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfD2E3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 00:29:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43482 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD2E3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:29:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id w196so3245581ywd.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 21:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=65wEfYgxWk51SngzsWDGGLkeNi4aWWYP9+RVNbeVfio=;
        b=sXz89DjZyDhE7dpaYT8JxNeAH5uG99lZt0sZ/sJpDXkg0fUZUUB/AHEzHxuwRLTHet
         nV/x/MlEJ7VMk/avI5WCIVBqIq+G6FPTrgMvgnIG/Vc8Vo7oSbIB94OvMQvtW2aKQYA+
         vXyEi/jovC3n6ZkYqBxDggU/OgA2KXdeSRYL25CX2/fkjrUj6OEweFCfVSneo3DHKCK3
         swURCCq+ZS0NSHQpjxo4X6a51QGF96RYnwy9V5hLpCMCRq3w5OgMTC0C1VCHrBM2NYdO
         yHirmlFK4vy2EmZFZ6bn2Cy7BxGC0ePTo3yadbCv1fxlCutQHUiX7+gJP27Dp6GAayOL
         faFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=65wEfYgxWk51SngzsWDGGLkeNi4aWWYP9+RVNbeVfio=;
        b=rL5i+cra6KRamQrnb2YR3vprIcXYXrS6WX32RvZcCnO1QfVHHVZY3KuwBdGK3jIiQU
         G5Pqp2D5sOI9NeNbGObfqut8OL9Uv1bxuz//O8hsMga1gvdY4qC5eFKJ/mOiBMTxSWCz
         bGShJ0UjlIgjYC4vVYl6u8G0gOHyITnABq3yW/KOLoizI6SZJ7leLbgSKxkPCgeasCfQ
         ejOY5kN5pDs4PTPpXol1AsVfTseN+CEJH0bWnv+mB9WMMos+SBMrZAodvveveaOeNV7h
         +4Pqhrc/gQrBVcJj9uTuceMtboWZSOB7foXA7qczK/rD8+Nq68DWdg/pENhNoh/JhDvG
         LV4g==
X-Gm-Message-State: APjAAAUhUhMN7CjeE+G7pXuf2u94NF3W49Ear6YGRVDXH8d+s4OR8s0l
        A4QdpQqfTzZW6rpEoZYEK+f8Sg==
X-Google-Smtp-Source: APXvYqwailRrO/Y8SgtDcG0XT1V+s+aZGQSVtaE1FynPC7PnKdorrn/A6pWmnDHW/MPjDhjfovR8tg==
X-Received: by 2002:a81:a103:: with SMTP id y3mr37542865ywg.136.1556512177964;
        Sun, 28 Apr 2019 21:29:37 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id o11sm4779429ywj.15.2019.04.28.21.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 21:29:36 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 06DCB30008A; Sun, 28 Apr 2019 21:54:09 +0300 (+03)
Date:   Sun, 28 Apr 2019 21:54:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190428185408.macoxstmy5awsago@kshutemo-mobl1>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
 <20190422091045.GB3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422091045.GB3584@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 05:10:45PM +0800, Baoquan He wrote:
> kernel_randomize_memory() hardcodes the size of vmemmap section as 1 TB,
> to support the maximum amount of system RAM in 4-level paging mode, 64 TB.
> 
> However, 1 TB is not enough for vmemmap in 5-level paging mode. Assuming
> the size of struct page is 64 Bytes, to support 4 PB system RAM in 5-level,
> 64 TB of vmemmap area is needed. The wrong hardcoding may cause vmemmap
> stamping into the following cpu_entry_area section, if KASLR puts vmemmap
> very close to cpu_entry_area , and the actual area of vmemmap is much bigger
> than 1 TB.
> 
> So here calculate the actual size of vmemmap region, then align up to 1 TB
> boundary. In 4-level it's always 1 TB. In 5-level it's adjusted on demand.
> The current code reserves 0.5 PB for vmemmap in 5-level. In this new method,
> the left space can be saved to join randomization to increase the entropy.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
>   Fix typo Boris pointed out. 
> 
>  arch/x86/mm/kaslr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 387d4ed25d7c..4679a0075048 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -52,7 +52,7 @@ static __initdata struct kaslr_memory_region {
>  } kaslr_regions[] = {
>  	{ &page_offset_base, 0 },
>  	{ &vmalloc_base, 0 },
> -	{ &vmemmap_base, 1 },
> +	{ &vmemmap_base, 0 },
>  };
>  
>  /* Get size in bytes used by the memory region */
> @@ -78,6 +78,7 @@ void __init kernel_randomize_memory(void)
>  	unsigned long rand, memory_tb;
>  	struct rnd_state rand_state;
>  	unsigned long remain_entropy;
> +	unsigned long vmemmap_size;
>  
>  	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
>  	vaddr = vaddr_start;
> @@ -109,6 +110,14 @@ void __init kernel_randomize_memory(void)
>  	if (memory_tb < kaslr_regions[0].size_tb)
>  		kaslr_regions[0].size_tb = memory_tb;
>  
> +	/**

Nit: that is weird style for inline comment.

> +	 * Calculate how many TB vmemmap region needs, and aligned to
> +	 * 1TB boundary.
> +	 */
> +	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> +		sizeof(struct page);

Hm. Don't we need to take into account alignment requirements for struct
page here? I'm worried about some exotic debug kernel config where
sizeof(struct page) doesn't satify __alignof__(struct page).

> +	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
> +
>  	/* Calculate entropy available between regions */
>  	remain_entropy = vaddr_end - vaddr_start;
>  	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-- 
 Kirill A. Shutemov
