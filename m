Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6725720857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT3Lz3h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfDAPzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:55:06 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:32852 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:55:06 -0400
Received: by mail-ed1-f49.google.com with SMTP id q3so8737980edg.0;
        Mon, 01 Apr 2019 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BbkbLjRhAP2m6M+H3V/iFkQN5+l9IbV2kSNUBnOy1UI=;
        b=FT3Lz3h5xmECVOYxU3dJDLk5mS9nN+GVdoHnrwClcleUYmtfTBwqeK44Zo3C4+hHbQ
         vB0zezQeuZxUEOKPJ2dT9Xh/Tfa9pKtq0VqH8498XHleMWgbYuKmtm9aSPFdvZCwAL6Y
         y4Yygm7r8BG1Rt64bKKbi0PeCdnAMkzhVTxJ+2aBRwDF6REGDxokyDABi1ZHQqFZ1w2z
         YyhdRc83NLeDH4QiLl1qDAxoHoHOVZyyEIvmeTUXKVqFvLTfnkLMSlpMMZW5aclyG7g3
         Y/iJXWv6w9aqwQDJfqJJe1g88Mg/0EaAFVm79Q1yT0uFPckr20kXEbzyuHSrDAxrbolY
         Dp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BbkbLjRhAP2m6M+H3V/iFkQN5+l9IbV2kSNUBnOy1UI=;
        b=HsVvWAc2Ifmf6RsCmPO5zm6NWBhLf9Qkfjm9X9XHokeHseqKVrKkQQIksCxYuyPnyV
         ODoRdN4i+W5JrupSIMXUuKhNXmAHJDs8vnf22B/yN9Wvyp8m+TqPZJBaOTE3ihQqmMAz
         oThiEyPZAwb4sBnBjkK/iOfSolS5WOlxrSqD/YyonKGR8V+6ODUlquNZREHT/YeB3VDL
         kXZJHEPw6/HClfjjFmi3jsNBO3atiLOzTmF/pN8G98j4CSGVyE6f0ZlHZYO2oBZo6cis
         wmAp/+pYId1kU3lT4mSR/WxxHNZMRGoO2K0neNEPOkW0a5y0+WWci/My9g0wfk2Y/JGi
         LnAw==
X-Gm-Message-State: APjAAAVG0RHP682YrXLJDS8/hv3lB8MWjnUXguZwkbdCB+AxDkH524hf
        O5sCV8a7z0SceBq1RNJs4JQ=
X-Google-Smtp-Source: APXvYqxW7P7en+wRYki2eFA2MoEP5YHfWNE4Ij8LuD0Wpo8YhC5AnGHvPb7Q0Fi1lhQEXF0jJJKoMQ==
X-Received: by 2002:a50:f4ef:: with SMTP id v44mr8015912edm.193.1554134104274;
        Mon, 01 Apr 2019 08:55:04 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g3sm1954910ejp.31.2019.04.01.08.55.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 08:55:03 -0700 (PDT)
Subject: Re: [RFC 1/4] net/ipv4/fib: Remove run-time check in tnode_alloc()
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-2-dima@arista.com>
 <5beb631cf0dcc03d5afad3a29671677bdbc7b931.camel@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <c82b92e9-9809-87d2-85dc-67044d4e7632@gmail.com>
Date:   Mon, 1 Apr 2019 16:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <5beb631cf0dcc03d5afad3a29671677bdbc7b931.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 4/1/19 4:40 PM, Alexander Duyck wrote:
>> @@ -333,8 +328,7 @@ static struct tnode *tnode_alloc(int bits)
>>  {
>>  	size_t size;
>>  
>> -	/* verify bits is within bounds */
>> -	if (bits > TNODE_VMALLOC_MAX)
>> +	if ((BITS_PER_LONG <= KEYLENGTH) && unlikely(bits >= BITS_PER_LONG))
>>  		return NULL;
>>  
>>  	/* determine size and verify it is non-zero and didn't overflow */
> 
> I think it would be better if we left TNODE_VMALLOC_MAX instead of
> replacing it with BITS_PER_LONG. This way we know that we are limited
> by the size of the node on 32b systems, and by the KEYLENGTH on 64b
> systems. The basic idea is to maintain the logic as to why we are doing
> it this way instead of just burying things by using built in constants
> that are close enough to work.
> 
> So for example I believe TNODE_VMALLOC_MAX is 31 on a 32b system.

This is also true after the change: bits == 31 will *not* return.

> The
> main reason for that is because we have to subtract the TNODE_SIZE from
> the upper limit for size. By replacing TNODE_VMALLOC_MAX with
> BITS_PER_LONG that becomes abstracted away and it becomes more likely
> that somebody will mishandle it later.

So, I wanted to remove run-time check here on x86_64..
I could do it by adding !CONFIG_64BIT around the check.

But, I thought about the value of the check:
I believe it's here not to limit maximum allocated size:
kzalloc()/vzalloc() will fail and we should be fine with that.

In my opinion it's rather to check that (1UL << bits) wouldn't result in UB.


Thanks,
          Dmitry
