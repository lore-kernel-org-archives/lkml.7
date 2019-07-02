Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66439C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3924E218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKlI879d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGCAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:38:57 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39471 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfGCAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:38:56 -0400
Received: by mail-pl1-f180.google.com with SMTP id b7so200983pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIW4c2nsoK1zg9iPJ9PWWFYICxxuZVhWWS0PGONCcT8=;
        b=tKlI879d6GOCn5/viRbA8CB+2LHjMm+LHx8vu35g2JtHmWRh1MS1K2Oq0gOO4uanyd
         c15xofeqIVhd7SStkRQtGGQG8ogXRpToC2cmZoqBYxGBLvl9kjjYZ0xuo8mFYG1VEsLy
         ikmPD7gHqGybsUQltdIn7Jjmkd2wmRlohhi8jmnbU3YIPRnW77+JMRLFQ8emQ6GOC9vD
         mkgfNh+CChWY9/02UtCZY5Z4d/iptGSMjM4I4uAS4y3vUxK4UYVODhXk0yUlEZGc668+
         VgBtNszBl2lr0RVPKRfw91a/mbIqdV4lCzbBpKDNJSCzW2vG9+iNlMhl4b9cvPnPb3/T
         F3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIW4c2nsoK1zg9iPJ9PWWFYICxxuZVhWWS0PGONCcT8=;
        b=TmxF/S2NnJ19cSQL0rzBgOtKFuDw6d6RaHOoqOl5ZX46a4NkN9X5SkHiVOzOtFptrJ
         q4GigkWs5p5yLkarFFQ3wAoj8GmF+SNednsY7MGfzehWlxmCpYWYgxEgScH5Q0rc6zRz
         SP212GtjxPtJrx2AfeVX7XVY7++Qn6jxY2GIFAG2vdvW3uvxhb7kKDnjaDX5vcBp4zm8
         WDT8zheh5CtqrpctJlqNRSnzNXPQFBMVPN6A92iIyZ0PrF/dbyR74qc8SV5JCK4KA+wr
         tBVpz7mjsERzyuCkLhJ3nY4GRF5uGcYQU5NJdU/GcW1t+Fe6RAWtmx6HXo5Nhi2jHEVF
         z7oQ==
X-Gm-Message-State: APjAAAWxytzfkzqhAJl4+Hf5YMNgirrM8QgM745Y0XqxOROAaPgR4dXe
        k6TvMMBihtCFNkbRkHFGuweLhs9r
X-Google-Smtp-Source: APXvYqyoBXu4AyqKJhdPuz9LblEnnUpotkfLl9gMkZHnkxwo6EMqYJPvNrNLG2nCtlyB3nXPt7OwmA==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr37806898ple.131.1562110033549;
        Tue, 02 Jul 2019 16:27:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v22sm186381pgk.69.2019.07.02.16.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 16:27:12 -0700 (PDT)
Subject: Re: [PATCH -next] mm: Mark undo_dev_pagemap as __maybe_unused
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <1562072523-22311-1-git-send-email-linux@roeck-us.net>
 <20190702135418.ce51c988e88ca0d9546a2a11@linux-foundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa5137e4-478a-94b6-f0ae-28d48f53825e@roeck-us.net>
Date:   Tue, 2 Jul 2019 16:27:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702135418.ce51c988e88ca0d9546a2a11@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 1:54 PM, Andrew Morton wrote:
> On Tue,  2 Jul 2019 06:02:03 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Several mips builds generate the following build warning.
>>
>> mm/gup.c:1788:13: warning: 'undo_dev_pagemap' defined but not used
>>
>> The function is declared unconditionally but only called from behind
>> various ifdefs. Mark it __maybe_unused.
>>
>> ...
>>
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1785,7 +1785,8 @@ static inline pte_t gup_get_pte(pte_t *ptep)
>>   }
>>   #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
>>   
>> -static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
>> +static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>> +					    struct page **pages)
>>   {
>>   	while ((*nr) - nr_start) {
>>   		struct page *page = pages[--(*nr)];
> 
> It's not our preferred way of doing it but yes, it would be a bit of a
> mess and a bit of a maintenance burden to get the ifdefs correct.
> 
That is why I did it here. I understand that some maintainers don't like it,
and I noticed that it wasn't used elsewhere in the file, but it seemed to be
to most straightforward solution.

> And really, __maybe_unused isn't a bad way at all - it ensures that the
> function always gets build-tested and the compiler will remove it so we
> don't have to play the chase-the-ifdefs game.
> 
Yes, it does have its advantages. I like it myself, but usually I would not
impose my opinion on others. In this case, anything else would have been
quite awkward and be prone to never-ending adjustments.

Thanks,
Guenter
