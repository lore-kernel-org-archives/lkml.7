Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D482ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2182F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Mdw1iEYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfIKGn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:43:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45388 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfIKGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:43:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so8305252ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBgrDTpEw0rQgn/ixXrLh1SNi1gyM1DCfH7+wgZte8w=;
        b=Mdw1iEYPDsvdfG5R5BFHqM9Ekeawea62W7kvbDYteHhXCjwpip22SznIrXvysioEpT
         n4f9dVtyyGthnBVqxblNhg2whX1+TymJSoxGUAKko+JjoCTr2uQlyTmqX6wBrrK/RfD7
         1mD9BtpHJY0jIMVTBSjWDiP3Im0E1Cy1qawiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBgrDTpEw0rQgn/ixXrLh1SNi1gyM1DCfH7+wgZte8w=;
        b=MqXH1pFona69RGmJhwNVtm+NZlGCV8rIbSK93T4VEke6CTQtZQLVimzmUY5W51m3Ad
         Ci/JdcwbWl2hA7pQwM+m3WHtau/fQm0fYkIjficsuYeWPPwWVHH8Raulv61ZOKbrJge9
         VHm0cZNTHam2TtbINNyjqhf3XaiovLty9QT27opke2+qSCDTeArUWdrsCn5Vg8KGNFEA
         zAhWu8teXC9JseIbN0iza75PST8SGKf4R7hGp5ybjIdZHPdbbVYNHKwNxcUi0GllBb0X
         bleTK7ZOaTW4nVUmOIFpPpqviru0wIkXm51VTatMCRsZGtVl+AX7dgs9eTidP+16HuON
         OQFQ==
X-Gm-Message-State: APjAAAVIFuS5LE17t/pJy4Qw83scNB9a9oCpm9ykjMmhJQbA31MO1HnX
        xCgb7GbxU1GGvSwNYT6j12qRdQ==
X-Google-Smtp-Source: APXvYqyj6DMRx6vh8DsHePGeABlshcrjTlck+ipHBPwXCayZku3BG61nIOfuSUTGK4g4USYb6c6Wug==
X-Received: by 2002:a2e:96da:: with SMTP id d26mr21538874ljj.7.1568184202827;
        Tue, 10 Sep 2019 23:43:22 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 77sm4416923ljj.84.2019.09.10.23.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 23:43:22 -0700 (PDT)
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <20190909203826.22263-1-linux@rasmusvillemoes.dk>
 <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
 <95a9f6fbc8fc2cf81e9eadc6f7fef8dd3592e60b.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <354dc1f5-45b8-9e51-1ba0-b1fd368be45a@rasmusvillemoes.dk>
Date:   Wed, 11 Sep 2019 08:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95a9f6fbc8fc2cf81e9eadc6f7fef8dd3592e60b.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2019 02.15, Joe Perches wrote:
> On Tue, 2019-09-10 at 18:26 +0300, Andy Shevchenko wrote:
>> On Mon, Sep 9, 2019 at 11:39 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:

>>> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
>>> +#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err
>>
>> From long term prospective 300 and 550 hard coded here may be forgotten.

No? The point of the BUILD_BUG_ON_ZEROs is that if you add a new
Esomething, you'll get an instant build error if Esomething doesn't fit
nicely in the array you put it in. Then one can go back and figure out
whether the limit should be raised, a new codes_foo should be created,
or if it's early enough so it's not ABI yet, simply change Esomething to
a saner value.

A much bigger problem is that it's possible to add something to some
errno.h without updating this table, but there's no good solution for
that, I'm afraid. However, new Esomething are very rarely added, and
printf() will still handle it gracefully until somebody notices.

>>> +const char *errcode(int err)
>> We got long, why not to use long type for it?

Because errno values by definition have type int - and the linux syscall
ABI very clearly limits values to [1,4095]. I can change the type used
in vsnprintf.c if you prefer.

>>> +{
>>> +       /* Might as well accept both -EIO and EIO. */
>>> +       if (err < 0)
>>> +               err = -err;
>>> +       if (err <= 0) /* INT_MIN or 0 */
>>> +               return NULL;
>>> +       if (err < ARRAY_SIZE(codes_0))
>>> +               return codes_0[err];
>>
>> It won't work if one of the #ifdef:s in the array fails.
>> Would it?

I don't understand what you mean. How can an ifdef fail(?), and what
exactly won't work?

>>> +}
>>> +               long err = PTR_ERR(ptr);
>>> +               const char *sym = errcode(-err);
>>
>> Do we need additional sign change if we already have such check inside
>> errcode()?

Nah, but I went back and forth on this and ended up falling between two
stools. I think I'll drop the handling of negative arguments to
errcode(), the INT_MIN case makes that slightly ugly anyway.

> How is EBUSY differentiated from ZERO_SIZE_PTR ?

Huh? ZERO_SIZE_PTR aka (void*)(16L) is not IS_ERR(), so we won't get
here in that case.

Rasmus
