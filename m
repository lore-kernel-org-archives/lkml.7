Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2031C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8C2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfC2Oxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfC2Oxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:53:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629E32183F;
        Fri, 29 Mar 2019 14:53:34 +0000 (UTC)
Date:   Fri, 29 Mar 2019 10:53:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, julien.thierry@arm.com,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, linux@armlinux.org.uk, james.morse@arm.com,
        suzuki.poulose@arm.com, wanghaibin.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
Message-ID: <20190329105332.6b7fc1ae@gandalf.local.home>
In-Reply-To: <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
References: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
        <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 13:58:40 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On the other hand, if you can generate pseudo-NMIs, you could end-up
> tracing gic_handle_irq whilst being inside the tracing code with
> interrupts being notionally disabled (and that could be pretty bad).

Actually, that should still be safe. The tracing code is expected to
trace NMIs.

Now the entry of an NMI can be an issue because of the way tracing is
enabled. But this would also cause function tracing to crash, which was
not stated. Does function tracing have the same issue, or is this just
with function_graph tracing?

This is because a breakpoint is added to all the places that are going
to be traced so that the "nops" at the beginning of function calls are
going to be converted to calls to the tracer. Now that means a
breakpoint is being added at the beginning of gic_handle_irq(). I don't
know how this pseudo NMI works, but we have notrace set for do_NMI
because breakpoints at the entry (before it can fix things) causes
issues. But this still doesn't make sense because the gic_handle_irq()
call doesn't fix things up either, so other functions that are traced
by gic_handle_irq() should blow up too, which appears (by the patch)
not to be the case.

-- Steve
