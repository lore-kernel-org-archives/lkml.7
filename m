Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE26DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5520665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHNBS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:18:29 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:27000 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbfHNBS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:18:29 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x7E0n9Jj017975
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 08:49:09 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x7E0mjaZ017904;
        Wed, 14 Aug 2019 08:48:45 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 14 Aug 2019
 09:00:13 +0800
Date:   Wed, 14 Aug 2019 09:00:14 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/15] riscv: clear the instruction cache and all
 registers when booting
Message-ID: <20190814010013.GA18655@andestech.com>
References: <20190813154747.24256-1-hch@lst.de>
 <20190813154747.24256-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190813154747.24256-14-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x7E0mjaZ017904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Aug 13, 2019 at 05:47:45PM +0200, Christoph Hellwig wrote:
> When we get booted we want a clear slate without any leaks from previous
> supervisors or the firmware.  Flush the instruction cache and then clear
> all registers to known good values.  This is really important for the
> upcoming nommu support that runs on M-mode, but can't really harm when
> running in S-mode either.  

Sure.

> +#ifdef CONFIG_FPU

But it doesn't really mean that the running system has an FPU given CONFIG_FPU
enabled.  Normally the existence of an FPU is checked in riscv_fill_hwcap by
searching device tree, where the code looks like


bool has_fpu = false; // this one is global
...
#ifdef CONFIG_FPU
        if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
                has_fpu = true;
#endif


Or does CONFIG_FPU have a more intuitive meaning when CONFIG_M_MODE is enabled?

> +	csrr	t0, CSR_MISA
> +	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
> +	bnez	t0, .Lreset_regs_done
> +
> +	li	t1, SR_FS
> +	csrs	CSR_XSTATUS, t1
> +	fmv.s.x	f0, zero
> +	fmv.s.x	f1, zero
> +	fmv.s.x	f2, zero
> +	fmv.s.x	f3, zero
> +	fmv.s.x	f4, zero
> +	fmv.s.x	f5, zero
> +	fmv.s.x	f6, zero
> +	fmv.s.x	f7, zero
> +	fmv.s.x	f8, zero
> +	fmv.s.x	f9, zero
> +	fmv.s.x	f10, zero
> +	fmv.s.x	f11, zero
> +	fmv.s.x	f12, zero
> +	fmv.s.x	f13, zero
> +	fmv.s.x	f14, zero
> +	fmv.s.x	f15, zero
> +	fmv.s.x	f16, zero
> +	fmv.s.x	f17, zero
> +	fmv.s.x	f18, zero
> +	fmv.s.x	f19, zero
> +	fmv.s.x	f20, zero
> +	fmv.s.x	f21, zero
> +	fmv.s.x	f22, zero
> +	fmv.s.x	f23, zero
> +	fmv.s.x	f24, zero
> +	fmv.s.x	f25, zero
> +	fmv.s.x	f26, zero
> +	fmv.s.x	f27, zero
> +	fmv.s.x	f28, zero
> +	fmv.s.x	f29, zero
> +	fmv.s.x	f30, zero
> +	fmv.s.x	f31, zero
> +	csrw	fcsr, 0
> +	/* note that the caller must clear SR_FS */
> +#endif /* CONFIG_FPU */
