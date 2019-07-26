Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD5722C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfGZU4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfGZU4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:56:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C5A22BE8;
        Fri, 26 Jul 2019 20:56:51 +0000 (UTC)
Date:   Fri, 26 Jul 2019 16:56:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Message-ID: <20190726165649.0bf73f73@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1907262249210.1791@nanos.tec.linutronix.de>
References: <20190726183048.982726647@linutronix.de>
        <20190726185753.645792403@linutronix.de>
        <20190726164428.40a4e4b4@gandalf.local.home>
        <alpine.DEB.2.21.1907262249210.1791@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 22:52:18 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:
> > Have we marked all timer handlers that have normal spin_locks as
> > HRTIMER_MODE_SOFT? Otherwise, can't we switch one to hard below and
> > having their handler grab a spin_lock/mutex in hard interrupt context
> > in RT?  
> 
> See patch 09/12. We move all timers into soft mode which are not marked
> MODE_HARD.
> 


> > >  	sl->timer.function = hrtimer_wakeup;  
> 
> It's the wakeup function and nothing is supposed to override that.

Ah, that makes sense. Not the actual handler then.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

