Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC55C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FB6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFUPUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:20:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33961 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:20:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so4708445qkt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 08:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wP8Hqtmt5Uheo2nSZEeK4MZxkQao5hh8NYgThseHEY=;
        b=hT7oBNcI/R81H1v4nOQuXVCyOeY/RBE2pZu3pOJqLd2V6pGetGLjfIS3KjesOLF6Xd
         j3+lz2Szg5gppfkTDavDin1Bj2W8Is+2UGS61n0y7bACkgl+qdG8+VjOYFrlI5+JpTVZ
         Bce8DpKL/xhCiXARwoYV3m3GMYAeynyKLgsFW6Vph5IQuC37uLTxCzdXALWbVttWoC9y
         C8Z0JSA+/p2erDyTWRGaA4r+OizVVd2adzAT6IdLDSnjN6zA2lXeLLLHnXP8tzc535YQ
         wtG5FY4rYOXvwjwMXKdxbqLvZOm9nBEEkfN1lxmYNn72nIIyQR0sEd7EgTNidygGvOOs
         aceQ==
X-Gm-Message-State: APjAAAXMHkORIBVwr3YTSI327csJXu3qwe/NuYkwrj4kOmMnUl51yrwy
        Ktl/piWUuuI7cBiJWmDVbMDmjxATOX+nlAvhCqtvaaCa24o=
X-Google-Smtp-Source: APXvYqy9KR7oNoQWT/5eLnvUjNCtPMF4D/4fCtMg6abdP9hImSQzlDMlZWHTwiBzkqk/PfRSmiPkTAc+hvKfREynJxs=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr111727107qki.286.1561130430344;
 Fri, 21 Jun 2019 08:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <20190620141159.15965-3-Jason@zx2c4.com>
 <CAK8P3a1Dfx0MayHFP46KL0RDta9cZYBy3pVRTaVTbEsbMOy5xg@mail.gmail.com>
 <CAHmME9qDAEzZKBDowLmdaxtc8fJqp-w_cvOWsvubh5Yr=Kgm-g@mail.gmail.com>
 <CAK8P3a0MWFCvB_pMuYyZbhBQzuA6++i_Y14cJ9n0TozJpqpKPA@mail.gmail.com> <CAHmME9o0+9EKv=ErSUXQivkGoXamFJY3T_KETjf7=SG-FOB+WQ@mail.gmail.com>
In-Reply-To: <CAHmME9o0+9EKv=ErSUXQivkGoXamFJY3T_KETjf7=SG-FOB+WQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 17:20:13 +0200
Message-ID: <CAK8P3a2uaNXV35D+DtcJ4Pqm11+ORPr0UQsaA2ts6cQRW7vaMw@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: add missing _ns functions for coarse accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 5:07 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Jun 21, 2019 at 4:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I care less about these since ktime_get_real_fast_ns() already
> > exists. My preference would be leaving alons the _fast_ns()
> > functions for now, but making everything else consistent instead.
> >
> > Thomas created the _fast_ns() accessors with a specific application
> > in mind, and I suppose we don't really want them to be used much
> > beyond that. I wonder if we should try to come up with a better
> > name instead of "fast" that makes the purpose clearer and does
> > not suggest that it's faster to read than the "coarse" version.
>
> Oh shoot, I just submitted v3 having not seen this. Does v3's 4/4 look
> fine, or shall I undo the _fast switcheroo and resubmit?

I'd still prefer to leave out anything touching the _fast functions
from patches 1 and 4. AFAICT, that would leave ktime_get_tai_ns()
and ktime_get_boot_ns() to be renamed to clocktai() and bootime()
respectively.

       Arnd
