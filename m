Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11DAC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A220B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="I00cEMC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJIOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:21:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35426 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfJIOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:21:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so1823974lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjoBWNah/ifg5o3F6/ggCjuw7oqH/AZ2UOt9h6CGFbo=;
        b=I00cEMC2A7RAbE1W1pCwIixhLBGWr52k0GxZdw/bzo/vHaGVtYJNzsa3mvqv9fMuuz
         LDOZ1HkZC0eA1/W04lDYWq1c+2t6zT+xn5qVWOR4JqcXgJlwlvqtqoud48LR2Ih7lfSV
         wPdILcXkMgC0QS+RWPjvT5aQ+tdQ6WSOiD+y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjoBWNah/ifg5o3F6/ggCjuw7oqH/AZ2UOt9h6CGFbo=;
        b=cKIBHEbh+Ij0xacuj1rI4TAjlbSaSAt9k2gFHg0tLOOVGpvRyv9bMrlKVPS18culbC
         t0rmGtqDK1dKyaF0F/fOmRu4JviQJ0aG+5jcLpvRWvFa3jSQyfmbJ83n+yuq0jbcIxCo
         qspTegw5Pf4N12yzuU00c4l+1Qyy0iJx90L3bs2aZRq4nPBdYjdYYnYZFZUeMD4KPfzS
         kirICcbQlMxcd9tiF+5OGG8sSKOdf+T9pgL9dusjojc9QDK0fXv6qdqdFjo/34otogLO
         bhOQLxivbEO7RXsnqOaeEtk4zWwN5DP1juiz74Ega0IsSrnP06HZAeozVNSO6Y6tybiQ
         b1Ng==
X-Gm-Message-State: APjAAAUIeP9aSjkcfkGLm8UVvc/R21dbSqWgKjsSBB5xRELv30RPQqdh
        wtmURxxuvrNLAd2PXs/lbi1He4sHAP+Qi2U2
X-Google-Smtp-Source: APXvYqw+L3aQZrBXdYzZVx3ZDCtDAid9DfB/cNu5zr1fHVVnQlV8aAMeEHf6VZoH2ijwjIhvKJkGLw==
X-Received: by 2002:a19:ae05:: with SMTP id f5mr2216670lfc.165.1570630882856;
        Wed, 09 Oct 2019 07:21:22 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z14sm500967lfh.30.2019.10.09.07.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 07:21:22 -0700 (PDT)
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
 <20191009135522.GA20194@kadam>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b1f055ec-b4ec-d0ed-a03d-7d9828fa9440@rasmusvillemoes.dk>
Date:   Wed, 9 Oct 2019 16:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009135522.GA20194@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 15.56, Dan Carpenter wrote:
> [ I haven't reviewed the original patch ]
> 
> On Wed, Oct 09, 2019 at 03:26:18PM +0200, Rasmus Villemoes wrote:
>> On 09/10/2019 14.14, Markus Elfring wrote:
>>> From: Markus Elfring <elfring@users.sourceforge.net>
>>> Date: Wed, 9 Oct 2019 13:53:59 +0200
>>>
>>> Several functions return values with which useful data processing
>>> should be performed. These values must not be ignored then.
>>> Thus use the annotation “__must_check” in the shown function declarations.
>>
>> This _might_ make sense for those that are basically kmalloc() wrappers
>> in one way or another [1]. But what's the point of annotating pure
>> functions such as strchr, strstr, memchr etc? Nobody is calling those
>> for their side effects (they don't have any...), so obviously the return
>> value is used. If somebody does a strcmp() without using the result, so
>> what? OK, it's odd code that might be worth flagging, but I don't think
>> that's the kind of thing one accidentally adds.
> 
> 
> 	if (ret) {
> 		-EINVAL;
> 	}
> 
> People do occasionally make mistakes like this.  It can't hurt to
> warn them as early as possible about nonsense code.

In that case, ret (which I guess comes from one of these functions) is
indeed used. And gcc should already complain about that "statement with
no effect" for the -EINVAL; line. So I don't see how adding these
annotations would change anything.

>> And, for the
>> standard C functions, -Wall already seems to warn about an unused
>> call:
>>
>>  #include <string.h>
>> int f(const char *s)
>> {
>> 	strlen(s);
>> 	return 3;
>> }
>> $ gcc -Wall -o a.o -c a.c
>> a.c: In function ‘f’:
>> a.c:5:2: warning: statement with no effect [-Wunused-value]
>>   strlen(s);
>>   ^~~~~~~~~
> 
> That's because glibc strlen is annotated with __attribute_pure__ which
> means it has no side effects.

I know, except it has nothing to do with glibc headers. Just try the
same thing in the kernel. gcc itself knows this about __builtin_strlen()
etc. If anything, we could annotate some of our non-standard functions
(say, memchr_inv) with __pure - then we'd both get the Wunused-value in
the nonsense cases, and allow gcc to optimize or reorder the calls.

Rasmus
