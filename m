Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F50C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FF120663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsgkCyTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCFWb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:31:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45414 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCFWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:31:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id 125so9313101pgc.12;
        Wed, 06 Mar 2019 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ESza+D2sKA/LuHOn567IPxtp5+Pk9utnmnVH7Mgi6bY=;
        b=bsgkCyTFGhH6eWoGNiVtJ2vEw7AKwhbgSV3ypFiEydVGFWsiD2QoffDwZ379HYAb0u
         NHJhIbamXbEUWmunu9uEUDwKzZeyD/pCXITGjoIH9xhq3JySPxk85iq7G1MsXr4dGMO2
         jtvdUd83aPXdQ2cZxFxXu9xBlZ+HjCdX6TDRvXF2iyeKNbFBnrXNz7qyp9ixkQPI0bfq
         0bK2hCyG5mHKdV+fnJkJB3S2CM90C1u47zwRCXjUwW8FuNPbh1tTXFzb6fNhsOZwuv+g
         t8VaVIhoYuj5gcJtEpNXJAeTJns2/Jr9yjkfHko3IeRI5oUWBOdoguS+0m5KHQg50g9O
         p3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ESza+D2sKA/LuHOn567IPxtp5+Pk9utnmnVH7Mgi6bY=;
        b=rBWI6xCC3Tmqg9kzUR8hTbAaQzyoJt1eD/AdloKo6q1IAK4d5YwGE5xGjVm4kMWWRE
         xp8L6uL/1NKlazI7RLWiUOnk9ET/RK/XGvAKOdmC5UUMLLxpeEJd5/mi/xEb1ZjOXe9x
         664lZuxbBuTal0xBGka0GQtzZOHGhX+S4CRl7uMFvUIt3yJWOBvsoLWCZBCl3OU585BN
         ohDImlrYU3uCPzlz7lID/H5RZK6FbDJRg+1BEqnGKrImEvwdihpNyghbCaLYk/Wd6bmY
         hEmFC6DzZVK99q4NjNrGtLPsAxmvYKEx9F1P91SlPZgBkB51jHw3zcGgO73Ak20bwBDd
         uscg==
X-Gm-Message-State: APjAAAXsc3AN3DvsCCiXM9+auoR0GoGD170HRf7Rfek4cinRVZGnry9k
        Gw3vkjH4iAvaMdP8aCNABPff2okc
X-Google-Smtp-Source: APXvYqwROkUQIikIoTEUcrYlLR1J6ioFXkuWBzVZGUUOWG6TehlraURlSVmQB0awTPpkRBVx6S3+Hw==
X-Received: by 2002:a63:9246:: with SMTP id s6mr8262983pgn.349.1551911487277;
        Wed, 06 Mar 2019 14:31:27 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id s79sm6606909pfa.61.2019.03.06.14.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:31:26 -0800 (PST)
Subject: Re: [PATCH v2] xfrm: Reset secpath in xfrm failure
To:     Myungho Jung <mhjungk@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190306215556.GA6104@myunghoj-Precision-5530>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1b3fc434-a5d2-286f-e7ef-027d165a5413@gmail.com>
Date:   Wed, 6 Mar 2019 14:31:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190306215556.GA6104@myunghoj-Precision-5530>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2019 01:55 PM, Myungho Jung wrote:
> In esp4_gro_receive() and esp6_gro_receive(), secpath can be allocated
> without adding xfrm state to xvec. Then, sp->xvec[sp->len - 1] would
> fail and result in dereferencing invalid pointer in esp4_gso_segment()
> and esp6_gso_segment(). Reset secpath if xfrm function returns error.
> 
> Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
> Reported-by: syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
> Changes in v2:
>   - Add fixes tag.
> 
>  net/ipv4/esp4_offload.c | 9 +++++++--
>  net/ipv6/esp6_offload.c | 9 +++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index 8756e0e790d2..7329e40c73f6 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c
> @@ -51,14 +51,18 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
>  		if (!sp)
>  			goto out;
>  
> -		if (sp->len == XFRM_MAX_DEPTH)
> +		if (sp->len == XFRM_MAX_DEPTH) {
> +			secpath_reset(skb);
>  			goto out;
> +		}
>  
>  		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
>  				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
>  				      spi, IPPROTO_ESP, AF_INET);
> -		if (!x)
> +		if (!x) {
> +			secpath_reset(skb);
>  			goto out;
> +		}
>  

I suggest another exit label, so that you replace "goto out" by "goto out_reset";

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 8756e0e790d2a94a5b4a587c3bc3de0673baf2c4..76f754f6692696ba2aa8c9eb03b68b92d1e39ee1 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -82,6 +82,8 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
        xfrm_input(skb, IPPROTO_ESP, spi, -2);
 
        return ERR_PTR(-EINPROGRESS);
+out_reset:
+       secpath_reset(skb);
 out:
        skb_push(skb, offset);
        NAPI_GRO_CB(skb)->same_flow = 0;




>  		sp->xvec[sp->len++] = x;
>  		sp->olen++;
> @@ -66,6 +70,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
>  		xo = xfrm_offload(skb);
>  		if (!xo) {
>  			xfrm_state_put(x);
> +			secpath_reset(skb);
>  			goto out;
>  		}
>  	}


