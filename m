Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C9F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576868301;
	bh=IZyP1CzWPHFXxWCQpm+dZtMY5icMs84nWMzMuJOJo/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MjwNIrcvF2lMxqTQ/ASvguCtY3l6jCNNUNBugW4xL7k8emvyyzLB3UXCQDgPDzaKZ
	 t8px7XmH0qJqe3oC05EVJGlFeceJJq6mkyUBvsuZqe1Jsmx9/G8pc7oNzrDtTka13k
	 jXWgu8DCSwYbckhYBRBpiNUuBOLMQv9EPcvUd9x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLTS6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfLTS6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:58:20 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A24206D8;
        Fri, 20 Dec 2019 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576868298;
        bh=IZyP1CzWPHFXxWCQpm+dZtMY5icMs84nWMzMuJOJo/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QsDv3vbv6woSxz169v5KYYNA69m2xMZMn2xalcEtlCbc+V/IPZrmYExUY3iPEhmcD
         Lsgdj6z03aj7wk1sGT8sUZ0OSCO2ETByAks9XX44a7NlqjPoQkOaIoA4q44gwqizMU
         HVcvOrMVqA/4q8OeiNxbP2JBnabrnXkgRvREg5RI=
Date:   Sat, 21 Dec 2019 03:58:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <paulmck@kernel.org>, <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH] kprobes: Fix suspicious RCU usage WARN in
 get_kprobe()
Message-Id: <20191221035814.cb1800611c09b02bc448308d@kernel.org>
In-Reply-To: <1576846191-18801-1-git-send-email-john.garry@huawei.com>
References: <1576846191-18801-1-git-send-email-john.garry@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for your work. Actually, I already sent the same fix 2 weeks ago.

https://lore.kernel.org/lkml/157535316659.16485.11817291759382261088.stgit@devnote2/

Thank you,

On Fri, 20 Dec 2019 20:49:51 +0800
John Garry <john.garry@huawei.com> wrote:

> With CONFIG_PROVE_RCU_LIST set, we may get the following WARN in the
> test code:
> 
> Kprobe smoke test: started
> 
> =============================
> WARNING: suspicious RCU usage
> 5.5.0-rc1-00013-ge15bd404ed10-dirty #802 Not tainted
> -----------------------------
> kernel/kprobes.c:329 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by swapper/0/1:
> #0: ffff800011bf3648 (kprobe_mutex){+.+.}, at: register_kprobe+0x94/0x5a0
> 
> stack backtrace:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1-00013-ge15bd404ed10-dirty #802
> Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
> Call trace:
> dump_backtrace+0x0/0x1a0
> show_stack+0x14/0x20
> dump_stack+0xe8/0x150
> lockdep_rcu_suspicious+0xcc/0x110
> get_kprobe+0xb8/0xc0
> __get_valid_kprobe+0x18/0xc8
> register_kprobe+0x9c/0x5a0
> init_test_probes+0x80/0x400
> init_kprobes+0x13c/0x154
> do_one_initcall+0x88/0x428
> kernel_init_freeable+0x21c/0x2c4
> kernel_init+0x10/0x108
> ret_from_fork+0x10/0x18
> Kprobe smoke test: passed successfully
> 
> The code comment tells us the locking requirements:
> 
> /*
>  * This routine is called either:
>  * 	- under the kprobe_mutex - during kprobe_[un]register()
>  * 				OR
>  * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
>  */
> struct kprobe *get_kprobe(void *addr)
> {
> 	struct hlist_head *head;
> 	struct kprobe *p;
> 
> 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
> 	hlist_for_each_entry_rcu(p, head, hlist,
> 
> And we have the kprobe_mutex held in the path of concern, so add a
> RCU list traversal check condition for this.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> I sent as an RFC as I am not 100% certain that this is the right fix.
> It does solve my WARN.
> 
> I also assume __get_valid_kprobe() will require a similar change for
> similar reason.
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 53534aa258a6..908abdac77f1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -326,7 +326,8 @@ struct kprobe *get_kprobe(void *addr)
>  	struct kprobe *p;
>  
>  	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
> -	hlist_for_each_entry_rcu(p, head, hlist) {
> +	hlist_for_each_entry_rcu(p, head, hlist,
> +				 mutex_is_locked(&kprobe_mutex)) {
>  		if (p->addr == addr)
>  			return p;
>  	}
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
