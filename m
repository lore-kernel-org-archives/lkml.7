Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A586DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEA02488E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gLYc3xqL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E4riiPCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFDOJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:09:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:09:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B56E8605A2; Tue,  4 Jun 2019 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559657380;
        bh=0nzW0ayzUwLJhAg5Sz4mhw33AuIQ86bNlWTRqyY3WUE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gLYc3xqLs6pzINK78cPphCwee6VKTfbWXRJoaku+44j53BcDh6OOfc1uOwy6kHtaQ
         qEW0GiAkK1AmeWKFttEHkCOMD8ByOEl+PGaPi2xVpOE3D+jnjVlsUG3LUdO7e2U5Ff
         iFRlrRLLQXdDwhLBmsc33GQkmWPP95VqKH2OuZm0=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4344D605A2;
        Tue,  4 Jun 2019 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559657377;
        bh=0nzW0ayzUwLJhAg5Sz4mhw33AuIQ86bNlWTRqyY3WUE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E4riiPCfUQjip80iHCf2ATZ2tXI5DHDK/NuDsBSWzDZ/iX45gkpHf2AWqdFgPEaFy
         954o8FnvafEkpPx77014pscYzh+Lcun5//6PCs0xXcAa2d4cXRWzNjyBgk8lZc7i2b
         IXPR8qtWy3ZRFzzhJ4fotD/NAMjqnzQzP3ymag5k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4344D605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH V2 1/1] perf: event preserve and create across cpu hotplug
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <1559309956-32534-1-git-send-email-mojha@codeaurora.org>
 <1559309956-32534-2-git-send-email-mojha@codeaurora.org>
 <20190603175323.GD12203@krava>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <68ea89f6-8abf-0a1c-7a72-d668c1108bf4@codeaurora.org>
Date:   Tue, 4 Jun 2019 19:39:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603175323.GD12203@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/2019 11:23 PM, Jiri Olsa wrote:
> On Fri, May 31, 2019 at 07:09:16PM +0530, Mukesh Ojha wrote:
>> Perf framework doesn't allow preserving CPU events across
>> CPU hotplugs. The events are scheduled out as and when the
>> CPU walks offline. Moreover, the framework also doesn't
>> allow the clients to create events on an offline CPU. As
>> a result, the clients have to keep on monitoring the CPU
>> state until it comes back online.
>>
>> Therefore, introducing the perf framework to support creation
>> and preserving of (CPU) events for offline CPUs. Through
>> this, the CPU's online state would be transparent to the
>> client and it not have to worry about monitoring the CPU's
>> state. Success would be returned to the client even while
>> creating the event on an offline CPU. If during the lifetime
>> of the event the CPU walks offline, the event would be
>> preserved and would continue to count as soon as (and if) the
>> CPU comes back online.
>>
>> Co-authored-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> ---
>> Change in V2:
>>
>> As per long back discussion happened at
>> https://lkml.org/lkml/2018/2/15/1324
>>
>> Peter.Z. has suggested to do thing in different way and shared
>> patch as well. This patch fixes the issue seen while trying
>> to achieve the purpose.
>>
>> Fixed issue on top of Peter's patch:
>> ===================================
>> 1. Added a NULL check on task to avoid crash in __perf_install_in_context.
>>
>> 2. while trying to add event to context when cpu is offline.
>>     Inside add_event_to_ctx() to make consistent state machine while hotplug.
>>
>> -event->state += PERF_EVENT_STATE_HOTPLUG_OFFSET;
>> +event->state = PERF_EVENT_STATE_HOTPLUG_OFFSET;
>>
>> 3. In event_function_call(), added a label 'remove_event_from_ctx' to
>>     delete events from context list while cpu is offline.
>>
>>
>>   include/linux/perf_event.h |   1 +
>>   kernel/events/core.c       | 119 ++++++++++++++++++++++++++++-----------------
>>   2 files changed, 76 insertions(+), 44 deletions(-)
>>
> hi,
> I got crash on running "perf stat -a" and switching off
> one cpu in another terminal via:
>    "echo 0 > /sys/devices/system/cpu/cpu2/online"

Thanks Jiri for the testing it.

>
> jirka
>
>
> ---
> ibm-x3650m4-01 login: [  554.951780] smpboot: CPU 2 is now offline
> [  554.958301] BUG: kernel NULL pointer dereference, address: 0000000000000168
> [  554.966070] #PF: supervisor read access in kernel mode
> [  554.971802] #PF: error_code(0x0000) - not-present page
> [  554.977532] PGD 0 P4D 0
> [  554.980356] Oops: 0000 [#1] SMP PTI
> [  554.984256] CPU: 9 PID: 4782 Comm: bash Tainted: G        W         5.2.0-rc1+ #3
> [  554.992605] Hardware name: IBM System x3650 M4 : -[7915E2G]-/00Y7683, BIOS -[VVE124AUS-1.30]- 11/21/2012
> [  555.003190] RIP: 0010:__perf_remove_from_context+0xcd/0x130
> [  555.009407] Code: 8b 3d 97 51 5f 60 e8 b2 4d ee ff 48 8b 95 b8 00 00 00 48 01 c2 48 2b 95 c0 00 00 00 48 89 85 c0 00 00 00 48 89 95 b8 00 00 00 <49> 8b 9c 24 68 01 00 00 48 85 db 0f 84 43 ff ff ff 65 8b 3d 5b 51
> [  555.030361] RSP: 0018:ffffaea78542fcb8 EFLAGS: 00010002
> [  555.036190] RAX: 0000008136178cad RBX: ffffa0c0f78b0008 RCX: 000000000000001f
> [  555.044151] RDX: 00000080bf70f331 RSI: 0000000040000219 RDI: fffc405d97b9b8a9
> [  555.052112] RBP: ffffa0c0f78b0000 R08: 0000000000000002 R09: 0000000000029500
> [  555.060074] R10: 00078047268106e0 R11: 0000000000000001 R12: 0000000000000000
> [  555.068037] R13: ffffa0bf86a5c000 R14: 0000000000000001 R15: 0000000000000001
> [  555.076000] FS:  00007f0ace1c9740(0000) GS:ffffa0c2f78c0000(0000) knlGS:0000000000000000
> [  555.085029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  555.091438] CR2: 0000000000000168 CR3: 000000046c908001 CR4: 00000000000606e0
> [  555.099401] Call Trace:
> [  555.102133]  ? perf_event_read_event+0x110/0x110
> [  555.107286]  ? list_del_event+0x140/0x140
> [  555.111757]  event_function_call+0x113/0x130
> [  555.116521]  ? list_del_event+0x140/0x140
> [  555.120994]  ? perf_event_read_event+0x110/0x110
> [  555.126144]  perf_remove_from_context+0x20/0x70
> [  555.131200]  perf_event_release_kernel+0x79/0x330
> [  555.136451]  hardlockup_detector_perf_cleanup+0x33/0x8d


Looks like the support for arm64 is missing for 
hardlockup_detector_perf_cleanup() 
(HAVE_HARDLOCKUP_DETECTOR_PERF/HAVE_PERF_EVENTS_NMI),
i.e why it has passed for me.

Wondering what could have caused this,


lockup_detector_offline_cpu
  watchdog_disable
    watchdog_nmi_disable
      perf_event_disable(event);

Above path might have disabled the event, perf_remove_from_context this 
might try to remove event from the context list.

My change only effects when event is destroyed while the offline cpu . 
will look more into it .

Thanks,
Mukesh

> [  555.142282]  lockup_detector_cleanup+0x16/0x30
> [  555.147241]  _cpu_down+0xf3/0x1c0
> [  555.150941]  do_cpu_down+0x2c/0x50
> [  555.154737]  device_offline+0x81/0xb0
> [  555.158822]  online_store+0x4a/0x90
> [  555.162714]  kernfs_fop_write+0x116/0x190
> [  555.167188]  vfs_write+0xa5/0x1a0
> [  555.170885]  ksys_write+0x59/0xd0
> [  555.174583]  do_syscall_64+0x55/0x1c0
> [  555.178670]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  555.184306] RIP: 0033:0x7f0acd8b1c58
> [  555.188301] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 c5 5a 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> [  555.209261] RSP: 002b:00007ffe3883af68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  555.217709] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0acd8b1c58
> [  555.225669] RDX: 0000000000000002 RSI: 000055ce3c955780 RDI: 0000000000000001
> [  555.233632] RBP: 000055ce3c955780 R08: 000000000000000a R09: 00007f0acd9433c0
> [  555.241594] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0acdb83780
> [  555.249557] R13: 0000000000000002 R14: 00007f0acdb7e740 R15: 0000000000000002
> [  555.257521] Modules linked in: xt_MASQUERADE nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 nft_counter nft_compat tun bridge stp llc nf_tables nfnetlink sunrpc intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass crct10dif_pclmul crc32_pclmul ipmi_si ghash_clmulni_intel cdc_ether usbnet intel_cstate mii intel_uncore ipmi_devintf iTCO_wdt iTCO_vendor_support ipmi_msghandler sg wmi intel_rapl_perf ioatdma i2c_i801 pcspkr lpc_ich xfs libcrc32c sr_mod cdrom sd_mod mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ahci libahci igb crc32c_intel dca drm libata i2c_algo_bit megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
> [  555.329511] CR2: 0000000000000168
> [  555.333218] ---[ end trace f871a38c5e6d1393 ]---
> [  555.338371] RIP: 0010:__perf_remove_from_context+0xcd/0x130
> [  555.344588] Code: 8b 3d 97 51 5f 60 e8 b2 4d ee ff 48 8b 95 b8 00 00 00 48 01 c2 48 2b 95 c0 00 00 00 48 89 85 c0 00 00 00 48 89 95 b8 00 00 00 <49> 8b 9c 24 68 01 00 00 48 85 db 0f 84 43 ff ff ff 65 8b 3d 5b 51
> [  555.365543] RSP: 0018:ffffaea78542fcb8 EFLAGS: 00010002
> [  555.371372] RAX: 0000008136178cad RBX: ffffa0c0f78b0008 RCX: 000000000000001f
> [  555.379334] RDX: 00000080bf70f331 RSI: 0000000040000219 RDI: fffc405d97b9b8a9
> [  555.387294] RBP: ffffa0c0f78b0000 R08: 0000000000000002 R09: 0000000000029500
> [  555.395264] R10: 00078047268106e0 R11: 0000000000000001 R12: 0000000000000000
> [  555.403228] R13: ffffa0bf86a5c000 R14: 0000000000000001 R15: 0000000000000001
> [  555.411189] FS:  00007f0ace1c9740(0000) GS:ffffa0c2f78c0000(0000) knlGS:0000000000000000
> [  555.420219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  555.426630] CR2: 0000000000000168 CR3: 000000046c908001 CR4: 00000000000606e0
> [  555.434593] Kernel panic - not syncing: Fatal exception
> [  555.471650] Kernel Offset: 0x1e800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  555.483688] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
