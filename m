Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21342190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbUJU9dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfCVQMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:12:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43153 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:12:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id d26so2123285ede.10;
        Fri, 22 Mar 2019 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNbiROqocIMhe+r4/JZLDDMawn+rRistlEcQ+uTaB7E=;
        b=TbUJU9dxWeLrnAKFEXRasRmF2hoVCbmrFFAm5vTT+Rh/V+PMd12zifqF71yQPCORiV
         So8IWVF035URyJms9oKjffyheTwsOVV8jUCYbkUgokbcD+kl/BTEH6eUvRWi5CDbf9S6
         7tiICm9FRMpojuX4br0yOE0SYHfFuXvrzAHR0OzvWCMp7cmCvhbo7KsZz60xSQyrU3DA
         0kRGst1708o5Auv4JcULzQgSCMkcerg82ZEpi60eu1mMfT/4ctSKZSRuTq69vyQ0deQL
         Yg7rXhP5gR1xgSsz60UbgJLcHfTWYkeklR/ZD+LKXwSJbXBmX3o7MNbwNZFnAkxIK5/J
         ahpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNbiROqocIMhe+r4/JZLDDMawn+rRistlEcQ+uTaB7E=;
        b=LaG4XxIbj+WVmk83cEmOgpozcEBNWViaFr1JfYctLNMQwBsYm1TpLvuxXN+UjDgpfA
         5e4bp3z4fQhHKPKHiY/4nDFxIQ2OPLojeMoY0SitMG8pyLYfmcgHo/fKhTRhi2wUJi0t
         LmV0gqmPrdGl/YJ8v1M7D6SXpGtOBllL+s+CdqPQCvSqNjWJJld04udYVGwEwbNzqMSO
         Rv9pn/inpyoXxV7cw6iQhRXG+y2zfVO3Sn7QaY/WFPAoMhIZA838s3SLPJw7Ate3Si6Q
         urjbJfJj20OtiVdG5DD09hlIcZDQgAVdnC37wFEqgwqnoaGSl1B9r7uW10cAjzo6hRB6
         fr7Q==
X-Gm-Message-State: APjAAAUfC4h8cvWPVzQF77fJDm7Ifyjqtd0GctEqWdhmP3ymYBe7GYgp
        CNp5VV67gcXlhTpxzJt69b4=
X-Google-Smtp-Source: APXvYqwWj6W4xNuOkRQhQaqGD4yIjteMZUOdV8oRYj6k6Zs0ZAvLj2NFCl9LTLQ8C4ldHdzp69d4LA==
X-Received: by 2002:a17:906:251b:: with SMTP id i27mr6135129ejb.146.1553271168017;
        Fri, 22 Mar 2019 09:12:48 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id u21sm1778965ejm.45.2019.03.22.09.12.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 09:12:46 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:12:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tuong Lien <tuong.t.lien@dektech.com.au>,
        LUU Duc Canh <canh.d.luu@dektech.com.au>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        GhantaKrishnamurthy MohanKrishna 
        <mohan.krishna.ghanta.krishnamurthy@ericsson.com>,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: avoid a clang -Wuninitialized warning
Message-ID: <20190322161244.GG21978@archlinux-ryzen>
References: <20190322141819.641588-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322141819.641588-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:18:13PM +0100, Arnd Bergmann wrote:
> clang notices that we pass 'maddr' into the tipc_bearer_xmit() function
> without having initialized it first:
> 
> net/tipc/node.c:831:6: error: variable 'maddr' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>         if (!tipc_link_is_establishing(l)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/tipc/node.c:847:46: note: uninitialized use occurs here
>         tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
>                                                     ^~~~~
> net/tipc/node.c:831:2: note: remove the 'if' if its condition is always true
>         if (!tipc_link_is_establishing(l)) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/tipc/node.c:821:31: note: initialize the variable 'maddr' to silence this warning
>         struct tipc_media_addr *maddr;
>                                      ^
>                                       = NULL
> 
> This is harmless because it won't use 'maddr' if the
> queue is empty, but it's better to make that explicit
> and not even call the function in that case.
> 
> As clang is able to inline the check, it then notices that
> the code is safe.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for looking into this and fixing it!

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  net/tipc/node.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 2dc4919ab23c..ca4cafd00a38 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -844,7 +844,8 @@ static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
>  	tipc_node_write_unlock(n);
>  	if (delete)
>  		tipc_mon_remove_peer(n->net, n->addr, old_bearer_id);
> -	tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
> +	if (!skb_queue_empty(&xmitq))
> +		tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
>  	tipc_sk_rcv(n->net, &le->inputq);
>  }
>  
> -- 
> 2.20.0
> 
