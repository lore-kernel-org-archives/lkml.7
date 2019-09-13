Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD52C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2FC20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfIMLeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 07:34:03 -0400
Received: from foss.arm.com ([217.140.110.172]:41964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfIMLeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:34:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AFF028;
        Fri, 13 Sep 2019 04:34:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71BE93F59C;
        Fri, 13 Sep 2019 04:34:01 -0700 (PDT)
Date:   Fri, 13 Sep 2019 12:33:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix function types in COND_SYSCALL
Message-ID: <20190913113355.GA32453@lakrids.cambridge.arm.com>
References: <20190910224044.100388-1-samitolvanen@google.com>
 <20190911151545.GD3360@blommer>
 <20190912131143.u3rncvqdgx4z3ckz@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912131143.u3rncvqdgx4z3ckz@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 02:11:44PM +0100, Will Deacon wrote:
> On Wed, Sep 11, 2019 at 04:15:46PM +0100, Mark Rutland wrote:
> > On Tue, Sep 10, 2019 at 03:40:44PM -0700, Sami Tolvanen wrote:
> > > Define a weak function in COND_SYSCALL instead of a weak alias to
> > > sys_ni_syscall, which has an incompatible type. This fixes indirect
> > > call mismatches with Control-Flow Integrity (CFI) checking.
> > > 
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > 
> > This looks correct to me, builds fine, and I asume has been tested, so FWIW:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > In looking at this, I came to the conclusion that we can drop the ifdeffery
> > around our SYSCALL_DEFINE0(), COND_SYSCALL(), and SYS_NI(), which I evidently
> > cargo-culted from x86 (where the ifdeffery is actually necessary).
> 
> Curious: why is it required on x86?

Due to the way they share some native calls with (IA32) compat, but need
slightly different wrappers to marshall registers, they have ifdeffery
like:

#ifdef CONFIG_IA32_EMULATION
#define COND_SYSCALL(name)                                              \
        cond_syscall(__x64_sys_##name);                                 \
        cond_syscall(__ia32_sys_##name)
#endif

#ifndef COND_SYSCALL
#define COND_SYSCALL(name) cond_syscall(__x64_sys_##name)
#endif

... so that they define the compat wrapper when necessary, but not otherwise.

As we don't share the native syscall table with compat tasks, we don't
need to do anything like that, and can unconditionally define the native
case once.

> > I can send a follow up for that.
> 
> Yes, please.

I'll cook that up now, atop of Sami's patch applied to arm64's
for-next/core.

Thanks,
Mark.
