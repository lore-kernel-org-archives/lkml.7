Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F892C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2172082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ApmwI4Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDJWEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:04:40 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32933 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:04:40 -0400
Received: by mail-ua1-f65.google.com with SMTP id g8so1347637uaj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4aWi1wS1YVslWR356uZkvbxTdDNY3mN7eypptxf9C0=;
        b=ApmwI4ZcQfswleBNbXyLxhMXm1d+7sqwfTN58Einw3Dqtx6ypqsh+9AM6pLtWMhxVC
         eyu90o0jB/cz+n4gvjah8F6RptUlf+Qri7k38ErtsQzNIb+YujNSbVNlG6CY5ikH0ygg
         pSVsWKS26hXJi3mlsC+0N9JQySNp3FrSd84EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4aWi1wS1YVslWR356uZkvbxTdDNY3mN7eypptxf9C0=;
        b=PNqKwsq9LR4pmofCUhdACV1wKXBXr6If5Kra7+PI4Y4LzgNjU8bcc+41CM4SjAq5Gw
         uEjMy/zwy4JU/tHRKKApFtcoqwc+uuyzQ/JuEwLe82Xfe2bgMZfr5JVq4aRwyXVhA3tr
         1ilgOLhzQ+muT5cmJ5F4wXXm5U+ifqh9ZNcjo+X/gOeavwYTiZfGf1ukp5iOOnln22Wb
         NXMg3I8Q4vpyxHCx8ec8CNWnjP95B0qYGo0FrlVhBcn3ODIhOhYe9DWCiADXswQjNh9D
         SgTX89CMFXxFzoFttNiZ/DFfoc4adDw3BVjY2ZVKQDK2vwO3/CH+i6ko5cpZxlnOXdgD
         zBVg==
X-Gm-Message-State: APjAAAXpAhP2uw2G1hdnseZKYZXE1Oi8YnMN49qks+q8EJoqCVU8wDne
        R/rZIYpvik8gDGEvW6uyaO6lHCxYoZk=
X-Google-Smtp-Source: APXvYqz/WnhkayfsPPNV427ekvbmVqd+zvh7qnHPeBgPl9+gUZrQ9yFhGcY3Breekd0FYB+tBJV4WQ==
X-Received: by 2002:ab0:2144:: with SMTP id t4mr23592396ual.65.1554933878144;
        Wed, 10 Apr 2019 15:04:38 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 2sm15774539vke.27.2019.04.10.15.04.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:04:37 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id l17so1340856uar.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:04:36 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr19404515uah.80.1554933876328;
 Wed, 10 Apr 2019 15:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190410212627.29514-1-okaya@kernel.org> <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
In-Reply-To: <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:04:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
Message-ID: <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 2:54 PM Sinan Kaya <Okaya@kernel.org> wrote:
>
> On 4/10/2019 5:45 PM, Kees Cook wrote:
> > On Wed, Apr 10, 2019 at 2:26 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> We can't seem to have a kernel with CONFIG_EXPERT set but
> >> CONFIG_DEBUG_KERNEL unset these days.
> >>
> >> While some of the features under the CONFIG_EXPERT require
> >> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
> >>
> >> The meaning of CONFIG_EXPERT and CONFIG_DEBUG_KERNEL has been
> >> mixed here.
> >
> > I don't agree: the point of EXPERT is to show _everything_, which
> > means DEBUG_KERNEL should be selected to show those options as well. I
> > think this is fine as-is. What is the problem you want to solve?
> >
> > I think of it as low (nothing selected) medium (DEBUG_KERNEL) and high
> > (EXPERT and DEBUG_KERNEL). So EXPERT enables DEBUG_KERNEL too.
> >
>
> Sure, let's see if there is a better option.
>
> I don't want any of the debug features in my kernel but still
> need all the expert features. My kernel is considered a production
> kernel. I don't really want to ship all the good debug enables.

Production kernels enable it. e.g. Ubuntu:
$ grep '\bCONFIG_DEBUG_KERNEL\b' /boot/config-$(uname -r)
CONFIG_DEBUG_KERNEL=y

> On the other hand, I need the features under CONFIG_EXPERT to have
> a functional system.
>
> Let's take "multiple users" as an example.
>
> What's the point of having a kernel without multiple users? :)
>
> I don't see the relationship between CONFIG_DEBUG and CONFIG_EXPERT
> as none of the features except KALLSYMS depend on it. If there was
> a compile time dependency, I'd say move it to the things that need
> it as this patch suggests.

CONFIG_DEBUG_KERNEL mainly only enables the visibility of various
other options. I can only find two instances of it controlling a
"default", and one is overridden by CONFIG_SMP on alpha. :)

$ git grep -B2 'default.*DEBUG_KERNEL'
arch/alpha/Kconfig.debug-config MATHEMU
arch/alpha/Kconfig.debug-       tristate "Kernel FP software
completion" if DEBUG_KERNEL && !SMP
arch/alpha/Kconfig.debug:       default y if !DEBUG_KERNEL || SMP
--
kernel/trace/Kconfig-menuconfig FTRACE
kernel/trace/Kconfig-   bool "Tracers"
kernel/trace/Kconfig:   default y if DEBUG_KERNEL

What do you see enabled that CONFIG_DEBUG_KERNEL enables that you don't want?

-- 
Kees Cook
