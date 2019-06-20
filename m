Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0390C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE422082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KIuWzBO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFTUqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:46:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45418 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:46:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so6524638edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zlxmS4RlOT5dd4x2YBCTagMAGWiR3GVlEN2t2GzpYWM=;
        b=KIuWzBO+cFBOW/VG7l3ADv+pAc3wHn2VRuBgi7vrjKNGJx451pnMmWftiXJFRNmUU5
         YfDghHf/UW+DCeBP9IVDhXrGyEljBcAXzMDfNF6E3NfcFgXACNnRlmILufPStxxHJ2qF
         2fONboiWrY5C2bdssBDNqyx2UpYoP24R80CjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlxmS4RlOT5dd4x2YBCTagMAGWiR3GVlEN2t2GzpYWM=;
        b=WkBqpoUE5PtqFnDPLFctH5jIPoKIq0oosq87q/8mVh+L7zS6K5PY1rlawOmH5NkUNi
         Hl7i3n+8GQ5jYrfpOZ0lmTuet3/IvN2SY1tE8VR9Z4IsGGsp4XJKTwLF3V+Ku0y1OIJG
         fe4sF4YpJsOd0mO5eL4LJbbUaqWpW0x6HJ7e6YTLtPT4QDW2oKk3/YTCGJ45KPtY4gFo
         zoQfnB0hfrCL6f01bffZsGuRk60MYI8O2GPbkU20H0o6ML4YeZNW6IZTCGwhGbYY5C8K
         S8iTNE8eJ3jeeDakP6l+xNGyJEYKNLfq0eRCzsrJPgaOjYX60Lh3+0fdKRNcIUiM1d0+
         TSHQ==
X-Gm-Message-State: APjAAAXHgW7HggS/8uhbmNe7+8sZbRJc9SyFnoqYvnjDSbSDhMgP4EGN
        Y8hk1FP3FlWqcTzzheZx0nhPhpXCRmznF7fB
X-Google-Smtp-Source: APXvYqwOfucS6taGA1Dn70RUcLmZ1YfsfUD+LtB5NFJTNGhro2ofEAzoAgJGWXD2MfavUPahwa1fxA==
X-Received: by 2002:a17:906:85d4:: with SMTP id i20mr3125274ejy.256.1561063570440;
        Thu, 20 Jun 2019 13:46:10 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id c48sm180605edb.10.2019.06.20.13.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:46:09 -0700 (PDT)
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for
 DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk>
 <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk>
Date:   Thu, 20 Jun 2019 22:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 00.35, Nick Desaulniers wrote:
> On Mon, Jun 17, 2019 at 3:20 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> It relies on
>>
>> (1) standard assembly directives that should work on
>> all architectures
>> (2) the "i" constraint for an constant, and
>> (3) %cN emitting the constant operand N without punctuation
>>
>> and of course the layout of _ddebug being what one expects.
>>
>> Now, clang before 9.0 doesn't satisfy (3) for non-x86 targets.
> 
> Thanks so much for resending with this case fixed, and sorry I did not
> implement (3) sooner!  I appreciate your patience.
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I'm happy to help test this series, do you have a tree I could pull
> these from quickly? 

I've pushed them to https://github.com/Villemoes/linux/tree/dyndebug_v6
. They rebase pretty cleanly to just about anything you might prefer
testing on. Enabling it for arm64 or ppc64 is a trivial two-liner
similar to the x86 patch (and similar to the previous patches for those
arches). Thanks for volunteering to test this :)

> Anything I should test at runtime besides a boot
> test?

Well, apart from booting, I've mostly just tested that the debugfs
control file is identical before and after enabling relative pointers,
and that enabling/disabling various pr_debug()s by writing to the
control file takes effect. I should only be changing the format for
storing the metadata in the kernel image, so I think that should be enough.

While this is still not merged, some new user of one of the string
members could creep in, but that should be caught at build time.

Rasmus
