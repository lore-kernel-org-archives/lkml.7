Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD778C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868CE20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDOI4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfDOI4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 502AF3082211;
        Mon, 15 Apr 2019 08:56:45 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7FD05D71A;
        Mon, 15 Apr 2019 08:56:43 +0000 (UTC)
Date:   Mon, 15 Apr 2019 10:56:41 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel/time/ntp.c: Possible off-by-one error in TAI range check?
Message-ID: <20190415085641.GI28203@localhost>
References: <CAFqZXNsO63bX37T=bg=QRt6_EtpvXUNQ_N-TSXsN4=wd1Dz2zQ@mail.gmail.com>
 <CAFqZXNuqWGNwUTUxWjZRmx4PFL2zsRRo6fu+ZXZwaQAMvuf1kQ@mail.gmail.com>
 <alpine.DEB.2.21.1904151008460.1729@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904151008460.1729@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 15 Apr 2019 08:56:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:09:43AM +0200, Thomas Gleixner wrote:
> > On Mon, Apr 8, 2019 at 10:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Commit 153b5d054ac2 ("ntp: support for TAI") added a possibility to
> > > change the TAI offset from userspace via adjtimex(2). The code checks
> > > if the input value (txc->constant) is greater than 0 and if it is not,
> > > then it doesn't modify the value. Ignoring the fact that this check
> > > should probably be in timekeeping_validate_timex() and cause -EINVAL
> > > to be returned when false, I find it strange that the check doesn't
> > > allow to set the value to 0, which seems to be the default value...
> > >
> > > Was this behavior intended or should the code actually check for
> > > txc->constant >= 0 instead of txc->constant > 0?

I guess zero here means "unknown" and maybe the intention was to not
allow setting the offset to an unknown value once it has been set to a
valid value. The trouble is that after inserting a leap second the
offset may change from zero to one.

I think it should be changed to allow setting the offset to zero.

-- 
Miroslav Lichvar
