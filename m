Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A20218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfB1JOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:14:37 -0500
Received: from foss.arm.com ([217.140.101.70]:44690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbfB1JOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:14:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2098EBD;
        Thu, 28 Feb 2019 01:14:36 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B0FE3F738;
        Thu, 28 Feb 2019 01:14:35 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:14:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kasan: prevent recursive instrumentation
Message-ID: <20190228091428.GA31464@lakrids.cambridge.arm.com>
References: <20190222182851.21174-1-mark.rutland@arm.com>
 <CACT4Y+Z39U5JqaDQ-VMCn6Zmg+sJ58ZRO4ts8DQEr8XKS53Eug@mail.gmail.com>
 <20190225113509.GE26236@lakrids.cambridge.arm.com>
 <CACT4Y+YtEzSU3dE0NpU1XXtdAWXGptwAk64EeBXzPb61YTz0-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YtEzSU3dE0NpU1XXtdAWXGptwAk64EeBXzPb61YTz0-Q@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:01:08PM +0100, Dmitry Vyukov wrote:
> On Mon, Feb 25, 2019 at 12:35 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sat, Feb 23, 2019 at 11:29:45AM +0100, Dmitry Vyukov wrote:
> > > On Fri, Feb 22, 2019 at 7:29 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > When CONFIG_KASAN is selected, <linux/kasan-checks.h> defines the
> > > > prototypes for kasan_check_{read,write}(), rather than inline stubs.
> > >
> > > +kasan-dev@googlegroups.com
> > >
> > > Doesn't this do the same as?
> > > https://groups.google.com/d/msg/kasan-dev/NwEdpGgUeac/oXUIRUC6CAAJ
> >
> > I had missed that patch -- thanks for the pointer!
> >
> > Either patch should both fix the issue with the EFI stub, but the
> > __kasan_check*() renaming in this patch also prevents unexpected
> > instrumentation within mm/kasan/common.c, if a call to kasan_check_*()
> > were inlined there.
> >
> > If you think that robustness is worthwhile, I can spin a v2 making that
> > a bit clearer, and fix the logic to look at __SANITIZE_ADDRESS__ rather
> > than adding the KASAN_NOSANITIZE definition.
> >
> > AFAICT Arnd's patch isn't queued anywhere just yet.
> 
> I dunno. I don't have strong preference.
> Also not sure if Arnd's patch is not, say, in mm... problems of
> extremely long patch submission times... patches should take at most
> days to commit.

I see Arnd's patch is in linux-next today, so it looks like that's
solved.

I'll drop this patch unless we see any other problems.

Thanks,
Mark.
