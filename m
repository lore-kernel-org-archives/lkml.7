Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F48CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE9E2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfJaJHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJaJHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:07:11 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84BC25945B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:07:11 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k10so2889409wrl.22
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uv8J8WDWlm5KkI7ZZB1632xd20pA70gOpFtg9sDlJvM=;
        b=bFQoyIP+3H64fcp3Q8gGN1DilcNdHg/ELt7Qh0N7fZKZ8W9eat7Wly0DlzxGLcV/jn
         OqLZ0BJR7vqtSsz6bcYuThfyQ6NapLyEJvkHluVC8rJRgFuRyonhWKyT5HC4T1IXFscZ
         6tDLwqWeXZJWr9YSRcwQ4KUgLwONVGYtaDSnFhSMg9rF3z3hAcO/JPO0h1Xdk3uJsRhg
         7SJgpQJ15SGc33RggVeaC2L4pmOvFnTsZBR8rsaJJejsT8dIfwBKu7e54L3sQAYZDgWe
         jAAEQNNcJkDjOkEIASp+BqXIVATnN9s19wutrp4HHb28STvO2zQR5ZotrgSI4kKCHsfc
         k83A==
X-Gm-Message-State: APjAAAUY5yvuhxXuQwrfxltfsCZQrLOY0XWCFq9j42puGxkcaAGx9zdW
        VH4FoN6pbpp3ZMyl6RHAeC22Pq3ofB+EkW20rL3gNb52ujZ2A9FNvnvSPz1rhb7m6c234g5p0Om
        jixmmMrP6VjoPE5zQwDUCN4NH
X-Received: by 2002:a1c:6308:: with SMTP id x8mr4076651wmb.140.1572512830195;
        Thu, 31 Oct 2019 02:07:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfjaVx5Id/rjqKFiRz8/nIcvC1Gfp7404XpLuXKxzmGRZ2YVyve+OhEy7UlUWjEBX07Dmh7Q==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr4076626wmb.140.1572512829951;
        Thu, 31 Oct 2019 02:07:09 -0700 (PDT)
Received: from steredhat ([91.217.168.176])
        by smtp.gmail.com with ESMTPSA id x205sm3535236wmb.5.2019.10.31.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:07:09 -0700 (PDT)
Date:   Thu, 31 Oct 2019 10:07:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, sunilmut@microsoft.com, willemb@google.com,
        stefanha@redhat.com, ytht.net@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, decui@microsoft.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vsock: Simplify '__vsock_release()'
Message-ID: <20191031090707.ec33h3z6zhux3hbq@steredhat>
References: <20191031064741.4567-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031064741.4567-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 07:47:41AM +0100, Christophe JAILLET wrote:
> Use '__skb_queue_purge()' instead of re-implementing it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  net/vmw_vsock/af_vsock.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ab43b2bba31..2983dc92ca63 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -641,7 +641,6 @@ EXPORT_SYMBOL_GPL(__vsock_create);
>  static void __vsock_release(struct sock *sk, int level)
>  {
>  	if (sk) {
> -		struct sk_buff *skb;
>  		struct sock *pending;
>  		struct vsock_sock *vsk;
>  
> @@ -662,8 +661,7 @@ static void __vsock_release(struct sock *sk, int level)
>  		sock_orphan(sk);
>  		sk->sk_shutdown = SHUTDOWN_MASK;
>  
> -		while ((skb = skb_dequeue(&sk->sk_receive_queue)))
> -			kfree_skb(skb);
> +		skb_queue_purge(&sk->sk_receive_queue);
>  
>  		/* Clean up any sockets that never were accepted. */
>  		while ((pending = vsock_dequeue_accept(sk)) != NULL) {

Good clean-up!

This patch LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
