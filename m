Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B293C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053D6218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553906999;
	bh=YfMGlcqzJvLqsR52Rr/cdP7QW7zXjPeLPRX5Ihzq2+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSvhnlAHV03eBt7yF4JjfiFb73wslKNr1HSCAiUqJJzk01ufJsku6ZqmVwb1RTyMe
	 rcVAPVprqPNQ8BxweJzbZYGVHfS4tStgpp23s6lqNtPq9ZgAX+zjp/OJVsDIsb3KNs
	 A7PzPJK6fP5dQuufz5ZPX/lwZQt+qQBjGfKX/fd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfC3At5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbfC3At5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:49:57 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981F1206DD;
        Sat, 30 Mar 2019 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553906996;
        bh=YfMGlcqzJvLqsR52Rr/cdP7QW7zXjPeLPRX5Ihzq2+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzyF6x+hLsVSLV2GYxP7enzMzvmCkBUHxvZSXsEKtvWSTxsxlRE8t2diHx00JjU5i
         s6iyJrnTdL0XwSrjrVNDag2z2yYNQfoOvCYC9Hq3KBhCw6He6lb2IsL9e61fRLnOXx
         F34gOwbn7WqNPKllRppebG05Kww50EmsVW6ookXU=
Date:   Sat, 30 Mar 2019 08:49:49 +0800
From:   Guo Ren <guoren@kernel.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190330004949.GA15705@guoren-Inspiron-7460>
References: <20190329171230.GB32456@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329171230.GB32456@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Dmitry,

It works for me.

Tested-by: Guo Ren <ren_guo@c-sky.com>
Acked-by: Guo Ren <ren_guo@c-sky.com>

On Fri, Mar 29, 2019 at 08:12:30PM +0300, Dmitry V. Levin wrote:
> C-SKY syscall arguments are located in orig_a0,a1,a2,a3,regs[0],regs[1]
> fields of struct pt_regs.
> 
> Due to an off-by-one bug and a bug in pointer arithmetic
> syscall_get_arguments() was reading orig_a0,regs[1..5] fields instead.
> Likewise, syscall_set_arguments() was writing orig_a0,regs[1..5] fields
> instead.
> 
> Fixes: 4859bfca11c7d ("csky: System Call")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/csky/include/asm/syscall.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
> index d637445737b7..9a9cd81e66c1 100644
> --- a/arch/csky/include/asm/syscall.h
> +++ b/arch/csky/include/asm/syscall.h
> @@ -49,10 +49,11 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
>  	if (i == 0) {
>  		args[0] = regs->orig_a0;
>  		args++;
> -		i++;
>  		n--;
> +	} else {
> +		i--;
>  	}
> -	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
> +	memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
>  }
>  
>  static inline void
> @@ -63,10 +64,11 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
>  	if (i == 0) {
>  		regs->orig_a0 = args[0];
>  		args++;
> -		i++;
>  		n--;
> +	} else {
> +		i--;
>  	}
> -	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> +	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
>  }
>  
>  static inline int
> -- 
> ldv
