Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60673ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397F0217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="fvMKJxrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfJOG3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:29:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35404 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfJOG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:29:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so11808430pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=EVslka8YIIComg0Mb0g4qEN93Z7Bcof6eewif1bv3wA=;
        b=fvMKJxrKgp9CYweCSx4MbPgFiuWurTltPjobUhlnzb8Cmkn10UhyDvibnvLfhdCaPZ
         iAcFBr/ToDPczF6SCfKJW4c8wPd2bWUyqCWkL1mx5drZ4hYuVcGff1H76UgQlLjMw/Fk
         yNZnuw4mvgPV/E9nzi6lE81E6UMI/dcXYr0qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EVslka8YIIComg0Mb0g4qEN93Z7Bcof6eewif1bv3wA=;
        b=L0C86Ihems/XHN/ZzRwiJI8AK7DjTDotwaFUKs2RWECxA/2VySxoGJ5eh49kxv7+CB
         1Imwch3hjUiHD6Fx3AuBOZnQz0Ogb6t/HOEywCsOk5i+Zid0cFiKR1P9pQIPpk5TdsmA
         mo5aZBObZPasxsjeG875ZiJyVV0X9W2hpluhYo42yUVrPwntWDB+qKo+u2+sTmfphYh5
         g5KKsBTp7ZA5+OM7YLLqD5ZdabUtrIO2gfyZmHXpxb6+zwkyAmnOsFl2KMyDrLyHLMTh
         SGzdQNTjYomcxVy9b5qj6bxQ/T+NdGJK51K/FcrR7ooxs2QqRZMdZThr//zCKQ5Ru6h2
         m1Ig==
X-Gm-Message-State: APjAAAUPSGqmZBdnBVvhK+WICPZ9OElm1yD9vgH5uehoqY4ycEzUAeUp
        82iOAEztT2gHAxER9+vw/d3Ucg==
X-Google-Smtp-Source: APXvYqzYXrgvkLqJx+T8uaM5IYuUGK7SLiyvcJPx/6JLaQ1UBHy/P4sYrgAY4hiObjyQROeFg8fEOg==
X-Received: by 2002:a17:90a:9201:: with SMTP id m1mr41063558pjo.42.1571120984449;
        Mon, 14 Oct 2019 23:29:44 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id s191sm14125845pgc.94.2019.10.14.23.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 23:29:43 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com> <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
Date:   Tue, 15 Oct 2019 17:29:40 +1100
Message-ID: <878spmttbf.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> @@ -2497,6 +2533,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>>  	if (!addr)
>>>  		return NULL;
>>>  
>>> +	if (kasan_populate_vmalloc(real_size, area))
>>> +		return NULL;
>>> +
>>
>> KASAN itself uses __vmalloc_node_range() to allocate and map shadow in memory online callback.
>> So we should either skip non-vmalloc and non-module addresses here or teach kasan's memory online/offline
>> callbacks to not use __vmalloc_node_range() (do something similar to kasan_populate_vmalloc() perhaps?). 
>
> Ah, right you are. I haven't been testing that.
>
> I am a bit nervous about further restricting kasan_populate_vmalloc: I
> seem to remember having problems with code using the vmalloc family of
> functions to map memory that doesn't lie within vmalloc space but which
> still has instrumented accesses.

I was wrong or remembering early implementation bugs.

If the memory we're allocating in __vmalloc_node_range falls outside of
vmalloc and module space, it shouldn't be getting shadow mapped for it
by kasan_populate_vmalloc. For v9, I've guarded the call with
is_vmalloc_or_module. It seems to work fine when tested with hotplugged
memory.

Thanks again.

Regards,
Daniel

> On the other hand, I'm not keen on rewriting any of the memory
> on/offline code if I can avoid it!
>
> I'll have a look and get back you as soon as I can.
>
> Thanks for catching this.
>
> Kind regards,
> Daniel
>
>>
>> -- 
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/352cb4fa-2e57-7e3b-23af-898e113bbe22%40virtuozzo.com.
