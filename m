Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC7C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0134F24A28
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Mrz2Vdio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE3MeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:34:15 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38626 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3MeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:34:14 -0400
Received: by mail-it1-f195.google.com with SMTP id i63so4771905ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=EsfID8EQxz6/RRBN7JaozMUmaptV/iJMuglmTU1OygU=;
        b=Mrz2VdioQwlFg85VFNu0Gdw4peCAeOZHWiGBmrW37WSrJ43Hjq+ASqism38ga4NfDV
         sGVmJ5hXBl8EEWXwIxcnfNj6nWuSl2VjWxBPxiYMZcbZgvcQ39dqy2DKr47B28J2TAaF
         Xmp6KRiB1WZDgZuDtMoQRPrYLrCXaSr+4GnuUV7YkCN4TbAw/lvFBKtKWz8aChM9gXHJ
         6XKr/IzxsAYY1EpW2i0op0NbGCJJkQHPQm18E1IQHrQ8wKj7xLCP4kb3A4tQtYGcVEQ/
         GcPxuKn42JybQTX1QLK+db6L+gawno552KeMvYdFdq1ehN0fxrgiC5oJTyjo9UyfVnW2
         Aplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=EsfID8EQxz6/RRBN7JaozMUmaptV/iJMuglmTU1OygU=;
        b=ZUzN+UZODt3vddPSO6cm5XYrCkkvkgLZuglcQePrlH+mpaCD3FkvbAkCcVNWtK6tRR
         dI6U2MZhEFK1UwJIEW6hKaD3LkPpDvw/xSb/CBCxOIUQ6Zl0H7EzIOv9KG7DvLthIMZ5
         UN9JIFKKwETvewQVfJ9NHiy0hrNQ+zooBUF3eLaWS3Hma/FhJ6njImCRCFFvhjQnewHQ
         bVqbCXcW3PrWi4otUu5s4hBYYTTV7ku1EeoCefLdei5Z5Xr+4PiqwrKA3QNsnBcXtCmz
         oCjoeR2gPlxSwPK8f69GlhZe17Jim80eOnELVgsRXijHFFr9Zzu36EkEZEjAayDBSog2
         YpdA==
X-Gm-Message-State: APjAAAX3aWLsy89RorH9azY87RNrzMuwuMTIPI/djQVhy/q1OodISzwI
        +Fp8t/SNxNxEsIrAnywpoPxJUhqzBThhKQ==
X-Google-Smtp-Source: APXvYqxOBSmI9zDfQ3qg8oQb7MkxBh9PmHz4kqKXFn2DvHKMtLwPOCo/4ToGxhAxf7oFbv0E1Pd5IQ==
X-Received: by 2002:a24:2249:: with SMTP id o70mr2524547ito.101.1559219653896;
        Thu, 30 May 2019 05:34:13 -0700 (PDT)
Received: from [26.67.195.214] ([172.56.12.21])
        by smtp.gmail.com with ESMTPSA id c2sm851679iok.53.2019.05.30.05.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:34:13 -0700 (PDT)
Date:   Thu, 30 May 2019 14:34:06 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <29140f38-c713-109b-8b83-400191b81035@roeck-us.net>
References: <1559216447-28355-1-git-send-email-linux@roeck-us.net> <CAB50BEC-4816-4D92-AC46-921C62B1D344@brauner.io> <b4e3a71d-9892-f71c-3df5-4c721ff0ed75@roeck-us.net> <3C2871DE-8F84-4B5E-81CA-04B073E4B27D@brauner.io> <29140f38-c713-109b-8b83-400191b81035@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] samples: pidfd: Fix compile error seen if __NR_pidfd_send_signal is undefined
To:     Guenter Roeck <linux@roeck-us.net>, Jann Horn <jannh@google.com>
CC:     linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <B1D54C53-E639-4E0D-931D-2CEBE444A07E@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2019 2:29:43 PM GMT+02:00, Guenter Roeck <linux@roeck-us=2Enet> =
wrote:
>On 5/30/19 4:55 AM, Christian Brauner wrote:
>> On May 30, 2019 1:50:31 PM GMT+02:00, Guenter Roeck
><linux@roeck-us=2Enet> wrote:
>>> On 5/30/19 4:43 AM, Christian Brauner wrote:
>>>> On May 30, 2019 1:40:47 PM GMT+02:00, Guenter Roeck
>>> <linux@roeck-us=2Enet> wrote:
>>>>> To make pidfd-metadata compile on all arches, irrespective of
>>> whether
>>>>> or not syscall numbers are assigned, define the syscall number to
>-1
>>>>> if it isn't to cause the kernel to return -ENOSYS=2E
>>>>>
>>>>> Fixes: 43c6afee48d4 ("samples: show race-free pidfd metadata
>>> access")
>>>>> Cc: Christian Brauner <christian@brauner=2Eio>
>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us=2Enet>
>>>>> ---
>>>>> samples/pidfd/pidfd-metadata=2Ec | 4 ++++
>>>>> 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/samples/pidfd/pidfd-metadata=2Ec
>>>>> b/samples/pidfd/pidfd-metadata=2Ec
>>>>> index 640f5f757c57=2E=2E1e125ddde268 100644
>>>>> --- a/samples/pidfd/pidfd-metadata=2Ec
>>>>> +++ b/samples/pidfd/pidfd-metadata=2Ec
>>>>> @@ -21,6 +21,10 @@
>>>>> #define CLONE_PIDFD 0x00001000
>>>>> #endif
>>>>>
>>>>> +#ifndef __NR_pidfd_send_signal
>>>>> +#define __NR_pidfd_send_signal	-1
>>>>> +#endif
>>>>> +
>>>>> static int do_child(void *args)
>>>>> {
>>>>> 	printf("%d\n", getpid());
>>>>
>>>> Couldn't you just use the actual syscall number?
>>>> That should still fail if the kernel is to old
>>>> and still work on kernels that support it
>>>> but for whatever reason the unistd=2Eh h
>>>> header doesn't have it defined=2E
>>>>
>>>
>>> syscall numbers can differ from architecture to architecture, and
>the
>>> provided solution is used in other test code=2E Please feel free to
>>> submit
>>> a different patch, though - I am only interested in a fix, which
>>> doesn't
>>> have to be mine=2E
>>>
>>> Note that this fails in mips builds=2E
>>>
>>> Thanks,
>>> Guenter
>>=20
>> The syscall number is the same on all arches for this syscall=2E
>> It's been added after the syscall numbering
>> work by Arnd=2E
>>=20
>
>As I suggested, please feel free to submit a different patch to fix the
>problem=2E
>What you are saying may be correct, but I would not personally want to
>rely on it
>or create a hard assumption that it will always be the case=2E
>
>Thanks,
>Guenter

I'll pick this patch up=2E

Acked-by: Christian Brauner <christian@brauner=2Eio>
