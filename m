Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3443C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF31215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3G4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:56:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfH3G4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:56:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so943100edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0wOFc2w1+MlzfFoetON2U+b8zwj/F9oWEQnG1Zo3LVI=;
        b=j6cbsfvuldAax6xnobCyPf0QnxVHnHdCQjCFhQkI8o+6xwfgvwTgkpsLEBJw9l3Dh1
         ZpT9GKBr2xJkz9gJrDV8/xNTM1l2xsUiLs+nm8DdvBmHGR2/lhRs1pXlIJquAnhRK0Go
         Kv5ifWtw0VIOkrNI4T4UH6LOe9im1lZjnIfe15UbLflJettQAls6H/jG4/rBKKF/jq/i
         atwdKBhDA1+C1cccj6+TmzYRukIEVV4521bvpUjReLr17g/gifEp6fCxyNvpVUrd3NXt
         cPkqxb2IfOWFbN2TtVuUiJ726RQfAy61sdRZ/GKWUEWMVhJnFRRxdZ4SLzaqBQoEygjc
         kK2A==
X-Gm-Message-State: APjAAAVJDcMBC0fr2/gxFcdc5n6O+8vF4420sKeIAtsd3UeRLWbkVelE
        2rpqMlMhN8krpmQn9QK9UMY=
X-Google-Smtp-Source: APXvYqzIPAzyop8kuhvacqKLm0o7HsxfPZ+027A/ZlA/bBAA5GKwc7Eib6GLMXM0v0zOnBkgO+hjtw==
X-Received: by 2002:aa7:d981:: with SMTP id u1mr13739637eds.150.1567148188990;
        Thu, 29 Aug 2019 23:56:28 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id l27sm670788ejd.31.2019.08.29.23.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 23:56:28 -0700 (PDT)
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
 <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
 <alpine.DEB.2.21.1908300842060.2184@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <7933d51f-5c2e-26a4-2dee-e13e61d0ac8c@linux.com>
Date:   Fri, 30 Aug 2019 09:56:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908300842060.2184@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.08.2019 03:42, Julia Lawall wrote:
> 
> 
> On Thu, 29 Aug 2019, Denis Efremov wrote:
> 
>> On 8/29/19 8:10 PM, Denis Efremov wrote:
>>> This patch adds coccinelle script for detecting !likely and
>>> !unlikely usage. These notations are confusing. It's better
>>> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
>>> likely(!x) for readability.
>>
>> I'm not sure that this rule deserves the acceptance.
>> Just to want to be sure that "!unlikely(x)" and "!likely(x)"
>> are hard-readable is not only my perception and that they
>> become more clear in form "likely(!x)" and "unlikely(!x)" too.
> 
> Is likely/unlikely even useful for anything once it is a subexpression?
>> julia
> 

Well, as far as I understand it,

It's correct since it sets the probability of likely/unlikely subexpression
is true to 90% (see https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/Other-Builtins.html).
The probability of a whole expression is then computed by GCC
in this case. It's kind of assigning individual weights to conjuncts/disjuncts.
I think that it can be useful when you are not sure about the probability
of the whole expression but you know something about subexpressions it consists, e.g.,
likely(E1) && E2. However, I think that "!unlikely(x)" is fully equivalent in this sense
to "likely(!x)". I tested it once again for allyesconfig with branch profiling
disabled and bloat-o-meter shows no diff in binary size.

Denis
