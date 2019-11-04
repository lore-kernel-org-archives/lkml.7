Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBBBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E879A20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfKDNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:52:01 -0500
Received: from foss.arm.com ([217.140.110.172]:43414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfKDNwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:52:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F171FB;
        Mon,  4 Nov 2019 05:52:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739A93F6C4;
        Mon,  4 Nov 2019 05:51:58 -0800 (PST)
Date:   Mon, 4 Nov 2019 13:51:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org,
        Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCHv2 7/8] arm64: implement ftrace with regs
Message-ID: <20191104135155.GG45140@lakrids.cambridge.arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-8-mark.rutland@arm.com>
 <8132dc13-9fbd-24e2-8a5e-28b005043c3e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8132dc13-9fbd-24e2-8a5e-28b005043c3e@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 05:51:46PM +0530, Amit Daniel Kachhap wrote:
> On 10/29/19 10:28 PM, Mark Rutland wrote:
> > +/*
> > + * Due to -fpatchable-function-entry=2, the compiler has placed two NOPs before
> > + * the regular function prologue. For an enabled callsite, ftrace_init_nop() and
> > + * ftrace_make_call() have patched those NOPs to:
> > + *
> > + * 	MOV	X9, LR
> > + * 	BL	<entry>
> > + *
> > + * ... where <entry> is either ftrace_caller or ftrace_regs_caller.
> > + *
> > + * Each instrumented function follows the AAPCS, so here x0-x8 and x19-x30 are
> > + * live, and x9-x18 are safe to clobber.
> > + *
> > + * We save the callsite's context into a pt_regs before invoking and ftrace

> s/invoking and ftrace callbacks/invoking the ftrace callbacks

Whoops, that was meant to be 'any'. I've fixed that up locally.

Thanks,
Mark.
