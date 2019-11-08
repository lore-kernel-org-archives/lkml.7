Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8295FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4EC206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqvv0JCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfKHMWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:22:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38816 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfKHMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:22:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3857542pgh.5;
        Fri, 08 Nov 2019 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=265ilrPyAc+08beKAE2CsGbxxp/QxNAUXvuAhj1glKw=;
        b=Xqvv0JCtG2UB2ibnORP5AnamGOCO5c5RCClyrHl5tAcm0SKqpjy3Jb8jbFJlv54Gs4
         bqs0hUGHEO6qTLaRqH5AmbEl/9BJaRElGMx7JbzJFtcz9suz8bAkY3czNgrYc+gjK3Hq
         r4jnLqxU9bXeSQi8rzhgeqacY7VO1QZ/o4yvCkvgGPoR8uZKY7Hsc8/tGDxml1w8CO4f
         NLSht01j9yKBWBUBuUZ6M2oa6XkSnQgB+Rq6ZquOeKVj6EMzVXtMPORtsMosRN0BaDKq
         kVWHh87zTtyoYmR6jNFcloHsuuQhZcU9ZrnBeljnwt7nvZrOyW0i/O6CZqLFS4krF2ai
         WD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=265ilrPyAc+08beKAE2CsGbxxp/QxNAUXvuAhj1glKw=;
        b=I4O+zwE3QM+9rHbs9b74ihV/fkMwzjIOn5jjxlS79xqCaWIAh9bFT5jFQREYuLdQsU
         gdMTOYLjvOyoJpLqrhxc3vvpN8LSJGsGfd8FW2tIVfe2EsXzgG6xhpPoc+ujm+29G0Ah
         geYYOaH0N8ie+boaOXm4Iy44zN9J1dHLpft26d/tI/XJUPTi+Ej/Dy0P8YffDzDQnVhp
         d525SAHVomZZaYE62NIuGL3OIYsY3ouftxRcRnyiPmMNPUYUypFFNJnqNoLAYPPEM71E
         B93nfz4RIYDo0TjWp7l/YIkWL7iujmVKNnBTeNMybWr+ezICZa+uM7DHJN6ZCQqzeZbT
         UmSQ==
X-Gm-Message-State: APjAAAWhOrU9Ky9HbHcPbIywzi2Eh/hbFK5FNgwMDHkQ0jm5fi3S1USZ
        HrpmJJnJxpm7rJvEnFabwlI=
X-Google-Smtp-Source: APXvYqwIeSgiKu+IYnmeeumT/W7JTJ8l7PzqnI/dvRO+PyZMa04u0DS4TctCHfVEreUrjgTqhw7/vg==
X-Received: by 2002:a63:f923:: with SMTP id h35mr11853341pgi.323.1573215742278;
        Fri, 08 Nov 2019 04:22:22 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id j23sm5465721pfe.95.2019.11.08.04.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 04:22:21 -0800 (PST)
Subject: Re: [PATCH] tcp: remove redundant new line from tcp_event_sk_skb
To:     Tony Lu <tonylu@linux.alibaba.com>, edumazet@google.com,
        rostedt@goodmis.org, mingo@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
References: <20191108095007.26187-1-tonylu@linux.alibaba.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <795f4bb1-b40e-1745-0df4-6e55d80d5272@gmail.com>
Date:   Fri, 8 Nov 2019 04:22:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108095007.26187-1-tonylu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/19 1:50 AM, Tony Lu wrote:
> This removes '\n' from trace event class tcp_event_sk_skb to avoid
> redundant new blank line and make output compact.
> 
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>  include/trace/events/tcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 2bc9960a31aa..cf97f6339acb 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -86,7 +86,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
>  			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
>  	),
>  
> -	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s\n",
> +	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
>  		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
>  		  __entry->saddr_v6, __entry->daddr_v6,
>  		  show_tcp_state_name(__entry->state))
> 

This seems good to me. Only few comments :

I would add a

Fixes: af4325ecc24f ("tcp: expose sk_state in tcp_retransmit_skb tracepoint")

And also CC (I just did in this reply) the author of the above patch to make sure nothing unexpected happens.

Thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
