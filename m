Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8678C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633525889
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="K9uQ1yE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfE3LzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:55:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfE3LzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:55:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id h1so4034459wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=fp8w61/sXd/cMGRwN+CUPEh3aDFreFtZ+1N4JDzWGWY=;
        b=K9uQ1yE7GDKMFwVeCVTJc6F4fvEKOgM7aCV/xt7i1VjkBDAbc5bNnfu6PRB/bGoeiO
         8c6gH2XWZxwWjnu6JQX/Kh1xcYaaY5wViMWd1ZgpHHOYkLegawZ+QYJvCnRADBMLjs+A
         afAQBT0dfpuvob8uiIitJPG3gi+CcBv6PntxMXR5DcvClfblHw0ft4teQ4yYE43htMVI
         Xh9K6afgx/4dLxw1Avh3SHTgmZJ3t/RWqp03PR2r6jxVQflfsx23yfXFb8wdDbdLE0Xf
         XWMLlU+LsgnEz4Gx9h8+bTmzxAyQrpEVQ08m63RXb2JErHzCutwmKZVlKF+n3kskHmpf
         e1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=fp8w61/sXd/cMGRwN+CUPEh3aDFreFtZ+1N4JDzWGWY=;
        b=jb4aO3DSGbeRli8VSaYJLAJ94iTFJ2ZQpqI/y7D1d0g/9aXr8vYhqWx6CsMvdvQk+B
         oEk6shvgp4SXEmu4KoLBl9xAQAH/8q6OM6Lsx0Fwy4va5qo+HpCaQj4b+h9ePxT3+E5+
         EsUqxqB7jXFpfAFBetwJRL0MKsxYe1EP4ubRmUl7RUKi7SwVglNUhenq70NUeX5wlA2E
         79jXLr58nHtBQEJa2o883JamUcu5sAlb7fYcWXq5KFcBzokWZ+MuN/u1UF1XvbGZmF31
         XAYRgbikNUl+Twp3HunLhaZ7/8Kqf7HW5xUPYQ1NQ2zZeOUpLfWb/tlfuJfzR3btMaRq
         r1pg==
X-Gm-Message-State: APjAAAXj3q9ToTZ8FKYaYgIja3gUCl7KNeldS8MLPqXY9rfC4C3OG6iR
        t5+J4+Juo+qekKZ+3kHoIW5S0g==
X-Google-Smtp-Source: APXvYqz6sFyNjjHcwBpS+Jm0SBEiuIWJGYm3n1mxxgEXLwa+lEb8AkRorOAyF2xDMwEHgU9WyG6FNw==
X-Received: by 2002:adf:f041:: with SMTP id t1mr2358945wro.74.1559217308820;
        Thu, 30 May 2019 04:55:08 -0700 (PDT)
Received: from [192.168.1.161] (93-32-55-82.ip32.fastwebnet.it. [93.32.55.82])
        by smtp.gmail.com with ESMTPSA id h200sm3734380wme.11.2019.05.30.04.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:55:08 -0700 (PDT)
Date:   Thu, 30 May 2019 13:55:06 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <b4e3a71d-9892-f71c-3df5-4c721ff0ed75@roeck-us.net>
References: <1559216447-28355-1-git-send-email-linux@roeck-us.net> <CAB50BEC-4816-4D92-AC46-921C62B1D344@brauner.io> <b4e3a71d-9892-f71c-3df5-4c721ff0ed75@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] samples: pidfd: Fix compile error seen if __NR_pidfd_send_signal is undefined
To:     Guenter Roeck <linux@roeck-us.net>, Jann Horn <jannh@google.com>
CC:     linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <3C2871DE-8F84-4B5E-81CA-04B073E4B27D@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2019 1:50:31 PM GMT+02:00, Guenter Roeck <linux@roeck-us=2Enet> =
wrote:
>On 5/30/19 4:43 AM, Christian Brauner wrote:
>> On May 30, 2019 1:40:47 PM GMT+02:00, Guenter Roeck
><linux@roeck-us=2Enet> wrote:
>>> To make pidfd-metadata compile on all arches, irrespective of
>whether
>>> or not syscall numbers are assigned, define the syscall number to -1
>>> if it isn't to cause the kernel to return -ENOSYS=2E
>>>
>>> Fixes: 43c6afee48d4 ("samples: show race-free pidfd metadata
>access")
>>> Cc: Christian Brauner <christian@brauner=2Eio>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us=2Enet>
>>> ---
>>> samples/pidfd/pidfd-metadata=2Ec | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/samples/pidfd/pidfd-metadata=2Ec
>>> b/samples/pidfd/pidfd-metadata=2Ec
>>> index 640f5f757c57=2E=2E1e125ddde268 100644
>>> --- a/samples/pidfd/pidfd-metadata=2Ec
>>> +++ b/samples/pidfd/pidfd-metadata=2Ec
>>> @@ -21,6 +21,10 @@
>>> #define CLONE_PIDFD 0x00001000
>>> #endif
>>>
>>> +#ifndef __NR_pidfd_send_signal
>>> +#define __NR_pidfd_send_signal	-1
>>> +#endif
>>> +
>>> static int do_child(void *args)
>>> {
>>> 	printf("%d\n", getpid());
>>=20
>> Couldn't you just use the actual syscall number?
>> That should still fail if the kernel is to old
>> and still work on kernels that support it
>> but for whatever reason the unistd=2Eh h
>> header doesn't have it defined=2E
>>=20
>
>syscall numbers can differ from architecture to architecture, and the
>provided solution is used in other test code=2E Please feel free to
>submit
>a different patch, though - I am only interested in a fix, which
>doesn't
>have to be mine=2E
>
>Note that this fails in mips builds=2E
>
>Thanks,
>Guenter

The syscall number is the same on all arches for this syscall=2E
It's been added after the syscall numbering
work by Arnd=2E

Christian
