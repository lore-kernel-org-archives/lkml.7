Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8129257BD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KW9gnXpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE3LGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:06:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfE3LGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XWSZAD9Y6uBVo7L5n2t8Ehyy7C5gbqMnRx8yZh9FlDg=; b=KW9gnXpShROlZkddwXNzmFYlO
        fmIqAbGM2SAjmXl9zY3TDwFtQnfiDLggLdshi5XIGPQxS3N2b9fI8eNDGA5CdBld4QgdGWer5Q9Ir
        58plIdYsqK7CE2ULlzaf6e3ndrG50anFfSpiL1RUGymu0dFCqQYpDTA9rKtBgtDQFojobJPChdzfh
        MzHtjhsFqDNt+GjziZ1c5QrQMMbip4vZ+Zfak6M+Hs4u1QJVcpRPLOPMswU88cCWHQw/XIU3x1t9u
        QHvDrd9yzlNEjQ5Cs6u2sQB4QLtEFYrUHNmUW7XL7WXMfwfRqZkB5YqUhHS/1U//ulgnX74EIJ6o3
        ZQ2g4WdDw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWItL-0006m3-ND; Thu, 30 May 2019 11:06:39 +0000
Date:   Thu, 30 May 2019 04:06:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
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
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] mm: Generalize notify_page_fault()
Message-ID: <20190530110639.GC23461@bombadil.infradead.org>
References: <1559195713-6956-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559195713-6956-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:25:13AM +0530, Anshuman Khandual wrote:
> Similar notify_page_fault() definitions are being used by architectures
> duplicating much of the same code. This attempts to unify them into a
> single implementation, generalize it and then move it to a common place.
> kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
> must not be wrapped again within CONFIG_KPROBES. Trap number argument can

This is a funny quirk of the English language.  "must not" means "is not
allowed to be", not "does not have to be".

> @@ -141,6 +142,19 @@ static int __init init_zero_pfn(void)
>  core_initcall(init_zero_pfn);
>  
>  
> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
> +{
> +	int ret = 0;
> +
> +	if (kprobes_built_in() && !user_mode(regs)) {
> +		preempt_disable();
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret = 1;
> +		preempt_enable();
> +	}
> +	return ret;
> +}
> +
>  #if defined(SPLIT_RSS_COUNTING)

Comparing this to the canonical implementation (ie x86), it looks similar.

static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
{
        if (!kprobes_built_in())
                return 0;
        if (user_mode(regs))
                return 0;
        /*
         * To be potentially processing a kprobe fault and to be allowed to call
         * kprobe_running(), we have to be non-preemptible.
         */
        if (preemptible())
                return 0;
        if (!kprobe_running())
                return 0;
        return kprobe_fault_handler(regs, X86_TRAP_PF);
}

The two handle preemption differently.  Why is x86 wrong and this one
correct?
