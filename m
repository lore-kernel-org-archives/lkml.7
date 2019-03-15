Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF41C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF411218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUxATW68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCOUDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:03:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41701 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfCOUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:03:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so7168679pgb.8;
        Fri, 15 Mar 2019 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9AzJNPZrWzBDD4w+YR6o8R1NuHkXmo1ETr66/JW7xLw=;
        b=mUxATW68etjE5v8S6J9Jd+3aIJP3RDifB7SRhiyyAe3JOb88DPKvLOvqxA5fJjklUa
         0R51CHmyEhXiPvKBm8RTOmSqu9McUlBgo9ESFJeeOk3DFae8iSGVwwpnWkHL5T8LIehE
         H6aDiOVLZhFjZTl6Lyoxfp6D/MXHg0AlvvGtbOaILc1P4UMi+CnbvjCE9w2Bbb+mndVh
         HoRoU1W1TqYpdyrIt+3CSbdzFHrAwEv4kdI659SaRSqJ3zauITFYhoUxKS+o+Pa/IK6C
         O3HS9Q7uE1MPZhMMaTgS0hvmb0iSDSU6rlzoljfH1oI8gX1kjokIbEHdfL8Wq/7KSEZ6
         ejYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9AzJNPZrWzBDD4w+YR6o8R1NuHkXmo1ETr66/JW7xLw=;
        b=j6UodrotZECnNb7Cs4zveubsmCEGRX3Cs6HcPyyb6Y6JFklMYcFeLbvDHu51cquh/j
         dNLhJMIy2MYLgGHSLcA5WP5Hx4oZAdSiVDTvTzv7KIQlld2i/w6+bSNf3A+ityj4bnX7
         zSQQHiMp8th0LSOCx/XvVH3n7GUbxySDQ7Kce13U00qwn6mJEnqkqhJGjiCu20R8NUdy
         Mn0B8aYxp84sgHdb5kpbrZGdMMZV8NXu90Z2FrhWouThUb0zQTtBJfQ5YOCr9TlJH7pL
         vN1wvUqtY57gkSq5Z2cvr9JaUE8IL+TM6SdoojTKwHcbpDUa3Xpu2P4uU1IvBHC5JrNr
         qQUA==
X-Gm-Message-State: APjAAAVebYhvFcPdjK6g7LUakaMUH3T3bM978bRw/45M6STI7gLdn1LC
        BMyhNmdYiTHJ0zZyrBR+Pts=
X-Google-Smtp-Source: APXvYqz6d+NKyVLh5z3E5aaETq9ca7nFOcUBQOKqRBUqKTHpgoiu//RDThDx4hpT4mlqDLJyMQbN0g==
X-Received: by 2002:a63:780e:: with SMTP id t14mr5285862pgc.276.1552680213678;
        Fri, 15 Mar 2019 13:03:33 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id p34sm4428128pgb.18.2019.03.15.13.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:03:32 -0700 (PDT)
Subject: Re: [PATCH v11 08/14] net, arm64: untag user pointers in
 tcp_zerocopy_receive
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <56d3373c1c5007d776fcd5de4523f4b9da341fb6.1552679409.git.andreyknvl@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <04c5b2de-7fde-7625-9d42-228160879ea0@gmail.com>
Date:   Fri, 15 Mar 2019 13:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <56d3373c1c5007d776fcd5de4523f4b9da341fb6.1552679409.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/15/2019 12:51 PM, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
> can only by done with untagged pointers.
> 
> Untag user pointers in this function.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  net/ipv4/tcp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 6baa6dc1b13b..89db3b4fc753 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1758,6 +1758,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  	int inq;
>  	int ret;
>  
> +	address = untagged_addr(address);
> +
>  	if (address & (PAGE_SIZE - 1) || address != zc->address)

The second test will fail, if the top bits are changed in address but not in zc->address

>  		return -EINVAL;
>  
> 

