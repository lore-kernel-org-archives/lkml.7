Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F7AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7C2206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlGEvZB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfG2Qj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:39:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34844 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfG2Qj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:39:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so28334212pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nb4CjHnrkOlFdXVrAOvEL/gOTXxG/KIC7AXINQV9eWk=;
        b=nlGEvZB5fX2ZSbjO+u+hA8aR3krsDKHgKYElzvXmv0PoxwN2zWeRAb4a2Brjil6QEI
         B0hYH7uYLCYxzBMwAIjS7pmNDh42vwo3hfnbAaUYvsjT0Kh5nxhMPoAwH6hY020rLd1r
         kiIA8RbrpGdG55B62jcb5KYpu2RuFV4FJczq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nb4CjHnrkOlFdXVrAOvEL/gOTXxG/KIC7AXINQV9eWk=;
        b=LGMC+gzWJjNZk2ox/tpUOdMhLXdm37K7D0F/KQ/1iYjWJK+dAGdAQimHSUScf1fbjr
         fwO/SqtGp7G+Iorye9gVpiSOWBlaTRhdNCJadMC3M7jAyF94cCQF7OEeQ+M+86VGICg4
         Qp1Q9SExwARkaHSiSzqLCTrolKOtFwmhOFa7S3iccwilA52RpKOwaj/LznUR3ik2AKeR
         eHon7FTLIPD7m8iocMljCoGNFFU1MwVIRcf59zIM8v7iFQTzkszgcAJIah/nIMIBUmqz
         QIPh5CKUFkGTKjl1Me6LapEvdETCZo/Wzl1v3aDQTqavi2A9iZuR5VHF50RMrIjFhKLz
         bmTQ==
X-Gm-Message-State: APjAAAUGi7Z40X4d9KA3XZBxWPdP+G8YsoBD02T9MgRfET5cJZpIM8Nk
        Lv7WtWTUgKiq5uLr5jnFwgFffA==
X-Google-Smtp-Source: APXvYqyK2+iAItNJDXrCfMN9a1yOxU/cDJlsagolowGQVyJ92TnTYjA+8yIMajRcltnHr0bAJ/49qw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr36642822pfn.98.1564418395411;
        Mon, 29 Jul 2019 09:39:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14sm79017275pfq.158.2019.07.29.09.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:39:54 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:39:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] net/af_iucv: mark expected switch fall-throughs
Message-ID: <201907290939.A3EF9B979@keescook>
References: <20190729145947.GA9494@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729145947.GA9494@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:59:47AM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> net/iucv/af_iucv.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 537:3, 519:6, 2246:6, 510:6
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/iucv/af_iucv.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 09e1694b6d34..ebb62a4ebe30 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -512,7 +512,9 @@ static void iucv_sock_close(struct sock *sk)
>  			sk->sk_state = IUCV_DISCONN;
>  			sk->sk_state_change(sk);
>  		}
> -	case IUCV_DISCONN:   /* fall through */
> +		/* fall through */
> +
> +	case IUCV_DISCONN:
>  		sk->sk_state = IUCV_CLOSING;
>  		sk->sk_state_change(sk);
>  
> @@ -525,8 +527,9 @@ static void iucv_sock_close(struct sock *sk)
>  					iucv_sock_in_state(sk, IUCV_CLOSED, 0),
>  					timeo);
>  		}
> +		/* fall through */
>  
> -	case IUCV_CLOSING:   /* fall through */
> +	case IUCV_CLOSING:
>  		sk->sk_state = IUCV_CLOSED;
>  		sk->sk_state_change(sk);
>  
> @@ -535,8 +538,9 @@ static void iucv_sock_close(struct sock *sk)
>  
>  		skb_queue_purge(&iucv->send_skb_q);
>  		skb_queue_purge(&iucv->backlog_skb_q);
> +		/* fall through */
>  
> -	default:   /* fall through */
> +	default:
>  		iucv_sever_path(sk, 1);
>  	}
>  
> @@ -2247,10 +2251,10 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  			kfree_skb(skb);
>  			break;
>  		}
> -		/* fall through and receive non-zero length data */
> +		/* fall through - and receive non-zero length data */
>  	case (AF_IUCV_FLAG_SHT):
>  		/* shutdown request */
> -		/* fall through and receive zero length data */
> +		/* fall through - and receive zero length data */
>  	case 0:
>  		/* plain data frame */
>  		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
> -- 
> 2.22.0
> 

-- 
Kees Cook
