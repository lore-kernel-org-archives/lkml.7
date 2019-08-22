Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B2233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hMnkoT5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfHVXam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:30:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46389 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfHVXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:30:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so4563357pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pipHIj2z8t6n6jqMVgjlsl2tSXUd+7sKmIuVqD9kPY4=;
        b=hMnkoT5tbbKTZsnL0o1jbPhA9Rz8Qwpwy4McYBokvjjLVHvSW4wOMynuN5oMcP122a
         7WuQfzvAX0353Q+FkxsoKOMI95qLc2yuaJ1UYcq6w9RXgM4ouNA07MzId4svJ02rAvrs
         ZYfoOc+wEVTW6rnnvuG4FkOXzoQ9sH0pA1diY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pipHIj2z8t6n6jqMVgjlsl2tSXUd+7sKmIuVqD9kPY4=;
        b=c5U5WwgRrm1I71EXIIjyhbxp8Ubs6B/wTEaC4Q8bghgNgNgAZqPOJlJ6HI8DG7/aM1
         Ap4djLIuhoiSq7kBfNsKNwKlxQcA2lw23/88snw4Jdfnnz5ZWKdPrR8pfnsKoZwmXUff
         GlzBcRpl1OfgBy8KZWLWjhjXn0ZITJjA5L865faLUj464X6vZh4Xu8qdpxnLDpydFY7n
         a+yyJuhzMAsGLVR09d6cmWnDG9YWPYcLQMWGGqAMM3FkMnHbQ6ZcNu20IpkW2XD2YsCQ
         KWZNPCJ9sY8v4daR9vf6MjL3/88bnuo5B5qDs3slpWXe2uuiabSDBiWwr6uvFKo6M1c0
         3SKg==
X-Gm-Message-State: APjAAAU5rUKFsNEEBVuH6fqKoFmtibrU2Kq3ENgRrGVKRpmUSyL7mMBM
        HvR1sJAGNYDMViFx1uAWQjHfUA==
X-Google-Smtp-Source: APXvYqzKrKT+k/MJjU1tTcW0RKdJpKgeuPCz/JwywMw0aLkN5Y6KHgx4CNyQzDQLoks+nrLfaVWIWQ==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr2274285pje.130.1566516640592;
        Thu, 22 Aug 2019 16:30:40 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm526175pfc.22.2019.08.22.16.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 16:30:40 -0700 (PDT)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <20190822194712.GG16384@42.do-not-panic.com>
 <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
 <20190822211220.GR16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <009295ce-bdc5-61d8-b450-5fcdae041922@broadcom.com>
Date:   Thu, 22 Aug 2019 16:30:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822211220.GR16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2019-08-22 2:12 p.m., Luis Chamberlain wrote:
> On Thu, Aug 22, 2019 at 01:07:41PM -0700, Scott Branden wrote:
>> On 2019-08-22 12:47 p.m., Luis Chamberlain wrote:
>>> This implies you having to change the other callers, and while currently
>>> our list of drivers is small,
>> Yes, the list is small, very small.
>>
>> There is a single driver making a call to the existing API.
>>
>> And, the maintainer of that driver wanted
>> to start utilizing my enhanced API instead of the current API.
> You mean in the near term future? Your change makes it use the full file.
> Just checking.

The change in the patch keeps the existing functionality in the

qcom mdt_loader by reading the full file using the enhanced api.

I don't know when Bjorn will switch to use the partial firmware load:

https://lkml.org/lkml/2019/5/27/9

>
>> As such I think it is very reasonable to update the API right now.
> I'd prefer to see it separate, and we fix the race *before* we introduce
> the new functionality. I'll be poking at that shortly but I should note
> that I leave on vacation this weekend and won't be back for a good while.
> I already have an idea of how to approach this.
>
> When the current user want to use the new API it can do so, and then we
> just kill the older caller.

We can kill the older api right now as my patch in qcom mdt_loader

calls the new API which allows reading of full or partial files?

>
>>> following the history of the firmware API
>>> and the long history of debate of *how* we should evolve its API, its
>>> preferred we add yet another new caller for this functionality. So
>>> please add a new caller, and use EXPORT_SYMBOL_GPL().
>>>
>>> And while at it, pleaase use firmware_request_*() as the prefix, as we
>>> have want to use that as the instilled prefix. We have yet to complete
>>> the rename of the others older callers but its just a matter of time.
>>>
>>> So something like: firmware_request_into_buf_offset()
>> I would prefer to rename the API at this time given there is only a single
>> user.
>>
>> Otherwise I would need to duplicate quite a bit in the test code to support
>> testing the single user of the old api and then enhanced API.
>> Or, I can leave existing API in place and change the test case to
>> just test the enhanced API to keep things simpler in the test code?
> If the new user is going to move to the API once available I will be
> happy to then leave out testing for the older API. That would make
> sense.

I have switched the single user of the existing api to the new

API in the patch already?  And both full and partial reads using

the new API are tested with this patch series.  If you really insist

on keeping the old API for a single user I can drop that change from the

patch series and have the old request_firmware_api call simply

be a wrapper calling the new API.

>
> But if you do want to keep testing for the old API, and allow an easy
> removal for it on the test driver, wouldn't a function pointer suffice
> for which API call to use based on a boolean?
>
> But yeah if we're going to abandon the old mechanism I'm happy to skip
> its te

We can skip right now then.  As enhanced API is a superset of old API.

If you want the old API left in place I can just add the wrapper 
described and

only test the newly named function and thus indirectly test the old

request_firmware_into_buf.

> sting.
>
>    Luis
