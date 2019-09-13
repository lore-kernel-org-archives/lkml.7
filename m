Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A5C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667D720678
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i1l+219C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfIMM33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:29:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730007AbfIMM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CrGgdhhyRrFEwIE94Hl26sryidhYhTqOfxUWATyGN4g=; b=i1l+219ClDtpFQhLcnfanUhXM
        iKmh/lBfTIxuPc4ZBCGJe4+8k+mApc+0RMJLOXJNFZur0e7PLS+NWdTBmYv7OBq6oAJ0JHqzYtF/p
        oAr8UeO+Ki3C3Ej5TONFfMyVj8oyw4cETDTtNbX505kg8tVqUIkAK07596f3s5NVaesgqQOzGgSZ6
        ZA8+G+4N8eYGYj/a9RyEkCYpIYQdaQcvNoGqTHDB+YV1v1JIMkIL1m6MvgX/k4FKkJ95CS0a+/7t6
        JGBC2axSkRjNq1uO5fQTxu+CPjE7J69w7vJ4sjxz4FpRBAFbNPwIKobiyGL1/bUwDBuIRJUHb5Pt5
        WmnhwOmEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8khO-0005PS-Cp; Fri, 13 Sep 2019 12:29:14 +0000
Date:   Fri, 13 Sep 2019 05:29:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: problem starting /sbin/init (32-bit 5.3-rc8)
Message-ID: <20190913122914.GL29434@bombadil.infradead.org>
References: <a6010953-16f3-efb9-b507-e46973fc9275@infradead.org>
 <201909121637.B9C39DF@keescook>
 <201909121753.C242E16AA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909121753.C242E16AA@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 06:46:04PM -0700, Kees Cook wrote:
> This combination appears to be bugged since the original introduction
> of hardened usercopy in v4.8. Is this an untested combination until
> now? (I don't usually do tests with CONFIG_DEBUG_VIRTUAL, but I guess
> I will from now on!)

Tricky one because it is only going to trip when someone actually does
this with a highmem page, so if you have a small machine (eg <512MB)
running a 32-bit kernel, you won't hit it.

> Is kmap somewhere "unexpected" in this case? Ah-ha, yes, it seems it is.
> There is even a helper to do the "right" thing as virt_to_page(). This
> seems to be used very rarely in the kernel... is there a page type for
> kmap pages? This seems like a hack, but it fixes it:

I think this is actually the right thing to do.  It'd be better if we had
a kmap_to_head_page(), but we don't.

> @@ -227,7 +228,7 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  	if (!virt_addr_valid(ptr))
>  		return;
>  
> -	page = virt_to_head_page(ptr);
> +	page = compound_head(kmap_to_page((void *)ptr));
>  
>  	if (PageSlab(page)) {
>  		/* Check slab allocator for flags and size. */
> 
> 
> What's the right way to "ignore" the kmap range? (i.e. it's not Slab, so
> ignore it here: I can't find a page type nor a "is this kmap?" helper...)

I don't think we want it to be _ignored_ ... if an attempted copy crosses
outside this page boundary, we want it stopped.  So I think this patch
is as good as it can be.
