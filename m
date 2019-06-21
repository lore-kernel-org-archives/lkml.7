Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF3DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B952089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFUOlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:41:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35998 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:41:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so7152747qtl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bqWpEcNYsP9nydbQ+fkEq1ybX8MKG+9/h9Bhg3Q+sM=;
        b=Ju6IoHC5Us2/TXmrxKDtS/z3rNjyGe7k4XY5guSecoYukDwKcpreJra1Betro2LFLL
         iEQeicL12u16dqC/7l2LqgrlNo2XzU7NrdFosZslv+DquOh6ZDXp50zm85wgGW4aE9HF
         fSjp3UAHGdoE05OHJYuZ9j8pLzoeQKfFgeV8nlhozH855n+K21JNfHBNLI+M9/HWOZVN
         PA+LWh26ND9ARhjzEzm2lHhlKsGEJeVVmC75G8XpvuckQLMEP+yTduvLNy2Lapt2wEr6
         UzbK6rKOFfxHUbIPqeUgEP9SvuwM03OAxRpnurcQQN0kQpLW9EZ5u4uuregDXLmK9vqB
         eu9g==
X-Gm-Message-State: APjAAAXMczEXx5Vintrt7B7/k6WO5ZV5NuKDmsci+HllXVO4uhop2uWy
        ftURGg3Ud2DvsuYZiYBaDwrtk20gs/foB3iYfvY=
X-Google-Smtp-Source: APXvYqy+0qW/UCXce9lu4l3m6KJ0piRwURokDZVN+L70D7WshKJO4f27RD6fcRdEwtFf12XJa7GKBqnH0ibsxnmL5iY=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr39398341qtb.142.1561128062209;
 Fri, 21 Jun 2019 07:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <CAK8P3a14=isYJFZYZ5BGGPQY0eLCA7zswHTt=F7Yd4kN-8EtrA@mail.gmail.com>
 <CAHmME9pikBz6oNdCFePEERquaQC5njez5=SBL+Cq43mn-aFy4A@mail.gmail.com>
In-Reply-To: <CAHmME9pikBz6oNdCFePEERquaQC5njez5=SBL+Cq43mn-aFy4A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:40:44 +0200
Message-ID: <CAK8P3a1P8dqGC0cTWZWZavn9VeLWQ80xAHu3Xfh-e08N97f5dg@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: add missing non-_ns functions for fast accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:33 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Jun 21, 2019 at 4:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Typo: you have the same function names listed twice here,
> > one of them should be ktime_get_mono_fast() instead of
> > ktime_get_mono_fast_ns().
>
> Nice catch. Vim twitches gone crazy.
>
> > Also, we might want to rename ktime_get_boot_fast_ns()
> > to ktime_get_boottime_fast_ns in the process. It seems there
> > is only a single caller.
>
> And tai -> clocktai on the others. I can send a followup patch to
> unify all those after this set.

Yes, that's probably best.

       Arnd
