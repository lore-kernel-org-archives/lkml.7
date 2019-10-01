Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B443ECDFB6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178A921855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7a3cHIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfJAHCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:02:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AGuzTjIA6zIwZLTAcZWukiKmrFjmZKO6ZmG1uh+vwww=; b=m7a3cHIO2AekiG8nMLX4/ITuc
        85DytciWj/C0X/aKvjAWAHQqbE8eSoZSI9vfIcZWLEYDUgr6SaHbZ01ERw2Il+Z5oFdqPMub2xbIa
        II5V22h0o2+MZN0TQhpeNYNdWFiX7YSVeKVtfWwYab4262Q0imUFKbJj6pX/353y4yp3j/BWgCg4I
        TDrBvebmHPMLwO/hq+nxkxJaS3+4FaP+wkuTaTVl6bAQ+hfuH1U+aEze2nJjp0AnX1EdwNdpQI45R
        bT4w0mUhUQw86XAzau6iPGo7XmP7+hVcFtNzv1YwwsOlkAwk0nOg9UBVSu2RCCVWdFr5KV0HVFvRp
        dw9PXQRXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCBA-0003O3-Fe; Tue, 01 Oct 2019 07:02:36 +0000
Date:   Tue, 1 Oct 2019 00:02:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>, hch@infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Message-ID: <20191001070236.GA7622@infradead.org>
References: <20191001002318.7515-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001002318.7515-1-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 05:23:18PM -0700, Atish Patra wrote:
> /proc/cpuinfo should just print all the isa string as an information
> instead of determining what is supported or not. ELF hwcap can be
> used by the userspace to figure out that.
> 
> Simplify the isa string printing by removing the unsupported isa string
> print and all related code.
> 
> The relevant discussion can be found at
> http://lists.infradead.org/pipermail/linux-riscv/2019-September/006702.html

This looks good, but can you also rename the orig_isa argument to isa
now that we never modify it?

>  	/*
>  	 * Linux doesn't support rv32e or rv128i, and we only support booting
>  	 * kernels on harts with the same ISA that the kernel is compiled for.
>  	 */
>  #if defined(CONFIG_32BIT)
> -	if (strncmp(isa, "rv32i", 5) != 0)
> +	if (strncmp(orig_isa, "rv32i", 5) != 0)
>  		return;
>  #elif defined(CONFIG_64BIT)
> -	if (strncmp(isa, "rv64i", 5) != 0)
> +	if (strncmp(orig_isa, "rv64i", 5) != 0)
>  		return;
>  #endif

And I don't think having these checks here makes much sense.  If we want
to check this at all we should do it somewhere in the boot process.
