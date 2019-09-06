Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A58C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4308921927
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbfIFUzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:55:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39119 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387845AbfIFUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:55:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id u6so7710949edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q50YWDbiSd1qIGUsdn2HhgRM3zE7h0WNAycJ80w5WqI=;
        b=b8ep5il1/UW5U/R/SLoUCMnCTGKP71xTJCDs8822eJIJovCH78iDyTO9FE792XLLYR
         cb4EJajZ3j+ke/5cvqGjPYhxHJWggZBgxeK0mgF6soUw2X3WsITX8WYC/WDTlB/itRHH
         /O2Dft/4YvDR/dEF1KHhWVpDhj04a0PKQSEEHX7R74F8SrsbkcfFl5Pf2l6rQQzIwJUr
         LwBCVZbvr5bySrCDv0PF2Tnq+X/xGb3NK76JRrxs3qv4GAhny/KtYKiXUnZzBUNRdX+o
         05c2qZERp+5TIIO9lAQ2NrvhWmt0iQ7NGmLD58TL0S9PB1InoVHKzvck3twhCdLjlmV2
         TXpA==
X-Gm-Message-State: APjAAAXcDyxlWC963T2bkrQd9vBiXqgClYj9Ll1m9TIfDodtMYrPfFm0
        ZU1lI6UXnpmpAQxXqP6fK1M=
X-Google-Smtp-Source: APXvYqx1IskuV1YVXPEkNqMrhmasdZALFNksi0W7EFZ/LXpgqcz7IDSlJEfbpYTNi5H8vpkn2vCYDw==
X-Received: by 2002:a17:906:7294:: with SMTP id b20mr9136472ejl.216.1567803342364;
        Fri, 06 Sep 2019 13:55:42 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id a17sm1143026edv.66.2019.09.06.13.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 13:55:41 -0700 (PDT)
Subject: Re: [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
 <alpine.DEB.2.21.1909062217240.2643@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <3981b788-cd0b-d2c4-4585-d209f6f6a522@linux.com>
Date:   Fri, 6 Sep 2019 23:55:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909062217240.2643@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06.09.2019 23:19, Julia Lawall wrote:
> 
> 
> On Thu, 29 Aug 2019, Denis Efremov wrote:
> 
>> This patch adds coccinelle script for detecting !likely and
>> !unlikely usage. These notations are confusing. It's better
>> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
>> likely(!x) for readability.
>>
>> The rule transforms !likely(x) to unlikely(!x) based on this logic:
>>   !likely(x) iff
>>   !__builtin_expect(!!(x), 1) iff
>>    __builtin_expect(!!!(x), 0) iff
>>   unlikely(!x)
>>
>> For !unlikely(x) to likely(!x):
>>   !unlikely(x) iff
>>   !__builtin_expect(!!(x), 0) iff
>>   __builtin_expect(!!!(x), 1) iff
>>   likely(!x)
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
>> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
>> Cc: Nicolas Palix <nicolas.palix@imag.fr>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Markus Elfring <Markus.Elfring@web.de>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> A small improvement though would be to improve the explicit dependency of
> the last four python rules on r1 and r2.  Those rules won't execute unless
> the inherited metavariable has a value, which makes the same dependency.
> 
> julia

I think I will resend this patch as a part of patchset with all warnings fixed
in a couple of days. Hope this will help to create a discussion point with other
developers about readability of "!likely" and "!unlikely".

Thanks,
Denis
