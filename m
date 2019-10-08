Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7809AECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FC3217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XoZbfyRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfJHPoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:44:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rm4/9rv6HX2r0nJlpOILNCRrJ7/GYeb4OrtBUUbPm84=; b=XoZbfyRrk2Yb9Xh/JWriMo57w
        0MlWAM/84VG3DoYgBjM9o1GsAaajHkBisrShC21UZ/dgEzxExcZPpibG1/Gyotgp+84IJqBCxg+Ty
        nvgJr2coRkCNnyOesaeqKQzY86vATs2BI4MQraBpeK3X1BEI2MIxEnjhx9BBpXcuKMVqNbjpSUFI7
        FvjQvHeK9GVKw+cOMIsXDiBEzDhvmWZKXYpSl6rEKyE9RIC7zr9clShR9I2VpzK2k84Zp9WDvkcRN
        3SgHOINsTr/DceK00Y9xFGANdeUewSp/oOU/2C1RGF1gSadDYXxufXLsdp5iIZsvG3nDqiVin6TsG
        XTxymkvww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHrei-0001rR-O5; Tue, 08 Oct 2019 15:44:08 +0000
Date:   Tue, 8 Oct 2019 08:44:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Ghiti <aghiti@upmem.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [v1 PATCH  2/2] RISC-V: Consolidate isa correctness check
Message-ID: <20191008154408.GC20318@infradead.org>
References: <20191004012000.2661-1-atish.patra@wdc.com>
 <20191004012000.2661-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004012000.2661-3-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int riscv_read_check_isa(struct device_node *node, const char **isa)
> +{
> +	u32 hart;
> +
> +	if (of_property_read_u32(node, "reg", &hart)) {
> +		pr_warn("Found CPU without hart ID\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_string(node, "riscv,isa", isa)) {
> +		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n",
> +			hart);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Linux doesn't support rv32e or rv128i, and we only support booting
> +	 * kernels on harts with the same ISA that the kernel is compiled for.
> +	 */
> +#if defined(CONFIG_32BIT)
> +	if (strncmp(*isa, "rv32i", 5) != 0)
> +		return -ENODEV;
> +#elif defined(CONFIG_64BIT)
> +	if (strncmp(*isa, "rv64i", 5) != 0)
> +		return -ENODEV;
> +#endif

Using IS_ENABLED here would clean the checks up a bit.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b1ade9a49347..eaad5aa07403 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -38,10 +38,8 @@ void riscv_fill_hwcap(void)
>  		if (riscv_of_processor_hartid(node) < 0)
>  			continue;
>  
> -		if (of_property_read_string(node, "riscv,isa", &isa)) {
> -			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +		if (riscv_read_check_isa(node, &isa) < 0)
>  			continue;

Do we really get rid of warnings if we didn't find anything proper?
