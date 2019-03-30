Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F23C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A2D2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/2Hn/o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfC3HsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:48:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56085 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfC3HsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:48:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so4737151wmf.5;
        Sat, 30 Mar 2019 00:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veJ41/czBjZjPZmExTeSyn7Vlevg++tHqoguVHWlJ64=;
        b=r/2Hn/o+rHqZqs+dGeJyW5NwAx3ee22D0KrwWHEzFWOZQdr5VXBo3TKbrtoPnjtFXI
         wx7m881rzFZzIn9tLK6ZlhlrreQhuyS//HEOpYlGDz0EHpvXWBhIIGTco1xuCreyoo3n
         wEFY3iQFQ7d8OolnwMaEcZWgyTgfc8L3C3j6lRgphveKC78ubNSjkLnn9AhR+2n0lHL8
         /16fq6TG2FC6IANcHEVsV5936bOGC7LBEgQDkPSRzsQHPMNkXVA1YYLAPcbMOyLNU/o2
         trEEuSeuEzm2khgE9sZ2/sBa5qYB+8l11VdKmqiz7A4zjTnMNAm8KU5fwWFZLvEda3WN
         xYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veJ41/czBjZjPZmExTeSyn7Vlevg++tHqoguVHWlJ64=;
        b=da4WssWNd6WAusi6wvtdEC1sslDaLrLnnine2wW7A12nMTFGyVrg6xZtJN2GV5b0tv
         h8dJMYzNs2FHaeTYaXTN7riN+CUFMjnoCLFnuocYhjZ3PQzAuB5jhLdaaEwC4eQzJaF4
         7/wsNUMzAcknjE27iFRc/jc0bbulMyH9XOuFa+8SSqZG3wre/5Bf374jy1SZ0yIIjLx5
         3byb2FkxVjf99MwMnGz5Eq9NHSQtd7SxGSN2HZivhZ8IXdguPcFRQ6k9rs5sKKwMf6ub
         wQXEJBHDiBmXYhYbmlYo9i/msQaCrutW8GjQNn9RS4OHTfDrpJHBAuUhH9r5nz6eGpG/
         Nfrg==
X-Gm-Message-State: APjAAAUYkv5Jp22ncerlgxqUW2a7G6ngdezCcPLoLlcdqBQuED4N3Eog
        xEzlp2obCpWn00d4yQ7wgQY/AMGG
X-Google-Smtp-Source: APXvYqzpKedH9jkm41hfby3O8E93QAndg+3fTGSA4IX4o8NmfxDyUdSuN0BITohvjm7NHEqH2hfCIw==
X-Received: by 2002:a1c:9d46:: with SMTP id g67mr5585550wme.99.1553932091511;
        Sat, 30 Mar 2019 00:48:11 -0700 (PDT)
Received: from [192.168.8.147] (58.85.136.77.rev.sfr.net. [77.136.85.58])
        by smtp.gmail.com with ESMTPSA id g84sm5570564wmf.25.2019.03.30.00.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 00:48:10 -0700 (PDT)
Subject: Re: [PATCH net] ipv6: Fix dangling pointer when ipv6 fragment
To:     hujunwei <hujunwei4@huawei.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mingfangsen@huawei.com, liuzhiqiang26@huawei.com,
        zhangwenhao8@huawei.com
References: <cbbedd1f-3e99-85f7-86d7-d02a86d59c29@huawei.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <ee0fb75b-f976-02ae-31e3-c3f957f71923@gmail.com>
Date:   Sat, 30 Mar 2019 00:48:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cbbedd1f-3e99-85f7-86d7-d02a86d59c29@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2019 12:29 AM, hujunwei wrote:
> From: Junwei Hu <hujunwei4@huawei.com>
> 
> At the beginning of ip6_fragment func, the prevhdr pointer is
> obtained in the ip6_find_1stfragopt func.
> However, all the pointers pointing into skb header may change
> when calling skb_checksum_help func with
> skb->ip_summed = CHECKSUM_PARTIAL condition.
> The prevhdr pointe will be dangling if it is not reloaded after
> calling __skb_linearize func in skb_checksum_help func.
> 
> Here, I add a variable, nexthdr_offset, to evaluate the offset,
> which does not changes even after calling __skb_linearize func.
> 
> Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
> Signed-off-by: Junwei Hu <hujunwei4@huawei.com>
> Reported-by: Wenhao Zhang <zhangwenhao8@huawei.com>
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Interesting.

We got a syzbot report yesterday about this issue. (email thread : BUG: unable to handle kernel paging request in ip6_fragment)

<quote>
syzbot found the following crash on:

HEAD commit:    8c838f53 dpaa2-eth: fix race condition with bql frame acco..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12b83a9b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=e8ce541d095e486074fc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e8ce541d095e486074fc@syzkaller.appspotmail.com
</quote>


> 
> ---
>  net/ipv6/ip6_output.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index edbd12067170..6db3c60b3b66 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -606,12 +606,14 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>      __be32 frag_id;
>      int ptr, offset = 0, err = 0;
>      u8 *prevhdr, nexthdr = 0;
> +    u8 nexthdr_offset;
>  
>      err = ip6_find_1stfragopt(skb, &prevhdr);
>      if (err < 0)
>          goto fail;
>      hlen = err;
>      nexthdr = *prevhdr;
> +    nexthdr_offset = prevhdr - skb_network_header(skb);
>  
>      mtu = ip6_skb_dst_mtu(skb);
>  
> @@ -646,6 +648,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>          (err = skb_checksum_help(skb)))
>          goto fail;
>  
> +    prevhdr = skb_network_header(skb) + nexthdr_offset;
> +
>      hroom = LL_RESERVED_SPACE(rt->dst.dev);
>      if (skb_has_frag_list(skb)) {
>          unsigned int first_len = skb_pagelen(skb);
> 
