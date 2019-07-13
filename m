Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C63C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99890205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GBKoJIbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfGMVxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 17:53:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46826 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfGMVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 17:53:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so6413645plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7knXnl2++CFgl1JI0y7AdoYd0cxeaaz3u9LcN6Nzc0=;
        b=GBKoJIbDYL40ytBfLjjdyrhV6Xa17aiOXF67nY5wZGnfJ36o0brcuBzdRHb48joauj
         hsoENFwjmNy9W5NUlp7Bzljv5zQ3xRVgF9erHRUUoVJvvPELOK3qW0Q2BYNVWFs7b43i
         nQz5V2q7t/+u4b15AqHufZ3QrZOfJwX3PY47fYbuq+bmJz2LJGIJW0cGX0lDX5f5WJ1f
         +TCsGPV/gnprSXVI/j2ybfZgZm5cEhBxITQUHigpN8bq29ww8d0yoCPXOfpANPUmHbFZ
         egb699NxOku++AH5+aKv66wZ2F1+reJwKuByTEsNWV1KrFNZKeRjEggiF6SuHRhYj+ne
         o3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7knXnl2++CFgl1JI0y7AdoYd0cxeaaz3u9LcN6Nzc0=;
        b=pcu8eQsYoWn141usd7BzSr6ZRhf2RpqFojEOaQ2knTvlS+OMNO/pTBX5y4Kciir3Gr
         LVMrhFbYREsa3rK8wdQmyLLhXcj3Wrk8rt+z3/IidqRwvVh2+rBeTubfuFECWYRV0IyM
         f1xPekxmi8nZsj99WRrbqg3Vnzg6V56842BBC44nIonRq6ti6p+d62fXVQyi1vgQ3gz0
         Y7ZRPddbYdQH3HKsCEkul8khJ6NtndhIfFEUhjkZ4A8HJ/ZFY/2sSRYlJKqaVRscj4Kv
         CbuBX7u0lyP8Jd2yfXGNbAB4h/QrxlMnHEbQbAoffsVMRmXr7xvmuk3OtyXNTjruDINl
         Zi8w==
X-Gm-Message-State: APjAAAXodvQx6X7nwnxIqCfA9vk557UFqx3JbvKDhNOxdC1ibQwIh2UV
        AioKY8QDAZBMcTFbJ/Jt8v0=
X-Google-Smtp-Source: APXvYqx02JUB1gQ7VYbzSEBNpDUTlbVYzD3L8YrvaiHHDUeAEyQQnYdrydPsxOKGRUV4Lyy9Gx0vDA==
X-Received: by 2002:a17:902:8547:: with SMTP id d7mr20064189plo.171.1563054811664;
        Sat, 13 Jul 2019 14:53:31 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id d14sm17326936pfo.154.2019.07.13.14.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 14:53:30 -0700 (PDT)
Subject: Re: [PATCH] block: elevator.c: Check elevator kernel argument again
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190713035221.31508-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75c5681a-389f-cfaf-7f3f-31a2daec9da4@kernel.dk>
Date:   Sat, 13 Jul 2019 15:53:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713035221.31508-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 9:52 PM, Marcos Paulo de Souza wrote:
> Since the inclusion of blk-mq, elevator= kernel argument was not being
> considered anymore, making it impossible to specify a specific elevator
> at boot time as it was used before.
> 
> This is done by checking chosen_elevator global variable, which is
> populated once elevator= kernel argument is passed. Without this patch,
> mq-deadline is the only elevator that is can be used at boot time.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
> 
>   I found this issue while inspecting why noop scheduler was gone, and
>   so I found that was now impossible to use a scheduler different from
>   mq-deadeline.
> 
>   Am I missing something? Is this a desirable behavior?

Just google, I'm sure 2-3 discussions on this topic will come up.

tldr is that the original parameter was a mistake and doesn't work at
all for multiple devices. Today it's even worse, as we have device
types that won't even work properly with any scheduler, liked the
zoned devices. The parameter was never enabled for blk-mq because of
that, and hence died when the legacy IO path was scrapped. It's not
coming back.

-- 
Jens Axboe

