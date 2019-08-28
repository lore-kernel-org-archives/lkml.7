Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7022B22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfH1PUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:20:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfH1PUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:20:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E780AAE00;
        Wed, 28 Aug 2019 15:20:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9257DA809; Wed, 28 Aug 2019 17:20:42 +0200 (CEST)
Date:   Wed, 28 Aug 2019 17:20:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190828152040.GC2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20190825182922.GC20639@zn.tnic>
 <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
 <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic>
 <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
 <20190825201723.GG20639@zn.tnic>
 <20190826125342.GC28610@zn.tnic>
 <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com>
 <20190827173955.GI29752@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827173955.GI29752@zn.tnic>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:39:55PM +0200, Borislav Petkov wrote:
> @@ -42,5 +43,24 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
>  			return;
>  		}
>  	}
> +
> +	/*
> +	 * Stupid sanity-check whether RDRAND does *actually* generate
> +	 * some at least random-looking data.
> +	 */
> +	prev = tmp;
> +	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
> +		if (rdrand_long(&tmp)) {
> +			if (prev != tmp)
> +				changed++;

You could do some sort of weak statistical test like

		if (popcnt(prev ^ tmp) < BITS_PER_LONG / 3)
			bad++;

		if (bad > TOO_BAD)
			WARN(...);

this should catch same value, increments you mentioned and possibly
other trivial classes of not-so-random values.
