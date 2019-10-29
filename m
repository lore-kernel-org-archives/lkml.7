Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D278CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C0C21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GzRBZMkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfJ2VLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:11:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42983 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ2VLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:11:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so2932480wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jzc5SphXTBrdUOnsHcsz6Kv2zKhcckogB+EMxfSC+W4=;
        b=GzRBZMknZ6PJjqjSg7LcletNje7HHjxj2/Py6Vgos74AI/KzFBUTImuNepZmauCZxp
         xW9pq09rGBWK5BFK4Lbsy/PHbnCyKiNI+z3dC5Xh1hPQxChHD8YO/kd7p1RYrjoiLLQi
         x/or0KdFUGqKLXyadfMjgS/sUeKYoEVgYJ/2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jzc5SphXTBrdUOnsHcsz6Kv2zKhcckogB+EMxfSC+W4=;
        b=W3UAJqJlx4/2A6AaCWMMASLW42DbM0QSbKl4WxX3ItTUoYPodDvA2dPIx9dIzS2q3p
         3hmEzkaBPl7ngaa6MfgU0l5z6XML8UWk6Q9n5VrG1D7A7YP1qfE53+ZXGz2QDOJQCXAg
         6aNp42RVteyjyse2ArOSbcUDa78PypjE7FtbFouKmGsi9jXnMIcqyogZ9Y49LjfzysuP
         o/Tmu/I+HuKszOv9kP/WM+sRqHAUJnySLhWHTxCdPQazWfsS9439VxFKsSmJykU0BRYP
         GfHui0YSwK7Dpk62CgALa7kPW2CgXozD2KTkHW7BfC+iGszz2T9BZwB9tf4mVfw1LTjL
         yWZg==
X-Gm-Message-State: APjAAAUSpAkr2a9YLqHIHLHSGCRxMkczvrR8uzM4UGbmt+TM3h003kxx
        wsQiOqFvhIM/7GXJLSOranF7F42G34idxUkd
X-Google-Smtp-Source: APXvYqywIRKIxrTc5gINIOm/p9vuLkFieHMMNMHKw0+1nObWCoreZtWPnevND5QedwZIF87dCvk6eA==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr22618873wrx.105.1572383507160;
        Tue, 29 Oct 2019 14:11:47 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id l26sm4251157wmg.3.2019.10.29.14.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 14:11:46 -0700 (PDT)
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a2e6bdc2-3d35-a3dc-13ef-1ce32f77ef17@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 22:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029191925.GA19316@linux-8ccs>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 20.19, Jessica Yu wrote:
> +++ Rasmus Villemoes [27/09/19 13:07 +0200]:
>> On 27/09/2019 11.36, Masahiro Yamada wrote:
>>>
>>> A typical kernel configuration has 10K exported symbols, so it
>>> increases 10KB in rough estimation.
>>>
>>> I did not come up with a good idea to refactor it without increasing
>>> the code size.
>>
>> Can't we put the "aMS" flags on the __ksymtab_strings section? That
>> would make the empty strings free, and would also deduplicate the
>> USB_STORAGE string. And while almost per definition we don't have exact
>> duplicates among the names of exported symbols, we might have both a foo
>> and __foo, so that could save even more.
>>
>> I don't know if we have it already, but we'd need each arch to tell us
>> what symbol to use for @ in @progbits (e.g. % for arm). It seems most
>> are fine with @, so maybe a generic version could be
>>
>> #ifndef ARCH_SECTION_TYPE_CHAR
>> #define ARCH_SECTION_TYPE_CHAR "@"
>> #endif
>>
>> and then it would be
>> section("__ksymtab_strings,\"aMS\","ARCH_SECTION_TYPE_CHAR"progbits,1")
> 
> FWIW, I've just tinkered with this, and unfortunately the strings
> don't get deduplicated for kernel modules :-(
> 
> Apparently ld does not do the deduplication for SHF_MERGE|SHF_STRINGS
> sections for relocatable files (ld -r), which kernel modules are. See:
> 
>    https://sourceware.org/ml/binutils/2009-07/msg00291.html

I know <https://patches-gcc.linaro.org/patch/5858/> :)

> But, the strings do get deduplicated for vmlinux. Not sure if we can
> find a workaround for modules or if the benefit is significant enough
> if it only for vmlinux.

I think it's definitely worth if, even if it "only" benefits vmlinux for
now. And I still hope to revisit the --force-section-merge some day, but
it's very far down my priority list.

Rasmus


