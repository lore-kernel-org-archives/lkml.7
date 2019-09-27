Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BD7C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063A2217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrSbo6tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfI0WrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:47:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0WrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=60BRoPU6f1csk67hhK0xl/wDOsgjDKeSqv9zsD2ShtQ=; b=XrSbo6tZfJZ7zd7+ZSAuO/42Y
        qfOq186O1Jdde4x0dp0uwEIKzC4l3G8nRDEp2Qbvq2141njSTPMfKpkZppsIGNoJtNwXZBLwy5+Zy
        NHfo0cCgFlgtNJTx2U72HD9D5ZAk8BAZRoCTnA47coS0tNwYCly8CRke6kVqjlsuLgSiPH1qJ7aNW
        Nm8U7bj86u6rSqAIM9DritIalPv/XCxx4TW70rhjTiM1zQfsPJuye1ck0Ab31qIuoslmZMpm/cZGc
        m3c4i7sfUfKZ4slwjyB/kbO/atmPogBjpr4msWplcLelBoCff3UT3p5tg0YqY4vM8cvqTX2JOUPAl
        qifH26P3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDz15-00034z-CV; Fri, 27 Sep 2019 22:47:11 +0000
Date:   Fri, 27 Sep 2019 15:47:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in do_trap_break()
Message-ID: <20190927224711.GI4700@infradead.org>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-5-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569199517-5884-5-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:45:17AM +0800, Vincent Chen wrote:
> To make the code more straightforward, replacing the switch statement
> with if statement.
> 
> Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/kernel/traps.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index dd13bc90aeb6..1ac75f7d0bff 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -124,23 +124,24 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
>  
>  asmlinkage void do_trap_break(struct pt_regs *regs)
>  {
> +	if (user_mode(regs)) {
> +		force_sig_fault(SIGTRAP, TRAP_BRKPT,
> +				(void __user *)(regs->sepc));
> +		return;
> +	}
> +#ifdef CONFIG_GENERIC_BUG
> +	{
>  		enum bug_trap_type type;
>  
>  		type = report_bug(regs->sepc, regs);
> +		if (type == BUG_TRAP_TYPE_WARN) {
>  			regs->sepc += get_break_insn_length(regs->sepc);
>  			return;
>  		}
> +#endif /* CONFIG_GENERIC_BUG */
> +
> +	die(regs, "Kernel BUG");

I like where this is going, but I think this can be improved further
given that fact that report_bug has a nice stub for the
!CONFIG_GENERIC_BUG case.

How about:

	if (user_mode(regs))
		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->sepc);
	else if (report_bug(regs->sepc, regs) == BUG_TRAP_TYPE_WARN)
		regs->sepc += get_break_insn_length(regs->sepc);
	else
		die(regs, "Kernel BUG");
