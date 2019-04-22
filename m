Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAD6206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555965718;
	bh=Yf1MetlrvGfpLssBO3O9YJ+2t5+frfMmAYhuiSRLAxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5UmRYES4vhPsBVETaDh6XtV/BovVTNq/VnUAW9X5jlsF/bO02d1atUWyPELBdayM
	 A776SYawbvvkc/UNUQqAp+Btugw7PH28qSb/gT3Na45WsPa04O8bWzjWHxvsB54RuD
	 GyWRw3lIOlTRK+igPpfsMDTHef8ps1gxtxuNoMZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfDVUl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDVUl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:41:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECD420859;
        Mon, 22 Apr 2019 20:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555965715;
        bh=Yf1MetlrvGfpLssBO3O9YJ+2t5+frfMmAYhuiSRLAxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rbc2ko9OSmPWqxiHk2Vt1iLbLdJygxdWZ0rkBgDk4sxjMDQGRGHxH6Z+rp3psxopj
         dVbz/WmgQOVgGk/j7oTJL3u+8h5Qi/pNf1WjKKDT9tGJM0WuhYwuJqW3umkfd0y6D4
         Y3SKd1EHz/4tgttKu2Q2JMFsG/BDfdVNurQExS38=
Date:   Mon, 22 Apr 2019 22:41:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, colona@arista.com,
        akpm@linux-foundation.org, christian@brauner.io, arnd@arndb.de,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190422204152.GA5869@kroah.com>
References: <20190422145950.78056-1-weizhenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422145950.78056-1-weizhenliang@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:59:50PM +0800, Zhenliang Wei wrote:
> In the fixes commit, removing SIGKILL from each thread signal mask
> and executing "goto fatal" directly will skip the call to
> "trace_signal_deliver". At this point, the delivery tracking of the SIGKILL
> signal will be inaccurate.
> 
> Therefore, we need to add trace_signal_deliver before "goto fatal"
> after executing sigdelset.
> 
> Note: The action[SIGKILL] must be SIG_DFL, and SEND_SIG_NOINFO matches
> the fact that SIGKILL doesn't have any info.
> 
> Acked-by: Christian Brauner <christian@brauner.io>
> Fixes: cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")
> Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
> ---
>  kernel/signal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 227ba170298e..0f69ada376ef 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2441,6 +2441,7 @@ bool get_signal(struct ksignal *ksig)
>  	if (signal_group_exit(signal)) {
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL);
>  		recalc_sigpending();
>  		goto fatal;
>  	}
> -- 
> 2.14.1.windows.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
