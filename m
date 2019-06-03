Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E08CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6452505E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFCRxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFCRxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:53:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 443D62CE940;
        Mon,  3 Jun 2019 17:53:29 +0000 (UTC)
Received: from krava (ovpn-204-51.brq.redhat.com [10.40.204.51])
        by smtp.corp.redhat.com (Postfix) with SMTP id 227961B465;
        Mon,  3 Jun 2019 17:53:23 +0000 (UTC)
Date:   Mon, 3 Jun 2019 19:53:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH V2 1/1] perf: event preserve and create across cpu hotplug
Message-ID: <20190603175323.GD12203@krava>
References: <1559309956-32534-1-git-send-email-mojha@codeaurora.org>
 <1559309956-32534-2-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559309956-32534-2-git-send-email-mojha@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 03 Jun 2019 17:53:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 07:09:16PM +0530, Mukesh Ojha wrote:
> Perf framework doesn't allow preserving CPU events across
> CPU hotplugs. The events are scheduled out as and when the
> CPU walks offline. Moreover, the framework also doesn't
> allow the clients to create events on an offline CPU. As
> a result, the clients have to keep on monitoring the CPU
> state until it comes back online.
> 
> Therefore, introducing the perf framework to support creation
> and preserving of (CPU) events for offline CPUs. Through
> this, the CPU's online state would be transparent to the
> client and it not have to worry about monitoring the CPU's
> state. Success would be returned to the client even while
> creating the event on an offline CPU. If during the lifetime
> of the event the CPU walks offline, the event would be
> preserved and would continue to count as soon as (and if) the
> CPU comes back online.
> 
> Co-authored-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
> Change in V2:
> 
> As per long back discussion happened at
> https://lkml.org/lkml/2018/2/15/1324
> 
> Peter.Z. has suggested to do thing in different way and shared
> patch as well. This patch fixes the issue seen while trying
> to achieve the purpose.
> 
> Fixed issue on top of Peter's patch:
> ===================================
> 1. Added a NULL check on task to avoid crash in __perf_install_in_context.
> 
> 2. while trying to add event to context when cpu is offline.
>    Inside add_event_to_ctx() to make consistent state machine while hotplug.
> 
> -event->state += PERF_EVENT_STATE_HOTPLUG_OFFSET;
> +event->state = PERF_EVENT_STATE_HOTPLUG_OFFSET;
> 
> 3. In event_function_call(), added a label 'remove_event_from_ctx' to 
>    delete events from context list while cpu is offline.
> 
> 
>  include/linux/perf_event.h |   1 +
>  kernel/events/core.c       | 119 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 76 insertions(+), 44 deletions(-)
> 

hi,
I got crash on running "perf stat -a" and switching off
one cpu in another terminal via:
  "echo 0 > /sys/devices/system/cpu/cpu2/online"

jirka


---
ibm-x3650m4-01 login: [  554.951780] smpboot: CPU 2 is now offline
[  554.958301] BUG: kernel NULL pointer dereference, address: 0000000000000168
[  554.966070] #PF: supervisor read access in kernel mode
[  554.971802] #PF: error_code(0x0000) - not-present page
[  554.977532] PGD 0 P4D 0
[  554.980356] Oops: 0000 [#1] SMP PTI
[  554.984256] CPU: 9 PID: 4782 Comm: bash Tainted: G        W         5.2.0-rc1+ #3
[  554.992605] Hardware name: IBM System x3650 M4 : -[7915E2G]-/00Y7683, BIOS -[VVE124AUS-1.30]- 11/21/2012
[  555.003190] RIP: 0010:__perf_remove_from_context+0xcd/0x130
[  555.009407] Code: 8b 3d 97 51 5f 60 e8 b2 4d ee ff 48 8b 95 b8 00 00 00 48 01 c2 48 2b 95 c0 00 00 00 48 89 85 c0 00 00 00 48 89 95 b8 00 00 00 <49> 8b 9c 24 68 01 00 00 48 85 db 0f 84 43 ff ff ff 65 8b 3d 5b 51
[  555.030361] RSP: 0018:ffffaea78542fcb8 EFLAGS: 00010002
[  555.036190] RAX: 0000008136178cad RBX: ffffa0c0f78b0008 RCX: 000000000000001f
[  555.044151] RDX: 00000080bf70f331 RSI: 0000000040000219 RDI: fffc405d97b9b8a9
[  555.052112] RBP: ffffa0c0f78b0000 R08: 0000000000000002 R09: 0000000000029500
[  555.060074] R10: 00078047268106e0 R11: 0000000000000001 R12: 0000000000000000
[  555.068037] R13: ffffa0bf86a5c000 R14: 0000000000000001 R15: 0000000000000001
[  555.076000] FS:  00007f0ace1c9740(0000) GS:ffffa0c2f78c0000(0000) knlGS:0000000000000000
[  555.085029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  555.091438] CR2: 0000000000000168 CR3: 000000046c908001 CR4: 00000000000606e0
[  555.099401] Call Trace:
[  555.102133]  ? perf_event_read_event+0x110/0x110
[  555.107286]  ? list_del_event+0x140/0x140
[  555.111757]  event_function_call+0x113/0x130
[  555.116521]  ? list_del_event+0x140/0x140
[  555.120994]  ? perf_event_read_event+0x110/0x110
[  555.126144]  perf_remove_from_context+0x20/0x70
[  555.131200]  perf_event_release_kernel+0x79/0x330
[  555.136451]  hardlockup_detector_perf_cleanup+0x33/0x8d
[  555.142282]  lockup_detector_cleanup+0x16/0x30
[  555.147241]  _cpu_down+0xf3/0x1c0
[  555.150941]  do_cpu_down+0x2c/0x50
[  555.154737]  device_offline+0x81/0xb0
[  555.158822]  online_store+0x4a/0x90
[  555.162714]  kernfs_fop_write+0x116/0x190
[  555.167188]  vfs_write+0xa5/0x1a0
[  555.170885]  ksys_write+0x59/0xd0
[  555.174583]  do_syscall_64+0x55/0x1c0
[  555.178670]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  555.184306] RIP: 0033:0x7f0acd8b1c58
[  555.188301] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 c5 5a 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[  555.209261] RSP: 002b:00007ffe3883af68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  555.217709] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0acd8b1c58
[  555.225669] RDX: 0000000000000002 RSI: 000055ce3c955780 RDI: 0000000000000001
[  555.233632] RBP: 000055ce3c955780 R08: 000000000000000a R09: 00007f0acd9433c0
[  555.241594] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0acdb83780
[  555.249557] R13: 0000000000000002 R14: 00007f0acdb7e740 R15: 0000000000000002
[  555.257521] Modules linked in: xt_MASQUERADE nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 nft_counter nft_compat tun bridge stp llc nf_tables nfnetlink sunrpc intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass crct10dif_pclmul crc32_pclmul ipmi_si ghash_clmulni_intel cdc_ether usbnet intel_cstate mii intel_uncore ipmi_devintf iTCO_wdt iTCO_vendor_support ipmi_msghandler sg wmi intel_rapl_perf ioatdma i2c_i801 pcspkr lpc_ich xfs libcrc32c sr_mod cdrom sd_mod mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ahci libahci igb crc32c_intel dca drm libata i2c_algo_bit megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[  555.329511] CR2: 0000000000000168
[  555.333218] ---[ end trace f871a38c5e6d1393 ]---
[  555.338371] RIP: 0010:__perf_remove_from_context+0xcd/0x130
[  555.344588] Code: 8b 3d 97 51 5f 60 e8 b2 4d ee ff 48 8b 95 b8 00 00 00 48 01 c2 48 2b 95 c0 00 00 00 48 89 85 c0 00 00 00 48 89 95 b8 00 00 00 <49> 8b 9c 24 68 01 00 00 48 85 db 0f 84 43 ff ff ff 65 8b 3d 5b 51
[  555.365543] RSP: 0018:ffffaea78542fcb8 EFLAGS: 00010002
[  555.371372] RAX: 0000008136178cad RBX: ffffa0c0f78b0008 RCX: 000000000000001f
[  555.379334] RDX: 00000080bf70f331 RSI: 0000000040000219 RDI: fffc405d97b9b8a9
[  555.387294] RBP: ffffa0c0f78b0000 R08: 0000000000000002 R09: 0000000000029500
[  555.395264] R10: 00078047268106e0 R11: 0000000000000001 R12: 0000000000000000
[  555.403228] R13: ffffa0bf86a5c000 R14: 0000000000000001 R15: 0000000000000001
[  555.411189] FS:  00007f0ace1c9740(0000) GS:ffffa0c2f78c0000(0000) knlGS:0000000000000000
[  555.420219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  555.426630] CR2: 0000000000000168 CR3: 000000046c908001 CR4: 00000000000606e0
[  555.434593] Kernel panic - not syncing: Fatal exception
[  555.471650] Kernel Offset: 0x1e800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  555.483688] ---[ end Kernel panic - not syncing: Fatal exception ]---

