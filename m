Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070802186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfDENcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDENcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:32:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D9A2184B;
        Fri,  5 Apr 2019 13:32:10 +0000 (UTC)
Date:   Fri, 5 Apr 2019 09:32:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: WARN_ON: userstacktrace on irq events
Message-ID: <20190405093209.7a5c5133@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1904051000290.1802@nanos.tec.linutronix.de>
References: <20190403121640.70128095@gandalf.local.home>
        <alpine.DEB.2.21.1904051000290.1802@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019 10:12:27 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > BOOM! Warn on.
> > 
> > Can we make that access_ok() call in the copy_stack_frame not trigger
> > the warning just if we are in an interrupt?  
> 
> You really want to have access_ok_atomic() or such which does not have the
> WARN and use that in copy_stack_frame(). That's fine here because the
> actual copy is inside a pagefault disabled region.

I was thinking the same.

Masami, did you post patches to do something like this?
"access_ok_inatomic()" or something?

-- Steve
