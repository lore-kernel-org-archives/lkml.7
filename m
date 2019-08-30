Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FEC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A232343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gW/fE3FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfH3Wuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:50:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfH3Wuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:50:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so3798246edm.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CfAfO8SFrKZ2I7pAu+70yt1nPrM7Y8yF2OmTuE1xbn8=;
        b=gW/fE3FSns8anknDeOeJJyOt2IQU/XUaB6WvAAKAlQ9QftUc/u2rEBTneukYGt00JZ
         YJ2W2tO1Kz7TEiem2XROxNh1+3ancLg4vzIOP2DClTym5Og0J9GukiGquUyf8hQzk7f6
         FIG1QdAll7yFKTpQ+eV4cpwwbV6L8FXGq64Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfAfO8SFrKZ2I7pAu+70yt1nPrM7Y8yF2OmTuE1xbn8=;
        b=YF40KklFmWQOAmpKMw9bY6/i8og5pBRdfgFGIe1KQ05/Qe3pQNPAxpqqm2MLTFHs8m
         hSU4/r0SXEYjgIzOFixwyxHQ3c1iZqJso+8BD2YMEyRbB9vnQrtwzMuk0gq2FVRVulGZ
         CJHHliQLk+Sn5ZBQ4UwltN1+SbjxNc5BeAnXNj/5dk77ns9jUryLfezlto4juCiSwJdw
         wgldCZ3Gjt8wLMxQtDsp1PFG2ja6rbqpJy7Z2uidEcSOYwZ6AAakmDyeQ5zneiJNZD0d
         G/MlfOnYPZRvTNE2LudHaKOArbH4nEfyTa2DFnGfWSYwlJiiIffYnO9EkfKaRwYgcL9z
         iDsQ==
X-Gm-Message-State: APjAAAX+Dfs8RKBhctgKM4BaAF4S2fjleZJaQ7CgCUTQADnw3qvEgpzS
        NjH4kZwQ0+NRtEHEF8Dsq5MAEOAD8qVbc7Q4
X-Google-Smtp-Source: APXvYqzhG7BceYoIB8DYmhL8553QJa3SprL9HTGrWJAjJVTPrEvrI13ci1ahHiJZFhY2AFyxvsc1LQ==
X-Received: by 2002:a05:6402:611:: with SMTP id n17mr6361066edv.33.1567205450165;
        Fri, 30 Aug 2019 15:50:50 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id d9sm1226543edz.85.2019.08.30.15.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 15:50:49 -0700 (PDT)
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
To:     Joe Perches <joe@perches.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
 <9fecd3a9-e1ae-a1f9-a0c5-f5db3430c81d@rasmusvillemoes.dk>
 <92108c09c37a9355566b579db152a05e19f54ccf.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <516ab378-e79a-4e1c-8099-ccb22dfd5508@rasmusvillemoes.dk>
Date:   Sat, 31 Aug 2019 00:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <92108c09c37a9355566b579db152a05e19f54ccf.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2019 00.21, Joe Perches wrote:
> On Sat, 2019-08-31 at 00:03 +0200, Rasmus Villemoes wrote:
>> On 30/08/2019 23.53, Joe Perches wrote:
>>>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>>> []
>>>> @@ -2178,8 +2204,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>>>>  		return flags_string(buf, end, ptr, spec, fmt);
>>>>  	case 'O':
>>>>  		return kobject_string(buf, end, ptr, spec, fmt);
>>>> -	case 'x':
>>>> -		return pointer_string(buf, end, ptr, spec);
>>>>  	}
>>>>  
>>>>  	/* default is to _not_ leak addresses, hash before printing */
>>>
>>> why remove this?
>>>
>>
>> The handling of %px is moved above the test for ptr being an ERR_PTR, so
>> that %px, ptr continues to be (roughly) equivalent to %08lx, (long)ptr.
> 
> Ah.
> Pity the flow of the switch/case is disrupted.

Agree, but I don't think it's that bad.

> That now deserves a separate comment.

You mean a comment like /* %px means the user explicitly wanted the
pointer formatted as a hex value. */. Or do you want (the|an additional)
comment somewhere inside the switch()?

> But why not just extend check_pointer_msg?

Partly because that would rely on all %p<foo> actually eventually
passing ptr through to that (notably plain %p does not), partly because
the way check_pointer_msg works means that it has to return a string for
its caller to print - which is ok when the errcode is found, but breaks
if it needs to format a decimal. It can't even snprintf() to a stack
buffer and return that, because, well, you can't do that, and it would
be a silly recursive snprintf anyway.

OK, so perhaps you meant check_pointer() where it might be doable, but
again, with plain %p and possibly others we don't get to that.

Rasmus
