Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0224CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65E92075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b8QPhj9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfDVKhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:37:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42576 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDVKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:37:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id w23so8628887lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rWXg1dzH1/8yZZSlBOjiEiuiUUWVE78MmUlO9qZyjI=;
        b=b8QPhj9V37Y8sqX927Pjrce6uTf08Mm1qygRByTBVuqZvrwZpQbNzOg/yl0ad0ao2f
         7PoedmxAo/rx7fpdvTZbG6XNccEXGGhTDEVVgCP1Z23G7KR+npNE270+go4jqkDUDqC3
         3LfK4HRCr9mUGNzDXbBIPb+3f3LE2P3my1upEvL7nXEgOQ/eRHMrhrg3Hbw5kOfh64Hm
         NwqgODk2Lgy1oJM2n/Iw9pEV26CzITwDwvzXNfPf8MExohKFUY3Pvnl+0ZPdlxxFWYKE
         DdBJ+H4QrXoRFWOgRACSbxoUORm+Q60WLejLFNSDagodsIiui96BzDk/sGuKSvp2NBT+
         5oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rWXg1dzH1/8yZZSlBOjiEiuiUUWVE78MmUlO9qZyjI=;
        b=AxAsHZwKUbNpCgSD462kBQuljER6JtywmQ8uer1RHsKZYIBJ94ejiphp7PySV5M0Vg
         /JaRN3BIO4+VLfRqw8KGgFA1KZde7eLw54ThHy956b0Z+e7KJwcF+ZljK5KMdmaLLUvz
         kb1HpA1QIkjG+YE8soF2olx3QW2JLxlIbjTvYmvZVbjNEB5YrB4DR9Vx4jcr4V1HGTd2
         6gdGbUVxnKxwUDHJdBda1dQXZq3Re+OevyggkOJw5+8kVYLs3W+EaiczKzKQtKJgkD2L
         b1uuk3jMNlxFXsFuUH5P6BffhsX8GcRqBqhx3YKtseHDTWPrP/xgLLKa6fO15KQLZt0r
         xptA==
X-Gm-Message-State: APjAAAX5g9PaHLnsmVYgdeH2+0QjhRxN04Aa0dSb8nyp4eBPZB8LJBcV
        bo1nh1jqPruk9und4XMT/Dp9oFl7Xf0Z2DrZmuroLQ==
X-Google-Smtp-Source: APXvYqzqqtybG8tC+k5j8M2rjW/J+AJbY2+JlqX3pyZhm3c/Z9aaDAs1oqL5Pl+jMLWMMaE6rqGGNWGltrUgiUIrEp0=
X-Received: by 2002:ac2:5307:: with SMTP id c7mr1040291lfh.58.1555929436962;
 Mon, 22 Apr 2019 03:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190422065623.49364-1-weizhenliang@huawei.com>
In-Reply-To: <20190422065623.49364-1-weizhenliang@huawei.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Mon, 22 Apr 2019 12:37:05 +0200
Message-ID: <CAHrFyr4rD04qzwDb30h3RMLGPq+OLVGk1Kr8izfAaizkVE43UQ@mail.gmail.com>
Subject: Re: [PATCH v2] signal: trace_signal_deliver when signal_group_exit
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, colona@arista.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 8:57 AM Zhenliang Wei <weizhenliang@huawei.com> wrote:
>
> In the following commit, removing SIGKILL from each thread signal mask
> and executing "goto fatal" directly will skip the call to
> "trace_signal_deliver". At this point, the delivery tracking of the SIGKILL
> signal will be inaccurate.
>
> commit cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")
>
> Therefore, we need to add trace_signal_deliver before "goto fatal"
> after executing sigdelset.
>
> Note: The action[SIGKILL] must be SIG_DFL, and SEND_SIG_NOINFO matches
> the fact that SIGKILL doesn't have any info.
>
> Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>

Just a nit below otherwise

Acked-by: Christian Brauner <christian@brauner.io>

You should probably make the line:
commit cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")
a Fixes-line right above your commit:
Fixes cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")

> ---
>  kernel/signal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 227ba170298e..0f69ada376ef 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2441,6 +2441,7 @@ bool get_signal(struct ksignal *ksig)
>         if (signal_group_exit(signal)) {
>                 ksig->info.si_signo = signr = SIGKILL;
>                 sigdelset(&current->pending.signal, SIGKILL);
> +               trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL);
>                 recalc_sigpending();
>                 goto fatal;
>         }
> --
> 2.14.1.windows.1
>
>
