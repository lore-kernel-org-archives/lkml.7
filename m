Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC515C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBEF2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="z4hR54MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfF1Awz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:52:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34497 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfF1Awy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:52:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id q128so2495126ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pq41u0f/gOF6n9FN1LiqWASJozK08VcYm5UQx3JBapI=;
        b=z4hR54MRSiGtF8t4q9dah4h8cj2pJMI+wqYMO4G3f4n1Cm/ctRwuP0nef67Vx3cWZU
         A8z7sP6FixGi8TwWFYHBGf2/UIdf3i88iUAqPoroonUVqZcJ1O3/zWPlN1XTylu/sZTU
         noAfRUoWSNCex8O2XC/q00D0vJSKJK69xuJ8d+DKzDEkxZfv7t70/g1Hh4h+5tMF4/lS
         mnCsoZIrxO/0CKJg8250qhaUkvpGuoOiylbK+80rf3V91GzDEbnwVTGJpTmuFfjLUEqY
         eQMzxA/DdzHKv+hIg0qcqGDOk3xsEEVK674KQgsTzeUEJ1ogPb4BmcHJoOIHu9THfuYf
         h37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pq41u0f/gOF6n9FN1LiqWASJozK08VcYm5UQx3JBapI=;
        b=TbqFYQGcACoj9PnHXxOOIt0sQOvYs1kaDMzsNdP/EcEbI2EF7Y8071D0bnMod8RKfA
         wJIIHkQDoc4sAQEcW1Wir7bd9p/XCECTtvwPxcrozwCgM7SM0/s338kxc2rTCeO3ieCV
         gZ8tNc9LJOuOrXmiUAfxGjncdqHXlhJDVgLgdDY22oyxPwQlwWJse5P/3EOvrBO9u89B
         urpoMzfbBTrVawsvqxEirI8oKL5x87chRTsl1+yMZhC7VrgPgSWkf+YKXo6cC8MypHE7
         1P6vV8rXXDTP9yYvmAh8nlzTpvNHxgHPnETVwjU9YL4pNcDJxPPJ5SSokXQjr/JC98LZ
         zKUw==
X-Gm-Message-State: APjAAAXxJKLHk5n4Xi8BGnDhoR9j9mc+e5ht9SUC7nphRj1wMX544zdS
        fmQWsR2y7XT1fewVnEpeP+oTO3ezuHy55ot7cx+Jww==
X-Google-Smtp-Source: APXvYqyRIolVnKiXuofInpbngVe+ynMC0H+c8EXK0ZbQGFzrF+1NO2cGtpl4IhIRX9B2FuCNZAa8hFRG0EDB6B+W2yU=
X-Received: by 2002:a0d:fd42:: with SMTP id n63mr4573538ywf.329.1561683173719;
 Thu, 27 Jun 2019 17:52:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:e205:0:0:0:0:0 with HTTP; Thu, 27 Jun 2019 17:52:53
 -0700 (PDT)
X-Originating-IP: [2601:647:5180:35d7::cf52]
In-Reply-To: <20190628002208.v6brs6b6hf7b6sth@treble>
References: <20190616231500.8572-1-mforney@mforney.org> <20190628002208.v6brs6b6hf7b6sth@treble>
From:   Michael Forney <mforney@mforney.org>
Date:   Thu, 27 Jun 2019 17:52:53 -0700
Message-ID: <CAGw6cBuaMoZQK-hV+Ztg5uFqPU3dY6L7um1bzsxVPQfaX4JA7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool: Rename elf_open to prevent conflict with
 libelf from elftoolchain
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        elftoolchain-developers@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-27, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Sun, Jun 16, 2019 at 04:14:59PM -0700, Michael Forney wrote:
>> Signed-off-by: Michael Forney <mforney@mforney.org>
>> ---
>>  tools/objtool/check.c | 2 +-
>>  tools/objtool/elf.c   | 2 +-
>>  tools/objtool/elf.h   | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> Sorry for the delay, I was out for a bit and I'm still trying to get
> caught back up on email.

No worries :)

> These patches look fine.  I'll try to send them on to the -tip tree
> shortly.

Thanks!

> Just curious, have you done much testing with the elftoolchain version
> of libelf and objtool?  So far objtool has only been successfully used
> with the elfutils version, so I'm just curious how compatible your
> libelf is with the elfutils version.

I'm not affiliated with elftoolchain, I am just trying it out on my
system as an alternative to elfutils libelf for its clean codebase
that doesn't use many GNU C extensions.

I've done some basic testing to make sure that the .o files after
being processed with `objtool generate --no-fp --retpoline` match
between elfutils and elftoolchain. I noticed two differences, one of
which was due to a bug in elftoolchain that has since been fixed, and
the other is with the offset of SHT_NOBITS section after rewriting[0],
which I think doesn't matter.

[0] https://sourceforge.net/p/elftoolchain/tickets/571/
