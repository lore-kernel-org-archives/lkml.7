Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8259AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACEB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Lf7HVzPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfHZMFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:05:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41040 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfHZMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:05:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id m24so14781554ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=674zUEpW1qMBR3Wi1BQtNz764/jC32fVo4Wnlz37HVc=;
        b=Lf7HVzPz79lDRnTThZqVbYKB0aAd2zA1zy/h7fW06v68QWEw1WNy5mQZbXpt842yYq
         qxTTWJJRBCD2WDttnzkUs5l5niy76+oPT4xj67RbO7fqvEDVN+M2nq24zp3fBjfuRj75
         EyO5njAJHM6F6xW/gCMI2K0/cA9l5x8hvy6xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=674zUEpW1qMBR3Wi1BQtNz764/jC32fVo4Wnlz37HVc=;
        b=svY07ZYjaeYHfDZWlVfVuIdoL0CAaXm2xgHPYk4N3iQh27RQDrCz9RW6jl0SiQz2t+
         8bYLMmgoNMJNCTUbeAf4yZDjpqp/tN9wKZb41Qg2DkHBF+qn3XSZ5luWxEx60J5bomU9
         +sQmQ81TFTcBPiDSenchTmUT42gG9LawVup4pNzX2zB+8z1vyYG+ZHnRtBrt/MfwZ4fZ
         tPM+p03Qgd2EehZscH1a/z+4FbJGgLUauqAO4kjNzFOi9p6SeegLGxG81NOspN6rY+cp
         ebZESqLYVW9HNPsSVMYgUqDSofq4Bdbtm0kxslJV9zdOYVShr4lFYFDRqN0xxYzgvewh
         7VWw==
X-Gm-Message-State: APjAAAUli8MhRvU0cAZz0UnaoXqQgb2MmmyDA5GwwlzOrKKMJjqL5o7v
        RMhB8AZycdYeu+s1eR5B9q6xXUjb4iHHlyIA
X-Google-Smtp-Source: APXvYqx634hTfDpHZkU+yXAO9eBjOGIvulK43Z3s5tUBVD+a3YmY69JSLgMzlfPXQ8Gyo7lOpk7wyw==
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr10009917ljo.87.1566821114243;
        Mon, 26 Aug 2019 05:05:14 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h16sm1969294ljj.73.2019.08.26.05.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 05:05:13 -0700 (PDT)
Subject: Re: [PATCH] watchdog: imx2_wdt: fix min() calculation in
 imx2_wdt_set_timeout
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Georg Hofmann <georg@hofmannsweb.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190812131356.23039-1-linux@rasmusvillemoes.dk>
 <77faf1bd-14cc-831f-e65e-4f2aa74e1843@roeck-us.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8a7a29d4-92ed-1256-6c91-c2e528e58e3b@rasmusvillemoes.dk>
Date:   Mon, 26 Aug 2019 14:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <77faf1bd-14cc-831f-e65e-4f2aa74e1843@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2019 15.28, Guenter Roeck wrote:
> On 8/12/19 6:13 AM, Rasmus Villemoes wrote:
>> Converting from ms to s requires dividing by 1000, not multiplying. So
>> this is currently taking the smaller of new_timeout and 1.28e8,
>> i.e. effectively new_timeout.
>>
>> The driver knows what it set max_hw_heartbeat_ms to, so use that
>> value instead of doing a division at run-time.
>>
>> FWIW, this can easily be tested by booting into a busybox shell and
>> doing "watchdog -t 5 -T 130 /dev/watchdog" - without this patch, the
>> watchdog fires after 130&127 == 2 seconds.
>>
>> Fixes: b07e228eee69 "watchdog: imx2_wdt: Fix set_timeout for big
>> timeout values"
>> Cc: stable@vger.kernel.org # 5.2 plus anything the above got
>> backported to
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I'm not seeing this in v5.3-rc6, did it get picked up?

Rasmus
