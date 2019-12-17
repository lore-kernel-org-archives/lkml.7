Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D88206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+BAay/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLQNCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:02:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42087 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLQNCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:02:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so8616284qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMqoSPILaX9JqHTeF0FhgsNfEaaW/dXxRo7hcCgt0hc=;
        b=u+BAay/k8z46YMQwnBjhzt8KZee57iQcMPXQkL/vSg3ME9HGSoMZwnjKZTY3iVbcCu
         jkRLn85lhkvhT/yWssp23FEPRYD6U8SjJzfMQoqUstJruNPY4LC0F24X4CV3XrTvW4nQ
         xnAnjqGa73EwwCy721PBaJJuxz9FFmO8KwuSG5pSr+jZra+egiVt9a1anJnfaRG8+w4k
         ZEOr212xPvcRzsrPEkRjpkLNf4eHYJppj6sOeSdQU2wni2cfjGc9N5H8oEA4R1vsio06
         ekd0sQXUKeOgd/KcvspmWPnF39lR1SyY0hx5WQhpYXyG39rA+ETXezhgJ+gmoVthEu36
         7kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMqoSPILaX9JqHTeF0FhgsNfEaaW/dXxRo7hcCgt0hc=;
        b=ZABP1T5SqRyliKeO/Kp7Wm/SSIRwL/nG8wCoa426osKDA6C5dWGh78/q4zs9hbpB+m
         MVdVPei0W4wKY/yYOWQOOEJY7o5OpJj9TMvVNM8GTZmfUXNowWReKySaJ8Qsgpk5yIcc
         FRd/juM1R0AGtY5bJHtuAJZglspzNXrNkUkbUgWFkjbBKz4GKCCla46IcG5tOXlHcHck
         o2j9pNapJpJQ8nksgUkV2UIVEBiE0nMvVSE+jefP8gq40d+V8vDkYz/3y9yqg5cvnY9F
         bkCdjfEKcmnhuAdID1U622qaccUVj6jBCr2c0Er5IZc6lBjgKu2NC/NOvQlSo4ml1p/6
         R9OQ==
X-Gm-Message-State: APjAAAVVNDFSvYzmz7yXFDBZ/8bcKHsPSpBmp30pq7qcH8woZEFKc7tl
        X6Vm0vws/agsH//pXwlAK4dFXZbTMevBC/37TBaRKA==
X-Google-Smtp-Source: APXvYqwlcCZnbzsPbkcJCV8plRndTi9Q+27Roq6PvhYzkEwLCVOLNrP+Hj5ppaMTnhDqa8Y7FH4b0WyHqBS+LnXLqH8=
X-Received: by 2002:ac8:30f7:: with SMTP id w52mr4392848qta.380.1576587772044;
 Tue, 17 Dec 2019 05:02:52 -0800 (PST)
MIME-Version: 1.0
References: <3c4608bc-9c84-d79b-de76-b1a1a2a4fb6d@gmail.com>
In-Reply-To: <3c4608bc-9c84-d79b-de76-b1a1a2a4fb6d@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 14:02:40 +0100
Message-ID: <CACT4Y+b3nvFAgM32SF0Bv46EOO4UFEK3M99pqYzEwmsmLvmhTQ@mail.gmail.com>
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

On Tue, Dec 17, 2019 at 1:56 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> The kernel may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
>
> kernel/kcov.c, 237:
>      vfree in kcov_put
> kernel/kcov.c, 413:
>      kcov_put in kcov_ioctl_locked
> kernel/kcov.c, 427:
>      kcov_ioctl_locked in kcov_ioctl
> kernel/kcov.c, 426:
>      spin_lock in kcov_ioctl
>
> vfree() can sleep at runtime.
>
> I am not sure how to properly fix this possible bug, so I only report it.
> A possible way is to replace vfree() with kfree(), and replace related
> calls to vmalloc() with kmalloc().
>
> This bug is found by a static analysis tool STCheck written by myself.

Hi Jia-Ju,

Are you sure kcov_ioctl_locked can really release the descriptor? It
happens in the context of ioctl, which means there is an open
reference for the file descriptor. So ioctl should not do vfree I
would assume.
