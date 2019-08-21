Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35154C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1B322DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHUAmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:42:44 -0400
Received: from verein.lst.de ([213.95.11.211]:32992 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfHUAmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:42:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B5F168B20; Wed, 21 Aug 2019 02:42:41 +0200 (CEST)
Date:   Wed, 21 Aug 2019 02:42:41 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/15] riscv: provide native clint access for M-mode
Message-ID: <20190821004241.GA20250@lst.de>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-9-hch@lst.de> <fa0570285684e03587ee8f09b86f0d058d757c55.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0570285684e03587ee8f09b86f0d058d757c55.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:24:31AM +0000, Atish Patra wrote:
> > +static inline void clint_set_timer(unsigned long delta)
> > +{
> > +	writeq_relaxed(clint_read_timer() + delta,
> > +		clint_time_cmp +
> > cpuid_to_hartid_map(smp_processor_id()));'
> 
> This is not compatible with 32 bit mode. IIRC, timecmp is a 64 bit on
> RV32 as well. Here is the implementation in OpenSBI.

writeq alwasy writes 64-bit anyway, but the deltas is just 32-bit
per the Linux clocksource API.

> > +static inline cycles_t get_cycles(void)
> > +{
> > +#ifdef CONFIG_64BIT
> > +	return readq_relaxed(clint_time_val);
> > +#else
> > +	return readl_relaxed(clint_time_val);
> > +#endif
> 
> Same comment as above. Both RV32 & RV64 bit have 64 bit have 64 bit
> precission for timer val. You have to read 32 bits at a time and "or"
> them to get 64 bit value. Here is the implementation from OpenSBI

But the Linux API is only going to read 32-bits of that, same as
for the rdtime pseudo-instruction used by the current SBI-based code.

Note that I've reworked this area a bit for v4, which I'm going to
send out soon, including cleanups to the existing code to make a few
of these things more obvious:

http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.4
