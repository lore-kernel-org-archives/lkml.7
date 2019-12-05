Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229D2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ak2B3Pk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfLEJNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:13:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40678 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfLEJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9SKkEwleM0Kgl1HXUfSvMknCeedbxkFPyHrx58igVDY=; b=Ak2B3Pk9llVBxc4o4HhKJcqKX
        wYef7Nnmugzro6QjTQnYauxWqfalj8fK1zWN6rCNC37knhfi8WKM8NXtZZlxxPvZ6IfRSi8szXYbR
        4HzSIc8QRSCvTIKdWAuKiTymcsvBYmGTYK6UI3bAGf18JMMa5jz09xr0vo8MIV6pm9ZnT3hvtmIYA
        zBYVxVDwhzOXLkhEb2RtxUftPc8p//eS1P1MnUta0Fq10BT+tGQxcoeONr+olR1qY8AjIJ0RzHuWq
        TphJUqFBa+GY4YTJ+xo7GDpLKw9NitH9wN7Ke6karckE9LHarfTG/AscHYEBbArBZfJwDHR0thI9M
        l5Un2m2lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icnCD-00029R-9b; Thu, 05 Dec 2019 09:13:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D651C3011E0;
        Thu,  5 Dec 2019 10:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03AD120B8E996; Thu,  5 Dec 2019 10:13:11 +0100 (CET)
Date:   Thu, 5 Dec 2019 10:13:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de
Subject: Re: [Patch v2 4/6] x86/mm: Refine debug print string retrieval
 function
Message-ID: <20191205091311.GD2810@hirez.programming.kicks-ass.net>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
 <20191205021403.25606-5-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205021403.25606-5-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:14:01AM +0800, Wei Yang wrote:
> Generally, the mapping page size are:
> 
>    4K, 2M, 1G
> 
> except in case 32-bit without PAE, the mapping page size are:
> 
>    4K, 4M
> 
> Based on PG_LEVEL_X definition and mr->page_size_mask, we can calculate
> the mapping page size from a predefined string array.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  arch/x86/mm/init.c | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 0eb5edb63fa2..ded58a31c679 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -308,29 +308,20 @@ static void __ref adjust_range_page_size_mask(struct map_range *mr,
>  	}
>  }
>  
> +static void __meminit mr_print(struct map_range *mr, unsigned int maxidx)
>  {
> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
> +	static const char *sz[2] = { "4K", "4M" };
> +#else
> +	static const char *sz[4] = { "4K", "2M", "1G", "" };
> +#endif
> +	unsigned int idx, s;
>  
> +	for (idx = 0; idx < maxidx; idx++, mr++) {
> +		s = (mr->page_size_mask >> PG_LEVEL_2M) & (ARRAY_SIZE(sz) - 1);

Is it at all possible for !PAE to have 1G here, if you use the sz[4]
definition unconditionally?

> +		pr_debug(" [mem %#010lx-%#010lx] page size %s\n",
> +			 mr->start, mr->end - 1, sz[s]);
> +	}
>  }

