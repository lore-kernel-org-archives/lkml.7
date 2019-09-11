Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F712C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52D6207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iktAugW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfIKKPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:15:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47060 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfIKKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:15:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so19392327ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9kt1CQafIKHj/rHsG6mTJs/CDrUdJxcoRtxru9KNIIc=;
        b=iktAugW3hJD0fx1Mw3vh0knWXjv2kzp5AZw4KSCK3AsaOuN+ieamhuN7lmY7l001vc
         E+Bw1UUWNfzJKEpjHhyrYQuHoO6fhOY2Gv1siIiYX5gHyxZzgek3vX9Q8jMH/w2NMPaD
         u1UbUJr4qgpKkVG13fXg9aZm8fQYOfFr6rvvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kt1CQafIKHj/rHsG6mTJs/CDrUdJxcoRtxru9KNIIc=;
        b=Q6ZaOKhC4L0nPDOAlIYhz5/LHmfZzY6LzAeS0t+ffvMnAJXTKizGz1+7V4z8MTf0Xb
         wCWN1kVyKkSbUAKMVAUM4m5EOnRWuoKogzALFQtOkcY3mKrDnIYki3p6tJD/853PlkpL
         3yaB4tcmyhpHITR4OSnPK2TeTf64NZomJPYNfhsxMkUov2dJJriT5b6KrdbLxp8RShqn
         O+ozZFWfoWvdkodcSsvii+VfPBhxFqowMClbpUrgK/8G/WaBoXJoJNq7c1er/mmAmtMI
         KYI6PbGsX+cRBpnW9JirwgPmQfO+eSQcn684rUU+FrsTXQhzItjZE4/gGqt+LTRlgqSj
         u7Xw==
X-Gm-Message-State: APjAAAUbGz19auoAO3siODxL71iqISdZ4AQHNjaPOZWnTc8eUKHxeBVW
        lc+wQBLOyTX/9j80/+x85ig1Lg==
X-Google-Smtp-Source: APXvYqzYDJlOd0oaFf/DIvrn5sCLtqtD+U9OlgwAoanyEXdZ4W5myJ1ffax3gZYquRafZEtsbH8GxA==
X-Received: by 2002:a2e:9c86:: with SMTP id x6mr22795025lji.141.1568196900869;
        Wed, 11 Sep 2019 03:15:00 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 18sm4074325ljd.86.2019.09.11.03.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 03:15:00 -0700 (PDT)
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <20190909203826.22263-1-linux@rasmusvillemoes.dk>
 <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
 <95a9f6fbc8fc2cf81e9eadc6f7fef8dd3592e60b.camel@perches.com>
 <354dc1f5-45b8-9e51-1ba0-b1fd368be45a@rasmusvillemoes.dk>
 <8f21cddf-0e39-8379-6eab-60e8238a020d@kleine-koenig.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7e02e25e-a67a-e7a2-3d85-fd2166a882e5@rasmusvillemoes.dk>
Date:   Wed, 11 Sep 2019 12:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8f21cddf-0e39-8379-6eab-60e8238a020d@kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2019 11.37, Uwe Kleine-König wrote:
> On 9/11/19 8:43 AM, Rasmus Villemoes wrote:
>> On 11/09/2019 02.15, Joe Perches wrote:
>>> On Tue, 2019-09-10 at 18:26 +0300, Andy Shevchenko wrote:
>>>> On Mon, Sep 9, 2019 at 11:39 PM Rasmus Villemoes
>>>> <linux@rasmusvillemoes.dk> wrote:
>>>>> +{
>>>>> +       /* Might as well accept both -EIO and EIO. */
>>>>> +       if (err < 0)
>>>>> +               err = -err;
>>>>> +       if (err <= 0) /* INT_MIN or 0 */
>>>>> +               return NULL;
>>>>> +       if (err < ARRAY_SIZE(codes_0))
>>>>> +               return codes_0[err];
>>>>
>>>> It won't work if one of the #ifdef:s in the array fails.
>>>> Would it?
>>
>> I don't understand what you mean. How can an ifdef fail(?), and what
>> exactly won't work?
> 
> I think Joe means: What happens if codes_0[57] is "" because there is no
> ESOMETHING with value 57.

[That was Andy, not Joe, I was lazy and replied to both in one email
since Joe quoted all of Andy's questions].

So first, for good measure, codes_0[57] may be NULL but not "". Second,
if we're passed 57 but no Exxx on this architecture has the value 57,
then yes, we return NULL, just as if we're passed -18 or 0 or 1234. But
57 (or -57, or ERR_PTR(-57)) would realistically never find its way into
an err variable (be it pointer or integer) in the first place when no
ESOMETHING has the value 57.

Except for the case where somebody in the future adds #define ESOMETHING
57 to their asm/errno.h and starts using ESOMETHING, without updating
the table in errcode.c. But if that's the case, letting the caller
handle the "sorry, I can't translate 57 to some string" is still the
right thing to do.

Rasmus

