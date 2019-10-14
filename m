Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C01C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79D7207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfJNKJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:09:51 -0400
Received: from foss.arm.com ([217.140.110.172]:39488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbfJNKJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:09:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22B3337;
        Mon, 14 Oct 2019 03:09:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CDAD3F718;
        Mon, 14 Oct 2019 03:09:50 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:09:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] stop_machine: avoid potential race behaviour
Message-ID: <20191014100943.GA41626@lakrids.cambridge.arm.com>
References: <20191007104536.27276-1-mark.rutland@arm.com>
 <20191008083637.GI2294@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008083637.GI2294@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:36:37AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 07, 2019 at 11:45:36AM +0100, Mark Rutland wrote:
> > Both multi_cpu_stop() and set_state() access multi_stop_data::state
> > racily using plain accesses. These are subject to compiler
> > transformations which could break the intended behaviour of the code,
> > and this situation is detected by KCSAN on both arm64 and x86 (splats
> > below).
> 
> I really don't think there is anything the compiler can do wrong here.
> 
> That is, I'm thinking I'd like to get this called out as a false-positive.

I agree that in practice, it's very unlikely this would go wrong.

There are some things the compiler could do, e.g. with re-ordering of
volatile and plain reads of the same variable:

  https://lore.kernel.org/lkml/20191003161233.GB38140@lakrids.cambridge.arm.com/

... and while I agree that's vanishingly unlikely to happen here, I
couldn't say how to rule that out without ruling out cases that would
actually blow up in practice.

> That said, the patch looks obviously fine and will help with the
> validation effort so no real objection there.

Great! Can I take that as an Acked-by?

I assume this should go via the tip tree.

Thanks,
Mark.
