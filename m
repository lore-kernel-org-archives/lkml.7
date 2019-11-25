Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305A52071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWiYstIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKYJWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:22:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbfKYJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574673734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9x30wzyNhuowB7YV3qmw7n+bPJNB/t14GhunrwtUrhw=;
        b=EWiYstIHMqqBfKXnymmoOL5Nt9GOCR7cnqkJtU3g2755sq676DWsClxnwyadfld0Irp5Tx
        CwaEZlrOGXQ+x3AoB8Z7fS473cGHDLITxUT2ekuwPNGU3Zpb6VpfpCnRFj/mD6W5eoT8fS
        c3Yu38qqrOPX5o5Nr6OWK9c7SGjI2J0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-F6yw9wDgMfSWiksl6v5uuQ-1; Mon, 25 Nov 2019 04:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9368A800580;
        Mon, 25 Nov 2019 09:22:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8FB7A5D9CA;
        Mon, 25 Nov 2019 09:22:03 +0000 (UTC)
Date:   Mon, 25 Nov 2019 10:22:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7] perf: Sharing PMU counters across compatible events
Message-ID: <20191125092202.GB20575@krava>
References: <20191115235504.4034879-1-songliubraving@fb.com>
 <20191122193343.GB2157@krava>
 <951F0EE1-5DCC-46CA-8891-39A891512CEE@fb.com>
MIME-Version: 1.0
In-Reply-To: <951F0EE1-5DCC-46CA-8891-39A891512CEE@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: F6yw9wDgMfSWiksl6v5uuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 07:50:06PM +0000, Song Liu wrote:
>=20
>=20
> > On Nov 22, 2019, at 11:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >=20
> > On Fri, Nov 15, 2019 at 03:55:04PM -0800, Song Liu wrote:
> >> This patch tries to enable PMU sharing. When multiple perf_events are
> >> counting the same metric, they can share the hardware PMU counter. We
> >> call these events as "compatible events".
> >>=20
> >> The PMU sharing are limited to events within the same perf_event_conte=
xt
> >> (ctx). When a event is installed or enabled, search the ctx for compat=
ible
> >> events. This is implemented in perf_event_setup_dup(). One of these
> >> compatible events are picked as the master (stored in event->dup_maste=
r).
> >> Similarly, when the event is removed or disabled, perf_event_remove_du=
p()
> >> is used to clean up sharing.
> >>=20
> >> A new state PERF_EVENT_STATE_ENABLED is introduced for the master even=
t.
> >> This state is used when the slave event is ACTIVE, but the master even=
t
> >> is not.
> >>=20
> >> On the critical paths (add, del read), sharing PMU counters doesn't
> >> increase the complexity. Helper functions event_pmu_[add|del|read]() a=
re
> >> introduced to cover these cases. All these functions have O(1) time
> >> complexity.
> >>=20
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> Cc: Jiri Olsa <jolsa@kernel.org>
> >> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Tejun Heo <tj@kernel.org>
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >>=20
> >> ---
> >> Changes in v7:
> >> Major rewrite to avoid allocating extra master event.
> >=20
> > hi,
> > what is this based on? I can't apply it on tip/master:
> >=20
> > =09Applying: perf: Sharing PMU counters across compatible events
> > =09error: patch failed: include/linux/perf_event.h:722
> > =09error: include/linux/perf_event.h: patch does not apply
> > =09Patch failed at 0001 perf: Sharing PMU counters across compatible ev=
ents
> > =09hint: Use 'git am --show-current-patch' to see the failed patch
> > =09When you have resolved this problem, run "git am --continue".
> > =09If you prefer to skip this patch, run "git am --skip" instead.
> > =09To restore the original branch and stop patching, run "git am --abor=
t".
>=20

hi,
I'm getting warning below when running 'perf test',
not sure what's the reason yet..

jirka


---


[  230.228358] WARNING: CPU: 29 PID: 2133 at kernel/events/core.c:3069 __pe=
rf_event_enable+0x1d3/0x220^M
[  230.237395] Modules linked in: intel_rapl_msr intel_rapl_common skx_edac=
 nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssi=
f irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate =
intel_uncore ipmi_si dell_smbios intel_rapl_perf iTCO_wdt wmi_bmof dell_wmi=
_descriptor ipmi_devintf mei_me iTCO_vendor_support dcdbas mei i2c_i801 lpc=
_ich wmi ipmi_msghandler acpi_power_meter xfs libcrc32c mgag200 drm_kms_hel=
per i2c_algo_bit drm_vram_helper ttm drm megaraid_sas tg3 crc32c_intel^M
[  230.282700] CPU: 29 PID: 2133 Comm: perf Not tainted 5.4.0-rc7+ #37^M
[  230.288964] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 1=
2/14/2018^M
[  230.296444] RIP: 0010:__perf_event_enable+0x1d3/0x220^M
[  230.301496] Code: 0f b6 d2 83 c2 01 48 83 b8 b0 00 00 00 00 74 15 5b 44 =
09 f2 5d 4c 89 ef 41 5c 41 5d 41 5e 41 5f e9 72 fd ff ff 83 ca 08 eb e6 <0f=
> 0b eb ba 48 8b 45 10 4c 8d 78 f0 4c 39 fd 74 83 49 8b 87 98 00^M
[  230.320242] RSP: 0018:ffff9b2d87a93bd0 EFLAGS: 00010086^M
[  230.325468] RAX: ffff88ad77312010 RBX: ffff88ad77312000 RCX: 00000000000=
00000^M
[  230.332600] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88ad773=
12000^M
[  230.339731] RBP: ffff88ad77312000 R08: ffff88ad77312000 R09: ffff88ad773=
12000^M
[  230.346863] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88ad84b=
07100^M
[  230.353997] R13: ffff88ad8f9af700 R14: 0000000000000003 R15: ffff88ad773=
12000^M
[  230.361130] FS:  00007fca82c1f100(0000) GS:ffff88ad8f980000(0000) knlGS:=
0000000000000000^M
[  230.369217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[  230.374961] CR2: 00007fca82c1cff0 CR3: 00000017f65a2003 CR4: 00000000007=
606e0^M
[  230.382095] DR0: 0000000000b65268 DR1: 0000000000000000 DR2: 00000000000=
00000^M
[  230.389227] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00600^M
[  230.396358] PKRU: 55555554^M
[  230.399071] Call Trace:^M
[  230.401538]  event_function+0x85/0xc0^M
[  230.405211]  ? ctx_resched+0xc0/0xc0^M
[  230.408789]  remote_function+0x3e/0x50^M
[  230.412547]  generic_exec_single+0x91/0xd0^M
[  230.416652]  ? ctx_resched+0xc0/0xc0^M
[  230.420230]  smp_call_function_single+0xd1/0x110^M
[  230.424852]  task_function_call+0x45/0x70^M
[  230.428872]  ? event_sync_dup_count+0x90/0x90^M
[  230.433239]  event_function_call+0x8f/0x110^M
[  230.437425]  ? ctx_resched+0xc0/0xc0^M
[  230.441003]  ? ring_buffer_attach+0x186/0x1b0^M
[  230.445362]  ? _perf_event_disable+0x50/0x50^M
[  230.449636]  perf_event_for_each_child+0x34/0x80^M
[  230.454256]  ? _perf_event_disable+0x50/0x50^M
[  230.458530]  _perf_ioctl+0x24b/0x700^M
[  230.462118]  ? mem_cgroup_commit_charge+0xcb/0x1a0^M
[  230.466918]  ? __handle_mm_fault+0xd49/0x1ac0^M
[  230.471279]  ? _cond_resched+0x15/0x30^M
[  230.475037]  perf_ioctl+0x3d/0x60^M
[  230.478361]  do_vfs_ioctl+0x405/0x660^M
[  230.482032]  ksys_ioctl+0x5e/0x90^M
[  230.485351]  ? __x64_sys_fcntl+0x84/0xb0^M
[  230.489276]  __x64_sys_ioctl+0x16/0x20^M
[  230.493033]  do_syscall_64+0x5b/0x180^M
[  230.496708]  entry_SYSCALL_64_after_hwframe+0x44/0xa9^M

