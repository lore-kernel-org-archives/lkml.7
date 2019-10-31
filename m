Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B0CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4462087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dqdqSuKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJaLDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:03:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40324 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfJaLDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:03:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id f4so4277063lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cj0fZ1R7bow/E6sb1SfZRa4gs2EtWB03pvxa6+qHUK8=;
        b=dqdqSuKjLKJupXMsYqnIkO1byz1R2VPjNfRgdKC5/iBjSqgJMi0aXJc6nnzSklLS/H
         oxVpvpgRutQfeJDDnlZx5gzdO1YeIqi/acL+E2OBE0J6lxFHpMBTq3coHmxxG1G7rbcP
         1kAvIVwwGOc6bGqFp4rHFhsJZGq0rWe7nwtfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cj0fZ1R7bow/E6sb1SfZRa4gs2EtWB03pvxa6+qHUK8=;
        b=mw/wg12NE7Umkzuqhq9T5RZmX1SYSYjxRg6iqlHKGWlqnSmMEAqzLNEOY5Z36GwWl5
         bMwhxQmmDsthwGBtLAPJ7vfdmC7MEkJI8reCa8p9707TRfcQPwgtO49ATnWEzRWx5DTP
         XDa/NV2sRBnCla2miyz/9zJpSKuQgrx6DrWepwOCqeSxxxovLA2k9b3SiHzKLgaPf4ld
         07xV7Vto/5ubzvBWIJGlp6+0HppIJemvIYPGUayPWBEccsBYkPtoYUxCgabJ2/xT1bSG
         dBpJS+JJV6tK1a0H34Dw5ihBhVW++Sw7u9CMdBCqlwCeDv4QgxAseYRICtdEwIrVpzWR
         KDmg==
X-Gm-Message-State: APjAAAW09Vqmn55XET0ElTSzvWkxlxtrWbOLolkCH3Cai/E/CgcWJpWy
        os4UEfTrnGxf34ZN4eqno3JpAdMFtFHqW5EoT0o=
X-Google-Smtp-Source: APXvYqy/Z6pm7vW1gWzS+NW62+bF3K1YVujaNNsce0yelSOeWYdn0RYEhmDQJkv/ZwiyW04VEVUW2A==
X-Received: by 2002:a19:4b4f:: with SMTP id y76mr3105515lfa.102.1572519832508;
        Thu, 31 Oct 2019 04:03:52 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a18sm1683843lfi.15.2019.10.31.04.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 04:03:51 -0700 (PDT)
Subject: Re: [PATCH 4/7] module: avoid code duplication in
 include/linux/export.h
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-5-yamada.masahiro@socionext.com>
 <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
 <20191029191925.GA19316@linux-8ccs>
 <a2e6bdc2-3d35-a3dc-13ef-1ce32f77ef17@rasmusvillemoes.dk>
 <20191031101306.GA2177@linux-8ccs>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8eb4f2fd-f34f-606d-8e7d-4b6b6fb86edc@rasmusvillemoes.dk>
Date:   Thu, 31 Oct 2019 12:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031101306.GA2177@linux-8ccs>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2019 11.13, Jessica Yu wrote:
> +++ Rasmus Villemoes [29/10/19 22:11 +0100]:
>> On 29/10/2019 20.19, Jessica Yu wrote:

>>> Apparently ld does not do the deduplication for SHF_MERGE|SHF_STRINGS
>>> sections for relocatable files (ld -r), which kernel modules are. See:
>>>
>>>    https://sourceware.org/ml/binutils/2009-07/msg00291.html
>>
>> I know <https://patches-gcc.linaro.org/patch/5858/> :)
> 
> That is exactly what we need! :)
> 
>>> But, the strings do get deduplicated for vmlinux. Not sure if we can
>>> find a workaround for modules or if the benefit is significant enough
>>> if it only for vmlinux.
>>
>> I think it's definitely worth if, even if it "only" benefits vmlinux for
>> now. And I still hope to revisit the --force-section-merge some day, but
>> it's very far down my priority list.
> 
> Yeah, I think it's worth having too.
> 
> If you don't have any extra cycles at the moment, and it's far down
> your priority list, do you mind if I take a look and maybe try to push
> that patch of yours upstream again? 

Knock yourself out :) IIRC, it did actually work for the powerpc I was
targeting, but I don't remember if that was just "readelf/objdump
inspection of the ELF files looks reasonable" or if I actually tried
loading the modules. I've pushed the patch to
https://github.com/Villemoes/binutils-gdb/commit/107b9302858fc5fc1a1690f4a36e1f80808ab421
so you don't have to copy-paste from a browser.

I don't know how successful I'd
> be, but now since it's especially relevant for namespaces, it's
> definitely worth looking at again.

Yeah, but even ignoring namespaces, it would be nice to have format
strings etc. deduplicated. Please keep me cc'ed on any progress you make.

Thanks,
Rasmus
