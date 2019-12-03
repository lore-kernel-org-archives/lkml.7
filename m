Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA26E2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575353653;
	bh=PVv+/qAr+M/CeBLnlFxIT4i2RhVSD5tYMtADCQJOYGs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P0oziUzD1FL7Teu7vRkFj39oDjI1HYbSML9/r9yG5yWQZyK0xyb+tKBfxtDIVsoWA
	 4Fd/Th6/WfmfsZ1avEDzhlT08htNqmjT1UeFKx0uiaJ47l5YOJOXKylWO8BDaKkqbt
	 Ra7lNZCAj/564gqaSm6mSdSeAZdl079AfR0YIYKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLCGOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfLCGOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:14:12 -0500
Received: from localhost.localdomain (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629782068E;
        Tue,  3 Dec 2019 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575353651;
        bh=PVv+/qAr+M/CeBLnlFxIT4i2RhVSD5tYMtADCQJOYGs=;
        h=From:To:Cc:Subject:Date:From;
        b=veuCyeFFvFRIMoPmBXPBGfSDr+Wi4iG/A8HGXiHf0bvunzUTrFF6JD6kp9lW4P9QU
         zbDzUsQyG60vxVHtOU9wQ6dJEbccCNuiPYMH3b6yr1pnmtKhzi9xRiIbX/XgJX3urB
         O9VIijfBxLDleN9etI2BxbEoq5QCFnKr9dFiYgT4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mhiramat@kernel.org
Subject: [PATCH] modules: lockdep: Suppress suspicious RCU usage warning
Date:   Tue,  3 Dec 2019 15:14:04 +0900
Message-Id: <157535364480.17342.7937104819926015512.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running kprobe module test, find_module_all() caused
a suspicious RCU usage warning.

-----
 =============================
 WARNING: suspicious RCU usage
 5.4.0-next-20191202+ #63 Not tainted
 -----------------------------
 kernel/module.c:619 RCU-list traversed in non-reader section!!

 other info that might help us debug this:


 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by rmmod/642:
  #0: ffffffff8227da80 (module_mutex){+.+.}, at: __x64_sys_delete_module+0x9a/0x230

 stack backtrace:
 CPU: 0 PID: 642 Comm: rmmod Not tainted 5.4.0-next-20191202+ #63
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x71/0xa0
  find_module_all+0xc1/0xd0
  __x64_sys_delete_module+0xac/0x230
  ? do_syscall_64+0x12/0x1f0
  do_syscall_64+0x50/0x1f0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x4b6d49
-----

This is because list_for_each_entry_rcu(modules) is called
without rcu_read_lock(). This is safe because the module_mutex
is locked.

Pass lockdep_is_held(&module_lock) to the list_for_each_entry_rcu()
to suppress this warning, This also fixes similar issue in
mod_find() and each_symbol_section().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/module.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index cb6250be6ee9..38e5c6a7451b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -214,7 +214,8 @@ static struct module *mod_find(unsigned long addr)
 {
 	struct module *mod;
 
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list,
+				lockdep_is_held(&module_mutex)) {
 		if (within_module(addr, mod))
 			return mod;
 	}
@@ -448,7 +449,8 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
 		return true;
 
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list,
+				lockdep_is_held(&module_mutex)) {
 		struct symsearch arr[] = {
 			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
 			  NOT_GPL_ONLY, false },
@@ -616,7 +618,8 @@ static struct module *find_module_all(const char *name, size_t len,
 
 	module_assert_mutex_or_preempt();
 
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list,
+				lockdep_is_held(&module_mutex)) {
 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
 			continue;
 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))

