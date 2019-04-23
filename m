Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2EEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828A0214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfDWOMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:12:46 -0400
Received: from foss.arm.com ([217.140.101.70]:57234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDWOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:12:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85984A78;
        Tue, 23 Apr 2019 07:12:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF913F238;
        Tue, 23 Apr 2019 07:12:43 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:12:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
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
Message-ID: <20190423141240.GC56999@lakrids.cambridge.arm.com>
References: <20190415143821.GA46880@beast>
 <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
 <20190416170808.GC54708@lakrids.cambridge.arm.com>
 <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
 <CAKwvOdn-MGokV0vsGq2GdRK-eGHdyC6+vVHYSfwOfpqNWwQzXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn-MGokV0vsGq2GdRK-eGHdyC6+vVHYSfwOfpqNWwQzXw@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:44:10AM -0700, Nick Desaulniers wrote:
> On Tue, Apr 16, 2019 at 9:03 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Apr 16, 2019 at 12:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > > > On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > It would be nice if we could simply rely on a more recent binutils these
> > > > > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > > > > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > > > > hack by turning that into a CPP macro which built that name.
> 
> Mark, can you give me a test case for this? I'd like to check if
> clang's integrated assembler supports this or not, so we can file an
> issue and fix it if not.

The below is a smoke test. The entire op0:op1:cn:cm:op2 space is 14
bits, so it should be feasible to generate and run an exhautive test for
all encodings.

I've included SYS and SYSL here too, since I strongly suspect we'll need
those going forward.

Thanks
Mark.

---->8----
/*
 * ${CC} -c test.c
 *
 * OLD_* encodings already exist, NEW_* encodings haven't yet be
 * allocated (per ARM DDI 0487D.a), but should assemble. All encodings
 * chosen arbitrarily.
 */

// OSDTRRX_EL1
#define OLD_DBG_REG	"s2_0_c0_c0_2"
#define NEW_DBG_REG	"s2_7_c0_c15_0"

// MIDR_EL1
#define OLD_SYS_REG	"s3_0_c0_c0_0"
#define NEW_SYS_REG	"s3_6_c1_c0_7"

#define REG(r)					\
	asm volatile("msr " r ", xzr\n");	\
	asm volatile("mrs xzr, " r "\n")

// DC IVAC, XZR
#define OLD_SYS	"#0, c7, c6, #1"
#define NEW_SYS "#7, c15, c15, #7"

#define NEW_SYSL_MIN	"#0, c0, c0, #0"
#define NEW_SYSL_MAX	"#7, c15, c15, #7"

#define SYS(s)	asm volatile("sys " s ", xzr\n")
#define SYSL(s)	asm volatile("sysl xzr, " s "\n")

void test(void)
{
	REG(OLD_DBG_REG);
	REG(NEW_DBG_REG);

	REG(OLD_SYS_REG);
	REG(NEW_SYS_REG);

	SYS(OLD_SYS);
	SYS(NEW_SYS);

	SYSL(NEW_SYSL_MIN);
	SYSL(NEW_SYSL_MAX);
}
