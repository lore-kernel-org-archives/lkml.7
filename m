Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D38C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D6120890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Mr43gy1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfIPJUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:20:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41240 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIPJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:20:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id z9so32396956edq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=glvpReCPDRVkLn9zpzSNpP3OHMiPsWWEoMy1D4x4tMc=;
        b=Mr43gy1Bhlqi2cMq6MxNQWr+R1+dwgniNtjTsTR3urFn73yrPBcFmMn/zGJpGK24Pe
         p30BdzlkqB9M2aoCiz1gYKqSC69suQlL7uL9rzuPNChreBcqfIUyjuj4Blk9+QTH/9A6
         mHpIPD5mT4F5LiHCzuWmPYl5KMGbDjJBRoGjV8GSlALoX6FuuvktcKLloUWLNqYBxdu4
         wT+yqPD7W5P+YYvxl1WtNyYLsM3MUWNW9Lbe8+IOU+rr/29urfgyHMtdXzAzeFirvy/b
         S3qfKABiHm8SwI8pxkapXnQHXDMeycFCcaJ+uldYGUEW/zjrZ52cqCTk2eXpBck7ip5q
         pUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=glvpReCPDRVkLn9zpzSNpP3OHMiPsWWEoMy1D4x4tMc=;
        b=cXDXrsz1k5KjYUAdmbZcJKWl1xQdNozWQo8otaPHqWnuGa4N0lcjrM4kJ29H77KA1v
         uqkXleeBtduwSsaAgm2B/SIeG9VfwGoD3U9BLJkv82nkrI7IPSUHZqX24k2ebw+YKAsC
         mrWTrwmDD0z+Ox6KHJd2JGFBcwuDZTc2S10GbsDO6uq8pM65zKvime6MiYYPzn87iFvd
         Me+mDjjyVH/N7/w42PJmRua/+YP8iIWvxmBdo/Na/1ZPg7FER2fax8rcZ6macv2q7SX3
         dTbLiT7nY0d5hH8YnlHF41QEF1pYIfdDAsewyfltmHeMjeCrLz0UKLpbjVkHfKaT0sTD
         p6ww==
X-Gm-Message-State: APjAAAWiNIRfb4Xpt4TKB8PT7f3izfbp5dlxcIdiVzS4UTMYZp4dgAkc
        qWEA93NRYXOsfJzDBj0kdalhEg==
X-Google-Smtp-Source: APXvYqybun8WIw9RjZFQef3sSQgZDs9Qwwkd2MmheAEv+efu9QyQb9R9OfX14SfjkoUG8ior6HHHgg==
X-Received: by 2002:a50:a7c4:: with SMTP id i62mr15999938edc.92.1568625636812;
        Mon, 16 Sep 2019 02:20:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a3sm4194276eje.90.2019.09.16.02.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 02:20:35 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7FD80104174; Mon, 16 Sep 2019 12:20:37 +0300 (+03)
Date:   Mon, 16 Sep 2019 12:20:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com
Subject: Re: [PATCH v3 1/2] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Message-ID: <20190916092037.yqdp2vyhl4byhbh5@box.shutemov.name>
References: <20190913163239.125108-1-justin.he@arm.com>
 <20190913163239.125108-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913163239.125108-2-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:32:38AM +0800, Jia He wrote:
> On arm64 without hardware Access Flag, copying fromuser will fail because
> the pte is old and cannot be marked young. So we always end up with zeroed
> page after fork() + CoW for pfn mappings. we don't always have a
> hardware-managed access flag on arm64.
> 
> Hence implement arch_faults_on_old_pte on arm64 to indicate that it might
> cause page fault when accessing old pte.
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index e09760ece844..b41399d758df 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -868,6 +868,18 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  #define phys_to_ttbr(addr)	(addr)
>  #endif
>  
> +/*
> + * On arm64 without hardware Access Flag, copying fromuser will fail because
> + * the pte is old and cannot be marked young. So we always end up with zeroed
> + * page after fork() + CoW for pfn mappings. we don't always have a
> + * hardware-managed access flag on arm64.
> + */
> +static inline bool arch_faults_on_old_pte(void)
> +{
> +	return true;

Shouldn't youc check if this particular machine supports hardware access
bit?

> +}
> +#define arch_faults_on_old_pte arch_faults_on_old_pte
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* __ASM_PGTABLE_H */
> -- 
> 2.17.1
> 
> 

-- 
 Kirill A. Shutemov
