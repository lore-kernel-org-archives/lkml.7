Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE99C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BAC20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfGHKSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:18:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfGHKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:18:52 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiIhU-1iOhhf3G5u-00fPo6; Mon, 08 Jul 2019 12:18:49 +0200
Subject: Re: [PATCH] mfd: asic3: One function call less in asic3_irq_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
 <20190707005251.GQ17978@ZenIV.linux.org.uk>
 <4b06e2fb-a0ba-56e5-b46b-98e986e6f2fd@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <6e8eab5f-1f5c-b3dc-6b65-96a874ec2789@metux.net>
Date:   Mon, 8 Jul 2019 12:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4b06e2fb-a0ba-56e5-b46b-98e986e6f2fd@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wZhPg0d2X13sXXJjtQQzyQirdFpfMpeqPVXZaZlM41GPJExzFCm
 Yw1C+00phsDHeK8fj/B0Jz3mjzhpy0c4vYxqe3T8coHtaCQMJwzl6uptENFSXwIO9xuTJzd
 /QcZoWB2br6snlxnJ3BTEovycqeQOqQXkjIQ+m8c9XM2yVEWHj3ch4hPfL+5qZ3qZkQ1Mlk
 awHv+xu7ro7PiwXuaK5kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/dZ6YzWsiE=:yd5q3Vgf9pRCN5gJDxbbcL
 xoxWY4mSkFE7gPPF4vO5p4el2qryucwMFujowPu81wrOt4m2kXMD1qHk8nhPOtxS0+LApVG0Q
 RWj+GmJyQm9xv/qSRyAD4AHvWRubZDATHNEI1J7VgfPCRcO8LP8x+PZM+V38nHgCnk4jQnJEE
 smqNVdTizDPJPTd6e0f+VnDbPQI4goDcQzLB1DBFp3Pe7pHT52KgQWB46X0iLzZRBI7H53X1G
 bj9OdTSKmjlHhuvJIYnxTqU4GooY4lCCPGtpgUgDOh0XAzGTRDIgUZHISMoF0/MVFJ6yekiU7
 YpPZBJqwcR2eT40ULUppI9Bffl9wsO7q98TJilMK7eyHsRfKwyMJ+eK2F33JoF3OnRYP3GDvo
 n40U6P9olyDakCKDcSSLWES2AvkVh65oZTv/6clkq9tMhFKSYEIYj/bbtIohD09/uRsRFW+SK
 YPw3WF+jYqZepazS1RgBmuXs26wfJ43K1cTge4e2tnMZRje6FPJSM3nN32tinSQ7QEcvgNSPB
 pnLNQaz6KrmYjJ17WDJEDrcNTEWm5PMl5s9ouvlBnxk8ZpQnlrDvYzRLlN7B4j0Nq6/dkAVAy
 DtjExW+RwASd8weyQVLsoCT5Qez41R7rQCJmkCSqaaneXD7PNko35N7YQw3YJxJLHU2Tw8Waf
 YZ5VfkTDwINKj32GCVxljK08LpCACWloa/WCf2OtStIS9Yei2cd3Py5GYO+Mkez81vKPGJ+Hj
 1AwTJkAfoT0BiqOVyZlgnibStcTR+C/X8K4uyGJhu4YFxqhoWsReZGvV3KA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.19 09:56, Markus Elfring wrote:
>>> Avoid an extra function call by using a ternary operator instead of
>>> a conditional statement.
>>
>> Which is a good thing, because...?
> 
> I suggest to reduce a bit of duplicate source code also at this place.

Duplicate code (logic) or just characters ?

IMHO, readability is an important aspect, so we could be careful about
that. Some of your other patches IMHO made it actually a bit easier
to read, but this particular case doesnt seem so to (just according
to my personal taste).

I believe the compiler can do optimize that, based on the given flags.
(eg. size vs. speed). Therefore, I think that readability for the
human reader should be primary argument.

>> ... except that the result is not objectively better by any real criteria.
> 
> We can have different opinions about the criteria which are relevant here.

Which criterias are you operating on ?

> I dare to point another change possibility out.
> I am unsure if this adjustment will be picked up finally.

I think it's good that you're using tools like cocci for pointing out
*possible* points of useful refactoring. But that doesn't mean that a
particular patch can be accepted or not in the greater context.

Note that such issues are pretty subjective - it's not a technical but
an asthetic matter, so such issues can't be resolved by logic. Here, the
better something fits the personal taste of the maintainrs, the easier
it is for them to quickly understand the code (w/o having to give it any
deeper thoughts), thus reduces their brain load. Therefore that should
be the the primary argument left.

Don't see this as a judgment of your work as such - this kind of work
just tends to have a high rate of non-acceptable output (unless the
individual maintainer doing it himself).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
