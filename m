Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F6720B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn7GTGxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHIUTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:19:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHIUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:19:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so24738294wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CU5GhqD34I+4I/wKjBx1pJkLxBMLeU2dxzdKCeha0fA=;
        b=Jn7GTGxDyJkhDN/2Znu08WIaawEzU0y6yZSlwmsQiY61RlJd1eTogokXAabXcJ5sPc
         SXvb0BWDnGnooi20lIATilnQeAUQ4ooGrHUWBK4w4Hhxwleeq43+5duHzNbagPiTp1zB
         //D8eFPwgmPWtCQm8eKbZYV9KoqZosG7D8DKZLi+2/UFNOesZok78wudchx8dsDwDuBr
         xcI9Xljqc/xCoUe3ho7+c6QR8zLD32gJ6Fzp9gF76OLK+AqZbVlM9ctjF/HJSGsbMQmk
         4jL54osofXOPPZGgO6vUXjGloK+dOmgP0U+hIjLvj72ITF5d//tNFEjXSoi0eH0Z8OE2
         DlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CU5GhqD34I+4I/wKjBx1pJkLxBMLeU2dxzdKCeha0fA=;
        b=lnCSC+C5vt2Ak8wamijV8+JDmNaZPqSF5T5E+ub0B1ptSmYhXiOlzU2YolsXTOSmzQ
         A8MECvJFUJvGkbhRTkRgknGjH3VqBrLXw04UQxMjKTrbzm4ZB33kiiHqVRRhxno/f9NL
         Jzf9Qu+UiyaGqMimGV4aT21FVEjhD7G2J6wufWe7kg1n2YnikG91nSRwFtNRYr+aF9iB
         pUKui8mrsCHTVmAuu9LjfYBEV15WskSVJKuriZ29LYatNgRbw/BjA2drNocJHnF5b1J4
         n9TeVi212xuJ5W4Fwg8F066N2NWN+xFi1j3QWKUohNVogpiYtGM2JSCHjXIh5CkMH9+H
         7s5A==
X-Gm-Message-State: APjAAAXOXUG/1vGgAcjKHgJoYaucjKd2ezzUuvXTnSTQ7KfFEiYXNSWa
        IDztgBPJiFCGWDScbhJRzfRcwS7rkh8zgUFh9iEbSDw7
X-Google-Smtp-Source: APXvYqw1d8OiVM9mT4FhG4ORzaAQl8RXTI++5oh9pTnSV2jbRTCIlgRjRVIzeFLnTix5RHO3L43d6TZ7ztP6VYbljjE=
X-Received: by 2002:adf:a54d:: with SMTP id j13mr9228694wrb.261.1565381984439;
 Fri, 09 Aug 2019 13:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
 <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
 <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
 <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com>
 <20190806125931.oqeqateyzqikusku@treble> <CAKwvOd=wa-XPCpoLQoQJH8Me7S=fXLfog0XsiKyFZKu8ojW_UQ@mail.gmail.com>
 <alpine.DEB.2.21.1908082221150.2882@nanos.tec.linutronix.de> <CAKwvOdkTD-0inuEKLTsH_tKXzXjvzwnUDwYZ++-hOUrC_FU=sw@mail.gmail.com>
In-Reply-To: <CAKwvOdkTD-0inuEKLTsH_tKXzXjvzwnUDwYZ++-hOUrC_FU=sw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Aug 2019 22:19:29 +0200
Message-ID: <CA+icZUWgE5NTEa9Q0jof0Hv52tZM8-869Daww7dueaaMMXt+7A@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 1:03 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Aug 8, 2019 at 1:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > tglx just picked up 2 other patches of mine, bumping just in case he's
> > > not picking up patches while on vacation. ;)
> >
> > I'm only half on vacation :)
> >
> > So I can pick it up.
>
> Thanks, will send half margaritas.
>

Sends some Turkish Cay.

- Sedat -
