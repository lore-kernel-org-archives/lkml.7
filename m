Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADEFC46476
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6B020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfFGJKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:10:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33609 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:10:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so1392716wru.0;
        Fri, 07 Jun 2019 02:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BkHOgQp9ZNT+w4r/aHTtr9WepEQUBdYdl9/a+tV9soA=;
        b=AlyPNiy/nmOz7yw1lGihpnVVQlGuhUdDTiGQj68Z+FYXMh7V+EybfUX8bjNjlospLn
         iiY+OqQXAp/H4rCt7oralkYvo2GuwjsgNBk5Cf4TKceWap6ZBCrsmEwLQRSV/K+Y8Xkw
         k4G6Gx0YRVRXDOBNQnOm0haE9NtF1abDeds0MZyYpJVGjVtpEeDjdTUCgBh6pzZz7vY5
         l9e0eIJHWJcDuZyauBxcHvhi+5tRrQkt6MUWMruSzq3YUU4MajDndRFNUDCh2YdOQ/Ky
         BWUuKTVdCEHFhVEEWSb02/9IJgFgNpklsZiL1Qdr5TB/blH1VO3LSC9aBKiiPlg3UAxo
         HASw==
X-Gm-Message-State: APjAAAWEsu1n4Y7JUUhrzJK01p3TitlMqUMTftMxrbJnLwk3UQ7UwQJG
        5L7zZjQBWOICB4ypXDOQfomWWl24
X-Google-Smtp-Source: APXvYqww0GZgtRbdcN4fLGmRxER87DrsdGTWzb/8L9RINKlwcWi6JWh+Uiq6bfjEfwgfX7zMxIFl0Q==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr18664982wrm.100.1559898639593;
        Fri, 07 Jun 2019 02:10:39 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id 34sm1727277wre.32.2019.06.07.02.10.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 02:10:38 -0700 (PDT)
Subject: Re: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
To:     Gen Zhang <blackgod016574@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190531011424.GA4374@zhanggen-UX430UQ>
 <eb8e2d33-e8f7-93a5-c8bc-98731c0d63b6@suse.cz>
 <20190605160043.GA4351@zhanggen-UX430UQ>
 <20190606201646.B4CC4206BB@mail.kernel.org>
 <20190607015258.GA2660@zhanggen-UX430UQ>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e5b4639b-3077-59bb-6383-0c2bccdd9191@suse.cz>
Date:   Fri, 7 Jun 2019 11:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607015258.GA2660@zhanggen-UX430UQ>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 06. 19, 3:52, Gen Zhang wrote:
>>>>> @@ -3491,6 +3492,8 @@ static int clk_core_populate_parent_map(struct clk_core *core)
>>>>>                             kfree_const(parents[i].name);
>>>>>                             kfree_const(parents[i].fw_name);
>>>>>                     } while (--i >= 0);
>>>>> +                   kfree_const(parent->name);
>>>>> +                   kfree_const(parent->fw_name);
>>>>
>>>> Both of them were just freed in the loop above, no?
>>> for (i = 0, parent = parents; i < num_parents; i++, parent++)
>>> Is 'parent' the same as the one from the loop above?
>>
>> Yes. Did it change somehow?
> parent++?

parent++ is done after the loop body. Or what do you mean?

>>> Moreover, should 'parents[i].name' and 'parents[i].fw_name' be freed by
>>> kfree_const()?
>>>
>>
>> Yes? They're allocated with kstrdup_const() in clk_cpy_name(), or
>> they're NULL by virtue of the kcalloc and then kfree_const() does
>> nothing.
> I re-examined clk_cpy_name(). They are the second parameter of 
> clk_cpy_name(). The first parameter is allocated, not the second one.
> So 'parent->name' and 'parent->fw_name' should be freed, not 
> 'parents[i].name' or 'parents[i].fw_name'. Am I totally misunderstanding
> this clk_cpy_name()? :-(

The second parameter (the source) is parent_data[i].*, not parents[i].*
(the destination). parent->fw_name and parent->name are properly freed
in the do {} while loop as parents[i].name and parents[i].fw_name, given
i hasn't changed yet. I am not sure what you mean at all. Are you
uncertain about the C code flow?

thanks,
-- 
js
suse labs
