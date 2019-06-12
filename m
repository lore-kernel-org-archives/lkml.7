Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D788C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA62206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408842AbfFLJdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:33:37 -0400
Received: from foss.arm.com ([217.140.110.172]:48602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408577AbfFLJdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:33:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9275228;
        Wed, 12 Jun 2019 02:33:36 -0700 (PDT)
Received: from brain-police (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82CCF3F246;
        Wed, 12 Jun 2019 02:33:34 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:33:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Don't unconditionally add -Wno-psabi to
 KBUILD_CFLAGS
Message-ID: <20190612093331.GB11554@brain-police>
References: <20190607161201.73430-1-natechancellor@gmail.com>
 <20190611171931.99705-1-natechancellor@gmail.com>
 <20190612092519.GP28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612092519.GP28398@e103592.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:25:20AM +0100, Dave Martin wrote:
> On Tue, Jun 11, 2019 at 10:19:32AM -0700, Nathan Chancellor wrote:
> > v1 -> v2:
> > 
> > * Improve commit message explanation, I wasn't entirely happy with the
> >   first one; let me know if there are any issues/questions.
> > 
> > * Carry forward Dave's ack and Nick's review (let me know if you
> >   disagree with the commit messasge rewording).
> > 
> >  arch/arm64/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 8fbd583b18e1..e9d2e578cbe6 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -51,7 +51,7 @@ endif
> >  
> >  KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> >  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> > -KBUILD_CFLAGS	+= -Wno-psabi
> > +KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
> >  KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
> >  
> >  KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
> 
> Looks OK to me.  Thanks for the additional explanation.

I'd already queued the previous version, but somehow forgotten to push it
out. I'll push this one out instead later today.

Cheers,

Will
