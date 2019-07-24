Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E211C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3077D2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfGXLXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:23:24 -0400
Received: from foss.arm.com ([217.140.110.172]:39382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGXLXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:23:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286A0337;
        Wed, 24 Jul 2019 04:23:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72B4C3F71A;
        Wed, 24 Jul 2019 04:23:21 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:23:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 2/2] lib/test_kasan: Add stack overflow test
Message-ID: <20190724112318.GC2624@lakrids.cambridge.arm.com>
References: <20190719132818.40258-1-elver@google.com>
 <20190719132818.40258-2-elver@google.com>
 <20190723162403.GA56959@lakrids.cambridge.arm.com>
 <CANpmjNPBNUQXoPUNw46=iieH3SS1Pk8PxNvQ1FPdNCoU4g8F2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPBNUQXoPUNw46=iieH3SS1Pk8PxNvQ1FPdNCoU4g8F2w@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 06:49:03PM +0200, Marco Elver wrote:
> On Tue, 23 Jul 2019 at 18:24, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Jul 19, 2019 at 03:28:18PM +0200, Marco Elver wrote:
> > > Adds a simple stack overflow test, to check the error being reported on
> > > an overflow. Without CONFIG_STACK_GUARD_PAGE, the result is typically
> > > some seemingly unrelated KASAN error message due to accessing random
> > > other memory.
> >
> > Can't we use the LKDTM_EXHAUST_STACK case to check this?
> >
> > I was also under the impression that the other KASAN self-tests weren't
> > fatal, and IIUC this will kill the kernel.
> >
> > Given that, and given this is testing non-KASAN functionality, I'm not
> > sure it makes sense to bundle this with the KASAN tests.
> 
> Thanks for pointing out LKDTM_EXHAUST_STACK.
> 
> This patch can be dropped!

Cool; it's always nice to find the work has already been done! :)

Thanks,
Mark.
