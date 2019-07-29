Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E51BC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B2F2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbfG2PIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387402AbfG2PIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:08:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C052070B;
        Mon, 29 Jul 2019 15:08:08 +0000 (UTC)
Date:   Mon, 29 Jul 2019 11:08:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 11/12] hrtimer: Prepare support for PREEMPT_RT
Message-ID: <20190729110806.57c57399@gandalf.local.home>
In-Reply-To: <42299f02-ff29-f7e3-45f0-b9fef041aec9@suse.com>
References: <20190726183048.982726647@linutronix.de>
        <20190726185753.737767218@linutronix.de>
        <42299f02-ff29-f7e3-45f0-b9fef041aec9@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019 11:06:50 +0200
Juergen Gross <jgross@suse.com> wrote:

> In case we'd want to change that I'd rather not special case timers, but
> apply a more general solution to the quite large amount of similar
> cases: I assume the majority of cpu_relax() uses are affected, so adding
> a paravirt op cpu_relax() might be appropriate.
> 
> That could be put under CONFIG_PARAVIRT_SPINLOCK. If called in a guest
> it could ask the hypervisor to give up the physical cpu voluntarily
> (in Xen this would be a "yield" hypercall).

Seems paravirt wants our cpu_chill() ;-)

-- Steve
