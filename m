Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC3BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD51720679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHMQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:30:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfHMQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:30:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E7FC337;
        Tue, 13 Aug 2019 09:30:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59463F706;
        Tue, 13 Aug 2019 09:30:04 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:29:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] riscv: provide native clint access for M-mode
Message-ID: <20190813162958.GA27821@lakrids.cambridge.arm.com>
References: <20190813154747.24256-1-hch@lst.de>
 <20190813154747.24256-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813154747.24256-9-hch@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:47:40PM +0200, Christoph Hellwig wrote:
> RISC-V has the concept of a cpu level interrupt controller.  Part of it
> is expose as bits in the status registers, and 2 new CSRs per privilege
> level in the instruction set, but the machanisms to trigger IPIs and
> timer events, as well as reading the actual timer value are not
> specified in the RISC-V spec but usually delegated to a block of MMIO
> registers.  This patch adds support for those MMIO registers in the
> timer and IPI code.  For now only the SiFive layout also supported by
> a few other implementations is supported, but the code should be
> easily extensible to others in the future.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

> +/*
> + * This is the layout used by the SiFive clint, which is also shared by the qemu
> + * virt platform, and the Kendryte KD210 at least.
> + */
> +#define CLINT_IPI_OFF		0
> +#define CLINT_TIME_VAL_OFF	0xbff8
> +#define CLINT_TIME_CMP_OFF	0x4000;
> +
> +u32 __iomem *clint_ipi_base;
> +u64 __iomem *clint_time_val;
> +u64 __iomem *clint_time_cmp;
> +
> +void clint_init_boot_cpu(void)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");

Since the MMIO layout is that of the SiFive clint, the compatible string
should be specific to that. e.g. "sifive,clint". That way it will be
possible to distinguish it from other implementations.

What exactly is the "0" suffix for? Is that a version number?

If that's a CPU index, then I don't think that's the right way to encode
this unless the programming interface actually differs across CPUs. It
would be better to use an explicit phandle to express the affinity.

Thanks,
Mark.

