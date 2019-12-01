Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE3DC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FC20715
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="jwOVcGbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLATG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 14:06:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43622 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfLATG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 14:06:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id q28so11456414qkn.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYJMRHaiXc+sf5WEZ2y2GPKTcfT0mAf/egNeoJkGqUk=;
        b=jwOVcGbncaHcFffRkMA7LE9/UEhFUaIT8HSLGGQg6lzBye14j5BgANn42w4XkkyUfV
         ZOeYTUI0Dd3YuYKHFmy8XJ288eAiat5tF1T/Annsj7YQszO0ng4s3PnYNlcc6EvK8Mst
         nsUxYHAo+BA5vFB6wpkDCkxk7TWJ8NevfsWgUFUPHAht5Wo6CiF4uhiBp8edAwy1OiuX
         S1Jd1DrmUKk4BtedkskZETWYwSznYKzddZWM91onELxBhwwxx64JfrvTFsVTo8CLYBUB
         zeMcq1mqFwHppbPvN09508FJp8LjKrr8nCXj4xoCiyXtevuoR+S4h+dA+WQi+mdQEGob
         fBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MYJMRHaiXc+sf5WEZ2y2GPKTcfT0mAf/egNeoJkGqUk=;
        b=pDq8V3QGvt1DfnfQmBfa8YmeE8efbMpQH2H+BwEv1ZuxuunXjZPLJZ+FcAOWb5u3J8
         pwMvf2R8894N+tfU0iFSUUc4RY0qEK89BWN1tapBg68yS3wffnKaQxoN6gmF/lFzNIn+
         MWlRAAPQtp7NOVXnMnHTkxXt2y3xtYFocF/6GHGR+oUME1TZCXM91VlN6jc3Ru6s43ti
         t/fYTLmLXMNyST1yZk4sRZZ5/9+CI1Xo0PrO28QpYMqo61HYW4SlknJxy61ANhbjmreR
         eIp3+oFo7lUUHDr0I5iccjxSyR1wJjcKR86khVFpCj5fZLtQ3aurYKjB9qAl066fL9oG
         kItg==
X-Gm-Message-State: APjAAAVzNGChMt1MOKOA615Y7OmBDImdd7iVMgTplPQhjNjG5VJ2TZ/K
        MvA+h/XRU1R5VApemDBKKkktpg==
X-Google-Smtp-Source: APXvYqxQytCbo+98XXQij13g03gGpSRogXBmEDaQ9V4RHLtJy49OLvXxEnE89dRmw7RtqJlp/u3SRg==
X-Received: by 2002:a05:620a:16a4:: with SMTP id s4mr5994651qkj.488.1575227185774;
        Sun, 01 Dec 2019 11:06:25 -0800 (PST)
Received: from independence.bos.jonmasters.org (24-148-33-89.s2391.c3-0.grn-cbr1.chi-grn.il.cable.rcncustomer.com. [24.148.33.89])
        by smtp.gmail.com with ESMTPSA id k123sm6414644qkd.4.2019.12.01.11.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2019 11:06:25 -0800 (PST)
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
To:     Will Deacon <will@kernel.org>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "maeda.naoaki@fujitsu.com" <maeda.naoaki@fujitsu.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "tokamoto@jp.fujitsu.com" <tokamoto@jp.fujitsu.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <93009dbd-b31c-7364-86d2-21f0fac36676@jp.fujitsu.com>
 <20191101172851.GC3983@willie-the-truck>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <a06ae400-29b2-d88f-af48-deafd7e355fe@jonmasters.org>
Date:   Sun, 1 Dec 2019 11:02:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191101172851.GC3983@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/19 1:28 PM, Will Deacon wrote:

> On Fri, Nov 01, 2019 at 09:56:05AM +0000, qi.fuli@fujitsu.com wrote:

>> In this thread, I explained that:
>> * I found a performance problem which is caused by TLBI-is instruction.
>> * The problem occurs like this:
>>    1) On a core, OS tries to flush TLB using TLBI-is instruction
>>    2) TLBI-is instruction causes a broadcast to all other cores, and
>>    each core received hard-wired signal
>>    3) Each core check if there are TLB entries which have the specified
>> ASID/VA

(the above confuses implementation with architecture)

<snip>

> I think it's worth bearing in mind that I have little sympathy for the
> problem that you are seeing. As far as I can tell, you've done the
> following:
> 
>    1. You designed a CPU micro-architecture that stalls whenever it receives
>       a TLB invalidation request.

s/SPARC/Arm/ && wire in DVM

>    2. You integrated said CPU design into a system where broadcast TLB
>       invalidation is not filtered and therefore stalls every CPU every
>       time that /any/ TLB invalidation is broadcast.
> 
>    3. You deployed a mixture of Linux and jitter-sensitive software on
>       this system, and now you're failing to meet your performance
>       requirements.
> 
> Have I got that right?
> 
> If so, given that your CPU design isn't widely available, nobody else
> appears to have made this mistake and jitter hasn't been reported as an
> issue for any other systems, it's very unlikely that we're going to make
> invasive upstream kernel changes to support you. I'm sorry, but all I can
> suggest is that you check that your micro-architecture and performance
> requirements are aligned with the design of Linux *before* building another
> machine like this in future.
> 
> I hate to be blunt, but I also don't want to waste your time.

I always tried to ask nicely for the above to be heeded. There's a 
difference between "hi, our implementation doesn't scale, and here's 
why" vs "there's a problem with all TLBIs...". There isn't. The problem 
is the implementation and that should have been called out first thing.

Jon.

-- 
Computer Architect
