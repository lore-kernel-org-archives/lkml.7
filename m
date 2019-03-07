Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C15C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCGHfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:35:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46230 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:35:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so15991248qti.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 23:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVrhcwzUdrfMBOFICEODr2VSujOs0QbaY7FySkYqXhs=;
        b=Sh9qwhB8PNLDWRH9bDPvxnrxeTmeF+3P6HsjeF5+ftjDgV8S3QAwWCUWl7H4s7PVU/
         RI7dNM7RkmHf+2aKGvH4T/uSwwNgADqCd5spVRTJrFcyfO11s8gSzm7YAi3tIEZqgA1Y
         lKxlJNGPcLyHlfyHb+Nj8sTt9+PWm9ROFjxqUB8e6LuSdmbq6KkZbmfOqBigf+qX75vY
         KpctP0rlRSJhQRmZ+daLirVqxiQ7JHSzpVr+gaGpe8HEL/6hHwH4TvG6nEKTW9C4dkYJ
         HEtmki6QiGSDUMoReWVQYpPd+jAFDYAoTO/q7aUvCC38ENEM37z/YniOQMPJaqm9F2Sr
         s6OA==
X-Gm-Message-State: APjAAAWAJa5Iq7OiTEM5upfWtKCBu4yW43prDbInD2l+XWMvJ6iskpn7
        4wVgvgXTOjWLhSfKuC7LIkkeHSGogG5HI7BASMI=
X-Google-Smtp-Source: APXvYqxabejyCFacXaWKNGP/96qmZ/1c2TsU1VdXYdAZ4hfzESXpNpWFbkZ5LgDKnGoXMtt8LFHxzlXC49Ayfym7Agg=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr9003381qtn.212.1551944145834;
 Wed, 06 Mar 2019 23:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20190306103350.GA10570@kroah.com> <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
In-Reply-To: <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 08:35:29 +0100
Message-ID: <CAK8P3a3cQ1MCyWvh6Ei5_zKhcDrkV7P5ZZdUAn23ooAqNnipww@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 12:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 6, 2019 at 2:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> I wonder why this wasn't seen in linux-next? Yes, the connection is
> odd, and maybe it's very compiler version dependent, but I do hope
> people react to new warnings. The kernel is entirely warning-free for
> me for an x86-64 allmodconfig build, and I want to keep it that way.

I saw it in linux-next and sent a patch the other day, similar to yours,
but with a less verbose changelog:
https://patchwork.kernel.org/patch/10838499/

Overall, I had not done regular randconfig testing since the start of
the year, and found 62 regressions that had crept in during that
period. There was no significant uptick in -Wmaybe-uninitialized
warnings, this is the only one I saw, so I'd classify this as random
change in behavior due to inlining differences rather than a systematic
issue.
(there was a noticeable change in other warnings, particularly a stack
size increase from the new structleak plugin changes, fix is coming).

     Arnd
