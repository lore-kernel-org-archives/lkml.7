Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D549C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50012082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix2ApAcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfC0Vpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:45:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40658 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC0Vpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:45:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id u68so12489208lff.7;
        Wed, 27 Mar 2019 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ePXw1ur8TPL83zNRUeR6bNl13zLm/leF/RlfHF1Gnng=;
        b=ix2ApAcXYtdb7DB6Vym29a7FVcEwPT2S18LPNDA6FZBW74XIoEnzflln9qWJHbDzkJ
         EfMh6sDLryj/iseF4aAr9K9+fEpTwcm8LxZ2j4+0YYGgP0vlpkiNggo9OBqJiJdpgsJT
         wwL7rTnpztM+vpULxI6WGnbOH44cGb0XGN5ecHblXwkB3h7PMRQDTsd7+pFdnrnQSskY
         xcyrySRnjsepL051RJM3WGhbuD1cdiAFnPvQjQTFPi4OP6Cvnfcb3wFG0K96OGYetUgr
         vfULE1se1yxuHxcYOLy/y5C/uVvLRgWtZh7gxhlQremyOwQ8vmDq2YIg7GLS9EGDbPyU
         I9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ePXw1ur8TPL83zNRUeR6bNl13zLm/leF/RlfHF1Gnng=;
        b=Z+IfyzMvuSwFKwCkBdYunZV5r6wQeayORrO4Eoomwdwkk63OgRg7vjSl9xOgWZUFLx
         /dSYT+zr0vgfgx9HP6XfaqJGjoPuAaoqEHKCcnOTbackwd8qbS6BZKcL/5Njetnzb9Gh
         8R9d0vZwDfUYwl0aI/J1mDW8Sukj8sY1xbU6WOAr1AYia/McbBTXyZGcOGz6NEdLt6tp
         2jS7/G5oK+xDopRQl24KW0TKgT93kLkQLpNx97DNzra9YmrdU+v1+JUzFCVL/cnYLsL9
         KnGr+JgT+YNBkuGnMZeEwMpUfTlwGeEoC6AZmXvQbVPXQhf1+W4XdCR568y4XdRb50f6
         /Jlg==
X-Gm-Message-State: APjAAAVmHr8jkA4LBWIKmuGeRCdKFk6kuhULdeWZIpxsmdoeG9ONrCLH
        oEzX6/tSbhYgdL9UHd0JYqRL8i19
X-Google-Smtp-Source: APXvYqwzDKtm1gQTtWJ9Tb/K0vHiDqRpXiNgITlhwwOIzQn1Mf3FVrkh/tSVkLiDLDykDMeh84ynKg==
X-Received: by 2002:ac2:5471:: with SMTP id e17mr19800820lfn.87.1553723135640;
        Wed, 27 Mar 2019 14:45:35 -0700 (PDT)
Received: from [192.168.1.19] (ckh73.neoplus.adsl.tpnet.pl. [83.31.83.73])
        by smtp.gmail.com with ESMTPSA id q5sm4766647lfm.16.2019.03.27.14.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 14:45:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] leds: netdev trigger: use memcpy in
 device_name_store
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-2-linux@rasmusvillemoes.dk>
 <987c3e60-edb3-44f0-be28-434c70bb8659@gmail.com>
 <d1fccd75-c48b-d585-1170-1c1b76e1e098@rasmusvillemoes.dk>
 <21193aab-7880-d116-64e8-dd08afe5a47f@gmail.com>
 <5871d2bd-1a9d-9cf0-e8bd-6d691ea94415@rasmusvillemoes.dk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <0cfbe06c-8d5b-5e94-21d9-15cf7b3ed022@gmail.com>
Date:   Wed, 27 Mar 2019 22:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5871d2bd-1a9d-9cf0-e8bd-6d691ea94415@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 10:31 PM, Rasmus Villemoes wrote:
> On 27/03/2019 22.20, Jacek Anaszewski wrote:
> 
>> Thanks for the heads-up. I must admit I'm hitting into that for the
>> first time. After "git am" it was all OK, but it got screwed up after
>> "git rebase -i". And having "commit.cleanup = scissors" set globally all
>> the time is annoying if one extensively uses interactive rebase for
>> rewording commit messages. It entails the need for manual removal of
>> the whole stuff that appears then after actual commit message prepended
>> with "#" comment characters.
> 
> Eh, no? At least, whenever I do commit or rebase -i, git automatically
> inserts a trailer starting with the magic scissor line
> 
> # ------------------------ >8 ------------------------
> # Do not modify or remove the line above.
> # Everything below it will be ignored.
> 
> Maybe there's some other config option to get that, or it depends on git
> version. But I certainly don't do anything at all other than write or
> modify the commit message.

I don't have this "#-- >8 --" line. Will have to find out the reason.
I'm using git version 2.11.0 btw.

> Never had a problem myself since I set commit.cleanup = scissors, but I
> have had lots of my commit messages mangled, which is why I'm reacting.
> 
>> This is probably the reason why people use often other characters
>> for command prompt (see the other fix for ledtrig-netdev).
> 
> Command prompt char is not the only problem; C snippets with #include or
> other preprocessor directives also regularly gets mangled, as does shell
> snippets with a bit of commentary.

True. I certainly will have to get my git config fixed.

-- 
Best regards,
Jacek Anaszewski
