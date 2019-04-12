Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC51C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FE9218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAT8eQvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDLUux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:50:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDLUuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:50:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so13555846wrn.6;
        Fri, 12 Apr 2019 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tW9GdCvyqnjHimarB7/jbPgznkpeKfzM+bzEv7UppK4=;
        b=tAT8eQvrKZUEltzntxILyn7x+MOL0Wyxz3SRK4lwwjYdMWxs74+WhtorfC8mPYvI9c
         cZ7J7Y4stmQk36YcaSUetN5O2NVUtVViP8u1l7LwJeFup8Gc/rZGFWCIq5bht5EzQVk9
         EUh3XqX84c4WduK4sZ7kmTheMYXLJhwjLpqegSLg/1Y+c2aOx8FlLE+vWbjTgqKIWGkM
         GZzqN02P/jIGZWxL7n1q2foODIrQgglPvanqTs2OUIBIvViFyyPOQyRSTqRiJeDDCoSa
         qcCMVb6ogKzEM3sN3Z7Skq9IewbzhQ74g5YD4yH6OUBcG1h3nwgecmd9rg5MX8pt2pHG
         WvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tW9GdCvyqnjHimarB7/jbPgznkpeKfzM+bzEv7UppK4=;
        b=FVGKSGAdVrf1kM4vfjGSVXKM/S+XRY2DzUsgkYQGweh2sWqwfsOuVQjyNrjmr0RgZk
         Z7YYBIKwoOTtbefizzORaOn38Q6vr9NwHcbIEmBilV/mj/mPM/g/6HoawtTPaAW5eWGv
         N1VnkegMMmWm6OkIsDYm7AaDIpWbTZl94W4kn2vwerpyAMX/87oywZxlvKmdFShACT9C
         SBzKz2w05x0YAoK5H2lX0JOf2/wGcf4ZGjYPR50Z58c9EnmEV+7E8PRo2JqXlID2aOH8
         kcVGrfvka3bOlcecjK2uf2MRzfDb3yH4Lz6wjd+1KY1rnu2TfAtKz8D2xCgQ0s8Bte4l
         CV6Q==
X-Gm-Message-State: APjAAAWtkGFwIUEO8cT/vnv7Nu5dsYqBzpIB7wmU/HRyxILRZdAFZkTP
        iWHp1vZvciZ5+hBPe7oQsN4=
X-Google-Smtp-Source: APXvYqxNFzSCKesgR+5JDSY/McNRwMuqHgnhbSse+eI3qPjbOLXLHDvbiY4zwTbeforQ5Mk0YVS2Gw==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr35604603wrj.228.1555102250546;
        Fri, 12 Apr 2019 13:50:50 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id i18sm38063976wrm.7.2019.04.12.13.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 13:50:49 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] platform/x86: asus-wmi: Switch fan boost mode
To:     Daniel Drake <drake@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        Endless Linux Upstreaming Team <linux@endlessm.com>
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <72b3e0aa-d53a-8a82-1505-f4f00aa2bb46@gmail.com>
 <fecb4870-7875-a524-bf6d-3108e25af888@gmail.com>
 <CAD8Lp45ivFJiW0FZo+ZOyUdpV1JFwPg=o7rx7eyp_YdSAbRRkg@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <01fca675-29a3-6959-58a6-d5420ace30df@gmail.com>
Date:   Fri, 12 Apr 2019 22:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD8Lp45ivFJiW0FZo+ZOyUdpV1JFwPg=o7rx7eyp_YdSAbRRkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.19 10:03, Daniel Drake wrote:
> On Thu, Apr 11, 2019 at 1:47 PM Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
>> * 0x00 - is normal,
>> * 0x01 - is obviously turbo by the amount of noise, might be useful to
>> avoid CPU frequency throttling on high load,
>> * 0x02 - the meaning is unknown at the time as modes are not named
>> in the vendor documentation, but it does look like a quiet mode as CPU
>> temperature does increase about 10 degrees on maximum load.
> 
> I'm curious which vendor documentation you're working with here.

That would be user manual for FX505 series, which is pretty minimalistic.
It says it has a fan mode switch key and that's it. Following up on your
comment, I've searched more and actually did found their names hidden in
marketing web page on the website. You're right, they call them balanced,
overboost and silent there.

> From the spec,
> 0 = normal
> 1 = overboost
> 2 = silent

> Also you can use DSTS on the 0x00110018 device to check the exact
> capabilities supported, which you should use to refine which modes can
> be cycled through.
> Bit 0 = overboost supported
> Bit 1 = silent supported
> 
> Thanks
> Daniel
> 

Thanks! I was guessing that the 3 in DSTS must've meant something.

Appreciate your comments! Will definitely implement them. I'm going to post
the v3 patch series approximately middle of next week.

Best regards,
Yurii
