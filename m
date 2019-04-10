Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDEDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F82082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDJVZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:25:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32832 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDJVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:25:15 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEKiM-0004hb-1D; Wed, 10 Apr 2019 23:25:02 +0200
Date:   Wed, 10 Apr 2019 23:25:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 12/27] x86/pkru: Provide .*_pkru_ins() functions
Message-ID: <20190410212501.jglzib2qcygjnmxc@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-13-bigeasy@linutronix.de>
 <20190410163615.GB26580@zn.tnic>
 <20190410165241.GD26580@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410165241.GD26580@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-10 18:52:41 [+0200], Borislav Petkov wrote:
> On Wed, Apr 10, 2019 at 06:36:15PM +0200, Borislav Petkov wrote:
> > Well, this is going in the wrong direction. The proper thing to do would
> > be to have:
> > 
> > rdpkru()
> > wrpkru()
> > 
> > which only do the inline asm with the respective opcodes. Just like
> > rdtsc(), clflush(), etc.
> 
> IOW, like this:
> 
> ---
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23..e2948ce1376c 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -127,14 +127,14 @@ static inline int pte_dirty(pte_t pte)
>  static inline u32 read_pkru(void)
>  {
>  	if (boot_cpu_has(X86_FEATURE_OSPKE))
> -		return __read_pkru();
> +		return rdpkru();
>  	return 0;
>  }
>  
>  static inline void write_pkru(u32 pkru)
>  {
>  	if (boot_cpu_has(X86_FEATURE_OSPKE))
> -		__write_pkru(pkru);
> +		wrpkru(pkru);

I think if this is a simple

   's@__write_pkru_ins@wrpkru@g'
   's@__read_pkru_ins@rdpkru@g'

then it should work just fine and match what Dave asked for.

>  }
>  
>  static inline int pte_young(pte_t pte)

Sebastian
