Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2EDC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9420866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="hsQfGCh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFNIUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:20:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39751 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFNIUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:20:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so1107209lfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42M+YEzd5zf6PM/JEJP1Qt4hv7uQKTp1ClSVToSd+Vk=;
        b=hsQfGCh9Hj4vN30YEJGpXPlDYptqPkZ0oKEIO7cvEIIPkRT9bNjZ2mk8NII5j4mJ3s
         KjSoOOLGj6hRynkAMyAK1mD0PjoIy19ID9T8mhurGZdXnNY7SWNB7KZswegcCgVLHWvg
         UCzNutM5w7Mdc59O4abr4oRX3F8rDXArKU9e7Kqmf+mqjySAdMBUSSTbDsbNa0c6zxWW
         pcppHkVR48Dx9EHe42rR6Kb7Z8H2r2crcDQQWaMeuX1VS3M23c1e4Yx67Y/EHxvOt93z
         Oyuo6E4TauvXh7aEbP7IQgf6fLdlSfW0oaOlL+0Gnr9W8SKOjezVwG3HRmRdqluMlcMP
         VYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42M+YEzd5zf6PM/JEJP1Qt4hv7uQKTp1ClSVToSd+Vk=;
        b=RMrW75+zmWLG1fQFY5wSG68F5bemtsZ74SKwslsyc106l7duFS35JygBM/WKxNxkKo
         7T1gduu7Fuhtjn+8YXjlR8eyzC46xL5jzdjdgaLQmXpsx019yrUySv6Xev+R6PWNpFoD
         hv7YMv3tLHj34dmS4gJqtN7febQswkCdcy934lP+TFDe5k1g7qh6Xb0XNuXaOQ3qfXoD
         m6gWbyH+B7zTYXmkq2ILVty9ZH6wXHXPj9nW7csoXfgZUh6WnORgUSZxUF5uuBsbMOiI
         GLMq9tUE9tpVQPaT7YgwTYv63AXYXjH+lgNzp2mu5ZB2Jq/hPye/n4r1b5OTBGlQRNVC
         6skQ==
X-Gm-Message-State: APjAAAWPn0bU5uaRqiD5WZniuKD+tClqCSGrCKS7qQq4GiOmWaHt7gXs
        vfJrB4nijV1i4nxFyGcWykDa1g==
X-Google-Smtp-Source: APXvYqxL/mg5t9siFzHZqSM5diqpEzmbeHManaTNXSuvybmNR+W/nnnIF6zPLGTIJTLwt0nvF6mIgQ==
X-Received: by 2002:ac2:44a4:: with SMTP id c4mr46671553lfm.116.1560500430653;
        Fri, 14 Jun 2019 01:20:30 -0700 (PDT)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id w1sm495002ljm.81.2019.06.14.01.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 01:20:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] Address regression in inet6_validate_link_af
To:     Maxim Mikityanskiy <maximmi@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
References: <20190611100327.16551-1-jonas@norrbonn.se>
 <58ac6ec1-9255-0e51-981a-195c2b1ac380@mellanox.com>
 <833019dc-476f-f604-04a6-d77f9f86a5f4@norrbonn.se>
 <323df302-aa17-df40-846d-3354d4bb126a@mellanox.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <0dfcb2ad-0698-b005-b6a2-5d52ee00bf9a@norrbonn.se>
Date:   Fri, 14 Jun 2019 10:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <323df302-aa17-df40-846d-3354d4bb126a@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/2019 16:13, Maxim Mikityanskiy wrote:
> On 2019-06-13 09:45, Jonas Bonn wrote:
>> Hi Max,
>>
>> On 12/06/2019 12:42, Maxim Mikityanskiy wrote:
>>> On 2019-06-11 13:03, Jonas Bonn wrote:
>>>> Patch 7dc2bccab0ee37ac28096b8fcdc390a679a15841 introduces a regression
>>>> with systemd 241.  In that revision, systemd-networkd fails to pass the
>>>> required flags early enough.  This appears to be addressed in later
>>>> versions of systemd, but for users of version 241 where systemd-networkd
>>>> nonetheless worked with earlier kernels, the strict check introduced by
>>>> the patch causes a regression in behaviour.
>>>>
>>>> This patch converts the failure to supply the required flags from an
>>>> error into a warning.
>>> The purpose of my patch was to prevent a partial configuration update on
>>> invalid input. -EINVAL was returned both before and after my patch, the
>>> difference is that before my patch there was a partial update and a
>>> warning.
>>>
>>> Your patch basically makes mine pointless, because you revert the fix,
>>> and now we'll have the same partial update and two warnings.
>>
>> Unfortunately, yes...
> 
> So what you propose is a degradation.

Yes.  You're not going to get an argument out of me here... :)

> 
>>>
>>> One more thing is that after applying your patch on top of mine, the
>>> kernel won't return -EINVAL anymore on invalid input. Returning -EINVAL
>>> is what happened before my patch, and also after my patch.
>>
>> Yes, you're right, it would probably be better revert the entire patch
>> because the checks in set_link_af have been dropped on the assumption
>> that validate_link_af catches the badness.
> 
> We shouldn't introduce workarounds in the kernel for some temporary bugs
> in old userspace. A regression was introduced in systemd: it started
> sending invalid messages, didn't check the return code properly and
> relied on an undefined behavior. It was then fixed in systemd. If the
> kernel had all kinds of workarounds for all buggy software ever existed,
> it would be a complete mess. The software used the API in a wrong way,
> the expected behavior is failure, so it shouldn't expect anything else.
> For me, the trade-off between fixing the kernel behavior and supporting
> some old buggy software while keeping a UB in the kernel forever has an
> obvious resolution.

You're missing the point:  this is a regression in kernel behaviour. 
systemd v241 is a tagged release, included in downloadable releases of 
at least Yocto 2.7 and Fedora 30.  Irregardless of whether systemd's 
implementation is buggy or not, it's functionality depends on the 
(undefined but deterministic) behaviour of a released kernel and 
therefore you can't just change that behaviour.

Like I said, I can get past this, so I'm happy to pretend that I didn't 
discover this and just patch my own system.  Unfortunately, I suspect 
this isn't the last you'll hear about this.

/Jonas

>>
>> Anyway, for the record, the error is:
>>
>> systemd:  Could not bring up interface... (invalid parameter)
>>
>> And the solution is:  Linux >= 5.2 requires systemd != v241.
>>
>> If nobody else notices, that's good enough for me.
>>
>>>
>>> Please correct me if anything I say is wrong.
>>
>> Nothing wrong, but it's still a regression.
>>
>> /Jonas
>>
>>>
>>> Thanks,
>>> Max
>>>
