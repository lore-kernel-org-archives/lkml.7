Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E51BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1247120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575352938;
	bh=U3312gghEjD+4yD8J4laQQ5wqu89YhGM/9fXJ/iYSrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gg8VwIBTWf8rirH2xzHj1K/yfmxFerT13EsHqoL/y/55PTP2ncKhYp6oozm+YNZv/
	 B1MXdqurvOXUcXOFrMJudFLajvnD2vCV4AV7J/8zIBKql18gow0Lx4oboabOArV5aO
	 OEMvs9nRgvCoiQOkzzKVjS51wexxnLh5evH3TP8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLCGCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfLCGCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:02:16 -0500
Received: from devnote2 (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776F220684;
        Tue,  3 Dec 2019 06:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575352935;
        bh=U3312gghEjD+4yD8J4laQQ5wqu89YhGM/9fXJ/iYSrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y6VwYbwS2TBnVxRp3WwQ4lohL3RGNRE4yYMEL8L/8Ei4NFKyg60CVfzAR5vTPlWOc
         dkwH12N44ttRYA4SnqCCmxiCUtGvTWN2vMc5JJ+C08j5RCfl7cKqmyaHkNk0qFAoub
         STmJDnoNkHkp4PVt93w5Xuk2zOs1AY+y6D5s0MI0=
Date:   Tue, 3 Dec 2019 15:02:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching
 kprobe
Message-Id: <20191203150210.7210c6e29c537c8954889c5b@kernel.org>
In-Reply-To: <20191202233531.GO17234@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
        <20191202210854.GD17234@google.com>
        <20191203073453.057c1bed6931457b011dd8cc@kernel.org>
        <20191202233531.GO17234@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 18:35:31 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Tue, Dec 03, 2019 at 07:34:53AM +0900, Masami Hiramatsu wrote:
> > Hi Joel,
> > 
> > On Mon, 2 Dec 2019 16:08:54 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > > > Anders reported that the lockdep warns that suspicious
> > > > RCU list usage in register_kprobe() (detected by
> > > > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > > > access kprobe_table[] by hlist_for_each_entry_rcu()
> > > > without rcu_read_lock.
> > > > 
> > > > If we call get_kprobe() from the breakpoint handler context,
> > > > it is run with preempt disabled, so this is not a problem.
> > > > But in other cases, instead of rcu_read_lock(), we locks
> > > > kprobe_mutex so that the kprobe_table[] is not updated.
> > > > So, current code is safe, but still not good from the view
> > > > point of RCU.
> > > > 
> > > > Let's lock the rcu_read_lock() around get_kprobe() and
> > > > ensure kprobe_mutex is locked at those points.
> > > > 
> > > > Note that we can safely unlock rcu_read_lock() soon after
> > > > accessing the list, because we are sure the found kprobe has
> > > > never gone before unlocking kprobe_mutex. Unless locking
> > > > kprobe_mutex, caller must hold rcu_read_lock() until it
> > > > finished operations on that kprobe.
> > > > 
> > > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Instead of this, can you not just pass the lockdep_is_held() expression as
> > > the last argument to list_for_each_entry_rcu() to silence the warning? Then
> > > it will be a simpler patch.
> > 
> > Ah, I see. That is more natural to silence the warning.
> 
> Np, and on such fix, my:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 

Thanks! I found another similar issue while testing, I'll fix it too.

-- 
Masami Hiramatsu <mhiramat@kernel.org>
