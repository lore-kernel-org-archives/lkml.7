Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44267C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1702F20700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570386439;
	bh=D9jiQWeRqRG+ppn2xi0rBElN4ymqMXokXVheMWCnbeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KoeAidomoF8dOeWNyi5w5s4Ppcu1Z3Kkane71Mz9bdioFIoHKoMyEBWg3bvooRsQJ
	 elQK3jLbl1TNNrkLN9LkEp/EpsJrZWxO1rpB7iJ20oLmwIw3JtXBPGj7+mkYggmOrn
	 J32cETYgFIXbBx3HVcy5ZxRcx2UJQOokJ+UrIn/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfJFS1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:27:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38345 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfJFS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:27:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so7689513lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSwrr4EKUZ4tCfO+qrPjuD/XJ+zP1LA36jiW6xcbRg4=;
        b=A7x/snAk50gSY/c2Z1Cok2ZTKX1E1o/8rt/5cHQQYg6HVTex37287kziYL0yqfjzhE
         8D5UQZ31JhL9jyMv3H/Dz000hD/VDflP/kX6GMT3vaAG3fFyM00+tAlHFV8M7lxLvgfG
         Q++yJLhsRcx68SYLR3LdHp6yprRxIfJ27U0AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSwrr4EKUZ4tCfO+qrPjuD/XJ+zP1LA36jiW6xcbRg4=;
        b=Yqsg/DsifeUTaH6fAoReNgFxKvkomCMn3Y9R4hp8Z/WnJJIJpeLFP0BeUpFySCIO3u
         QEZ5gS72svFpxkC23XxINzMCK04l/UJSwthZVQMmGK4XR6RPIwmwhNM2u6/LWEZ4+PWX
         4448EWFGCYij4Lvj2fcHXTRqjDj95KRogr5+3zk9WTbu8i0YFo+sYY7K0QTPZKQGmNN0
         7wXMer6rWjd1xLJ88L2wHrkc1XWor9oqhvtdJyqw0GUseItjqP2LfgIDx2qg6jJk1Kqy
         GsNpWOU4jp6c+yGkQyKn1yByewNIJFYGn+JCNRv3fn2w0sunEmjMc2OmeG1cFYb3Sb2O
         SKsw==
X-Gm-Message-State: APjAAAWXtE21oRlAddqqHnMrn8yoytfAf2nLYr3TtT3LtO3vCHt0aoni
        5pEXEZu6YpE3egm5cGVdGkIxoyi5M7Y=
X-Google-Smtp-Source: APXvYqySf3RyOMtVcAJ8TmRVffrB/nAZaHr6uvz7/qq/b1l04HOURzWkPRgirye6185tq4egUxq2dA==
X-Received: by 2002:ac2:554e:: with SMTP id l14mr15439706lfk.32.1570386435626;
        Sun, 06 Oct 2019 11:27:15 -0700 (PDT)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com. [2a00:1450:4864:20::232])
        by smtp.gmail.com with ESMTPSA id 126sm2896531lfh.45.2019.10.06.11.27.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 11:27:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m7so11331083lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:27:15 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr16247833ljf.48.1570386430371;
 Sun, 06 Oct 2019 11:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd> <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd> <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
 <20191006182103.GA2394@amd>
In-Reply-To: <20191006182103.GA2394@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 11:26:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whT=S76NWHVfvvV7Vcx2G+e-QAB=89jykA20a4TRYAT+g@mail.gmail.com>
Message-ID: <CAHk-=whT=S76NWHVfvvV7Vcx2G+e-QAB=89jykA20a4TRYAT+g@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 11:21 AM Pavel Machek <pavel@ucw.cz> wrote:
>
>
> Even without cycle counter... if we _know_ we are trying to generate
> entropy and have MMC available, we don't care about power and
> performance.
>
> So we can just...
>
>    issue read request on MMC
>    while (!interrupt_done)
>          i++
>
> ...and then use i++ as poor man's version of cycle counter.
>
> [We would not want to do that in normal operation, for obvious
> reasons, just when userland is blocked and waiting for entropy.]
>
> Hmm?

I hate it, but it might be worth it for the existing timer thing
alternative when we don't have a cycle counter.

Then we'd have _something_ for those bad embedded devices.

I still absolutely hate the idea of doing disk IO for this.

               Linus
