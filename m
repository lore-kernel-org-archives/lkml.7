Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA37C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020582189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfH1Mdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:33:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34751 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1Mdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:33:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so2857918edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3unkaMrl/qzsX06autNLUdhronbmncl167htZAoTRjI=;
        b=flQ0JHBst+ozyUQt8em/WQffA+bsrARJC3KNZkNezN9e60qC5iyUeBXk6uLV+etD1B
         Pu6KhEIQez6s7FSPc0NAldkmlMRix3ojSDDRNzsREX2Z9pum8TY2w7RRqu2oUGbMGGl7
         RyJthOPHE9UKx5p1q+KdAnVQZ5BpDFfoBaUulUOWkg48EOtP2hqThae9TS+ep8zRH+p1
         Dty79pfdbOxQ5E1WSRg/R7+wHj+brHmqg6WCdSJQbuwt7GSVq8LW9/+2MFDIVVv0Wlvb
         jxddECtedy/S7V33MVIIKmgm2vJDkDijyU+9ZHSgUD5p8SZr9K9hERqQlHxZ2GxUwIgp
         9j+A==
X-Gm-Message-State: APjAAAVCQXKb8nWL6ow8jvK1RVaAR1H7JCeRxudV1LSGxNlSNA+/5nrQ
        6W2MqHQU9mR0NwSP6mrv2Ec=
X-Google-Smtp-Source: APXvYqwvWhZKxywMO9CDSJJHbOso7S4Y8nuND+mNgXU/P+ZFkTLsUiLEZcwPu1th2bc8XZMVNgWMQg==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr3714065eds.291.1566995628892;
        Wed, 28 Aug 2019 05:33:48 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id a16sm369829ejr.10.2019.08.28.05.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 05:33:48 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
 <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <16053035-655a-7d53-29d1-ea914e3a21dd@linux.com>
Date:   Wed, 28 Aug 2019 15:33:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 2:33 PM, Rasmus Villemoes wrote:
> On 25/08/2019 21.19, Julia Lawall wrote:
>>
>>
>>> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
>>>
>>>
>>>
>>>> On 25.08.2019 19:37, Joe Perches wrote:
>>>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>>>
>>>> Please explain _why_ is it better in the changelog.
>>>>
>>>
>>> In my naive understanding the negation (!) before the likely/unlikely
>>> could confuse the compiler
>>
>> As a human I am confused. Is !likely(x) equivalent to x or !x?
> 
> #undef likely
> #undef unlikely
> #define likely(x) (x)
> #define unlikely(x) (x)
> 
> should be a semantic no-op. So changing !likely(x) to unlikely(x) is
> completely wrong. If anything, !likely(x) can be transformed to
> unlikely(!x).

As far as I could understand it:

# define likely(x)	__builtin_expect(!!(x), 1)
# define unlikely(x)	__builtin_expect(!!(x), 0)

From GCC doc:
__builtin_expect compares the values. The semantics of the built-in are that it is expected that exp == c.

if (!likely(cond))
if (!__builtin_expect(!!(cond), 1))
if (!((!!(cond)) == 1))
if ((!!(cond)) != 1) and since !! could result in 0 or 1
if ((!!(cond)) == 0)

if (unlikely(cond))
if (__builtin_expect(!!(cond), 0))
if ((!!(cond)) == 0))

Thanks,
Denis

