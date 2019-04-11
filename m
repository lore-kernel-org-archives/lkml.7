Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C230BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DD62082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Al80tNCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDKHBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:01:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VYbJzQw7T4sWfqY2fgQDJDOLaKA52Nv1WM6QY9eEvX0=; b=Al80tNChYpBL+sHza1FeO9mA5
        J8VbYbZ0w+SzT8Q31/MVLqMePl6SnN+JUOiHFYbrzmA0PHSQksv3wad6XS0ygFnsi+5ojji2ClngA
        xdmIDhkdhoiMqLlKRSV40rCLcq2Sa0KjVxHU+xrw1PxcDmEvta2RiqjVSZMxjHwv0LtPnSa6raZkv
        Y/82xHAgaLdNvU4+/3NmkMtsTcWL4WfZc5W3dqjoEOGaeaRDAeHIhw1kbJ0O0czN1jIkadUMp3w0D
        1NyV7fVJK4mAMn4qpRf3cD43ceYB6AjLOwWWo89+AKcAVie9x7Rh4InxYA5UCJEJQBE95E/QQDzpi
        KsdT4fucg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETi4-0003iG-2Y; Thu, 11 Apr 2019 07:01:20 +0000
Date:   Thu, 11 Apr 2019 00:01:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 3/4] RISC-V: Implement nosmp commandline option.
Message-ID: <20190411070119.GD29422@infradead.org>
References: <20190410230443.15729-1-atish.patra@wdc.com>
 <20190410230443.15729-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410230443.15729-4-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:04:42PM -0700, Atish Patra wrote:
> nosmp command line option sets max_cpus to zero. No secondary harts
> will boot if this is enabled. But present cpu mask will still point to
> all possible masks.
> 
> Fix present cpu mask for nosmp usecase.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/smpboot.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index eb533b5c2c8c..a8ad200581aa 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -47,6 +47,17 @@ void __init smp_prepare_boot_cpu(void)
>  
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> +	int cpuid;
> +
> +	/* This covers non-smp usecase mandated by "nosmp" option */
> +	if (max_cpus == 0)
> +		return;
> +
> +	for_each_possible_cpu(cpuid) {
> +		if (cpuid == smp_processor_id())
> +			continue;
> +		set_cpu_present(cpuid, true);
> +	}

Most other architectures seem to use init_cpu_present() here.

Otherwise this looks fine to me.
