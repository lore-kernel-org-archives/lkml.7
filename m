Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9993AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C22175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfEXSfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:35:55 -0400
Received: from foss.arm.com ([217.140.101.70]:48762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfEXSfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:35:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E187EA78;
        Fri, 24 May 2019 11:35:54 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E403F703;
        Fri, 24 May 2019 11:35:53 -0700 (PDT)
Date:   Fri, 24 May 2019 19:35:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: use the correct function type for
 __arm64_sys_ni_syscall
Message-ID: <20190524183551.GE9697@fuggles.cambridge.arm.com>
References: <20190503191225.6684-1-samitolvanen@google.com>
 <20190503191225.6684-4-samitolvanen@google.com>
 <20190507172512.GA35803@lakrids.cambridge.arm.com>
 <20190507183227.GA10191@google.com>
 <20190515114035.GG24357@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515114035.GG24357@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Wed, May 15, 2019 at 12:40:39PM +0100, Will Deacon wrote:
> On Tue, May 07, 2019 at 11:32:27AM -0700, Sami Tolvanen wrote:
> > On Tue, May 07, 2019 at 06:25:12PM +0100, Mark Rutland wrote:
> > > I strongly think that we cant to fix up the common definition in
> > > kernel/sys_ni.c rather than having a point-hack in arm64. Other
> > > architectures (e.g. x86, s390) will want the same for CFI, and I'd like
> > > to ensure that our approached don't diverge.
> > 
> > s390 already has the following in arch/s390/kernel/sys_s390.c:
> > 
> >   SYSCALL_DEFINE0(ni_syscall)
> >   {
> >         return -ENOSYS;
> >   }
> > 
> > Which, I suppose, is cleaner than calling sys_ni_syscall.
> > 
> > > I took a quick look, and it looks like it's messy but possible to fix
> > > up the core.
> > 
> > OK. How would you propose fixing this?
> 
> In the absence of a patch from Mark, I'd suggest just adding a SYS_NI macro
> to our asm/syscall_wrapper.h file which avoids the error injection stuff. It
> doesn't preclude moving this to the core later on, but it unblocks the CFI
> work.

Do you plan to repost this?

Will
