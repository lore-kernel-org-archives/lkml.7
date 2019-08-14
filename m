Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DCDC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF592064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfHNEfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:35:55 -0400
Received: from verein.lst.de ([213.95.11.211]:34398 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfHNEfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:35:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9889C68B02; Wed, 14 Aug 2019 06:35:51 +0200 (CEST)
Date:   Wed, 14 Aug 2019 06:35:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Kao <alankao@andestech.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] riscv: clear the instruction cache and all
 registers when booting
Message-ID: <20190814043551.GA22862@lst.de>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-14-hch@lst.de> <20190814010013.GA18655@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814010013.GA18655@andestech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:00:14AM +0800, Alan Kao wrote:
> But it doesn't really mean that the running system has an FPU given CONFIG_FPU
> enabled.  Normally the existence of an FPU is checked in riscv_fill_hwcap by
> searching device tree, where the code looks like
> 
> 
> bool has_fpu = false; // this one is global
> ...
> #ifdef CONFIG_FPU
>         if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
>                 has_fpu = true;
> #endif
> 
> 
> Or does CONFIG_FPU have a more intuitive meaning when CONFIG_M_MODE is enabled?

No, it doesn't..

> 
> > +	csrr	t0, CSR_MISA
> > +	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
> > +	bnez	t0, .Lreset_regs_done

... which is why we have these few lines of code that check the
caps returns from the misa CSR, similar to the elf_caps check quoted
above.
