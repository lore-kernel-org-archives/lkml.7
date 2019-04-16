Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2593BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FA420872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfDPRIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:08:15 -0400
Received: from foss.arm.com ([217.140.101.70]:59970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfDPRIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:08:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77CDA80D;
        Tue, 16 Apr 2019 10:08:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D6F3F59C;
        Tue, 16 Apr 2019 10:08:11 -0700 (PDT)
Date:   Tue, 16 Apr 2019 18:08:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190416170808.GC54708@lakrids.cambridge.arm.com>
References: <20190415143821.GA46880@beast>
 <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > It would be nice if we could simply rely on a more recent binutils these
> > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > hack by turning that into a CPP macro which built that name.
> >
> > It looks like binutils has been able to do that since September 2014...
> >
> > Are folk using toolchains older than that to compile kernels?
> 
> Do you have a link to a commit?  If we can pinpoint the binutils
> version, that might help.

IIUC any version of binutils with commit:

  df7b4545b2b49572 ("[PATCH/AArch64] Generic support for all system registers using mrs and msr")

... should be sufficent.

That's on gitweb at:

  https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=df7b4545b2b49572ab63690c130df973af109615

> Also, I look forward to this patch for use of Clang's integrated
> assembler (regardless of LTO).  I remember getting frustrated trying
> to figure out how to resolve this for both assemblers, and I had
> forgotten this solution existed.

Is this the only blocker for the integrated assembler?

Thanks,
Mark.
