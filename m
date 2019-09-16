Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE315C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760C62067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPzZpDPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfIPOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:01:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfIPOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:01:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so38985318wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zTxJha4DJ6sGbvkhtuP/UdXYSv6JinPmcqOY2Z8QttE=;
        b=CPzZpDPBDwSaGqjpbEVxNq6zdFADTMF3m2iy8eZ3L6P3umUVSYFuFJz68fiNfLrAHL
         UeqDF8CPC3CWa8xF08czQHvJbc+i1W8fJ7hvF2GOlwkQdO9iF50USN4G22gKbn7oySqo
         49qpq0Zj2VYpojpTOc5YrC84tf4igmCz4OZXo3O3ruhKPfvMYcw08rWrL0Z88TWbO3Yq
         3jRizo8S5JUS5f86tTpfu1BzPiStE01VUCrr0tbY6mRfz74wHbSWkB7n1dyTvB8F6cKu
         nVwUGI+whM2RXMiruyARED/s76SDXDfuUojK54Svruo2BfnBxSpvnlRtujzQU3xU4pIN
         woYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zTxJha4DJ6sGbvkhtuP/UdXYSv6JinPmcqOY2Z8QttE=;
        b=c9buLwZ9eajsfMkDXBQGGeVlLlL29hxE9Buo1JyOQfwZudXnzBugtt8mVo44a3b6p7
         n2i2LptnvqiCy8wxkLLtybSR239V0ooF0lfsBKKK3hhPtbR2IZq8TYcrxwCk8UzQlTKa
         /Fa4CMO6xxRxTOQiXsGLk+uMp693t2xGbo2xUYV8wULg8LlaU7Z2JiKjsVzuYsiBq+PL
         wSeqibQADRS7kEY4E7MwTGHKY1AC4yW2LzniMlSK3RJq2oF0iyB1x0L92ptQd+5dcBM4
         PHvs1nkrIZuQ0nUxCHsjY2GQk++ODz2bt5BoHA5uH9kN24NQFaPh8S7+og2GsDVbGDb7
         ZBEg==
X-Gm-Message-State: APjAAAURYbxFHEUgJZQVjKvq8ZQIqtBhTYgRSb4UWWYRYP6vg090HWfv
        eVFg4Uku6gRBv9PWsM0QZw4gVYaFBimepg==
X-Google-Smtp-Source: APXvYqxYL8KP+1GSLPJas/EcVxkDY7EtP7mAp63QqZxDyGun8ZnywEYsx+UvVeFARPUwtQevsZF/hQ==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr8340750wrj.22.1568642500627;
        Mon, 16 Sep 2019 07:01:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0c1:1609::e5b? ([2620:10d:c092:200::1:39bf])
        by smtp.gmail.com with ESMTPSA id h26sm31263575wrc.13.2019.09.16.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:01:39 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [Openipmi-developer] [PATCH 0/1] Fix race in ipmi timer cleanup
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
 <20190828223238.GB3294@t560> <15517bfc-3022-509d-15ea-c2b8e7a91e0a@gmail.com>
 <20190829181536.GC3294@t560> <20190915010852.GG13407@t560>
Openpgp: preference=signencrypt
Autocrypt: addr=Jes.Sorensen@gmail.com; keydata=
 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 WQ==
Message-ID: <d93bbba3-16e0-7c68-2fec-fde840bd7072@gmail.com>
Date:   Mon, 16 Sep 2019 10:01:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915010852.GG13407@t560>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/19 9:08 PM, Corey Minyard wrote:
>>
>>>
>>> {disable,enable}_si_irq() themselves are racy:
>>>
>>> static inline bool disable_si_irq(struct smi_info *smi_info)
>>> {
>>>         if ((smi_info->io.irq) && (!smi_info->interrupt_disabled)) {
>>>                 smi_info->interrupt_disabled = true;
>>>
>>> Basically interrupt_disabled need to be atomic here to have any value,
>>> unless you ensure to have a spin lock around every access to it.
>>
>> It needs to be atomic, yes, but I think just adding the spinlock like
>> I suggested will work.  You are right, the check for timer_running is
>> not necessary here, and I'm fine with removing it, but there are other
>> issues with interrupt_disabled (as you said) and with memory ordering
>> in the timer case.  So even if you remove the timer running check, the
>> lock is still required here.
> 
> It turns out you were right, all that really needs to be done is the
> del_timer_sync().  I've added your patch to my queue.
> 
> Sorry for the trouble.

Awesome!

Sorry I was going to get back and look at it again, but Linux Plumbers
and playing sardine i a tin can got in the way.

Cheers,
Jes

