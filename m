Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83228C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505DB21835
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu5Yi3Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgADA1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:27:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36324 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADA1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:27:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so32914215lfe.3;
        Fri, 03 Jan 2020 16:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWkELf4CBgeAYNIurRlueebcxpdZ5jZGPBfBd+vxH7I=;
        b=Nu5Yi3JpH5JV3WI56GXPVEyXKneEuNmA9KVFQnmADeJt4zG1tBp+QKGsQJ1a0epyfK
         mxkPpMLFK8dr15W0UpKBznsZaNh2OLgxEniIhlEvgiSWiYLgT286L0vN2Qs5hXQnlydS
         uSQmC0ayM4PDvR/QiCySjLh28MupY9iMVTwyA1ZqNnTr8lOhLk1+8GfumFhrAfGtCSzQ
         P/ixvPFk6SfBhSjqyv1PWPd/DVD6QProAGr982yyJC285Wo4sT5xF3eDw0c3YHLpj6OD
         /mdus/Wl+FnrZ7TFkf4drVrj8fmr+B8sgxz6KNugnSmiGNc4RvosM0m+SVPxuGSesIrb
         boVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWkELf4CBgeAYNIurRlueebcxpdZ5jZGPBfBd+vxH7I=;
        b=bTXX6ltIpYS/jGywrmBPFsQw7Nch0lE0mc855NMHKNPskuQ3cAVAjMgr/gwwi0oKSn
         XmDxQ0r2m+px7d1RyYk7kWgnxgZPFDytAT+CUJ3EMn7XknAE7k4hwZTDV61UM334+voc
         fPhXDi7S0peaKKG9zD51GWbK6L2bXriJOpiOAgL/4HLhpN0vNDB8IDfmFVo+8KytNp+8
         VSyFS4JRBEiyGGR1popi2zbh3/aKyDGvKOTfJAvuVxFACcCRQNbJIwI/sBNdAX0NAHNj
         xu0smUDNjIlkPsk46ER62Uol08W4euKJ7bt1kfsNI3WbTwnNcEt6d6HqnYbYo9Gkgbh+
         nIfA==
X-Gm-Message-State: APjAAAUpYZeekJhXxs2quvnaM/GxRKScNfZcllJ3iKFHXLGk29AyevRG
        DgETRl8ENTEMnD/710fs8VbuITiF
X-Google-Smtp-Source: APXvYqwQMOg4LAL9u2e6ktspztd+rveqntwhZF+XxZ9TeJSAzLKV4Lk3W8gY0012Vx8I4bR2Cn2emQ==
X-Received: by 2002:ac2:4adc:: with SMTP id m28mr49831242lfp.26.1578097639050;
        Fri, 03 Jan 2020 16:27:19 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d25sm25340043ljj.51.2020.01.03.16.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 16:27:18 -0800 (PST)
Subject: Re: [PATCH v1 3/7] dmaengine: tegra-apb: Prevent race conditions on
 channel's freeing
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191228204640.25163-1-digetx@gmail.com>
 <20191228204640.25163-4-digetx@gmail.com>
 <20191230204555.GB24135@qmqm.qmqm.pl> <20191230205054.GC24135@qmqm.qmqm.pl>
 <4e1e4fef-f75c-f2e2-4d9e-29af69daf8db@gmail.com>
 <20200103081604.GD14228@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0d76d93d-a465-646b-8dfa-7b42d3f597f6@gmail.com>
Date:   Sat, 4 Jan 2020 03:27:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200103081604.GD14228@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.01.2020 11:16, Michał Mirosław пишет:
> On Thu, Jan 02, 2020 at 06:09:45PM +0300, Dmitry Osipenko wrote:
>> 30.12.2019 23:50, Michał Mirosław пишет:
>>> On Mon, Dec 30, 2019 at 09:45:55PM +0100, Michał Mirosław wrote:
>>>> On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
>>>>> It's unsafe to check the channel's "busy" state without taking a lock,
>>>>> it is also unsafe to assume that tasklet isn't in-fly.
>>>>
>>>> 'in-flight'. Also, the patch seems to have two independent bug-fixes
>>>> in it. Second one doesn't look right, at least not without an explanation.
>>>>
>>>> First:
>>>>
>>>>> -	if (tdc->busy)
>>>>> -		tegra_dma_terminate_all(dc);
>>>>> +	tegra_dma_terminate_all(dc);
>>>>
>>>> Second:
>>>>
>>>>> +	tasklet_kill(&tdc->tasklet);
>>>
>>> BTW, maybe you can convert the code to threaded interrupt handler and
>>> just get rid of the tasklet instead of fixing it?
>>
>> This shouldn't bring much benefit because the the code's logic won't be
>> changed since we will still have to use the threaded ISR part as the
>> bottom-half and then IRQ API doesn't provide a nice way to synchronize
>> interrupt's execution, while tasklet_kill() is a nice way to sync it.
> 
> What about synchronize_irq()?

Good point! I totally forgot about it.

The only difference between tasklet and threaded ISR should be that
hardware interrupt is masked during of the threaded ISR execution, but
at quick glance it shouldn't be a problem.

BTW, I'm now thinking that the current code is wrong by accumulating
callbacks count in ISR if callback's execution takes too much time, not
sure that it's something what DMA clients expect to happen, will try to
verify that.

It also will be nice to get rid of the free list since it only
complicates code without any real benefits, I actually checked that
kmalloc doesn't introduce any noticeable latency at all.

I'll probably defer the above changes for now, leaving them for 5.7,
otherwise it could be a bit too many changes for this patchset
(hopefully it will get into 5.6).

> BTW, does tegra_dma_terminate_all() prevent further interrupts that might
> cause the tasklet to be scheduled again?

Yes, it should prevent further interrupts because it stops hardware and
clears interrupt status, thus in a worst case ISR could emit "Interrupt
already served status" message.
