Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2EACA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C505C20656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfKAQ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:29:12 -0400
Received: from foss.arm.com ([217.140.110.172]:38210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfKAQ3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:29:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11591FB;
        Fri,  1 Nov 2019 09:29:11 -0700 (PDT)
Received: from blommer (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5829C3F719;
        Fri,  1 Nov 2019 09:29:08 -0700 (PDT)
Date:   Fri, 1 Nov 2019 16:28:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     jthierry@redhat.com, linux-parisc@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, deller@gmx.de,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, James.Bottomley@HansenPartnership.com,
        takahiro.akashi@linaro.org, mingo@redhat.com, james.morse@arm.com,
        jeyu@kernel.org, amit.kachhap@arm.com, will@kernel.org,
        duwe@suse.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Message-ID: <20191101162847.GA3677@blommer>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191101153929.GA9053@t470p.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101153929.GA9053@t470p.stackframe.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 04:39:30PM +0100, Sven Schnelle wrote:
> On Tue, Oct 29, 2019 at 04:58:24PM +0000, Mark Rutland wrote:
> > This series is a reworked version of Torsten's FTRACE_WITH_REGS series
> > [1]. I've tried to rework the existing code in preparatory patches so
> > that the patchable-function-entry bits slot in with fewer surprises.
> > This version is based on v5.4-rc3, and can be found in my
> > arm64/ftrace-with-regs branch [2].
> > 
> > Patch 1 adds an (optional) ftrace_init_nop(), which the core code uses
> > to initialize callsites. This allows us to avoid a synthetic MCOUNT_ADDR
> > symbol, and more cleanly separates the one-time initialization of the
> > callsite from dynamic NOP<->CALL modification. Architectures which don't
> > implement this get the existing ftrace_make_nop() with MCOUNT_ADDR.
> > 
> > Recently parisc gained ftrace support using patchable-function-entry.
> > Patch 2 makes the handling of module callsite locations common in
> > kernel/module.c with a new FTRACE_CALLSITE_SECTION definition, and
> > removed the newly redundant bits from arch/parisc.

> > Since v1 [3]:
> > * Add a couple of people to Cc
> > * Fold in Ard's Reviewed-by tag
> > * Rename ftrace_code_init_disabled() to ftrace_nop_initialize()
> > * Move ftrace_init_nop() to <linux/ftrace.h>, with kerneldoc
> > * Update kerneldoc for rec parameters
> [..]
> 
> I tested this series on parisc both with ftracing kernel internal functions and
> module functions. Both are working fine, so feel free to add my
> 
> Tested-by: Sven Schnelle <svens@stackframe.org>

Thanks! That's much appreciated.

I've applied that to patches 1 and 2, since the remainder of the series was
confined to arch/arm64/.

Mark.
