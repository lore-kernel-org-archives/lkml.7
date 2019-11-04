Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCFFCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630042184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfKDNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:38:41 -0500
Received: from foss.arm.com ([217.140.110.172]:43224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfKDNil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:38:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97DD81FB;
        Mon,  4 Nov 2019 05:38:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE8D3F6C4;
        Mon,  4 Nov 2019 05:38:38 -0800 (PST)
Date:   Mon, 4 Nov 2019 13:38:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, catalin.marinas@arm.com, deller@gmx.de,
        duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191104133836.GF45140@lakrids.cambridge.arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-2-mark.rutland@arm.com>
 <20191104081620.732320a8@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104081620.732320a8@grimm.local.home>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 08:16:20AM -0500, Steven Rostedt wrote:
> On Tue, 29 Oct 2019 16:58:25 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Architectures may need to perform special initialization of ftrace
> > callsites, and today they do so by special-casing ftrace_make_nop() when
> > the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
> > patchable-function-entry), we don't have an mcount-like symbol and don't
> > want a synthetic MCOUNT_ADDR, but we may need to perform some
> > initialization of callsites.
> > 
> > To make it possible to separate initialization from runtime
> > modification, and to handle cases without an mcount-like symbol, this
> > patch adds an optional ftrace_init_nop() function that architectures can
> > implement, which does not pass a branch address.
> > 
> > Where an architecture does not provide ftrace_init_nop(), we will fall
> > back to the existing behaviour of calling ftrace_make_nop() with
> > MCOUNT_ADDR.
> > 
> > At the same time, ftrace_code_disable() is renamed to
> > ftrace_nop_initialize() to make it clearer that it is intended to
> > intialize a callsite into a disabled state, and is not for disabling a
> > callsite that has been runtime enabled. The kerneldoc description of rec
> > arguments is updated to cover non-mcount callsites.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

Just to check, are you happy if this were to go via the arm64 tree with
the rest of the patches?

Mark.
