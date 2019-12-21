Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E8FC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3776A2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raPYXzxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLUCnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:43:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37763 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLUCnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:43:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so11055407wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 18:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aG/6VJAuRbFI92ikmGfoMv9gEFQfb1tWIpO7XSYMEwY=;
        b=raPYXzxEMBq0yPsUt53IzQ1XbYLgoMqNAuNlDTIQ6VF95rrzkYFjuW7X9bKx8Un5PD
         dQ93JBqPt6iO+VlffXlKz2KJU4CkXmi8rVH1+Elj3AAzgtfIOSeCgEKxoC964Z4v6gZ6
         gdKXAuy0KKjR4f2uSewoMsglAevo9nQaXwr9rx/Lh+K6DBJyIDVeKpw8mI+MoOVMUVOl
         0fYhHa5ixmqHIXhbISdwR62flcdTF7XWP5PHEYGfEwXufLrPDGBTtbTfqNIWeNzkrI/l
         hp2jnZNv9vrfIG8Ex8DlkVDJ17v1Y9TRhbzlgJApb8leorA4jappi9c1gX+U8yP67rmS
         ZqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aG/6VJAuRbFI92ikmGfoMv9gEFQfb1tWIpO7XSYMEwY=;
        b=SaROiaxFnnPHGGnyaZXHGf0BnU9faoqp0yWLRNJPFp1pLvWEcR3O00rNKxvryYSfnk
         iNZ8x00iy137wIDbctSaa7ph1iGj5OU9/KSKWbzBV0pFc19G6op5f9VlFw3el/IWadOo
         AMya0tAKr7zGeB8esRjNRxOv9P0Jne/wZvJqqur1M6MGH4bH/AWmNEloGqjKf5TscV3a
         XwfSL+Emuo3HptpjXQrDp5CxRsrKKwhonVhKecphq3l64QH2O2zDi8ZVnZJJFTi9fqnY
         jLS+vlVgTfe6NkaJSXVV9yalzE0S7nyMt+up0K/EbOXLYdAfln00ttj8NaubH0cRtLZr
         bixA==
X-Gm-Message-State: APjAAAVOKbSeewhPQKPKa9zqkTRadYt806FjrA3lEifjljwf36b+lmsJ
        4suN8uEauJO0Z6QJsoxipAmmrQG7C0c=
X-Google-Smtp-Source: APXvYqyLvl6uq9mzEn91Yv8DGLuzE0Y6Q1BiNUOtNzYmjf77EDAk4gAV0OmnbfMgppi2XJN9oVVx7Q==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr19415804wmh.35.1576896186435;
        Fri, 20 Dec 2019 18:43:06 -0800 (PST)
Received: from macbook.local ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a133sm11749722wme.29.2019.12.20.18.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 18:43:05 -0800 (PST)
Subject: Re: [PATCH] interconnect: Check for valid path in icc_set_bw()
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, linux-kernel@vger.kernel.org
References: <20191220171310.24169-1-georgi.djakov@linaro.org>
 <20191220190426.GE549437@yoga>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <6a9d1b18-b34a-6ecb-0fe6-66dd7ee8cb52@linaro.org>
Date:   Sat, 21 Dec 2019 04:43:04 +0200
MIME-Version: 1.0
In-Reply-To: <20191220190426.GE549437@yoga>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the comments!

On 20.12.19 21:04, Bjorn Andersson wrote:
> On Fri 20 Dec 09:13 PST 2019, Georgi Djakov wrote:
> 
>> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/core.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 63c164264b73..14a6f7ade44a 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -498,6 +498,11 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>>  	if (!path || !path->num_nodes)
>>  		return 0;
>>  
>> +	if (IS_ERR(path)) {
> 
> This is a sign of a logical error, and the print is likely to be
> ignored/lost in the noise. So I think the response should aid to help
> the developer hitting this to resolve the issue.
> 
> So I think this is more visible and more useful as:
> 
> 	if (WARN_ON(IS_ERR(path)))
> 		return -EINVAL;

That's actually what i had in mind initially, but then started
wondering whether this isn't a bit too noisy. But oh well, let's
scream loud if something is done incorrectly.

> 
> PS. Doesn't path->num_nodes == 0 fall in this category as well? When
> would you have a path object with no nodes passed to this function?

Yes, will make the warning cover this case too.

Thanks,
Georgi

> 
> Regards,
> Bjorn
> 
>> +		pr_err("%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>> +		return -EINVAL;
>> +	}
>> +
>>  	mutex_lock(&icc_lock);
>>  
>>  	old_avg = path->reqs[0].avg_bw;

