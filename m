Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A276C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC5F2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCMNY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:24:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46852 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:24:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id i5so1021322qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZeJ3NNaRP26nEXpWMX7nvnHeisnf3Hy47e8EtFPvvU=;
        b=Mh7rwfwnqcNH2TMh/WwP+qgRrGiO86BO7m4IiEE03Pt9eKESn//X3bnSLDTSH5mB2O
         9VbBjmTzndjueo0hIwyiqa92rR2hCYbk8MxiGJKbxC8chzvTIL7z8qIFUzWiQrWKxkOz
         ZOreuHLi3odsKije0lZ8Lb0NRLDQrb2JnGBwZu9Owfj9fCc2GzEpJvY8nQWtf0QLpQLw
         X9Fcn3d5FI1N4/vipOBqJfKJ26U3CtVEueJKoOjR0xpjVhHfOJMmJYoJAthOBziWcmKQ
         SV48lhn8WBPQI2n9n5WlZONRJTi1xjvyp4nYCWJlDIBcLsET7bKn6KJilt9XLqJMMYws
         NFEQ==
X-Gm-Message-State: APjAAAXJbUrzodxIUTczUrViKA6fo0qXhB8alYJu8IRUVI33Ng0vnmhN
        +AqxTYIQW7IYJ2Plpy3yQ3sRslchOMFwJOEMLuQ=
X-Google-Smtp-Source: APXvYqyEb/kYJ238BSFaBG5LGlhQem8Nym0+CkaPGjskctag+4Cqeo0Y2qKg2UNe/n2DFN82sjOSFKiJEKIOcErn7/Q=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr33122517qki.291.1552483494186;
 Wed, 13 Mar 2019 06:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190313131438.8212-1-mpe@ellerman.id.au>
In-Reply-To: <20190313131438.8212-1-mpe@ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 14:24:35 +0100
Message-ID: <CAK8P3a0A9dbneHo7_CrgiPS8ROaV1bWrYWJUh5Zo2FfEuABfhw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies
 across Y2038
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, jaydee@email.cz,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 2:14 PM Michael Ellerman <mpe@ellerman.id.au> wrote:

> That causes CLOCK_MONOTONIC to jump ahead by ~4 billion seconds which
> it is not meant to do. Worse, if the time is then set back before the
> Y2038 boundary CLOCK_MONOTONIC will jump backward.
>
> We can fix it simply by storing the full 64-bit offset in the
> vdso_data, and using that in the VDSO assembly code. We also shuffle
> some of the fields in vdso_data to avoid creating a hole.

I see nothing wrong with your patch, but I would point out that there is
a patch series [1] from Vincenzo Frascino to unify the vdso implementation
across architectures that I hope can make it into linux-5.2, and that will
resolve this issue, as well as allow 32-bit architectures to provide
a working interface with 64-bit time_t.

      Arnd

[1] https://lore.kernel.org/linux-arm-kernel/20190222122430.21180-1-vincenzo.frascino@arm.com/
