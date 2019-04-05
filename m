Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762B3206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TfPkypfM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQyFVAjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfDEGrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:47:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:47:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 75FB2609F3; Fri,  5 Apr 2019 06:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554446829;
        bh=GW7WCqZ/kt/rcIsbdZNdWqoDeu0IwQVDlnNoiYbbT7c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TfPkypfM0c7Pna0sgW/vH2h2g+KXgl7bA/KSe8Ob+XPEeBjHNkuOYwnTJWWrRBtU/
         Rakw+XO1ixl0FNh/f6CiSj4NWz2NcIriGoHJ0s2m7zqVRh2rmkqk0RBUhaHrln+yCv
         hlmv2KkszjB1pX4BgJ01CHp2dk99MVi8QP9hUAQQ=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67D016087A;
        Fri,  5 Apr 2019 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554446828;
        bh=GW7WCqZ/kt/rcIsbdZNdWqoDeu0IwQVDlnNoiYbbT7c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FQyFVAjgf40UU4imQ/DuAFDjziMBSOA0r3Yj8xzXvqiC932+wpddHdAAZ1obXb9yf
         8RakB2buW0IG2ro7QmoAkyE6JtXdXYs1Ghfu8Vq57Tgc58aUPVj55oaGSb79i2acqh
         63YWi5wXHDTTmQaow7xqGKhoTV6FZzrHFDOTxlbs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67D016087A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] tcp: remove redundant check on tskb
To:     Colin King <colin.king@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404144603.27682-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b4c8d1bc-0ecf-21cb-fe11-ebe5d7e91712@codeaurora.org>
Date:   Fri, 5 Apr 2019 12:17:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404144603.27682-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 8:16 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The non-null check on tskb is always false because it is in an else
> path of a check on tskb and hence tskb is null in this code block.
> This is check is therefore redundant and can be removed as well
> as the label coalesc.
>
> if (tsbk) {
>          ...
> } else {
>          ...
>          if (unlikely(!skb)) {
>                  if (tskb)       /* can never be true, redundant code */
>                          goto coalesc;
>                  return;
>          }
> }
>
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   net/ipv4/tcp_output.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e265d1aeeb66..32061928b054 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3088,7 +3088,6 @@ void tcp_send_fin(struct sock *sk)
>   		tskb = skb_rb_last(&sk->tcp_rtx_queue);
>   
>   	if (tskb) {
> -coalesce:
>   		TCP_SKB_CB(tskb)->tcp_flags |= TCPHDR_FIN;
>   		TCP_SKB_CB(tskb)->end_seq++;
>   		tp->write_seq++;
> @@ -3104,11 +3103,9 @@ void tcp_send_fin(struct sock *sk)
>   		}
>   	} else {
>   		skb = alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
> -		if (unlikely(!skb)) {
> -			if (tskb)
> -				goto coalesce;
> +		if (unlikely(!skb))
>   			return;
> -		}
> +
>   		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
>   		skb_reserve(skb, MAX_TCP_HEADER);
>   		sk_forced_mem_schedule(sk, skb->truesize);
