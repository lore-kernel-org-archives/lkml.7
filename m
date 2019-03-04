Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5721520663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCDUyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:54:09 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:54:08 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZCSt-1gVvSC0xV3-00V9kK; Mon, 04 Mar 2019 21:53:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Beulich <JBeulich@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <jbeulich@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] [v3] xen: remove pre-xen3 fallback handlers
Date:   Mon,  4 Mar 2019 21:52:39 +0100
Message-Id: <20190304205300.2582076-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QcaSXjLOGR8UcGaIFZsBU5NxjYWgj7CWpwkReQnMNxEjXwyvvqg
 12vMoqsMa/xyg2IOoMC1VMD2YkxqxP2XEF4OaJVJgBd5K2/ASEesnS7CAvHag7Md7kF3RZc
 Nd8DYLsEmHY+62jmnqUfhLKDcsEOaslMhHNwWzDmWYlW+A6/zyLQkGPaN759zVu4qw8CcQO
 lBNBLNHHbHVxVSrDEXFtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w1Cd9zXSfT8=:v0zgZOs/IsnhQwY4CFsOWy
 aJPl9OOuVe8EuTH0sUWD2r/xURAv5Dh7djGQ+7deC3a1ZRpZY5Msy00SNrVwQ7y0XEbsX4RfH
 Tle707rI3DyzgF0FVakX+AyjAPZ7f8Sk3mUHY3w+y/mEWTlVU29BqwvrcRnJCvSqG09FeA+ji
 Z7T2B0k448VeUGjWdnj33BOcU7oJRHQTNSqvA9V07oYrNzSWHDMf2wcZlY2MQ9xhjjFW6Ro6c
 iu67ro8K9zxJ+eoEooZRnYRs1x103d2AyLV4sfA4+CFatWLeqH0ovIZgksp6zgs/zt/wu+Yjz
 EwU1+CMApVwnt+IC8BjPKdh1eBVd/ypoQ15n/5fBvMZlk/frC+k496WlRw9UGXKxUwgHodVae
 YNON/4NfqZlgVAokL0eA4jt7Kr0ixpRxGtCXwkCBJYEQU7RN+vfKCYowxEI2XwhE2B9WWlUj0
 dJcckcxUGAtscQqdj3xdMKwBWuUK3LfUh27+cR3P+hhVzpXVYAGTQA9rD/srn8f4txsfSoBPt
 ydo+MRAtoV9llhbWymibvtSKAWtj6vWmey4aTZGHSfiKeqW4UrwN+aZAgznvAKcSAljOjni5w
 6pZM9Qv12hR6LJd8VVkCZAngWZI5RoyzffqBf1+xRDeYRh9C/Ja4ar/KvxL8t2c64p1sU1c5z
 Xyqbpw5ESJQ7hcpb9wPSwYnhQXZqI42CjuRfxoMJQtvryGYyKZpnRUQIED7xpxHC4H9Wmerk9
 nDyWLWR5dnwYmInMz+JZMkjnXFIgmAXhiaNEAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy hypercall handlers were originally added with
a comment explaining that "copying the argument structures in
HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
variable is sufficiently safe" and only made sure to not write
past the end of the argument structure, the checks in linux/string.h
disagree with that, when link-time optimizations are used:

In function 'memcpy',
    inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
    inlined from '__startup_pirq' at drivers/xen/events/events_base.c:529:2,
    inlined from 'restore_pirqs' at drivers/xen/events/events_base.c:1439:3,
    inlined from 'xen_irq_resume' at drivers/xen/events/events_base.c:1581:2:
include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
   __read_overflow2();
   ^

Further research turned out that only Xen 3.0.2 or earlier required the
fallback at all, while all versions in use today don't need it.
As far as I can tell, it is not even possible to run a mainline kernel
on those old Xen releases, at the time when they were in use, only
a patched kernel was supported anyway.

Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v2] use a table lookup instead of a switch/case statement, after
multiple suggestions.
[v3] remove that file completely
[resend] I just stumbled over this again, the last submission was a year
         ago, and it seems it never got merged
---
 arch/x86/include/asm/xen/hypercall.h | 13 +----
 drivers/xen/Makefile                 |  1 -
 drivers/xen/fallback.c               | 81 ----------------------------
 3 files changed, 2 insertions(+), 93 deletions(-)
 delete mode 100644 drivers/xen/fallback.c

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index ef05bea7010d..de6f0d59a24f 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -332,15 +332,11 @@ HYPERVISOR_update_va_mapping(unsigned long va, pte_t new_val,
 		return _hypercall4(int, update_va_mapping, va,
 				   new_val.pte, new_val.pte >> 32, flags);
 }
-extern int __must_check xen_event_channel_op_compat(int, void *);
 
 static inline int
 HYPERVISOR_event_channel_op(int cmd, void *arg)
 {
-	int rc = _hypercall2(int, event_channel_op, cmd, arg);
-	if (unlikely(rc == -ENOSYS))
-		rc = xen_event_channel_op_compat(cmd, arg);
-	return rc;
+	return _hypercall2(int, event_channel_op, cmd, arg);
 }
 
 static inline int
@@ -355,15 +351,10 @@ HYPERVISOR_console_io(int cmd, int count, char *str)
 	return _hypercall3(int, console_io, cmd, count, str);
 }
 
-extern int __must_check xen_physdev_op_compat(int, void *);
-
 static inline int
 HYPERVISOR_physdev_op(int cmd, void *arg)
 {
-	int rc = _hypercall2(int, physdev_op, cmd, arg);
-	if (unlikely(rc == -ENOSYS))
-		rc = xen_physdev_op_compat(cmd, arg);
-	return rc;
+	return _hypercall2(int, physdev_op, cmd, arg);
 }
 
 static inline int
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 5df6d21142f2..7124f9e749b4 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
-obj-$(CONFIG_X86)			+= fallback.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
 obj-y	+= mem-reservation.o
 obj-y	+= events/
diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
deleted file mode 100644
index b04fb64c5a91..000000000000
--- a/drivers/xen/fallback.c
+++ /dev/null
@@ -1,81 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/bug.h>
-#include <linux/export.h>
-#include <asm/hypervisor.h>
-#include <asm/xen/hypercall.h>
-
-int xen_event_channel_op_compat(int cmd, void *arg)
-{
-	struct evtchn_op op;
-	int rc;
-
-	op.cmd = cmd;
-	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, event_channel_op_compat, &op);
-
-	switch (cmd) {
-	case EVTCHNOP_close:
-	case EVTCHNOP_send:
-	case EVTCHNOP_bind_vcpu:
-	case EVTCHNOP_unmask:
-		/* no output */
-		break;
-
-#define COPY_BACK(eop) \
-	case EVTCHNOP_##eop: \
-		memcpy(arg, &op.u.eop, sizeof(op.u.eop)); \
-		break
-
-	COPY_BACK(bind_interdomain);
-	COPY_BACK(bind_virq);
-	COPY_BACK(bind_pirq);
-	COPY_BACK(status);
-	COPY_BACK(alloc_unbound);
-	COPY_BACK(bind_ipi);
-#undef COPY_BACK
-
-	default:
-		WARN_ON(rc != -ENOSYS);
-		break;
-	}
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(xen_event_channel_op_compat);
-
-int xen_physdev_op_compat(int cmd, void *arg)
-{
-	struct physdev_op op;
-	int rc;
-
-	op.cmd = cmd;
-	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, physdev_op_compat, &op);
-
-	switch (cmd) {
-	case PHYSDEVOP_IRQ_UNMASK_NOTIFY:
-	case PHYSDEVOP_set_iopl:
-	case PHYSDEVOP_set_iobitmap:
-	case PHYSDEVOP_apic_write:
-		/* no output */
-		break;
-
-#define COPY_BACK(pop, fld) \
-	case PHYSDEVOP_##pop: \
-		memcpy(arg, &op.u.fld, sizeof(op.u.fld)); \
-		break
-
-	COPY_BACK(irq_status_query, irq_status_query);
-	COPY_BACK(apic_read, apic_op);
-	COPY_BACK(ASSIGN_VECTOR, irq_op);
-#undef COPY_BACK
-
-	default:
-		WARN_ON(rc != -ENOSYS);
-		break;
-	}
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(xen_physdev_op_compat);
-- 
2.20.0

