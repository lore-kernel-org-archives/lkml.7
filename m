Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28068C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03791207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfDBJGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:06:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDBJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:06:52 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBFNX-0000cS-BX; Tue, 02 Apr 2019 11:06:47 +0200
Date:   Tue, 2 Apr 2019 11:06:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH ghak10 v6 1/2] timekeeping: Audit clock adjustments
In-Reply-To: <CAFqZXNtHxt6Huv2ufU-gp-0Y4WfyQSJkYVS0cmd0o+G=D1A-UQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904021104440.1676@nanos.tec.linutronix.de>
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-2-omosnace@redhat.com> <alpine.DEB.2.21.1903280020390.1789@nanos.tec.linutronix.de> <CAFqZXNtHxt6Huv2ufU-gp-0Y4WfyQSJkYVS0cmd0o+G=D1A-UQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019, Ondrej Mosnacek wrote:
> On Thu, Mar 28, 2019 at 1:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >  EXPORT_SYMBOL(do_settimeofday64);
> > > @@ -2322,6 +2326,8 @@ int do_adjtimex(struct timex *txc)
> > >               ret = timekeeping_inject_offset(&delta);
> > >               if (ret)
> > >                       return ret;
> > > +
> > > +             audit_tk_injoffset(delta);
> > >       }
> > >
> > >       ktime_get_real_ts64(&ts);
> >
> > This can be done at the end of do_adjtimex() quite nicely in preemptible
> > context.
> 
> But wait, isn't this call outside of the critical section as well? (I
> must have been moving the call around when I was writing the code and
> didn't realize that this function actually doesn't need GFP_ATOMIC at
> all...) Or am I missing something?

Nah. I was misreading it. Just it does not need GFP_ATOMIC at all. But then
you might just combine it with your new struct storage which you want to do
for __do_adjtimex() anyway.

Thanks,

	tglx
