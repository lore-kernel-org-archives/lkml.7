Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D447C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593702080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTDujX+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfLCUlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:41:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbfLCUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575405680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GFJmVPRnRJZZHh/nJkFtQILkfSrbn6sTsBqRNNHGUY0=;
        b=cTDujX+kvJ0akPcO4wkSdsWXSkVRsWYUSz44ZjGsXkekwpjme328ZsV5NiejYH6GrYRhKZ
        y7IGK29YfKE5sm7fncw/El+GEEzArOSStGoIJX2LygDwp3rys6lNg9jBhhQXkfInC8ubLj
        NHWXHZtnMPufaZmKuXbvPThm/4WdfeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-rhIgtziNMdSH-EUKhPqxxQ-1; Tue, 03 Dec 2019 15:41:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2248C8017CC;
        Tue,  3 Dec 2019 20:41:17 +0000 (UTC)
Received: from llong.com (ovpn-124-16.rdu2.redhat.com [10.10.124.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B860E1001938;
        Tue,  3 Dec 2019 20:41:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/tsc: Fix incorrect enabling of __use_tsc static_key
Date:   Tue,  3 Dec 2019 15:40:53 -0500
Message-Id: <20191203204053.12956-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rhIgtziNMdSH-EUKhPqxxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying the commit 4763f03d3d18 ("x86/tsc: Use TSC as sched clock
early") and the commit 608008a45798 ("x86/tsc: Consolidate init code"),
some x86 systems boot up with the following warnings:

[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2599.853 MHz processor
[    0.000000] ------------[ cut here ]------------
[    0.000000] static_key_enable_cpuslocked(): static key
'__use_tsc+0x0/0x10' used before call to jump_label_init()
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:132 static_key=
_enable_cpuslocked+0x7b/0x80
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-154.el8.x86_6=
4 #1
[    0.000000] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 0=
1/17/2017
[    0.000000] RIP: 0010:static_key_enable_cpuslocked+0x7b/0x80
  :
[    0.000000] Call Trace:
[    0.000000]  ? static_key_enable+0x16/0x20
[    0.000000]  ? setup_arch+0x43f/0xf68
[    0.000000]  ? printk+0x58/0x6f
[    0.000000]  ? start_kernel+0x63/0x55b
[    0.000000]  ? load_ucode_bsp+0xfb/0x12e
[    0.000000]  ? secondary_startup_64+0xb7/0xc0
[    0.000000] ---[ end trace fc2166797a50a8e0 ]---
  :
[ 1781.404905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long =
to run: 1.000 msecs
[ 1781.409905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long =
to run: 1.000 msecs
[ 1781.412905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long =
to run: 1.000 msecs
[ 1781.578905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long =
to run: 1.000 msecs
[ 1781.973905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long =
to run: 1.000 msecs
  :

In this particular case,

  setup_arch() =3D> tsc_early_init()
               =3D> tsc_enable_sched_clock()
               =3D> static_branch_enable()

However, jump_label_init() is called after setup_arch(). Before the
2 commits listed above, static_branch_enable() was only called in
tsc_init() which is after jump_label_init().

Since sched_clock() is used by the NMI handler to compute the elapsed
time and a 1000 HZ jiffies has a granularity of 1ms, the NMI warning
will be printed whenever the jiffies changes while in the middle of the
NMI handler. On systems that generate GHES NMI frequently, the constant
spewing of warning messages will significantly impact the performance
and usability of those systems.

To fix this problem, the static_branch_enable() is now taken out of
tsc_enable_sched_clock() and put back into tsc_init() like before. That
effective reverts commit 4763f03d3d18 ("x86/tsc: Use TSC as sched
clock early").

Fixes: 4763f03d3d18 ("x86/tsc: Use TSC as sched clock early")
Fixes: 608008a45798 ("x86/tsc: Consolidate init code")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/tsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..1e3a72040399 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1444,12 +1444,11 @@ static unsigned long __init get_loops_per_jiffy(voi=
d)
 =09return lpj;
 }
=20
-static void __init tsc_enable_sched_clock(void)
+static void __init tsc_init_sched_clock(void)
 {
 =09/* Sanitize TSC ADJUST before cyc2ns gets initialized */
 =09tsc_store_and_check_tsc_adjust(true);
 =09cyc2ns_init_boot_cpu();
-=09static_branch_enable(&__use_tsc);
 }
=20
 void __init tsc_early_init(void)
@@ -1463,7 +1462,7 @@ void __init tsc_early_init(void)
 =09=09return;
 =09loops_per_jiffy =3D get_loops_per_jiffy();
=20
-=09tsc_enable_sched_clock();
+=09tsc_init_sched_clock();
 }
=20
 void __init tsc_init(void)
@@ -1487,10 +1486,11 @@ void __init tsc_init(void)
 =09=09=09setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 =09=09=09return;
 =09=09}
-=09=09tsc_enable_sched_clock();
+=09=09tsc_init_sched_clock();
 =09}
=20
 =09cyc2ns_init_secondary_cpus();
+=09static_branch_enable(&__use_tsc);
=20
 =09if (!no_sched_irq_time)
 =09=09enable_sched_clock_irqtime();
--=20
2.18.1

