Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850A520854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553517741;
	bh=JoVyYx5EtyvRPyfbwDb/d2RVT8CUaOcNa5uhAyPSKCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tk4P+9dCphejzh//fDAWZ3Sl045q1ZPGJmyZkaC+OGVdMkFuDq7vT4hiWNBSvmDEK
	 x76SA4cyVMXFgTpBl4cA0tONv8E58+AdgvCLjnviSV82147ikvahbo1xJBDCph/oPJ
	 Y1Ens+rtuKT2Pwzvsw3xCjY7SG7zKMLJpQ9pfez4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfCYMmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731251AbfCYMmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:42:02 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B867520854;
        Mon, 25 Mar 2019 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553517722;
        bh=JoVyYx5EtyvRPyfbwDb/d2RVT8CUaOcNa5uhAyPSKCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF22OJMHahA/Vxwm8zSwrZSQkdZ5CiZKd3yIzPjClvfZki5cnJ993W3MvTuETypcz
         +yHPYoLEqeMNnek0SsyvJmvmrv6puveR0M5VDFqBpAnfD3I2HlOfZLdVxL0IRjtuuG
         vKLfSExytkhH9k9U4PYPsHMZNh9UsWCK3+x/JH4M=
Date:   Mon, 25 Mar 2019 20:41:54 +0800
From:   Guo Ren <guoren@kernel.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
        ren_guo@c-sky.com
Subject: Re: [PATCH] csky: Update syscall_trace_enter/exit implementation
Message-ID: <20190325124154.GA2653@guoren-Inspiron-7460>
References: <1553515419-1797-1-git-send-email-guoren@kernel.org>
 <20190325121754.GB19244@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325121754.GB19244@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Dmitry,

On Mon, Mar 25, 2019 at 03:17:54PM +0300, Dmitry V. Levin wrote:
> On Mon, Mar 25, 2019 at 08:03:39PM +0800, guoren@kernel.org wrote:
> [...]
> > diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
> > index a4eaa8d..9bf5b1a 100644
> > --- a/arch/csky/include/uapi/asm/ptrace.h
> > +++ b/arch/csky/include/uapi/asm/ptrace.h
> > @@ -62,6 +62,11 @@ struct user_fp {
> >  #define instruction_pointer(regs) ((regs)->pc)
> >  #define profile_pc(regs) instruction_pointer(regs)
> >  
> > +static inline unsigned long regs_return_value(struct pt_regs *regs)
> > +{
> > +	return regs->a0;
> > +}
> > +
> >  #endif /* __KERNEL__ */
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* _CSKY_PTRACE_H */
> 
> I wonder why we have this #ifdef __KERNEL__ code in the uapi namespace,
> it defeats the idea of uapi.  Doesn't it belong to non-uapi
> include/asm/ptrace.h namespace?

Yes, I should move __KERNEL__ codes into arch/csky/include/asm/ptrace.h.
But it'll be another patch for the modification. Any other problems?

Best Regards
 Guo Ren
