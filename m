Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41052053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zMq5h3LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfD2HLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:11:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39954 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfD2HLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:11:50 -0400
Received: by mail-io1-f65.google.com with SMTP id m9so1681647iok.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZtHuV4JUivTfwBqqXIvSzfQ5NYcx2yRMMOn4vVLdck=;
        b=zMq5h3LXI6dFcJu2i6XOStKa+tM16fFtWD7+tgYSvW+9c2o4N+upRwaKX3gJJ5vQr0
         lpJ1V3qgGa5UmrW7e3Etm5SVFEVrBLPpP4Y/UswM0QsARC9k8CrZPpSAGgHEd5ietLH+
         5JozCLefPjHuV9AskOy3Qup+cASN5AX1nhTDtx9IiJ2Bcfbr1uYEgsReF6jA5pTdOwxx
         RyxGEkCaySvJsij91WfNnrXR1Z0MPs432l1DTEOcsa/plnOkuK0mWfYrM2beOh0cmJQC
         AvOV6v/RTgja9IziLqxzgqGUjae063EeaBFsfV36gi6kg6zlpU2BmyJRaS0h7KfxhJc8
         KMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZtHuV4JUivTfwBqqXIvSzfQ5NYcx2yRMMOn4vVLdck=;
        b=l3/5PP3xBp2ib5/TMBJ8qnRmOMkkgtddh3bCziFg8v5dmBgqRlABLJuiINV9FrJLlX
         qC7rzIQgPKzSsZDLGzObX1gXHrP6EbrvQmBV/Epk+lZcYW7mMsEVo5FkQLn8bFxykpdk
         B2SpFHFX/WOP3SSvmVhdepub0JssP+ZfvwkE9cXfWmNigmyMbRYNAUDcZ1qNT1LZwcEh
         bWx0Wa9E6+xarP3zWOiwOK8F6+hiNMZOhJzrEbayegP7DvQPwMsmh31AnwmWrcjcVzXf
         Z3WvvPNW1hiLbKMJg8KJN1O690mLxLG7NAxojMehpR7VH2oW8C5AaXbVPqgbUtaWx/FW
         dcOQ==
X-Gm-Message-State: APjAAAUGSGtWNNKexJ142CkT86BZaHKtlE+SXot1aKQJep/pww9pfW3g
        W2yTfMmcfNyuwXzmf3NAWR2ednN2nEldrUwsWl1Wag==
X-Google-Smtp-Source: APXvYqy2NI0iAuUdXJt55fsNTPkhEPdO1qf8e3D8P12eYuAI66Rx7WjCDUuoAw8iwuybwsvy9TFZxSF/ySRELQ71P4Q=
X-Received: by 2002:a6b:fe0f:: with SMTP id x15mr19992622ioh.78.1556521909778;
 Mon, 29 Apr 2019 00:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190414154805.10188-1-krzk@kernel.org> <20190414154805.10188-3-krzk@kernel.org>
 <CAJKOXPfzV0wn0a-4xvy1B0fR=X4VvpqNmtqwRGFhFdCMH3OpHA@mail.gmail.com>
In-Reply-To: <CAJKOXPfzV0wn0a-4xvy1B0fR=X4VvpqNmtqwRGFhFdCMH3OpHA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 29 Apr 2019 00:11:38 -0700
Message-ID: <CAOesGMh1JA=RxrnohosW1SiwZrwDy_1mHNMBq2zrYXEFcCuEzQ@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: samsung: Changes for v5.2
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 11:53 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, 14 Apr 2019 at 17:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> >
> > The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> >
> >   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.2
> >
> > for you to fetch changes up to 7676e667c841375b41d9438b559756141aa93d0e:
> >
> >   ARM: s3c64xx: Tidy up handling of regulator GPIO lookups (2019-04-14 12:53:03 +0200)
> >
> > ----------------------------------------------------------------
> > Samsung mach/soc changes for v5.2
> >
> > 1. Cleanup in mach code.
> > 2. Add necessary fixes for Suspend to RAM on Exynos5422 boards (tested
> >    with Odroid XU3/XU4/HC1 family).  Finally this brings a working S2R
> >    on these Odroid boards (still other drivers might have some issues
> >    but mach code seems to be finished).
> > 3. Require MCPM for Exynos542x boards because otherwise not all of cores
> >    will come online.
> > 4. GPIO regulator cleanup on S3C6410 Craig.
>
> Hi Olof and Arnd,
>
> I see you pulled in DTS and DTS64 pull request. I think this one here
> is still pending.

Yeah, I don't always do them in order. It's easier to sweep all pull
requests of a certain type (i.e. DT, drivers, etc). I also ran out of
time and had to step away for a few hours.

Same thing now -- I'm done for the night but there's quite a few
remaining pull requests in the queue. I'll continue tomorrow.


-Olof
