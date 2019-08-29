Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FBC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC68233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfH2I1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfH2I1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:27:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFD47AFF9;
        Thu, 29 Aug 2019 08:27:05 +0000 (UTC)
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
To:     Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        metux IT consult Enrico Weigelt <lkml@metux.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <74303921-aa95-9962-2254-27e556af54f4@kleine-koenig.org>
 <20190829081249.3zvvsa4ggb5pfozl@pathway.suse.cz>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <45cd5b50-9854-fce7-5f08-f7660abb8691@suse.com>
Date:   Thu, 29 Aug 2019 10:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829081249.3zvvsa4ggb5pfozl@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.19 10:12, Petr Mladek wrote:
> On Wed 2019-08-28 21:18:37, Uwe Kleine-König  wrote:
>> Hello Petr,
>>
>> On 8/28/19 1:32 PM, Petr Mladek wrote:
>>> On Tue 2019-08-27 23:12:44, Uwe Kleine-König  wrote:
>>>> Petr Mladek had some concerns:
>>>>> There are ideas to make the code even more tricky to reduce
>>>>> the size, keep it fast.
>>>>
>>>> I think Enrico Weigelt's suggestion to use a case is the best
>>>> performance-wise so that's what I picked up. Also I hope that
>>>> performance isn't that important because the need to print an error
>>>> should not be so common that it really hurts in production.
> 
> This is contadicting. The "best" performance-wise solution was
> choosen in favor of space. The next sentence says that performance
> is not important.
> 
>>> I personally do not like switch/case. It is a lot of code.
>>> I wonder if it even saved some space.
>>
>> I guess we have to die either way. Either it is quick or it is space
>> efficient.
> 
> I am more concerned about the size. Well, array of strings will
> be both fast and size efficient.
> 
>> With the big case I trust the compiler to pick something
>> sensible expecting that it adapts for example to -Osize.
> 
> I am not sure what are the expectations here. I can't imagine
> another translation than:
> 
>     if (val == 1)
>       str = "EPERM";
>     else if (val == 2)
>       str = "ENOENT"
>     else if (val == 3)
>       str = "ESRCH"
>     ...
> 
> It means that all constans will be hardcoded in the code instead
> of in data section. Plus there will be instructions for each
> if/else part.
> 
>>> If you want to safe space, I would use u16 to store the numbers.
>>> Or I would use array of strings. There will be only few holes.
>>>
>>> You might also consider handling only the most commonly
>>> used codes from errno.h and errno-base.h (1..133). There will
>>> be no holes and the codes are stable.
>>
>> I'd like to postpone the discussion about "how" until we agreed about
>> the "if at all".
> 
> It seems that all people like this feature.

Hmm, what about already existing format strings conatining "%dE"?

Yes, I could find only one (drivers/staging/speakup/speakup_bns.c), but
nevertheless...

> 
> BTW: I though more about generating or cut&pasting the arrary.
> I can't find any reasonable way how to generate it.

Generate the array and errno.h/errno-base.h from the same source?


Juergen
