Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F82CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404B8206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575326100;
	bh=037N1n95HaeHA9qb/NcymMRdiDlQXJFA6+wjFRryMyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zqv4N+ewy0wF2rb8dx5mL8n9OLXst/cR/Up9t0df2SX5ZrCnKDUKwBqwDx1L7BVtb
	 EwOuc6VGEi7IHgGd38j9oCdsWpH62YbYi5/VPJutwAspTyS9fJPhIUtlZT8VM3Zi5Z
	 pMpjGWNjfCUUyTKmY6v2LyXetrmum8e0bv/I2xjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLBWe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfLBWe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:34:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A69206F0;
        Mon,  2 Dec 2019 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575326098;
        bh=037N1n95HaeHA9qb/NcymMRdiDlQXJFA6+wjFRryMyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hkEpkGihe2wrEItuO8f9YJbOJJ2pLUXESmFJNyn1lSmZL2+qDcmAe0r5vkxObLXzp
         9SLKZSIMUf+bfWdQb3tRJdWSj/UBP/At26m3VuEpN+mov0+M3fJvkGJijUavqaO95r
         56cg65RGdCL1Yc6wcsc1UKpqMFODwpObJeSPGJ5o=
Date:   Tue, 3 Dec 2019 07:34:53 +0900
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
Message-Id: <20191203073453.057c1bed6931457b011dd8cc@kernel.org>
In-Reply-To: <20191202210854.GD17234@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
        <20191202210854.GD17234@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Mon, 2 Dec 2019 16:08:54 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > Anders reported that the lockdep warns that suspicious
> > RCU list usage in register_kprobe() (detected by
> > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > access kprobe_table[] by hlist_for_each_entry_rcu()
> > without rcu_read_lock.
> > 
> > If we call get_kprobe() from the breakpoint handler context,
> > it is run with preempt disabled, so this is not a problem.
> > But in other cases, instead of rcu_read_lock(), we locks
> > kprobe_mutex so that the kprobe_table[] is not updated.
> > So, current code is safe, but still not good from the view
> > point of RCU.
> > 
> > Let's lock the rcu_read_lock() around get_kprobe() and
> > ensure kprobe_mutex is locked at those points.
> > 
> > Note that we can safely unlock rcu_read_lock() soon after
> > accessing the list, because we are sure the found kprobe has
> > never gone before unlocking kprobe_mutex. Unless locking
> > kprobe_mutex, caller must hold rcu_read_lock() until it
> > finished operations on that kprobe.
> > 
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Instead of this, can you not just pass the lockdep_is_held() expression as
> the last argument to list_for_each_entry_rcu() to silence the warning? Then
> it will be a simpler patch.

Ah, I see. That is more natural to silence the warning.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
