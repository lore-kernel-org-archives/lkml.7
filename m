Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0286AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C834F20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfDPT7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:59:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:59:53 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hGUFB-0002zU-7U; Tue, 16 Apr 2019 21:59:49 +0200
Date:   Tue, 16 Apr 2019 21:59:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel/time/ntp.c: Possible off-by-one error in TAI range
 check?
In-Reply-To: <20190415085641.GI28203@localhost>
Message-ID: <alpine.DEB.2.21.1904162159220.1780@nanos.tec.linutronix.de>
References: <CAFqZXNsO63bX37T=bg=QRt6_EtpvXUNQ_N-TSXsN4=wd1Dz2zQ@mail.gmail.com> <CAFqZXNuqWGNwUTUxWjZRmx4PFL2zsRRo6fu+ZXZwaQAMvuf1kQ@mail.gmail.com> <alpine.DEB.2.21.1904151008460.1729@nanos.tec.linutronix.de> <20190415085641.GI28203@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Miroslav Lichvar wrote:
> On Mon, Apr 15, 2019 at 10:09:43AM +0200, Thomas Gleixner wrote:
> > > On Mon, Apr 8, 2019 at 10:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > Commit 153b5d054ac2 ("ntp: support for TAI") added a possibility to
> > > > change the TAI offset from userspace via adjtimex(2). The code checks
> > > > if the input value (txc->constant) is greater than 0 and if it is not,
> > > > then it doesn't modify the value. Ignoring the fact that this check
> > > > should probably be in timekeeping_validate_timex() and cause -EINVAL
> > > > to be returned when false, I find it strange that the check doesn't
> > > > allow to set the value to 0, which seems to be the default value...
> > > >
> > > > Was this behavior intended or should the code actually check for
> > > > txc->constant >= 0 instead of txc->constant > 0?
> 
> I guess zero here means "unknown" and maybe the intention was to not
> allow setting the offset to an unknown value once it has been set to a
> valid value. The trouble is that after inserting a leap second the
> offset may change from zero to one.
> 
> I think it should be changed to allow setting the offset to zero.

Can someone please send a patch with a coherent changelog?

Thanks,

	tglx
