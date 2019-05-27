Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B8C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E12075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r3kxN2et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfE0Ia5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:30:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Ia4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tYmgRRAZXlzmh+48MaFMBo9wJBO9K9UONq9hyYIokTA=; b=r3kxN2etHuPUPm99PDyolE5PF
        +ux6Oy+VSD5nw1VYtyKO2JeifpDyfqhrUYBJRRpri+uRhp3Y7xfW8RdqhdO8SJycTyEwbGM/eSIir
        IWHfDB0GzPnW6GN8rpLem+f/OnbozvrhOq0jaRGBW+zNdWEWyIHN+0Afdh2b4m2ByYiEJ2zdRUtIa
        rp+Sm1mm57JObKTUnTJ4TsK5zAjr/FGWA4zEZxryLl3m1VuJsOcFcBnmt1AAayzQH3Oac4EHqSONp
        0POkM4yiSeakTgF6VrvoFcDkVziPANeBoaqoIX5RaVsY2alfQSBoh52kFeYygpJwiekEE7kd9P+Xd
        VyGFfJJYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVB1x-0006ZB-RZ; Mon, 27 May 2019 08:30:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B3B320137ADA; Mon, 27 May 2019 10:30:52 +0200 (CEST)
Date:   Mon, 27 May 2019 10:30:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/6] cpumask: Purify cpumask_next()
Message-ID: <20190527083052.GR2623@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525082203.6531-3-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 01:21:59AM -0700, Nadav Amit wrote:
> cpumask_next() has no side-effects. Mark it as pure.

It would be good to have a few word on why... because apparently you
found this makes a difference.

> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 147bdec42215..20df46705f9c 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -209,7 +209,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
>  	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
>  }
>  
> -unsigned int cpumask_next(int n, const struct cpumask *srcp);
> +unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
>  
>  /**
>   * cpumask_next_zero - get the next unset cpu in a cpumask
> -- 
> 2.20.1
> 
