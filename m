Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FD920578
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h2G+g0f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEFQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:05:28 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33247 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfEFQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:05:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id z145so8475038vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRFFU8Q/jQghW94GutkX/fzbuY9dKYgOCq1w5lys5os=;
        b=h2G+g0f5qcaSkmO+aIkatHsodbmhrHyNCkxJUs1xGr5Fil8QSPcy2zpt/dYAmSjtoo
         qNZIeF/MEpm8x3u4dQZ5NOzIxeuDUCemWdlh05SkylMyMccltrh9MUUIjiqdtgdyeb0D
         x9EtOIkulHA5fOCXhXBT9wjgf5lZuGNPbi4BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRFFU8Q/jQghW94GutkX/fzbuY9dKYgOCq1w5lys5os=;
        b=fQuWyZCfnbLglhUCKt+DBNGbn4CUcS4i5t+eFlJfGtIAj20nnfbQ/Qmnw9Ka+R1yRP
         xYubBUV0zIix38Ux8iEEK9VzTSUOzLJ/Q2Xutoh9TulcGnwmOiSxN617Jnd0pYEmkmdO
         KLmYdetsSqjvhPKvZQgzZoiZ82eTqbcr7xpwV/wp0mNWzbdM3K6lWWGfF2FakQhsHTKk
         8q/nZM7X9A+JEnJMgvpTPKQdaW8MiN1ZakQuPEManxnmbX2r3rmOa1UN8S9X6IaVuDQV
         yo9fOTWz1TAJIf4ShTPRS5dwOxO4+CpRTXl9ulNPGPFOuA77e3QmMmI2jHlFL50GIM8g
         /Ccw==
X-Gm-Message-State: APjAAAXTgdW7DR4KaVfGE0IFd2ipEOlcMlj2ip6Crx02R/n0jHECqjb1
        N7TXf5Wo+/n+8dxjt5/o2TjJ7kXZZJI=
X-Google-Smtp-Source: APXvYqz3xSf1hOkciDovAlHX0kDRAsgr2irMSx6/S6+xdhuHlf0Vq25PQ6ryiA1gnwou+GUnGoZ09w==
X-Received: by 2002:a67:14c6:: with SMTP id 189mr13952935vsu.203.1557158725649;
        Mon, 06 May 2019 09:05:25 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id t12sm3121085vsc.30.2019.05.06.09.05.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:05:24 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id v7so2550311ual.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:05:24 -0700 (PDT)
X-Received: by 2002:ab0:d89:: with SMTP id i9mr13008936uak.96.1557158723903;
 Mon, 06 May 2019 09:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181018185616.14768-1-keescook@chromium.org> <20181018185616.14768-3-keescook@chromium.org>
 <CAM0oz-91yjPQKnxGDjwFThs19U=+iziuUr=9z13NSibr_uRxZQ@mail.gmail.com>
 <20190505131654.GC25640@kroah.com> <CAD=FV=UV7x-qJU86MzHxY8bqDV7rcc3XoyotKyy_+1MpMM22bA@mail.gmail.com>
 <CAGXu5jKzH0Ttdtp5bXP_EAfp+fA+tEQwLXh=VmZ1r5q6wdpqaw@mail.gmail.com>
In-Reply-To: <CAGXu5jKzH0Ttdtp5bXP_EAfp+fA+tEQwLXh=VmZ1r5q6wdpqaw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 May 2019 09:05:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKtteYVhB=jpjBBkGqW5_XK=zpCP24Fj+mM0L8RBnhh=A@mail.gmail.com>
Message-ID: <CAGXu5jKtteYVhB=jpjBBkGqW5_XK=zpCP24Fj+mM0L8RBnhh=A@mail.gmail.com>
Subject: Re: [PATCH pstore-next v2 2/4] pstore: Allocate compression during late_initcall()
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug said:
> > > > I'd propose that these three patches:
> > > >
> > > > 95047b0519c1 pstore: Refactor compression initialization
> > > > 416031653eb5 pstore: Allocate compression during late_initcall()
> > > > cb095afd4476 pstore: Centralize init/exit routines

Okay, confirmed. These look sufficient to me, and the resulting tree
passes my pstore tests. Greg, can you please pull these into 4.19?

Thanks!

-- 
Kees Cook
