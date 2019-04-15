Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2816FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BCF206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfDOIJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:09:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:09:55 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFwgX-0001w6-HX; Mon, 15 Apr 2019 10:09:49 +0200
Date:   Mon, 15 Apr 2019 10:09:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Roman Zippel <zippel@linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel/time/ntp.c: Possible off-by-one error in TAI range
 check?
In-Reply-To: <CAFqZXNuqWGNwUTUxWjZRmx4PFL2zsRRo6fu+ZXZwaQAMvuf1kQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904151008460.1729@nanos.tec.linutronix.de>
References: <CAFqZXNsO63bX37T=bg=QRt6_EtpvXUNQ_N-TSXsN4=wd1Dz2zQ@mail.gmail.com> <CAFqZXNuqWGNwUTUxWjZRmx4PFL2zsRRo6fu+ZXZwaQAMvuf1kQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Ondrej Mosnacek wrote:

CC+ Miroslav

> On Mon, Apr 8, 2019 at 10:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Hello,
> >
> > while writing tests for clock adjustment auditing [1] [2], I stumbled
> > upon a strange behavior of adjtimex(2) when setting the TAI offset...
> >
> > Commit 153b5d054ac2 ("ntp: support for TAI") added a possibility to
> > change the TAI offset from userspace via adjtimex(2). The code checks
> > if the input value (txc->constant) is greater than 0 and if it is not,
> > then it doesn't modify the value. Ignoring the fact that this check
> > should probably be in timekeeping_validate_timex() and cause -EINVAL
> > to be returned when false, I find it strange that the check doesn't
> > allow to set the value to 0, which seems to be the default value...
> >
> > Was this behavior intended or should the code actually check for
> > txc->constant >= 0 instead of txc->constant > 0?
> 
> Ping?
> 
> >
> > Thanks,
> >
> > [1] https://github.com/linux-audit/audit-kernel/issues/10
> > [2] https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Software Engineer, Security Technologies
> > Red Hat, Inc.
> 
> -- 
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 
