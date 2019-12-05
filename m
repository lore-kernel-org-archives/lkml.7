Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92808C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6515624651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575573493;
	bh=IjLuAsJiaFdsPLJzv4fOjqC+NhLYxYJ5tvEVRrlmemc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yTq6DEUAdzaaUzYvWUQHF+KYJk3v6zwSam7shbxziZux+3YWcJ43mtsM82HHSJN2f
	 eg5jPnEAIZKbw7xuLnyPmTRnyS5IVgFPpslQZdorhN9PAixvjNJkOEFkf95KPoGRI5
	 8u0D07PCBy/fNJ/X3MSiKueYBFHEP1W7R/ThYX04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfLETSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLETSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:18:12 -0500
Received: from linux-8ccs (ip-109-41-192-234.web.vodafone.de [109.41.192.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE5F2464D;
        Thu,  5 Dec 2019 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575573491;
        bh=IjLuAsJiaFdsPLJzv4fOjqC+NhLYxYJ5tvEVRrlmemc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mseQgxqXQDfkArNpXBPAAx7LPKXvi3zwrbbMwe1NVO+6OXgm329Qvsl2VvCaaN3Pz
         BbU8dWZOzR0hxGwzf8/pZ2XHIZLR0ouS7P1y/GSHAHdBE5ktvHyVuTrr77l6Grq02m
         XLGj5+I2M9ecsO/l3ce+emjg06ebpIvamEiWVbag=
Date:   Thu, 5 Dec 2019 20:17:59 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: lockdep: Suppress suspicious RCU usage warning
Message-ID: <20191205191758.GA30613@linux-8ccs>
References: <157535364480.17342.7937104819926015512.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <157535364480.17342.7937104819926015512.stgit@devnote2>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masami Hiramatsu [03/12/19 15:14 +0900]:
>While running kprobe module test, find_module_all() caused
>a suspicious RCU usage warning.
>
>-----
> =============================
> WARNING: suspicious RCU usage
> 5.4.0-next-20191202+ #63 Not tainted
> -----------------------------
> kernel/module.c:619 RCU-list traversed in non-reader section!!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by rmmod/642:
>  #0: ffffffff8227da80 (module_mutex){+.+.}, at: __x64_sys_delete_module+0x9a/0x230
>
> stack backtrace:
> CPU: 0 PID: 642 Comm: rmmod Not tainted 5.4.0-next-20191202+ #63
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x71/0xa0
>  find_module_all+0xc1/0xd0
>  __x64_sys_delete_module+0xac/0x230
>  ? do_syscall_64+0x12/0x1f0
>  do_syscall_64+0x50/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4b6d49
>-----
>
>This is because list_for_each_entry_rcu(modules) is called
>without rcu_read_lock(). This is safe because the module_mutex
>is locked.
>
>Pass lockdep_is_held(&module_lock) to the list_for_each_entry_rcu()

s/module_lock/module_mutex/, but you don't have to respin the patch
just for this.

>to suppress this warning, This also fixes similar issue in
>mod_find() and each_symbol_section().
>
>Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami! This looks good. I'll queue this up shortly after the
merge window.

Jessica

>---
> kernel/module.c |    9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index cb6250be6ee9..38e5c6a7451b 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -214,7 +214,8 @@ static struct module *mod_find(unsigned long addr)
> {
> 	struct module *mod;
>
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list,
>+				lockdep_is_held(&module_mutex)) {
> 		if (within_module(addr, mod))
> 			return mod;
> 	}
>@@ -448,7 +449,8 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
> 	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
> 		return true;
>
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list,
>+				lockdep_is_held(&module_mutex)) {
> 		struct symsearch arr[] = {
> 			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
> 			  NOT_GPL_ONLY, false },
>@@ -616,7 +618,8 @@ static struct module *find_module_all(const char *name, size_t len,
>
> 	module_assert_mutex_or_preempt();
>
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list,
>+				lockdep_is_held(&module_mutex)) {
> 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
> 			continue;
> 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
>
