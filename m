Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3516C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C645420706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575595298;
	bh=K1h8wFONOn7HT/lNn+s3G3vdjhN2dKx00KjNLngfK+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vPO2yov4PQUR8brsE35HZiiBUJGswpb4IUqLyypfPwjJwaYTcWZig5tezUF2+Lx8h
	 6H9A5+X+GjHC1irMjbTTof5njhegR5gStWWFfGs3KEkXLsao+cHDX/Pm+kp3B8kPwq
	 xo0M8BWiCPhLQaVO53gKX80n0i5/Ve8WoGH9REo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLFBVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:21:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfLFBVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:21:37 -0500
Received: from devnote2 (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83DB20706;
        Fri,  6 Dec 2019 01:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575595296;
        bh=K1h8wFONOn7HT/lNn+s3G3vdjhN2dKx00KjNLngfK+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPcRouQUCD3tUBN5DglqLZgQtFGem0bkK1X7+YvZb95D1ICcL5+fpPFhdOQ5y6/3f
         QIXeC81PsXwnVKOe9mzSIghwBNC2V3NpYkEKNGgxyefkiAXEeHYVA7KKVxXb5VttnN
         mpHT9NUuJEW9BpFJ5LW5hCX3+Uj94tDDL7x3owSs=
Date:   Fri, 6 Dec 2019 10:21:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: lockdep: Suppress suspicious RCU usage warning
Message-Id: <20191206102129.abe60bfefb78048d4ab1d3cc@kernel.org>
In-Reply-To: <20191205191758.GA30613@linux-8ccs>
References: <157535364480.17342.7937104819926015512.stgit@devnote2>
        <20191205191758.GA30613@linux-8ccs>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 20:17:59 +0100
Jessica Yu <jeyu@kernel.org> wrote:

> +++ Masami Hiramatsu [03/12/19 15:14 +0900]:
> >While running kprobe module test, find_module_all() caused
> >a suspicious RCU usage warning.
> >
> >-----
> > =============================
> > WARNING: suspicious RCU usage
> > 5.4.0-next-20191202+ #63 Not tainted
> > -----------------------------
> > kernel/module.c:619 RCU-list traversed in non-reader section!!
> >
> > other info that might help us debug this:
> >
> >
> > rcu_scheduler_active = 2, debug_locks = 1
> > 1 lock held by rmmod/642:
> >  #0: ffffffff8227da80 (module_mutex){+.+.}, at: __x64_sys_delete_module+0x9a/0x230
> >
> > stack backtrace:
> > CPU: 0 PID: 642 Comm: rmmod Not tainted 5.4.0-next-20191202+ #63
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  dump_stack+0x71/0xa0
> >  find_module_all+0xc1/0xd0
> >  __x64_sys_delete_module+0xac/0x230
> >  ? do_syscall_64+0x12/0x1f0
> >  do_syscall_64+0x50/0x1f0
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4b6d49
> >-----
> >
> >This is because list_for_each_entry_rcu(modules) is called
> >without rcu_read_lock(). This is safe because the module_mutex
> >is locked.
> >
> >Pass lockdep_is_held(&module_lock) to the list_for_each_entry_rcu()
> 
> s/module_lock/module_mutex/, but you don't have to respin the patch
> just for this.

Oops.

> 
> >to suppress this warning, This also fixes similar issue in
> >mod_find() and each_symbol_section().
> >
> >Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks Masami! This looks good. I'll queue this up shortly after the
> merge window.

Thank you for merging :)


> 
> Jessica
> 
> >---
> > kernel/module.c |    9 ++++++---
> > 1 file changed, 6 insertions(+), 3 deletions(-)
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index cb6250be6ee9..38e5c6a7451b 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -214,7 +214,8 @@ static struct module *mod_find(unsigned long addr)
> > {
> > 	struct module *mod;
> >
> >-	list_for_each_entry_rcu(mod, &modules, list) {
> >+	list_for_each_entry_rcu(mod, &modules, list,
> >+				lockdep_is_held(&module_mutex)) {
> > 		if (within_module(addr, mod))
> > 			return mod;
> > 	}
> >@@ -448,7 +449,8 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
> > 	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
> > 		return true;
> >
> >-	list_for_each_entry_rcu(mod, &modules, list) {
> >+	list_for_each_entry_rcu(mod, &modules, list,
> >+				lockdep_is_held(&module_mutex)) {
> > 		struct symsearch arr[] = {
> > 			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
> > 			  NOT_GPL_ONLY, false },
> >@@ -616,7 +618,8 @@ static struct module *find_module_all(const char *name, size_t len,
> >
> > 	module_assert_mutex_or_preempt();
> >
> >-	list_for_each_entry_rcu(mod, &modules, list) {
> >+	list_for_each_entry_rcu(mod, &modules, list,
> >+				lockdep_is_held(&module_mutex)) {
> > 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
> > 			continue;
> > 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
> >


-- 
Masami Hiramatsu <mhiramat@kernel.org>
