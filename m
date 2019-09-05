Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C46C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DC420828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfIEHgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:36:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35578 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfIEHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:36:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so1149761lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2T9+4yCg/nj22t+epOd3cFsZ2Dp5yvNb3cPsYW2e68=;
        b=FFOGK8egGRRKtuB7jDoIbVRl2iqT18v+4veXXN57toPJyYrPiydNEhig8Ugmlv/ALg
         Qdwh7ZZGkWtOBb3kKAZg5GS9XSjNhxZrApKn4XLeKla/aVPKgHlVpJAJEzXd0t9EoSl6
         4cnR6ag94KKihafYGP7jrlisFKxEkmOJE4k+Ph++QxqiZ32U5teTYgU/Y+UvqGRpPkmP
         NY7wUhkIdiCeFyajFh87VCxc70txo8YCGDYjbfL82iYw6uAVgf3unUPRL8TCZ8g244fg
         f1OmQa9nVv9eFuNqoYTPP00zfz/loA5TQH7QGdyJ++NA1omQlFb4P4KOdk7ZdWCbYaEj
         IE5w==
X-Gm-Message-State: APjAAAV2P6qzyvm6qCsOn3/hCc0yWA3dqbLd1iut13NrR85p70nc9+pU
        nndrklzzYJtEbZ8mpN31QBc=
X-Google-Smtp-Source: APXvYqy9rn677gYfY4pdkqXuzmif6s2DoTq9rKFWfrqEEptNS26auCjeUi4G1MQrVQVuek6Z9BJjew==
X-Received: by 2002:a19:c191:: with SMTP id r139mr1343662lff.23.1567668994388;
        Thu, 05 Sep 2019 00:36:34 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id y22sm216706ljj.97.2019.09.05.00.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 00:36:33 -0700 (PDT)
Subject: Re: [RFC PATCH] coccinelle: check for integer overflow in binary
 search
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, tacingiht@gmail.com
References: <20190904221223.5281-1-efremov@linux.com>
 <alpine.DEB.2.21.1909050816370.2815@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <8916c9d9-bdf5-51c2-b5cb-49898e14a00c@linux.com>
Date:   Thu, 5 Sep 2019 10:36:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909050816370.2815@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.09.2019 09:20, Julia Lawall wrote:
> 
> 
> On Thu, 5 Sep 2019, Denis Efremov wrote:
> 
>> This is an RFC. I will resend the patch after feedback. Currently
>> I'm preparing big patchset with bsearch warnings fixed. The rule will
>> be a part of this patchset if it will be considered good enough for
>> checking.
>>
>> There is a known integer overflow error [1] in the binary search
>> algorithm. Google faced it in 2006 [2]. This rule checks midpoint
>> calculation in binary search for overflow, i.e., (l + h) / 2.
>> Not every match is an actual error since the array could be small
>> enough. However, a custom implementation of binary search is
>> error-prone and it's better to use the library function (lib/bsearch.c)
>> or to apply defensive programming for midpoint calculation.
>>
>> [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
>> [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>>  scripts/coccinelle/misc/bsearch.cocci | 80 +++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>  create mode 100644 scripts/coccinelle/misc/bsearch.cocci
>>
>> diff --git a/scripts/coccinelle/misc/bsearch.cocci b/scripts/coccinelle/misc/bsearch.cocci
>> new file mode 100644
>> index 000000000000..a99d9a8d3ee5
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/bsearch.cocci
>> @@ -0,0 +1,80 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/// Check midpoint calculation in binary search algorithm for integer overflow
>> +/// error [1]. Google faced it in 2006 [2]. Not every match is an actual error
>> +/// since the array can be small enough. However, a custom implementation of
>> +/// binary search is error-prone and it's better to use the library function
>> +/// (lib/bsearch.c) or to apply defensive programming for midpoint calculation.
>> +///
>> +/// [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
>> +/// [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
>> +//
>> +// Confidence: Medium
>> +// Copyright: (C) 2019 Denis Efremov, ISPRAS
>> +// Comments:
>> +// Options: --no-includes --include-headers
>> +
>> +virtual report
>> +virtual org
>> +
>> +@r depends on org || report@
>> +identifier l, h, m;
>> +statement S;
>> +position p;
>> +// to match 1 in <<
>> +// to match 2 in /
>> +// Can't use exact values, e.g. 2, because it fails to match 2L.
>> +// TODO: Is there an isomorphism for 2, 2L, 2U, 2UL, 2ULL, etc?
>> +constant c;
> 
> As far as I can see, you aren't checking for 2 at all at the moment?

Yes, there are no false positives even without pinning constants to 1, 2.
However, it's better to express this in the rule.

> You
> should be able to say constant c = {2, 2L, etc};.  Actually, we do
> consider several variants of 0, so it could be reasonable to allow eg 2 to
> match other variants as well.

It looks like integer literals aren't fully supported. When I'm trying to write
'constant c = {2L}; ' it fails with int_of_string error.

Denis
