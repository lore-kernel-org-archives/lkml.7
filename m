Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0431C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MtnKvHTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfDXNH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:07:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35260 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfDXNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:07:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so5007598wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=efC0d41bcdCEPg2sED1pE6Lj8uSJvrJgvXmS3cUlyUg=;
        b=MtnKvHTCfXNM6o0Xisy931EBHm/M5lxAMjgBSsm5QneZzWcgqB/9ei5sPkiCPbMsdI
         jabCrvWJrE5dEPorzVRRGf7e1aYoHOUXWu62s+tjlbmmt9YfM9Ys8fJQY5C1nhcsPYh8
         9pQLXTJTEhNvnXimRrd/cUCHm5zqU1v6KRycWpgXMVgLo/YBspuuIweQLfep+nGvu4Q9
         GANyJakFdPpSIJz7KWJZ4E+CiLfdB9AbQ8O0RHDtjdNk/aaLCPpcCIrqd64yQvEhFiXU
         a0YBzEMlkHreYotLSrTCZEvL8uICSxUhWbAK7zbhlps0BNjag9ccxOkJoLwmwLLuOtO5
         t/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efC0d41bcdCEPg2sED1pE6Lj8uSJvrJgvXmS3cUlyUg=;
        b=sTSLYiM6QWAu1V4irkwW7ODkXNp0PENLTUiygLkM++Dsvv7Phmd/8NOWjRr7uSWKQZ
         FSeMk3FGAEGBad5/rZfD5H4t2/cx3iV9lSt/m/ehPaZJi4Ld76zOQNXELxYBra/V+N8L
         EuI0L+mIqJ3MPiOWIiKwbcN9ha4WaXbBlBLDUNE4ITJRZgDbnlGd4aKvJoRQZN9PvUTY
         zlttfld5blXKelt2+/VKvDEaC6aM7HTNEt9YpfhWAxnK2q2k/ZJi3FZVIYAfedY/3Ux8
         w1gvAUcyOlFGFFFt+HbcDzUorilzKgb+oWujXReu2KKp5Ui/9/C4VddjVh2Md+yb9VBi
         KUvg==
X-Gm-Message-State: APjAAAX1RHMxt/gdPvWYgvmUc9vqZ1jP6PYvfRR34qKZYZx0D1gHxYm7
        TJzHF2kv+VYYzRSnfWxZcg4X1g==
X-Google-Smtp-Source: APXvYqxSqhzZdQM+LkndxvGGQ5P9BUBal4exkleRgtWHfaGFuiHITNNwUKpWwWm0uV4rDDv07rePUA==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr6534078wmb.85.1556111274838;
        Wed, 24 Apr 2019 06:07:54 -0700 (PDT)
Received: from brauner.io (p4FC0A32E.dip0.t-ipconnect.de. [79.192.163.46])
        by smtp.gmail.com with ESMTPSA id n1sm14163522wmc.19.2019.04.24.06.07.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 06:07:54 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:07:52 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, colona@arista.com,
        akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
        deepa.kernel@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190424130751.jckvq535ipfx5cq6@brauner.io>
References: <20190424125238.83264-1-weizhenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424125238.83264-1-weizhenliang@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 08:52:38PM +0800, Zhenliang Wei wrote:
> In the fixes commit, removing SIGKILL from each thread signal mask
> and executing "goto fatal" directly will skip the call to
> "trace_signal_deliver". At this point, the delivery tracking of the SIGKILL
> signal will be inaccurate.
> 
> Therefore, we need to add trace_signal_deliver before "goto fatal"
> after executing sigdelset.
> 
> Note: SEND_SIG_NOINFO matches the fact that SIGKILL doesn't have any info.
> 
> Acked-by: Christian Brauner <christian@brauner.io>

I think we're supposed to use more Reviewed-bys so feel free (or Andrew)
to change this to:

Reviewed-by: Christian Brauner <christian@brauner.io>

> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Cc: <stable@vger.kernel.org>
> Fixes: cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
> ---
>  kernel/signal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 227ba170298e..3edf526db7c6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2441,6 +2441,8 @@ bool get_signal(struct ksignal *ksig)
>  	if (signal_group_exit(signal)) {
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> +			&sighand->action[signr - 1]);

Hm, sorry for being the really nitpicky person here. Just for the sake
of consistency how about we do either:

+		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
+			&sighand->action[SIGKILL - 1]);

or

+		trace_signal_deliver(signr, SEND_SIG_NOINFO,
+			&sighand->action[signr - 1]);

I'm not going to argue about this though. Can just also leave it as is.

Christian
