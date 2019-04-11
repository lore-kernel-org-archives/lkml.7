Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4068D2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3SRF4NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDKRqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:46:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39966 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:46:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3805807pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEsnno8UWCUD8Kimd0fiNYZh+xSomoXPpGJKWoxyYTA=;
        b=H3SRF4NYZaNJBzjGTjYrBYGqvcT6/dwzlC0Bxh9QbJX0eJCD/Zd7YB4dwCsKh+pF/q
         VzRcQRgcsNx9VBpS0bKcLgwuCu/IQL1kRiQz4jpVKHnz0yuvrBxz7/JNYDLusXjeimE9
         Ib0GSBzKK+92Hr2C2bzG+Sl5J35pMJnVnUBeaqc3mKNBdQNwKbqciwj6Sht/VIcDInBa
         5WW2Y76AlhDvRdUNTp8PDjO+ZWUuqA2W5q2l8buRynTEehUS2sKxd0k+FfL84NLBlUVp
         6MKw9JJoXxz8mtXifGJkIyKyYZivELqmJbr7XzX5a4YmSRaXHY+VEzPKotNYJb7CAjWF
         Bprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEsnno8UWCUD8Kimd0fiNYZh+xSomoXPpGJKWoxyYTA=;
        b=b+BWUUog6uojZeTh+Du1o9WRz0siLEvxjFPuQMf/Kuz3RsaJ2yZEAil2QqaMZwTybF
         uPqeGTohEoPvajsnRSKdaqurKymQ46iF+6HcC6uU42N0ebdFlWBDKxiqvREF5qeCcY8y
         hRqQz/sTrewI4o1uKQqAimsuY9LJMqZCRQ0X5ayjKYw64ZnZ3jFTjXfwfI0n1CgCjFMC
         GLXM4MWS6GeqaUB833pJ6dLPbFuqm3rAa3Djtp6IbNpeklFGAFOo1KzdlsRugPl0ORND
         Ns/17EZIRzbCefSpZ3XYpuK9CcfxNUN+oOVGAXqs+MmbmoJeyTrFgPKnikEjgD4n1Cvt
         Dm2A==
X-Gm-Message-State: APjAAAXtoervyrV+OcULbffLLpsTxWGvRSPkAoOzjyKuk5b9a4ODEM4o
        /TlY/PXs/9oaz3BcGiHcKyhY3MNUM2jjnsCNl4gRNA==
X-Google-Smtp-Source: APXvYqz3U8KGRrwS/vDRCeN45kyfkRJs9sbt+b0Q75CPsiAfaogHFBc2dcRfvSGi1L20G1+JGU294l4owrMH5N04xMQ=
X-Received: by 2002:a63:7444:: with SMTP id e4mr48964424pgn.261.1555004801668;
 Thu, 11 Apr 2019 10:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
 <CAK8P3a3bn8yWHfhwppXdTfkyy7_uM=_OySKahoQtOyBxBT5QoQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3bn8yWHfhwppXdTfkyy7_uM=_OySKahoQtOyBxBT5QoQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Apr 2019 10:46:30 -0700
Message-ID: <CAKwvOdmmaxgXPQdEEEdGj7pBNeYrnME3=GpthThO1P8owsDD_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 3:18 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 11, 2019 at 12:20 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > llvm does does not understand -march=z9-109 and older target
> >
> > Please file bugs for these in LLVM's issue tracker.  It might be
> > possible to enable these additional architecture variants if they're
> > similar to existing ones and simply unrecognized.  IIRC, we had this
> > issue with armv7 variants.
>
> I really don't see that as necessary here. While generally speaking,
> it would be nice to support the widest possible range of hardware,
> and it would not be hard to add this support, it seems highly unlikely
> that anyone would actually want to use that in case of s390.
>
> The last enterprise distros to support z9 were SLES11 (end of life as
> of last month) and RHEL6 (ending its 10 year life next year). Anyone
> who is still on those releases will probably not install a brand new
> compiler, and anyone who is on newer releases won't run on prehistoric
> hardware.

Are those machine variants worth dropping kernel support for then?

>
> Debian still runs on very old hardware in theory, but even there you'd
> have a hard time finding someone to test the output of the compiler
> on an old machine.
>
>        Arnd



-- 
Thanks,
~Nick Desaulniers
