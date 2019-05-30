Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83629248B4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTDSK9NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE3M3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:29:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3M3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:29:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so3877983pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hFlzPJiE7eeheJcBBg2ho7OReqyleg0TFf5mxqcXWh8=;
        b=ZTDSK9NZ22pROK3/Hh7Mcr5ZyPo9XLvXK/iYFNQcyRV7FMay0RjaEFh1anwN2bb1rg
         zUnEEE7rBboN0xD8aNv7EipO5xfd0iThgFu7jt/DDuCCGkhaJ7eofZYnualh7UI1fWsc
         B51WTyo89aF8nCYpvMhdMzfRWT3TjZecBa0UgMJ61P3TT/DfhbfHEhnfOnUvBttOdxip
         NlmrtVuVsM+ewwj3qD533PQKlO6AJWddhiMfsT+XSSb33G3ysO8pU70kFa3OonUSjV1G
         KCMQXZzHS/QtJ69IVJjYG1qY9r1mctF+Xp4AMORftVEeDtSyPglSkDEh3biaNEPAYRW9
         PTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hFlzPJiE7eeheJcBBg2ho7OReqyleg0TFf5mxqcXWh8=;
        b=Uz6TuDmF7h8m98TYbLolJjDsjcrZyN0kJShU48mXwfJzyUEwnUAIW0D8yLKXpO0JMQ
         sR/xHhMBOkNmwyjorNbbnlbmbswhYeEUs7OjJcUM7Bolj9/Y1W30Al3KVdzIbaSPXacB
         MZEedvo4tBufcsiJvvZ74dUeXOVTM6+S9rMS4h6xFf/fnZEBch21+g6P2JnvdLnQrdHn
         tuYjpU6tGAhh/6T0961W+9ILhGzSmrLNEr28PnAA2Muiv2gSfvxJcKLZPKGm7Api4moO
         xLKW2DiAek2cR4jNhedQzPfpaN0DuNjG2s2+WWHnY4cN+UouPPOeYS5o3szbFn1HA1Wv
         2xeA==
X-Gm-Message-State: APjAAAVKHo33Y5HlHB2DIc3g+aPblBfgDChtWFKMpyfsoz2yaJl1M+4d
        W2zgoRfDaGcuNEOXMe+mUmBfNLel
X-Google-Smtp-Source: APXvYqxEhObzOidVVZ98OT7SjHJNupYKgb9JPBnhUPubfIb+VEnf5JidKT3yuN8U1tlddQzL5tmCLg==
X-Received: by 2002:a63:9d09:: with SMTP id i9mr3395991pgd.195.1559219387087;
        Thu, 30 May 2019 05:29:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10sm5695739pgh.43.2019.05.30.05.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:29:45 -0700 (PDT)
Subject: Re: [PATCH] samples: pidfd: Fix compile error seen if
 __NR_pidfd_send_signal is undefined
To:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <1559216447-28355-1-git-send-email-linux@roeck-us.net>
 <CAB50BEC-4816-4D92-AC46-921C62B1D344@brauner.io>
 <b4e3a71d-9892-f71c-3df5-4c721ff0ed75@roeck-us.net>
 <3C2871DE-8F84-4B5E-81CA-04B073E4B27D@brauner.io>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <29140f38-c713-109b-8b83-400191b81035@roeck-us.net>
Date:   Thu, 30 May 2019 05:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3C2871DE-8F84-4B5E-81CA-04B073E4B27D@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 4:55 AM, Christian Brauner wrote:
> On May 30, 2019 1:50:31 PM GMT+02:00, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/30/19 4:43 AM, Christian Brauner wrote:
>>> On May 30, 2019 1:40:47 PM GMT+02:00, Guenter Roeck
>> <linux@roeck-us.net> wrote:
>>>> To make pidfd-metadata compile on all arches, irrespective of
>> whether
>>>> or not syscall numbers are assigned, define the syscall number to -1
>>>> if it isn't to cause the kernel to return -ENOSYS.
>>>>
>>>> Fixes: 43c6afee48d4 ("samples: show race-free pidfd metadata
>> access")
>>>> Cc: Christian Brauner <christian@brauner.io>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> samples/pidfd/pidfd-metadata.c | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/samples/pidfd/pidfd-metadata.c
>>>> b/samples/pidfd/pidfd-metadata.c
>>>> index 640f5f757c57..1e125ddde268 100644
>>>> --- a/samples/pidfd/pidfd-metadata.c
>>>> +++ b/samples/pidfd/pidfd-metadata.c
>>>> @@ -21,6 +21,10 @@
>>>> #define CLONE_PIDFD 0x00001000
>>>> #endif
>>>>
>>>> +#ifndef __NR_pidfd_send_signal
>>>> +#define __NR_pidfd_send_signal	-1
>>>> +#endif
>>>> +
>>>> static int do_child(void *args)
>>>> {
>>>> 	printf("%d\n", getpid());
>>>
>>> Couldn't you just use the actual syscall number?
>>> That should still fail if the kernel is to old
>>> and still work on kernels that support it
>>> but for whatever reason the unistd.h h
>>> header doesn't have it defined.
>>>
>>
>> syscall numbers can differ from architecture to architecture, and the
>> provided solution is used in other test code. Please feel free to
>> submit
>> a different patch, though - I am only interested in a fix, which
>> doesn't
>> have to be mine.
>>
>> Note that this fails in mips builds.
>>
>> Thanks,
>> Guenter
> 
> The syscall number is the same on all arches for this syscall.
> It's been added after the syscall numbering
> work by Arnd.
> 

As I suggested, please feel free to submit a different patch to fix the problem.
What you are saying may be correct, but I would not personally want to rely on it
or create a hard assumption that it will always be the case.

Thanks,
Guenter
