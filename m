Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE8C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C519C206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krSe2nyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfIEAIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:08:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIEAIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:08:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so162398ljn.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zu7o2811sm/C6A/KNhYCc0bgcwAt8nC3g9vfQBeCxDc=;
        b=krSe2nyNUUQ42yEqQuiQKbA059yid8WbOIANwsENlZMWXndknivxXzrg98reyBRJUV
         hpUoNg2NnmeOqg9ZRGsuRQCadxNODVU8w4xPvygITVO2JdAOWglH/AtkrBiRxUMFVal9
         ZhebvNPPPQBnjKchG1YDL2JhwwSyYmYskdaqce6rnDdijto/M5W9iQ3pLhOHB5jlo0R2
         yONuP2QhOeGZnUVJiAITYAixBGoNtaAbDGfOwPewDGBwHjLIn9I+BV0Lx9wrtmibyi97
         UM+t/umTqDWRRho8tREbRaOtQgRx2JjMZ0vtEIyvGa2hPC4jQn8Kvrm59JCIitYFVNjg
         IcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zu7o2811sm/C6A/KNhYCc0bgcwAt8nC3g9vfQBeCxDc=;
        b=YHlDofiMsstycrrr57uVn2AVLrJQyfy5DrxxWl6QVojh1mGbvoUpCGG6b+ACTXs3RR
         J7xB7iRGqZ041ykUAryZdBVu0Qg+L6t/AtFf5QQfZ8Cxp9STn9oqAX/YVHfO7IAWnDrC
         aajXvIfe5NCjoMM3qVvy8zxMtNma12TFdHhkflPDbnPAvHH7/0hAXaT5N7/q84XxU5mT
         UW6L0ZQNUxFqwZcRd/IvZ4cVgbRR1j6WH0CBUWF8q9Jzv3Ynl7JlfG0NTK1/TbULKDHy
         QignhsbOG6GoqOLFIcvT8+dr+A13TgHLIQG4szHfFg8+UlaG20nj/yG5oCudhOYHDLYO
         0DBA==
X-Gm-Message-State: APjAAAVFK5T0w8c6/+nGFRmmg8K2o11EsrAMEAyd14l4QsgZFO7mGP7E
        VDBzBP/vFSZuRz43s20A/C8IGwj6bp3Wq5FZLpM=
X-Google-Smtp-Source: APXvYqwBe/D/C2MAdljspvsS4HzS2f00tB+lfsXyQCB8edddc946d7rnWPwZNB9/csxjeRHVO8gh0V/d1ts4/E/c2/w=
X-Received: by 2002:a2e:9555:: with SMTP id t21mr152882ljh.93.1567642079449;
 Wed, 04 Sep 2019 17:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-3-linux@rasmusvillemoes.dk>
 <CAKwvOdnZE7pCTykwjX_DDh0wKcUAVKA8eSYXSUFWG2e3swFEJQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnZE7pCTykwjX_DDh0wKcUAVKA8eSYXSUFWG2e3swFEJQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 02:07:48 +0200
Message-ID: <CANiq72kQb7VYBnfho_joF3p_-vi24WgYETE19EO3Ou6T5ixLew@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] lib/zstd/mem.h: replace __inline by inline
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 2:00 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> While you're here, would you mind replacing `__attribute__((unused))`
> with `__unused`?  I would consider "naked attributes" (haven't been
> feature tested in include/linux/compiler_attributes.h and are verbose)
> to be an antipattern.

+1 We should aim to avoid them entirely where possible.

We have __always_unused and __maybe_unused, please choose whatever
fits best (both map to "unused", we don't have __unused).

Cheers,
Miguel
