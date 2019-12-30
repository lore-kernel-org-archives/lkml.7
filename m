Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E8EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513DB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kFXRtfBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfL3Ohe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:37:34 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:41067 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfL3Ohd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:37:33 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 68ac53d3;
        Mon, 30 Dec 2019 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=7aEjW/TsXgUR/0HTMYxt13eFkHc=; b=kFXRtf
        BfiEqmjri0y3PshcHLuAZ/aW4UQrCX7AYD3/cbLACA2HthDm7tcbO9E1n9witAxx
        VQpvpaJdRs9BWpdiAZQFTkGmQHK8Rs1K3LcMfFfOrNKW5fM3hoMG+4/NzFy++TSt
        xH5IcjOMnUrV3EyNKupV2X92h1jYfJs21D+pR3aZJDdwmg1Q1QiDUNeYo8TYE/wv
        fCh1wtolDJPbftWos3BAwP1/LHhnlO3OlqNJGWcmbLWwc1cJ5L9qKMw8RxL9UBOH
        nPB3iF/tHbPnoNIng8aUvfz95ps2bTxkTtVoxCGtawoI75LQaEnbf6bZiqomGbnP
        jMRMCoIAN8Qg4FIw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ae90a694 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 30 Dec 2019 13:39:22 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 66so46453276otd.9;
        Mon, 30 Dec 2019 06:37:29 -0800 (PST)
X-Gm-Message-State: APjAAAVfb16z4i5fR4cGD92vvOVfrbF5bzOmTyXBEVjNCX6y96gXMul9
        sUyKYeZPlVVkv/mT50DQTx9Bw058MFcLR88G3qE=
X-Google-Smtp-Source: APXvYqyHFHLNrxuP48Lg+YeZE5/Amk7fGJf1A1hYpoeI6AJ4i7Pj3sKwYh0lazl5X3mtDZORoUvWany3TCUvhtDzQTg=
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr401529otq.120.1577716648710;
 Mon, 30 Dec 2019 06:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20191223130834.GA102399@zx2c4.com> <20191224135404.389039-1-Jason@zx2c4.com>
 <CAK8P3a1fVFDkHe=gLy55rHxwfZ8YKcUSYvnhSoMbcAgWy6Nm9w@mail.gmail.com>
 <CAHmME9o07dQV_MmWmtBFCKp=sdsO-scC6-UbXNi=dpU6umCoPg@mail.gmail.com> <CAK8P3a0sWObusG3xO_JE9CXCyNfFN0p6OgPjUyU2CHLBBZNpZw@mail.gmail.com>
In-Reply-To: <CAK8P3a0sWObusG3xO_JE9CXCyNfFN0p6OgPjUyU2CHLBBZNpZw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 30 Dec 2019 15:37:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9o==nBONywVgSjsmjs2H_A8itgmwibqzPmvivcSocKWRQ@mail.gmail.com>
Message-ID: <CAHmME9o==nBONywVgSjsmjs2H_A8itgmwibqzPmvivcSocKWRQ@mail.gmail.com>
Subject: Re: [PATCH] mips: vdso: conditionalize 32-bit time functions on COMPAT_32BIT_TIME
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> - Why does it crash in the first place rather than returning -ENOSYS?

There's a bit of speculation about this in the original thread that
prompted this patch (you're CC'd).

>
> - How does it actually work if you run an application built against
>   an old musl version on a kernel that tries to make this not work?
>   Do you just get a random time (uninitialized user space stack) and
>   work with that without checking the error code?

Actually, your patch fails here. The ts struct remains as it was
before, filled with garbage. No good. My original patch in this
thread, though, does result in the correct value being written to ts.

Jason
