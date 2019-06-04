Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4FEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932A424DB4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HARn4yCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfFDGyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:54:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFDGyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o0/x+1oKv0SZnOXYtDRUsgML6+umJV3GQkxVLH8VplA=; b=HARn4yClLyKIcGgcTwTDD+jMd
        1ef7NULcX2Ny2MFe3bZpZHb30cLWSrPWc+xLr8ShYTmRRwEt49WdLKzvXVE7+BLps/iqR4Kkhg4+D
        Jv5IlCPj9JeZ/4Zj90FKMkkfDVWaeU3eqEvefbikGR7rzaj7QViz1N46SKGNWu7zI4W3PoR20bU0u
        bPCRXeOfyT/1kv9ZkyME/bMQcBf1vGP9Zo0EO4Dgrn0hnw+ygmh+mzIgTUlc9k3aSnSRuQDc5mgfz
        1Hk0TIi/arJ70lLgpQO+eOM7NwXLFKSxYHf4sA/TaUDXS1/nqt5n66d+x7GKHDaCKsR0BqTZraZkJ
        0Wa5VbknA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3Ke-0001TW-0y; Tue, 04 Jun 2019 06:54:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9627520761B5F; Tue,  4 Jun 2019 08:54:01 +0200 (CEST)
Date:   Tue, 4 Jun 2019 08:54:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
Message-ID: <20190604065401.GE3402@hirez.programming.kicks-ass.net>
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:04:06PM +0530, Anshuman Khandual wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index ddf20bd..b6bae8f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -52,6 +52,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/memremap.h>
>  #include <linux/ksm.h>
> +#include <linux/kprobes.h>
>  #include <linux/rmap.h>
>  #include <linux/export.h>
>  #include <linux/delayacct.h>
> @@ -141,6 +142,21 @@ static int __init init_zero_pfn(void)
>  core_initcall(init_zero_pfn);
>  
>  
> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed
> +	 * to call kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret = 1;
> +	}
> +	return ret;
> +}

That thing should be called kprobe_page_fault() or something,
notify_page_fault() is a horribly crap name for this function.
