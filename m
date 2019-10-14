Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C747EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF7D206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfJNKTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:19:42 -0400
Received: from foss.arm.com ([217.140.110.172]:39672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbfJNKTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:19:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E38337;
        Mon, 14 Oct 2019 03:19:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E53A3F718;
        Mon, 14 Oct 2019 03:19:40 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:19:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, sgrover@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: KCSAN Support on ARM64 Kernel
Message-ID: <20191014101938.GB41626@lakrids.cambridge.arm.com>
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
 <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
 <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:09:40AM +0200, Marco Elver wrote:
> On Mon, 14 Oct 2019 at 10:40, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > I am from Qualcomm Linux Security Team, just going through KCSAN
> > > and found that there was a thread for arm64 support
> > > (https://lkml.org/lkml/2019/9/20/804).
> > >
> > > Can you please tell me if KCSAN is supported on ARM64 now? Can I
> > > just rebase the KCSAN branch on top of our let’s say android
> > > mainline kernel, enable the config and run syzkaller on that for
> > > finding race conditions?
> > >
> > > It would be very helpful if you reply, we want to setup this for
> > > finding issues on our proprietary modules that are not part of
> > > kernel mainline.
> > >
> > > Regards,
> > >
> > > Sachin Grover
> >
> > +more people re KCSAN on ARM64
> 
> KCSAN does not yet have ARM64 support. Once it's upstream, I would
> expect that Mark's patches (from repo linked in LKML thread) will just
> cleanly apply to enable ARM64 support.

Once the core kcsan bits are ready, I'll rebase the arm64 patch atop.
I'm expecting some things to change as part of review, so it'd be great
to see that posted ASAP.

For arm64 I'm not expecting major changes (other than those necessary to
handle the arm64 atomic rework that went in to v5.4-rc1)

FWIW, I was able to run Syzkaller atop of my arm64/kcsan branch, but
it's very noisy as it has none of the core fixes.

Thanks,
Mark.
