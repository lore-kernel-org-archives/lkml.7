Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47468C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B2B206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BybHCU4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfLQNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:14:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37905 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLQNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:14:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so1002169qtp.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hxHSznfGSxmFv1YcCaQUB87Luggj5Op/zVMd6ctM0Q=;
        b=BybHCU4AaS6uGhJ9v2cwyHNDrNPFgB3wBQP2+U74AQULalxmshgSnKjbFLaBBywatb
         MfjhCV/seKEtfdfgJO1wlfZmNLl9RciSue2tiZbfDghrYfWu00KuuTIDe/kajZRVSpBv
         GbTcbcPCOl//Ku1pAn/R8UulYUnTL1ffddG0pKo49KOYswTDxOWPzyz73XEoOuouHwAF
         HOrFQm9DsoNPLW306DZa0OwZdT358FY49k6XARlMPrsfCZZnBR6e0Nb5bNiCU15gg0lr
         yxJypLM1121j7GU7LIF0gyBdCcv6ioPnSahtCBZXcveKafU5seT1vGu1z2b/HhqjPNxR
         J3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hxHSznfGSxmFv1YcCaQUB87Luggj5Op/zVMd6ctM0Q=;
        b=VNWPql507sRZrAZo7FOD8aSi+OYjTSWPUCcTjgz8F/9SNRs1CnwIaIfRAloSFS0FUR
         uKehTCExcprIv4kcVCObNOhEMNUW2QnC0aIA2Giu3banP0zZpqLfVbp1nUxREAzU32l/
         9I52f8cnevRqIYlkHQCwa3eXqap8jXTjbMUCNug+3LnVgfmPEWSQzDujunDWUvjtBUIZ
         FbtepPUDkBQA/KTdMv7p7SkeOzg+5hijrEHpDu0JTnllO0t5AE11w6cSUszmdau+sQkJ
         NfeJn4ehCu2QHkfhiX4V5vErCQsH6+rHGEMrGe+xFoX+b6UYH9t8WhnJuJe1Lbe9vFS6
         4TPw==
X-Gm-Message-State: APjAAAWi4FSixpG0aLjahYeQ6PTyLZJul0UBXgQUhxX7wGXwh8v02q6T
        LH78+PknE7Q6bURYxAezthsKLQ68VxsWrda6x4GkNw==
X-Google-Smtp-Source: APXvYqz5Jx0MFPW0vC7/p0drF+0gKehqljZHBUo1H2aq8mFouh6mTzEkafP3B772ZeLCvgYgQU+ECJlvVmXTGFD2vhY=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr4484869qtp.50.1576588443442;
 Tue, 17 Dec 2019 05:14:03 -0800 (PST)
MIME-Version: 1.0
References: <3c4608bc-9c84-d79b-de76-b1a1a2a4fb6d@gmail.com>
 <CACT4Y+b3nvFAgM32SF0Bv46EOO4UFEK3M99pqYzEwmsmLvmhTQ@mail.gmail.com> <e0305f5c-ae52-c144-fe50-00f3f815ad82@gmail.com>
In-Reply-To: <e0305f5c-ae52-c144-fe50-00f3f815ad82@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 14:13:52 +0100
Message-ID: <CACT4Y+YLxmFTkDT88z9y5yH75bAi42-Hqatv9z2-EyufTtKHRw@mail.gmail.com>
Subject: Re: [BUG] kernel: kcov: a possible sleep-in-atomic-context bug in kcov_ioctl()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 2:11 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> On 2019/12/17 21:02, Dmitry Vyukov wrote:
> > On Tue, Dec 17, 2019 at 1:56 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> >> The kernel may sleep while holding a spinlock.
> >> The function call path (from bottom to top) in Linux 4.19 is:
> >>
> >> kernel/kcov.c, 237:
> >>       vfree in kcov_put
> >> kernel/kcov.c, 413:
> >>       kcov_put in kcov_ioctl_locked
> >> kernel/kcov.c, 427:
> >>       kcov_ioctl_locked in kcov_ioctl
> >> kernel/kcov.c, 426:
> >>       spin_lock in kcov_ioctl
> >>
> >> vfree() can sleep at runtime.
> >>
> >> I am not sure how to properly fix this possible bug, so I only report it.
> >> A possible way is to replace vfree() with kfree(), and replace related
> >> calls to vmalloc() with kmalloc().
> >>
> >> This bug is found by a static analysis tool STCheck written by myself.
> > Hi Jia-Ju,
> >
> > Are you sure kcov_ioctl_locked can really release the descriptor? It
> > happens in the context of ioctl, which means there is an open
> > reference for the file descriptor. So ioctl should not do vfree I
> > would assume.
>
> Thanks for the reply :)
> I am not sure, because I am not familiar with kcov.
> But looking at the code, if the reference count of kcov is 1, vfree()
> could be called.

That kcov_put should never call vfree. We still hold reference
associated with the file, which will be released in kcov_close.
