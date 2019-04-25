Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39451C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D0520679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="e340SQfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDYNOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:14:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37013 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfDYNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:14:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so1462328edw.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g75BwLN4R8xuSeRdoXz2tu6AoMbM+mYXbYPKXRT0R7U=;
        b=e340SQfEyWzBjupqs5uoZrKWC6KzrCsgk8PNiSgHHC/rNbfjMlG98ZoPFPIcLa7fn8
         oWiP3IOSkx8W3rbMVKRJYkt7z84sdwF409bw9AEeRz5aaUh301mlXy0Fn9lxeZetcI9I
         bwBhLdZO6UENXBfvNTheRZlIQoEFJt0g80VK9n4xjZXgaDDm0qmGJgxbiRndS/+yYi5U
         qhe1JHVYSZu77LOMOze/zVQxUhVuUC5n7Or3ggG0FV8CaENAG6O/9WJVNrLrWv6lmLsD
         6nrhGjZvN1rqq3O3U2kvEf8g2fgi9IeZNT3zINXfaAnGInLaYNNvcUhOsxYqBXc5eXpf
         F1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g75BwLN4R8xuSeRdoXz2tu6AoMbM+mYXbYPKXRT0R7U=;
        b=nzrBnGeEbXVuKxmKHS3egD9kyZeT+ZDlbB39lUS6JSV2esU4kitCPmCVHB6jx7lx/9
         5zqun4RQkNngU7O8mHkj9H7g1lt7zZ+KBsZhp9XPmekrC1vCECoM2R/UF1UgJy9GCWRo
         Qs6YM5rD1+9WkK+/tHPCZK3j1dOTVHUVcNvahsEnrP5b2oRCQpbu6AXWaVb45SmVeiWh
         j/YuBb+DXtTcRszAUC63PJRKrQ/qx5i1X2zJISXOKZHQyaBoMau7N/LIRuja2GXABnDR
         RKTxwLRyAtYCdBtLKTrHPn4Q/HbY0GeOO4wRqenqcbDab/k0AcEKQdYVuaWwTGZ8be5n
         m79g==
X-Gm-Message-State: APjAAAVl3vuOY5x10QMp+dkDzOmDGoC9cIjymSPu1Kxie4OTpLi02g8o
        SFj8sLTXvmbdxN/VFmXQ/NFILg==
X-Google-Smtp-Source: APXvYqx461iGgPD7H5ml0vBOQ/llJxZghfujB/gVtwo+HSE0ZOyd1BLxwIl+M+g9k9NADQBzeIhvHQ==
X-Received: by 2002:a17:906:288f:: with SMTP id o15mr7735725ejd.282.1556198070461;
        Thu, 25 Apr 2019 06:14:30 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id e21sm3476770edd.23.2019.04.25.06.14.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 06:14:29 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:14:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, colona@arista.com,
        akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
        deepa.kernel@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190425131427.xhlzntanu22tyhvu@brauner.io>
References: <20190425025812.91424-1-weizhenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425025812.91424-1-weizhenliang@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:58:12AM +0800, Zhenliang Wei wrote:
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
> Reviewed-by: Christian Brauner <christian@brauner.io>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Cc: <stable@vger.kernel.org>
> Fixes: cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")

Thanks for the patience! I think this is now ready to be picked up. :)

Christian

> 
> Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
> ---
>  kernel/signal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 227ba170298e..429f5663edd9 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2441,6 +2441,8 @@ bool get_signal(struct ksignal *ksig)
>  	if (signal_group_exit(signal)) {
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> +				&sighand->action[SIGKILL - 1]);
>  		recalc_sigpending();
>  		goto fatal;
>  	}
> -- 
> 2.14.1.windows.1
> 
> 
