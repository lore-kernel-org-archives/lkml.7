Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F0EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE045206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfKMUps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMUpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:45:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8CD206E6;
        Wed, 13 Nov 2019 20:45:47 +0000 (UTC)
Date:   Wed, 13 Nov 2019 15:45:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v3] ARM: ftrace: remove
 mcount(),ftrace_caller_old() and  ftrace_call_old()
Message-ID: <20191113154545.4717a5d6@gandalf.local.home>
In-Reply-To: <20191107160840.7bd821dc@xhacker.debian>
References: <20191107160840.7bd821dc@xhacker.debian>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 08:21:42 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Commit d3c61619568c ("ARM: 8788/1: ftrace: remove old mcount support")
> removed the old mcount support, but forget to remove these three
> declarations. This patch removes them.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
> 
> Changes since v2:
>   - really remove mcount() declaration too. I made a mistake when sending out v2
> 
> Changes since v1:
>   - remove mcount() declaration too
> 
>  arch/arm/include/asm/ftrace.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 18b0197f2384..48ec1d0337da 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -11,7 +11,6 @@
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
>  
>  #ifndef __ASSEMBLY__
> -extern void mcount(void);
>  extern void __gnu_mcount_nc(void);
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> @@ -23,9 +22,6 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	/* With Thumb-2, the recorded addresses have the lsb set */
>  	return addr & ~1;
>  }
> -
> -extern void ftrace_caller_old(void);
> -extern void ftrace_call_old(void);
>  #endif
>  
>  #endif

