Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D729DC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88F8217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558510226;
	bh=Y3sfF9uIWPNrWBoL+BrYYhAXkTeujPr/AtvO0B6+RLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bmNQNkopy09zkvsoOJFcY86wF45zwbnvsVEesn4rzrprFb8uVgyNOj+xW4+u6yCXI
	 NXi9I7/Z/1h9+G6wWiQ1bR1aZd7m99fPL4FX4fF5cQ7UV7nr5VQOEPs2T8R+wr56xh
	 0py+pHgr4CznliKTozGnDalM2B2VEF3FBXTvMBy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfEVHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfEVHaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:30:25 -0400
Received: from devnote2 (unknown [103.5.140.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDD52173E;
        Wed, 22 May 2019 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558510224;
        bh=Y3sfF9uIWPNrWBoL+BrYYhAXkTeujPr/AtvO0B6+RLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJ4AXDCriV2N0JWYQ73WEJrYI5Ff8Cdp3d4nd8YNnItJkH1LXacQLBtu4F9q7ggIq
         E1Pu8B10TOOXxcCwgftusuoVpWWxbStcZ3IUSwVjMdvnrIOwDqEy7EAtlqIR5rbh5Z
         uQZuNlycrsI6RceIIG65ywq+pNHiJGG0RHWy8oQo=
Date:   Wed, 22 May 2019 16:30:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable new kprobe event at boot
Message-Id: <20190522163021.b8d08103dd5df01b2e472e46@kernel.org>
In-Reply-To: <20190522003932.34367dcae6d9de27e254e174@kernel.org>
References: <155842537599.4253.14690293652007233645.stgit@devnote2>
        <20190521093317.7d698f79@gandalf.local.home>
        <20190522003932.34367dcae6d9de27e254e174@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 00:39:32 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Perhaps we could enable kprobes at early init?
> 
> It should be possible, I will try to find what blocks it. I guess after we
> switch early_text_poke() to text_poke(), we can use kprobes on x86. But
> for other archs, I need to investigate more.

OK, I just follow the kernel init related to kprobes

start_kernel()
 -> trace_init()
 -> rcu_init_nohz()
 -> perf_event_init()
 -> arch_call_rest_init()
   -> rest_init()
     -> rcu_scheduler_starting()
     -> kernel_thread(kernel_init)
kernel_init()
 -> kernel_init_freeable()
   -> wait_for_completion(&kthreadd_done);
   -> workqueue_init()
   -> smp_init()
   -> do_basic_setup()
     -> do_initcalls()
       -> do_initcall_level()
         (in subsys-level)
         -> init_kprobes()

Since optprobe uses workqueue, we can not move it before workqueue_init().
(but maybe we can disable it in early stage)
Also, since kprobes depends on rcu, I guess we can not move it before
rcu_scheduler_starting().
for kretprobe, we need to get the possible cpus, we need a fix if we move
it before before smp_init().
However, there is no reason we need to run it in subsys level. We can
move init_kprobes() in core or pure level safely.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
