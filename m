Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2520857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtSh0zcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCHTsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:48:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42266 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCHTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:48:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28JdJBN076641;
        Fri, 8 Mar 2019 19:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cQUONX3OPBPaYWfYeJkZnPCtOtS+gR8kKKOqimP5rrg=;
 b=WtSh0zcgZxZ0J/RvFX0ZLU3WPjTFS5L5nrCqeEbnIsUfwJCsBymLmOIgAp5K+AqHAXHq
 Y3mbm4nmBFq9HjaLurcdTNW77vZaiinWq+xpq84UMgbrX+GHAmEL40zse5GsT7SwhIGH
 MRwb5ncqy95K/P3pzUrK+LYBz4I2ZuZM8n5hXMgm+YguRaAdA4AEGV77brSIpYyWlRWE
 aS+Gl6zfOCKeKf0FKVbJslaNoIk1wKrZJIDoLpdp5jtG0rXYw1eOCysIR07WaMsyeQS6
 Ncq/ity3yHzu4T7xyJV15ENHbBfskGK0sdTR76io4SPBv7+/YpsR/JmmSmSQ8POeQyWl ZA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qyjfs22hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 19:46:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x28JkWwK013588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 19:46:32 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x28JkV2X008549;
        Fri, 8 Mar 2019 19:46:31 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 11:46:31 -0800
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
Date:   Fri, 8 Mar 2019 11:44:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222124544.GY9565@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/19 4:45 AM, Mel Gorman wrote:
> On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
>> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>> However; whichever way around you turn this cookie; it is expensive and nasty.
>> Do you (or anybody else) have numbers for real loads?
>>
>> Because performance is all that matters. If performance is bad, then
>> it's pointless, since just turning off SMT is the answer.
>>
> I tried to do a comparison between tip/master, ht disabled and this series
> putting test workloads into a tagged cgroup but unfortunately it failed
>
> [  156.978682] BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
> [  156.986597] #PF error: [normal kernel read fault]
> [  156.991343] PGD 0 P4D 0
> [  156.993905] Oops: 0000 [#1] SMP PTI
> [  156.997438] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 5.0.0-rc7-schedcore-v1r1 #1
> [  157.005161] Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
> [  157.012896] RIP: 0010:wakeup_preempt_entity.isra.70+0x9/0x50
> [  157.018613] Code: 00 be c0 82 60 00 e9 86 02 1a 00 66 0f 1f 44 00 00 48 c1 e7 03 be c0 80 60 00 e9 72 02 1a 00 66 90 0f 1f 44 00 00
>   53 48 89 fb <48> 2b 5e 58 48 85 db 7e 2c 48 81 3e 00 00 10 00 8b 05 a9 b7 19 01
> [  157.037544] RSP: 0018:ffffc9000c5bbde8 EFLAGS: 00010086
> [  157.042819] RAX: ffff88810f5f6a00 RBX: 00000001547f175c RCX: 0000000000000001
> [  157.050015] RDX: ffff88bf3bdb0a40 RSI: 0000000000000000 RDI: 00000001547f175c
> [  157.057215] RBP: ffff88bf7fae32c0 R08: 000000000001e358 R09: ffff88810fb9f000
> [  157.064410] R10: ffffc9000c5bbe08 R11: ffff88810fb9f5c4 R12: 0000000000000000
> [  157.071611] R13: ffff88bf4e3ea0c0 R14: 0000000000000000 R15: ffff88bf4e3ea7a8
> [  157.078814] FS:  0000000000000000(0000) GS:ffff88bf7f5c0000(0000) knlGS:0000000000000000
> [  157.086977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  157.092779] CR2: 0000000000000058 CR3: 000000000220e005 CR4: 00000000003606e0
> [  157.099979] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  157.109529] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  157.119058] Call Trace:
> [  157.123865]  pick_next_entity+0x61/0x110
> [  157.130137]  pick_task_fair+0x4b/0x90
> [  157.136124]  __schedule+0x365/0x12c0
> [  157.141985]  schedule_idle+0x1e/0x40
> [  157.147822]  do_idle+0x166/0x280
> [  157.153275]  cpu_startup_entry+0x19/0x20
> [  157.159420]  start_secondary+0x17a/0x1d0
> [  157.165568]  secondary_startup_64+0xa4/0xb0
> [  157.171985] Modules linked in: af_packet iscsi_ibft iscsi_boot_sysfs msr intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass crc32_pclmul ghash_clmulni_intel ixgbe aesni_intel xfrm_algo iTCO_wdt joydev iTCO_vendor_support libphy igb aes_x86_64 crypto_simd ptp cryptd mei_me mdio pps_core ioatdma glue_helper pcspkr ipmi_si lpc_ich i2c_i801 mei dca ipmi_devintf ipmi_msghandler acpi_pad pcc_cpufreq button btrfs libcrc32c xor zstd_decompress zstd_compress raid6_pq hid_generic usbhid ast i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops xhci_pci crc32c_intel ehci_pci ttm xhci_hcd ehci_hcd drm ahci usbcore mpt3sas libahci raid_class scsi_transport_sas wmi sg nbd dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [  157.258990] CR2: 0000000000000058
> [  157.264961] ---[ end trace a301ac5e3ee86fde ]---
> [  157.283719] RIP: 0010:wakeup_preempt_entity.isra.70+0x9/0x50
> [  157.291967] Code: 00 be c0 82 60 00 e9 86 02 1a 00 66 0f 1f 44 00 00 48 c1 e7 03 be c0 80 60 00 e9 72 02 1a 00 66 90 0f 1f 44 00 00 53 48 89 fb <48> 2b 5e 58 48 85 db 7e 2c 48 81 3e 00 00 10 00 8b 05 a9 b7 19 01
> [  157.316121] RSP: 0018:ffffc9000c5bbde8 EFLAGS: 00010086
> [  157.324060] RAX: ffff88810f5f6a00 RBX: 00000001547f175c RCX: 0000000000000001
> [  157.333932] RDX: ffff88bf3bdb0a40 RSI: 0000000000000000 RDI: 00000001547f175c
> [  157.343795] RBP: ffff88bf7fae32c0 R08: 000000000001e358 R09: ffff88810fb9f000
> [  157.353634] R10: ffffc9000c5bbe08 R11: ffff88810fb9f5c4 R12: 0000000000000000
> [  157.363506] R13: ffff88bf4e3ea0c0 R14: 0000000000000000 R15: ffff88bf4e3ea7a8
> [  157.373395] FS:  0000000000000000(0000) GS:ffff88bf7f5c0000(0000) knlGS:0000000000000000
> [  157.384238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  157.392709] CR2: 0000000000000058 CR3: 000000000220e005 CR4: 00000000003606e0
> [  157.402601] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  157.412488] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  157.422334] Kernel panic - not syncing: Attempted to kill the idle task!
> [  158.529804] Shutting down cpus with NMI
> [  158.573249] Kernel Offset: disabled
> [  158.586198] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> RIP translates to kernel/sched/fair.c:6819
>
> static int
> wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> {
>          s64 gran, vdiff = curr->vruntime - se->vruntime; /* LINE 6819 */
>
>          if (vdiff <= 0)
>                  return -1;
>
>          gran = wakeup_gran(se);
>          if (vdiff > gran)
>                  return 1;
> }
>
> I haven't tried debugging it yet.
>
I think the following fix, while trivial, is the right fix for the NULL
dereference in this case. This bug is reproducible with patch 14. I also 
did
some performance bisecting and with patch 14 performance is decimated, 
that's
expected. Most of the performance recovery happens in patch 15 which,
unfortunately, is also the one that introduces the hard lockup.

-------8<-----------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d0dac4..ecadf36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4131,7 +4131,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *curr)
          * Avoid running the skip buddy, if running something else can
          * be done without getting too unfair.
*/
-       if (cfs_rq->skip == se) {
+       if (cfs_rq->skip && cfs_rq->skip == se) {
                 struct sched_entity *second;

                 if (se == curr) {
@@ -4149,13 +4149,15 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *curr)
/*
          * Prefer last buddy, try to return the CPU to a preempted task.
*/
-       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+       if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, 
left)
+           < 1)
                 se = cfs_rq->last;

/*
          * Someone really wants this to run. If it's not unfair, run it.
*/
-       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+       if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, 
left)
+           < 1)
                 se = cfs_rq->next;

         clear_buddies(cfs_rq, se);

