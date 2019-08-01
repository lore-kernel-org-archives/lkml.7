Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BC9206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bt6gngaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbfHAQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:00:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfHAQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V+mqoypCyVp89zi7d87lU2RRcj8SerxFad94nqYfDDE=; b=bt6gngaaXNa1IgChUaFBMxOpq
        K1NbxFgScMZWeTQ73hgbZzAx4ufmsIUGLnz6lvvQJ6x5x9kT/i9sPC5jWyLi95xJWvW/47+MXAtDF
        rIxaoHaEtcFSyXxXF43v5KfgS3OyU+4BBTPDlndKEqrlEelpyXpfgbdl/mRkRLZAk+Y2fHVQc94UV
        tkOs/n9yRp+Ps6geOWY44SabkW5UBW5WXk+7k+AnO/GP2Wm1vCshU0UK/vFtMMGX9QwUueUrIm3Zn
        t0n2fDCZJ7ATyuYUOHF42+YhnnsUNO6xeZyKRmo1uYSWE+FaIzApgbGwXzYKGGlgHQJHoe84ILoOy
        DDx8UpF5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htDUz-00024S-4b; Thu, 01 Aug 2019 16:00:13 +0000
Date:   Thu, 1 Aug 2019 09:00:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, will@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: fix variable 'tag' set but not used
Message-ID: <20190801160013.GK4700@bombadil.infradead.org>
References: <1564670825-4050-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564670825-4050-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:47:05AM -0400, Qian Cai wrote:

Given this:

> -#define __tag_set(addr, tag)	(addr)
> +static inline const void *__tag_set(const void *addr, u8 tag)
> +{
> +	return addr;
> +}
> +
>  #define __tag_reset(addr)	(addr)
>  #define __tag_get(addr)		0
>  #endif
> @@ -301,8 +305,8 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define page_to_virt(page)	({					\
>  	unsigned long __addr =						\
>  		((__page_to_voff(page)) | PAGE_OFFSET);			\
> -	unsigned long __addr_tag =					\
> -		 __tag_set(__addr, page_kasan_tag(page));		\
> +	const void *__addr_tag =					\
> +		__tag_set((void *)__addr, page_kasan_tag(page));	\
>  	((void *)__addr_tag);						\
>  })

Can't you simplify that macro to:

 #define page_to_virt(page)	({					\
 	unsigned long __addr =						\
 		((__page_to_voff(page)) | PAGE_OFFSET);			\
-	unsigned long __addr_tag =					\
-		 __tag_set(__addr, page_kasan_tag(page));		\
-	((void *)__addr_tag);						\
+	__tag_set((void *)__addr, page_kasan_tag(page));		\
 })
