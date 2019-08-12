Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5554C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JaY4y5EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfHLO6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:58:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfHLO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OxtCqZsdSgj9huiQaCowabjYtf4RGoVyeAEuNHO72F0=; b=JaY4y5EWv7A0YcpscrPdgt+9B
        f14Nbul/ykGHxMxL4lLlHP5TwGRgcNh2g5t2U38TWtvpPRwm5zICf3QqPU3ZkhrzmIJJgCrezVmXH
        i8+iKGK5cqNf57sUXxH6sP1QC7zyj6JcCnRn4Asjqgsq5B18ULnhm02fOJvS5AuLzrieDU59UooJ5
        nwP5azFrUEDCiARPOCSW9dQOp3E162KPohxSeOdIKVpY4HX3LWwRJ/G0sxJWfCQrcr81e93ufU3Zh
        kLPUJU8Nwatt9BySBwZp0By+H1yMYhqgHq151cTrBukk22PXedB7L5rkR3Vd8l+jxAkvT+BPMeocM
        Qkzf+21wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBm4-0003i0-CB; Mon, 12 Aug 2019 14:58:16 +0000
Date:   Mon, 12 Aug 2019 07:58:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Correct the initialized flow of FP register
Message-ID: <20190812145816.GD26897@infradead.org>
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void fstate_off(struct task_struct *task,
> +			       struct pt_regs *regs)
> +{
> +	regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;

No need for the inner braces here.

> +}
> +
>  static inline void fstate_save(struct task_struct *task,
>  			       struct pt_regs *regs)
>  {
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index f23794b..e3077ee 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -64,8 +64,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>  	unsigned long sp)
>  {
>  	regs->sstatus = SR_SPIE;
> -	if (has_fpu)
> +	if (has_fpu) {
>  		regs->sstatus |= SR_FS_INITIAL;
> +#ifdef CONFIG_FPU
> +		/*
> +		 * Restore the initial value to the FP register
> +		 * before starting the user program.
> +		 */
> +		fstate_restore(current, regs);
> +#endif

fstate_restore has a no-op stub for the !CONFIG_FPU case, so the ifdef
here is not needed.

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
