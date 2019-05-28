Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A757208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ9ELxRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfE1Usv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:48:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34597 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfE1Usv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:48:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id j24so258364ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3l55ECOd6G49lDcW/Ub9navCGchmZ/ngyO7S9XQJ6c=;
        b=PZ9ELxRTP+rOjmudehGgkfrpzwB+tYb4J+9NuSIsIIjunFAET6NcKYWgV5I6CLjV7N
         VPaDjyoROvcKhuB5n8kymbXQ5WTHYJoFxONFsy/U9SrmTdwwfaF+E/gpvu8vd/TjhgZq
         tCFXX7774TErU6adjntnnasvvstKbpibjWPX+HbII1k39SvMa6hmGf1lxP2qpb5WdqC/
         LmG6HoS/8Fpq/W5kt68w73bcOphbIluSIqmeUcQqlCMJ6sypSS/os04PKi22d9MDGCKv
         tnMiDBuLNybYX8rGbpJgulObucTNte2fk7nLGfCmyBqiVcEDO4IyzA8leAwoHWsYAjWT
         rCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k3l55ECOd6G49lDcW/Ub9navCGchmZ/ngyO7S9XQJ6c=;
        b=rxKaMG7w4FH3Jr+6h8oxzbM6lHS5Z5O2f122NNTZG5NErB8BaSRQQ4794qirJY3+AX
         7NWhmIQxkyX82xqixLY+/cU1whVLSLqdEFnwB2nSnwdr33f6wFbFXWWTyBK3HHkjo8NV
         QSdZmPCaQs+PkZzHPZub4ryxmsG16j+kMZ9HwxwQeW2x4/WizulmTt4KmNdPnofUB4BI
         yuh6XitAmwthF4mKW8o5GNOtZksbso2KIINwzJufnkVjO4BD0c0QaeXNKPthYnFxIz+A
         Iu/yBHHM9Z+JudAd1PbxkjNoxALMA1XfTQwu7565phVWTljsG0ZLR0h2vAambWcKP3GL
         mcMA==
X-Gm-Message-State: APjAAAWFT7smwy4g4iDqDfWhEK7m1HVlb1M15/vneipBOPqnigheL8/X
        HgJLE/ACDpzYOFwrcqNQq8g=
X-Google-Smtp-Source: APXvYqzw7CcoKlp8zwkC53mptuXYf4zU7bsAIhPIaXXg1nNLTdDO0HLi/VhmQqwLaXJJ2CZ8zPkCDA==
X-Received: by 2002:a2e:9742:: with SMTP id f2mr32737091ljj.184.1559076528334;
        Tue, 28 May 2019 13:48:48 -0700 (PDT)
Received: from [192.168.1.15] (2-111-15-75-dynamic.dk.customer.tdc.net. [2.111.15.75])
        by smtp.gmail.com with ESMTPSA id d20sm3111879lja.32.2019.05.28.13.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 13:48:47 -0700 (PDT)
Subject: Re: [PATCH] trace: Avoid memory leak in predicate_parse()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
References: <20190528104400.388e4c3f@gandalf.local.home>
 <20190528154338.29976-1-tomasbortoli@gmail.com>
 <20190528163104.67763762@gandalf.local.home>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFpCTZMBEADNZ1+Ibh0Z4pgGRcd1aOUMbe/YfHktmajjcoTnKmZZunjoUVAl8waeLITd
 BC2c8i1wHzHcnthrmb1izs5XlG6PZnl8n5tjysSNbwggzS1NcEK1qgn5VjNlHQ5aRMUwCC51
 kicBiNmlQk2UuzzWwdheRGnaf+O1MNhC0GBeEDKQAL5obOU92pzflv6wWNACr+lHxdnpyies
 mOnRMjH16NjuTkrGbEmJe+MKp0qbjvR3R/dmFC1wczniRMQmV5w3MZ/N9wRappE+Atc1fOM+
 wP7AWNuPvrKg4bN5uqKZLDFH7OFpxvjgVdWM40n0cQfqElWY9as+228Sltdd1XyHtUWRF2VW
 O1l5L0kX0+7+B5k/fpLhXqD3Z7DK7wRXpXmY59pofk7aFdcN97ZK+r6R7mqrwX4W9IpsPhkT
 kUyg3/Dx/khBZlJKFoUP325/hoH684bSiPEBroel9alB7gTq2ueoFwy6R3q5CMUw3D+CZWHA
 3xllu46TRQ/Vt2g0cIHQNPoye2OWYFJ6kSEvaLpymjNDJ9ph2EuHegonDfOaYSq34ic2BcdB
 JkCgXRLP5K7KtRNJqqR+DM8xByeGmQv9yp6S97el+SiM9R53RhHawJZGz0EPl+2Q6+5mgh3u
 wXOlkmGrrSrlB8lc567l34ECl6NFtUPIL7H5vppIXAFl7JZUdQARAQABtB50b21hcyA8dG9t
 YXNib3J0b2xpQGdtYWlsLmNvbT6JAlQEEwEIAD4WIQSKOZIcNF9TdAG6W8ARUi5Y8x1zLgUC
 WkJNkwIbIwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRARUi5Y8x1zLvCXD/9h
 iaZWJ6bC6jHHPGDMknFdbpNnB5w1hBivu9KwAm4LyEI+taWhmUg5WUNO1CmDa2WGSUSTk9lo
 uq7gH8Y7zwGrYOEDVuldjRjPFR/1yW2JdAmbwzcYkVU0ZUhyo2XzgFjsnv3vJGHk/afEopce
 U6mOc2BsGDpo2izVTE/HVaiLE9jyKQF6Riy04QBRAvxbDvx1rl26GIxVI6coBFf4SZhZOnc0
 dzsip0/xaSRRIMG0d75weezIG49qK3IHyw2Fw5pEFY8tP0JJVxtrq2MZw+n4WmW9BVD/oCd/
 b0JZ4volQbOFmdLzcAi2w7DMcKVkW11I1fiRZ/vLMvA4b79r6mn3WJ8aMIaodG6CQzmDNcsF
 br+XVp8rc58m9q69BTzDH0xTStxXiwozyISAe2VGbGUbK9ngU/H1RX0Y01uQ9Dz0KfyjA0/Z
 QOBa4N1n1qoKFzoxTpu0Vyumkc5EnTk8NdWszt7UAtNSaIZcBuWHR7Kp0DqRHwom0kgTiNXJ
 8uNgvvFTkPd2Pdz1BqbpN1Fj856xPuKIiqs5qXI2yh3GhntFDbTOwOU3rr3x5NEv3wFVojdi
 HcLM+KVf29YkRHzuEQT5YT9h6qTk2aFRqq3HSXrP56hQ3whR7bQtziJspkuj+ekeTxcZ5lr4
 9FJI03hQJ4HbHn6x/Xw0+WjIOo4jBeUEI7kCDQRaQk2TARAA4JCPcQcISPAKKC1n9VQxgdH3
 oMqxhJ+gh/0Yb394ZYWLf7qOVQf/MgALPQIIFpcwYrw7gK4hsN7kj1vwPFy9JIqZtkgbmJHm
 aCj1LkZuf8tp5uvqzMZGcgm28IO6qDhPggeUE3hfA/y5++Vt0Jsmrz5zVPY0bOrLh1bItLnF
 U3uoaHWkAi/rhM6WwlsxemefzKulXoR9PIGVZ/QGjBGsTkNbTpiz2KsN+Ff/ZgjBJzGQNgha
 kc6a+eXyGC0YE8fRoTQekTi/GqGY7gfRKkgZDPi0Ul0sPZQJo07Dpw0nh5l6sOO+1yXygcoA
 V7I4bUeANZ9QJzbzZALgtxbT6jTKC0HUbF9iFb0yEkffkQuhhIqud7RkITe25hZePN8Y6Px0
 yF4lEVW/Ti91jMSb4mpZiAaIFcdDV0CAtIYHAcK1ZRVz//+72o4gMZlRxowxduMyRs3L5rE0
 ZkFQ6aPan+NBtEk1v3RPqnsQwJsonmiEgfbvybyBpP5MzRZnoAxfQ9vyyXoI5ofbl/+l9wv8
 mosKNWIjiQsX3KiyaqygtD/yed5diie5nA7eT6IjL92WfgSelhBCL4jV0fL4w8hah2Azu0Jg
 1ZtjjgoDObcAKQ5dLJA0IDsgH/X/G+ZMvkPpPIVaS5QWkiv66hixdKte/4iUrN+4waxJLCit
 1KGC2xPJ2UUAEQEAAYkCPAQYAQgAJhYhBIo5khw0X1N0AbpbwBFSLljzHXMuBQJaQk2TAhsM
 BQkJZgGAAAoJEBFSLljzHXMuOb0P/1EnY4Y6LfQ6bmhJQ6epA3fB70hRWCQsuPYLAgPKRoXy
 kmWH4ljqQDbA55TtIpnod/woR0IDnZcD7E9cyGzM2rHvSLXTkHhgIWacZHZopAUzq4j0lhiJ
 Wu57freQPU4rzMVGZXBktUsDMsJwp/3Tl2Kjqylh90qIOlB9laUusLIbl4w5J3EscIJzWvdL
 y1lJLtBmus/t75wN/aIB8l9YBKGuy0L4SAmjhN52pCgP/S+ANEKvdghQco51a4jD2Pv2uYH7
 nUU/Y70AmqOHjPR+qZ0hAUw6B+UtWQ+Fl587Qqi2XPUzdA8G2EjGFFPRlnhf2H/gOyAfeVYL
 NDwDgm9Yzp7Rx0O1QOnQsXTHqk7K38AdSdM2li/I/zegeblInnLi08Gq6mT6RkD6wV9HE5U3
 EIU0rDPyJo54MW39wGjfC2+PM5I0xebbxtnuTewRchVVfm7UWgLAy11pV3xM4wMSJOuqVMOz
 jYpWKYxDTpvsZ0ginUUY993Gb8k/CxjABEMUGVHhQPZ0OzjHIKS6cTzN6ue8bB+CGOLCaQp1
 C0NRT5Tn9zpLxtf5nBExFd/zVENY5vAV2ZbKQdemO54O7j6B9DSgVRrm83GCZxbL4d+qTYBF
 3tSCWw/6SG1F3q9gR9QrSC2YRjCmhijUVEh6FhZwB58TNZ1sEEttrps8TDa5tUd9
Message-ID: <77f8591e-6230-7341-7bb3-0599c16bea92@gmail.com>
Date:   Tue, 28 May 2019 22:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528163104.67763762@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 10:31 PM, Steven Rostedt wrote:
> On Tue, 28 May 2019 17:43:38 +0200
> Tomas Bortoli <tomasbortoli@gmail.com> wrote:
> 
>> @@ -578,6 +578,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>>  out_free:
>>  	kfree(op_stack);
>>  	kfree(inverts);
>> +	for (i = 0; prog_stack[i].pred; i++)
>> +		kfree(prog_stack[i].pred);
>>  	kfree(prog_stack);
>>  	return ERR_PTR(ret);
>>  }
> 
> I should have caught this, but thanks to the zero day bot, it found it
> first:
> 
>  kernel/trace/trace_events_filter.c:582:27-31: ERROR: prog_stack is NULL but dereferenced.
> 
> I changed the patch with the following:
> 
> From dfb4a6f2191a80c8b790117d0ff592fd712d3296 Mon Sep 17 00:00:00 2001
> From: Tomas Bortoli <tomasbortoli@gmail.com>
> Date: Tue, 28 May 2019 17:43:38 +0200
> Subject: [PATCH] tracing: Avoid memory leak in predicate_parse()
> 
> In case of errors, predicate_parse() goes to the out_free label
> to free memory and to return an error code.
> 
> However, predicate_parse() does not free the predicates of the
> temporary prog_stack array, thence leaking them.
> 
> Link: http://lkml.kernel.org/r/20190528154338.29976-1-tomasbortoli@gmail.com
> 
> Cc: stable@vger.kernel.org
> Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
> Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> [ Added protection around freeing prog_stack[i].pred ]
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_filter.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index d3e59312ef40..5079d1db3754 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -428,7 +428,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>  	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
>  	if (!op_stack)
>  		return ERR_PTR(-ENOMEM);
> -	prog_stack = kmalloc_array(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
> +	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
>  	if (!prog_stack) {
>  		parse_error(pe, -ENOMEM, 0);
>  		goto out_free;
> @@ -579,7 +579,11 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>  out_free:
>  	kfree(op_stack);
>  	kfree(inverts);
> -	kfree(prog_stack);
> +	if (prog_stack) {
> +		for (i = 0; prog_stack[i].pred; i++)
> +			kfree(prog_stack[i].pred);
> +		kfree(prog_stack);
> +	}
>  	return ERR_PTR(ret);
>  }
>  
> 

Oops again, I should have been more careful.

Thanks.
