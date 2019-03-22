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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1894C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE832083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB1usJ5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCVPWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:22:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36774 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:22:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so2010491edi.3;
        Fri, 22 Mar 2019 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4OzrE11C3lY9LCODCHosSXBSJbVCPNIr219DUyFchw=;
        b=fB1usJ5AqbooI902PtLBpQ68y3rU4CJYHO8teIJRKUnaaml9qxGjWsKA9pQHN6ptD3
         gHjZwJTCvpG3ldk58J2XHMEDi8/dbuDRbwod5qey89+31Y4e3P3kvWkJ6i5mKxufsAK7
         9TZKar3Ntc20YNQc9tV+nGhwmp+llmHzucvgGE+G/8bu8Kya0uFArv5FhZ4KEveCVwtC
         IwTpl3u/QKMPH6aRPKl5nkJLYFaAVMmGqXiH8LFBk4XdV9rgT9cu4jg0opE28FLjOjYy
         ndyy7ILhCyfEXkRk8LyUonzeXce92VhISXpF8xvjHiJtX48bWNTqlbl7cYJKIny6qEiM
         QQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4OzrE11C3lY9LCODCHosSXBSJbVCPNIr219DUyFchw=;
        b=RWxoMNmCnK+7MkH37vRV40QkGhUHaf5rOL8tIPITFBCSl62gic68XNE4GvRcEpRXMT
         QObQT5zweSrzajW8sBrI5WHFcl/BitKP9aMRwzNUJnSpXXlPVvXPPpQR4FrG6MunHwHJ
         zAu4DyxWicjEd8LcuGi1TixiNuYexqY5UjruWcEQU4wT6Ej6Nhw1D797W+j7v+6k70rm
         oN/imN53Ogl92bWk0Vbpr7f4hEsjrdk+rzz4B9N+EgAQKS2qCicVfIZ/n2i88zcKlsrO
         AK9ql+73Uyirnp14PCzz/D5kc+PyPej+vayjSUDwpV6THHN3NQs8xQd6QQ3ChoTsQ7Kr
         x3Bw==
X-Gm-Message-State: APjAAAXgaoe8F3sjZ4A/NPlxJYHcKGSJn3NI4QSr0rBOTEvLq8qE440+
        VBubRFl/6Kp17i4ctGXG0KQ=
X-Google-Smtp-Source: APXvYqxDxueiz+uFwhlmUbpaQj+gIcKvSyCHwKL2wyhLJm4hGht03a3qZBIu20xF0/UJuYfrmOHowA==
X-Received: by 2002:a17:906:d71:: with SMTP id s17mr5523029ejh.233.1553268132611;
        Fri, 22 Mar 2019 08:22:12 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f15sm16474eja.39.2019.03.22.08.22.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:22:11 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:22:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: avoid clang -Wuninitialized warning
Message-ID: <20190322152209.GC13220@archlinux-ryzen>
References: <20190322141848.659387-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322141848.659387-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:18:43PM +0100, Arnd Bergmann wrote:
> clang produces a false-positive warning as it fails to notice
> that "lost = true" implies that "ret" is initialized:
> 
> net/rxrpc/output.c:402:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (lost)
>             ^~~~
> net/rxrpc/output.c:437:6: note: uninitialized use occurs here
>         if (ret >= 0) {
>             ^~~
> net/rxrpc/output.c:402:2: note: remove the 'if' if its condition is always false
>         if (lost)
>         ^~~~~~~~~
> net/rxrpc/output.c:339:9: note: initialize the variable 'ret' to silence this warning
>         int ret, opt;
>                ^
>                 = 0
> 
> Rearrange the code to make that more obvious and avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  net/rxrpc/output.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 736aa9281100..004c762c2e8d 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -335,7 +335,6 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
>  	struct kvec iov[2];
>  	rxrpc_serial_t serial;
>  	size_t len;
> -	bool lost = false;
>  	int ret, opt;
>  
>  	_enter(",{%d}", skb->len);
> @@ -393,14 +392,14 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
>  		static int lose;
>  		if ((lose++ & 7) == 7) {
>  			ret = 0;
> -			lost = true;
> +			trace_rxrpc_tx_data(call, sp->hdr.seq, serial,
> +					    whdr.flags, retrans, true);
> +			goto done;
>  		}
>  	}
>  
> -	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags,
> -			    retrans, lost);
> -	if (lost)
> -		goto done;
> +	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags, retrans,
> +			    false);
>  
>  	/* send the packet with the don't fragment bit set if we currently
>  	 * think it's small enough */
> -- 
> 2.20.0
> 
