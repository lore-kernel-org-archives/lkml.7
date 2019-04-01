Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128E820828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FB7XB8Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfDAIG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:06:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAIG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xV/POvLaCwlAA2oqe8OCwNDS5H8Wst/4nELrZ/d7mVk=; b=FB7XB8PwzYlA/qfUYpONin1O4
        YwDPLGn/soKvFnrahb/1JxjnVt5tYhN2CmTogWfwZmS88+iRpmXIUQoVyNUK5PoIhJOEAlcQDv0H6
        /38MTCfkqQtV2d3QylC47TcWR3MeZPCtXVAZh2e/L0hf17wWUwavPJp2R6hn2bMguU2MNfkP8NUKk
        ilZd/3pq/inZT/lN6tgM/sVHa0zMdJ2dGFosZ4/isaWiPjKFdz/LLeIgAQCcKy40TnjNwiBuZHbTK
        NfyQFRCuy6jQdpbxxOZ3TZJ4EpLO5sn71mauLZgpRhLG+R+AVtwx3tiQWYVX8p88+XXKC8+vcqm0A
        daE91YTPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hArxZ-0008TZ-3M; Mon, 01 Apr 2019 08:06:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9539B20298592; Mon,  1 Apr 2019 10:06:23 +0200 (CEST)
Date:   Mon, 1 Apr 2019 10:06:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/asm: Clarify static_cpu_has()'s intended use
Message-ID: <20190401080623.GC11158@hirez.programming.kicks-ass.net>
References: <20190330112022.28888-1-bp@alien8.de>
 <20190330112022.28888-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330112022.28888-2-bp@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:20:18PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Clarify when one should use static_cpu_has() and when one should use
> boot_cpu_has().
> 
> Requested-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: x86@kernel.org
> ---
>  arch/x86/include/asm/cpufeature.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index 30cf12c81db3..1d337c51f7e6 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -156,9 +156,12 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
>  #else
>  
>  /*
> - * Static testing of CPU features.  Used the same as boot_cpu_has().
> - * These will statically patch the target code for additional
> - * performance.
> + * Static testing of CPU features. Used the same as boot_cpu_has(). It
> + * statically patches the target code for additional performance. Use
> + * static_cpu_has() only in fast paths, where every cycle counts. Which
> + * means that the boot_cpu_has() variant is already fast enough for the
> + * majority of cases and you should stick to using it as it is generally
> + * only two instructions: a RIP-relative MOV and a TEST.
>   */
>  static __always_inline bool _static_cpu_has(u16 bit)
>  {

Should we introduce cpu_has() ?

I'm sure it boot_cpu_has() is an awesome name, but in like 99.9% of the
cases we don't give a crap about which actual CPU has the feature set. We
also don't actually support asymmetric cpu features anyway.
