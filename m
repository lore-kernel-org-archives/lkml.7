Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95000C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D2C206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OK7y4D8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfFFXkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:40:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42842 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfFFXkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:40:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so58868plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zupcycHQhyZT5TPbzZH69TXNfK4PGS1TsnXYmh2heXA=;
        b=OK7y4D8OareDzwfMyIRJGXrsJrkBCTjHx+5e2R1/XnVCdlMIeUq2ylw1JdESiMjw4U
         vQuzE8d1AM5MapxQeB4XiUvJKPY9nfGTyJlfyEYbAf0cX6CGSM1fTIOoHvwvr8N89Fwz
         oKuJdZJ1czJp/0Awj+h8sAVxQNfO0Iyaa+Nu8ToGeJcB6izf81oFHFtnMGT2gOAc+zLf
         YhEPKHZQLHD8ZPVr6sOBalOoiKDdbP2er0moAg9N8sP/yQTvr/fJRlLyZxbUTLfxT+Nd
         SMQAWURCIlVmkk6htR9ZFo+Zq8eXp8j1EypQH3Tr8EqXWAx/dtpgQkohFh5HoSD/8mmt
         3vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zupcycHQhyZT5TPbzZH69TXNfK4PGS1TsnXYmh2heXA=;
        b=EV2ArIQEKJ047feQkYc/Ljt+QOTPqHCeOcv3W0qufHScNnSLWh1tE9CNusaDQWXT4/
         LURifOoNZUIqIVW7VUJTei4RnlcathRDmvqpAVYYyiTcZ5FqySz9L3CpU25oVbkQuDBm
         xib/OTRoHAV0ni4+Zq3/MQnx30eMsbC0mNuNTGAShSqtsrYWUg/B5ukKliYcgaumhs6U
         qX0WJAuePM58OOhQcRN2VniAWTtaMTVbsfOysXrNfyflC/qKeubuWjtCdwHIbBoW9HCK
         LRnR+LxNsxEZKVYG7dbL7vI466P06kU9D/yunOHxtQE9JCzorcryd6FlTvYitwSLMiyD
         RDOA==
X-Gm-Message-State: APjAAAX7z6pTT+RgYtsLjoFFQRQzE11vtL2fEESkHdCZW/rty1eQ7kd1
        sbiZ7td5v3n/qw2TUTDLkvUAO6CDvAKNhpg4glYYMg==
X-Google-Smtp-Source: APXvYqyX9NzgOKOBEhL3bfMOXwnl+YK9bQ96sRpsB/N0jk6CGTHPGokJOh/8Hytm71BtKVBSpMQIrhxbRxSBg/ZYe+8=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr50886675pls.179.1559864411389;
 Thu, 06 Jun 2019 16:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190606203003.112040-1-rrangel@chromium.org> <20190606205406.GA120512@google.com>
In-Reply-To: <20190606205406.GA120512@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Jun 2019 16:40:00 -0700
Message-ID: <CAKwvOd=RCL3hpHBVukomrRiXKhvJHMxe3HSrtd0MRcCe1B3ZGw@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add option to generate a Compilation Database
To:     Tom Roeder <tmroeder@google.com>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>, zwisler@chromium.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 1:54 PM Tom Roeder <tmroeder@google.com> wrote:
>
> On Thu, Jun 06, 2019 at 02:30:03PM -0600, Raul E Rangel wrote:
> > Clang tooling requires a compilation database to figure out the build
> > options for each file. This enables tools like clang-tidy and
> > clang-check.
> >
> > See https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html for more
> > information.

I'm also super happy to see this!
https://nickdesaulniers.github.io/blog/2017/05/31/running-clang-tidy-on-the-linux-kernel/
I don't know enough about GNU Make/Kbuild to answer the questions, but
hopefully Masahiro can help there.

> I'm glad to see someone adding this to the Makefile directly. I added
> scripts/gen_compile_commands.py in b302046 (in Dec 2018) when I was

Heh, cool.  I had a script that basically did this; we recently
dropped it from the Android trees when doing an audit of out of tree
patches.

> working on using clang-check to look for bugs in KVM. That script

I'm very interested in this work; my summer intern is looking into
static analyses of the Linux kernel.  Can you maybe reach out to me
off thread to tell me more about what you found (or didn't)?

> > Normally cmake is used to generate the compilation database, but the
> > linux kernel uses make. Another option is using
> > [BEAR](https://github.com/rizsotto/Bear) which instruments
> > exec to find clang invocations and generate the database that way.

It's probably possible to get this to work w/ GCC if the additional
dependency of bear exists on the host's system (and may reduce the
number of implementations).  Downside is the additional host
dependency.

Sounds like it may also be possible to just run
scripts/gen_compile_commands.py at build time if this config is
enabled?

Maybe a comparison of the output of Tom's script and your patch might
reveal if one approach is incomplete?
-- 
Thanks,
~Nick Desaulniers
