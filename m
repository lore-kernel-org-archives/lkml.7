Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20535C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF301207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfISKcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:32:22 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:51422
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfISKcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:32:22 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 06:32:20 EDT
Received: from mail0.xen.dingwall.me.uk ([82.47.84.47])
        by cmsmtp with ESMTPA
        id Ate8iVpWQwGUPAte8i0GXZ; Thu, 19 Sep 2019 11:26:45 +0100
X-Originating-IP: [82.47.84.47]
X-Authenticated-User: james.dingwall@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=0bfgdX8EJi0Cr9X0x0jFDA==:117
 a=0bfgdX8EJi0Cr9X0x0jFDA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
 a=J70Eh1EUuV4A:10 a=_iWfOJ2ZPrAvU1I8eIcA:9 a=CjuIK1q_8ugA:10
Received: from localhost (localhost [IPv6:::1])
        by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 7866F10B82E;
        Thu, 19 Sep 2019 10:26:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
        by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kv4HqIXKkmdq; Thu, 19 Sep 2019 10:26:44 +0000 (UTC)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2001:470:695c:302::c0a8:105])
        by dingwall.me.uk (Postfix) with ESMTP id 3091910B82B;
        Thu, 19 Sep 2019 10:26:44 +0000 (UTC)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
        id 0EF9BFAF4E; Thu, 19 Sep 2019 10:26:44 +0000 (UTC)
Date:   Thu, 19 Sep 2019 10:26:43 +0000
From:   James Dingwall <james@dingwall.me.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: pstore does not work under xen
Message-ID: <20190919102643.GA9400@dingwall.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfJomvg9iPgx+gWwFPIbRIwHyoZadbL6yxHIZa5+54aW+Ml3wKVvUHxNatOMdbjhdqolAKEEg9dqV33D5RxMWDDOP9YwmP7tMq0Xq8T/fAxYJgQPy2JWr
 RFHN805Zb5CNoLvMtiLaWegXF/PU05caqj17XL91U5FMp23QYsp1p0l6hxgHofx0z7dHiluyRPc3m7gcS2OBL1VczXN32fjCAvRUPBRuj+/FpWhuvIQJHUZN
 uxQAfPGb4eauDkC1C/HA/H/rm65ptNK4P9ilhukBcfoU4Yp6fzqhWGAJyhQ8Zbv5zR8BSsq3Sz3TJgIS7VLHHFNG+ONfJwnD+9qAaPrOtsT01Fw/bE/PBQCJ
 xjwy0AkoyvcO3Rud7jcA1Q8U+Y8g4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been investigating a regression in our environment where pstore 
(efi-pstore specifically but I suspect this would affect all 
implementations) no longer works after upgrading from a 4.4 to 5.0 
kernel when running under xen.  (This is an Ubuntu kernel but I don't 
think there are patches which affect this area.)

In kernel/panic.c the flow of panic() is roughly:

dump_stack();

atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

kmsg_dump(KMSG_DUMP_PANIC);


pstore registers a kdump callback which would normally be invoked by the 
call to kmsg_dump() however in Xen there is a panic_notifier registered 
which never returns preventing the pstore record being generated.  The 
implementation of xen_panic_event() has changed since v4.4 but I don't 
understand how this may have changed the behaviour.

Adding a couple of printks in arch/x86/xen/enlighten.c:

@@ -277,8 +278,10 @@ void xen_emergency_restart(void)
 static int
 xen_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
+       printk(KERN_WARNING "enter xen_panic_event()\n");
        if (!kexec_crash_loaded())
                xen_reboot(SHUTDOWN_crash);
+       printk(KERN_WARNING "exit xen_panic_event()\n");
        return NOTIFY_DONE;
 }

Only the first is printed when triggering a crash (echo c > 
/proc/sysrq-trigger)

[ 1185.458761] sysrq: SysRq : Trigger a crash
[ 1185.476937] Kernel panic - not syncing: sysrq triggered crash
[ 1185.495747] CPU: 1 PID: 19241 Comm: bash Tainted: P           OE     5.0.0-27-generic #4
[ 1185.513387] Hardware name: HP ProLiant EC200a/ProLiant EC200a, BIOS U26 05/21/2018
[ 1185.530705] Call Trace:
[ 1185.548683]  dump_stack+0x63/0x85
[ 1185.566553]  panic+0xfe/0x2b4
[ 1185.583634]  sysrq_handle_crash+0x15/0x20
[ 1185.600594]  __handle_sysrq+0x9f/0x170
[ 1185.617613]  write_sysrq_trigger+0x34/0x40
[ 1185.634271]  proc_reg_write+0x3e/0x60
[ 1185.651407]  __vfs_write+0x1b/0x40
[ 1185.668140]  vfs_write+0xb1/0x1a0
[ 1185.685087]  ksys_write+0x5c/0xe0
[ 1185.701190]  __x64_sys_write+0x1a/0x20
[ 1185.717719]  do_syscall_64+0x5a/0x120
[ 1185.733839]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1185.749739] RIP: 0033:0x7fe42e4f5154
[ 1185.764726] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 b1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
[ 1185.797937] RSP: 002b:00007fff092d0358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1185.814701] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe42e4f5154
[ 1185.831241] RDX: 0000000000000002 RSI: 000055c1c224bf10 RDI: 0000000000000001
[ 1185.848405] RBP: 000055c1c224bf10 R08: 000000000000000a R09: 0000000000000001
[ 1185.869816] R10: 000000000000000a R11: 0000000000000246 R12: 00007fe42e7d1760
[ 1185.888686] R13: 0000000000000002 R14: 00007fe42e7cd2a0 R15: 00007fe42e7cc760
[ 1185.905369] Kernel Offset: disabled
[ 1185.920295] enter xen_panic_event()
(XEN) Hardware Dom0 crashed: rebooting machine in 5 seconds.
(d1) Checking store ...xenstored: Checking store complete.xenstored: Checking store ...xenstored: Checking store complete.xenstored: Checking store ...xenstored: Checking store complete.xenstored: Checking store ...

Sorry for the long Cc list, I'm not sure who's court this falls in.

Thanks,
James
