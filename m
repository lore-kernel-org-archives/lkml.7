Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64820854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CNSYnKOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfCAC45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:56:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35106 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfCAC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:56:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x212sUIK135083;
        Fri, 1 Mar 2019 02:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=H7/C4NBSU819echd6FsmqBOR8jcFb1wk93ssHptpG3o=;
 b=CNSYnKOReZScVaLDdhDc7W+dGPleLWr1SVynHCjwbYq63CCpK/4oVnoEj9bi/FK8i5kg
 5/JFt/SzqeENVbIBwrFUvsxAjBouCX3LMn7QxJKWNx0XT8oA/1C+WpLyrSoA0lLeOeSc
 dFQTQ0HxFGBiIIQCwVTUQ4Bzv5ut4Sp2O6iHHZ9rJaIMmStZ+DXjw/n1udxxFddNB/py
 DmToaLMWxbHmvrbYfHO+XwdYPxXMfIBJUm1lwBYiKG2qepXtDHvqyA6J2/N6RVYKuAP7
 qUf3zFdB63LEMXMG+1MXaU2QDFTxipvgIahGA3RISmXlR6JNqGKpRU1oHGCJbcklfgmR fA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qtwkumw86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Mar 2019 02:56:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x212uNYt002823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 02:56:24 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x212uLXK010900;
        Fri, 1 Mar 2019 02:56:21 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 18:56:21 -0800
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <1add3ac5-d824-c2c2-b6a7-280f1c7834e3@oracle.com>
Date:   Thu, 28 Feb 2019 18:54:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218165620.383905466@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903010016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/19 8:56 AM, Peter Zijlstra wrote:
> A much 'demanded' feature: core-scheduling :-(
>
> I still hate it with a passion, and that is part of why it took a little
> longer than 'promised'.
>
> While this one doesn't have all the 'features' of the previous (never
> published) version and isn't L1TF 'complete', I tend to like the structure
> better (relatively speaking: I hate it slightly less).
>
> This one is sched class agnostic and therefore, in principle, doesn't horribly
> wreck RT (in fact, RT could 'ab'use this by setting 'task->core_cookie = task'
> to force-idle siblings).
>
> Now, as hinted by that, there are semi sane reasons for actually having this.
> Various hardware features like Intel RDT - Memory Bandwidth Allocation, work
> per core (due to SMT fundamentally sharing caches) and therefore grouping
> related tasks on a core makes it more reliable.
>
> However; whichever way around you turn this cookie; it is expensive and nasty.
>
I am seeing the following hard lockup frequently now. Following is full
kernel output:

[ 5846.412296] drop_caches (8657): drop_caches: 3
[ 5846.624823] drop_caches (8658): drop_caches: 3
[ 5850.604641] hugetlbfs: oracle (8671): Using mlock ulimits for SHM_HUGETL
B is deprecated
[ 5962.930812] NMI watchdog: Watchdog detected hard LOCKUP on cpu 32
[ 5962.930814] Modules linked in: drbd lru_cache autofs4 cpufreq_powersave
ipv6 crc_ccitt mxm_wmi iTCO_wdt iTCO_vendor_support btrfs raid6_pq
zstd_compress zstd_decompress xor pcspkr i2c_i801 lpc_ich mfd_core ioatdma
ixgbe dca mdio sg ipmi_ssif i2c_core ipmi_si ipmi_msghandler wmi
pcc_cpufreq acpi_pad ext4 fscrypto jbd2 mbcache sd_mod ahci libahci nvme
nvme_core megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[ 5962.930828] CPU: 32 PID: 10333 Comm: oracle_10333_tp Not tainted
5.0.0-rc7core_sched #1
[ 5962.930828] Hardware name: Oracle Corporation ORACLE SERVER
X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[ 5962.930829] RIP: 0010:try_to_wake_up+0x98/0x470
[ 5962.930830] Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00 8b 43
3c 8b 73 60 85 f6 0f 85 a6 01 00 00 8b 43 38 85 c0 74 09 f3 90 8b 43 38
<85> c0 75 f7 48 8b 43 10 a8 02 b8 00 00 00 00 0f 85 d5 01 00 00 0f
[ 5962.930831] RSP: 0018:ffffc9000f4dbcb8 EFLAGS: 00000002
[ 5962.930832] RAX: 0000000000000001 RBX: ffff88dfb4af1680 RCX:
0000000000000041
[ 5962.930832] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff88dfb4af214c
[ 5962.930833] RBP: 0000000000000000 R08: 0000000000000001 R09:
ffffc9000f4dbd80
[ 5962.930833] R10: ffff888000000000 R11: ffffea00f0003d80 R12:
ffff88dfb4af214c
[ 5962.930834] R13: 0000000000000001 R14: 0000000000000046 R15:
0000000000000001
[ 5962.930834] FS:  00007ff4fabd9ae0(0000) GS:ffff88dfbe280000(0000)
knlGS:0000000000000000
[ 5962.930834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5962.930835] CR2: 0000000f4cc84000 CR3: 0000003b93d36002 CR4:
00000000003606e0
[ 5962.930835] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 5962.930836] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 5962.930836] Call Trace:
[ 5962.930837]  ? __switch_to_asm+0x34/0x70
[ 5962.930837]  ? __switch_to_asm+0x40/0x70
[ 5962.930838]  ? __switch_to_asm+0x34/0x70
[ 5962.930838]  autoremove_wake_function+0x11/0x50
[ 5962.930838]  __wake_up_common+0x8f/0x160
[ 5962.930839]  ? __switch_to_asm+0x40/0x70
[ 5962.930839]  __wake_up_common_lock+0x7c/0xc0
[ 5962.930840]  pipe_write+0x24e/0x3f0
[ 5962.930840]  __vfs_write+0x127/0x1b0
[ 5962.930840]  vfs_write+0xb3/0x1b0
[ 5962.930841]  ksys_write+0x52/0xc0
[ 5962.930841]  do_syscall_64+0x5b/0x170
[ 5962.930842]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5962.930842] RIP: 0033:0x3b5900e7b0
[ 5962.930843] Code: 97 20 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb ea 90
90 90 90 90 90 90 90 90 83 3d f1 db 20 00 00 75 10 b8 01 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e fa ff ff 48 89 04 24
[ 5962.930843] RSP: 002b:00007ffedbcd93a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 5962.930844] RAX: ffffffffffffffda RBX: 00007ff4faa86e24 RCX:
0000003b5900e7b0
[ 5962.930845] RDX: 000000000000028f RSI: 00007ff4faa9688e RDI:
000000000000000a
[ 5962.930845] RBP: 00007ffedbcd93c0 R08: 00007ffedbcd9458 R09:
0000000000000020
[ 5962.930846] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffedbcd9458
[ 5962.930847] R13: 00007ff4faa9688e R14: 00007ff4faa89cc8 R15:
00007ff4faa86bd0
[ 5962.930847] Kernel panic - not syncing: Hard LOCKUP
[ 5962.930848] CPU: 32 PID: 10333 Comm: oracle_10333_tp Not tainted
5.0.0-rc7core_sched #1
[ 5962.930848] Hardware name: Oracle Corporation ORACLE
SERVER X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[ 5962.930849] Call Trace:
[ 5962.930849]  <NMI>
[ 5962.930849]  dump_stack+0x5c/0x7b
[ 5962.930850]  panic+0xfe/0x2b2
[ 5962.930850]  nmi_panic+0x35/0x40
[ 5962.930851]  watchdog_overflow_callback+0xef/0x100
[ 5962.930851]  __perf_event_overflow+0x5a/0xe0
[ 5962.930852]  handle_pmi_common+0x1d1/0x280
[ 5962.930852]  ? __set_pte_vaddr+0x32/0x50
[ 5962.930852]  ? __set_pte_vaddr+0x32/0x50
[ 5962.930853]  ? set_pte_vaddr+0x3c/0x60
[ 5962.930853]  ? intel_pmu_handle_irq+0xad/0x170
[ 5962.930854]  intel_pmu_handle_irq+0xad/0x170
[ 5962.930854]  perf_event_nmi_handler+0x2e/0x50
[ 5962.930854]  nmi_handle+0x6f/0x120
[ 5962.930855]  default_do_nmi+0xee/0x110
[ 5962.930855]  do_nmi+0xe5/0x130
[ 5962.930856]  end_repeat_nmi+0x16/0x50
[ 5962.930856] RIP: 0010:try_to_wake_up+0x98/0x470
[ 5962.930857] Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00 8b 43
3c 8b 73 60 85 f6 0f 85 a6 01 00 00 8b 43 38 85 c0 74 09 f3 90 8b 43 38
<85> c0 75 f7 48 8b 43 10 a8 02 b8 00 00 00 00 0f 85 d5 01 00 00 0f
[ 5962.930857] RSP: 0018:ffffc9000f4dbcb8 EFLAGS: 00000002
[ 5962.930858] RAX: 0000000000000001 RBX: ffff88dfb4af1680 RCX:
0000000000000041
[ 5962.930859] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff88dfb4af214c
[ 5962.930859] RBP: 0000000000000000 R08: 0000000000000001 R09:
ffffc9000f4dbd80
[ 5962.930859] R10: ffff888000000000 R11: ffffea00f0003d80 R12:
ffff88dfb4af214c
[ 5962.930860] R13: 0000000000000001 R14: 0000000000000046 R15:
0000000000000001
[ 5962.930860]  ? try_to_wake_up+0x98/0x470
[ 5962.930861]  ? try_to_wake_up+0x98/0x470
[ 5962.930861]  </NMI>
[ 5962.930862]  ? __switch_to_asm+0x34/0x70
[ 5962.930862]  ? __switch_to_asm+0x40/0x70
[ 5962.930862]  ? __switch_to_asm+0x34/0x70
[ 5962.930863]  autoremove_wake_function+0x11/0x50
[ 5962.930863]  __wake_up_common+0x8f/0x160
[ 5962.930864]  ? __switch_to_asm+0x40/0x70
[ 5962.930864]  __wake_up_common_lock+0x7c/0xc0
[ 5962.930864]  pipe_write+0x24e/0x3f0
[ 5962.930865]  __vfs_write+0x127/0x1b0
[ 5962.930865]  vfs_write+0xb3/0x1b0
[ 5962.930866]  ksys_write+0x52/0xc0
[ 5962.930866]  do_syscall_64+0x5b/0x170
[ 5962.930866]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5962.930867] RIP: 0033:0x3b5900e7b0
[ 5962.930868] Code: 97 20 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb ea 90
90 90 90 90 90 90 90 90 83 3d f1 db 20 00 00 75 10 b8 01 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e fa ff ff 48 89 04 24
[ 5962.930868] RSP: 002b:00007ffedbcd93a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 5962.930869] RAX: ffffffffffffffda RBX: 00007ff4faa86e24 RCX:
0000003b5900e7b0
[ 5962.930869] RDX: 000000000000028f RSI: 00007ff4faa9688e RDI:
000000000000000a
[ 5962.930870] RBP: 00007ffedbcd93c0 R08: 00007ffedbcd9458 R09:
0000000000000020
[ 5962.930870] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffedbcd9458
[ 5962.930871] R13: 00007ff4faa9688e R14: 00007ff4faa89cc8 R15:
00007ff4faa86bd0
[ 5963.987766] NMI watchdog: Watchdog detected hard LOCKUP on cpu 11
[ 5963.987767] Modules linked in: drbd lru_cache autofs4 cpufreq_powersave
ipv6 crc_ccitt mxm_wmi iTCO_wdt iTCO_vendor_support btrfs raid6_pq
zstd_compress zstd_decompress xor pcspkr i2c_i801 lpc_ich mfd_core ioatdma
ixgbe dca mdio sg ipmi_ssif i2c_core ipmi_si ipmi_msghandler wmi
pcc_cpufreq acpi_pad ext4 fscrypto jbd2 mbcache sd_mod ahci libahci nvme
nvme_core megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[ 5963.987775] CPU: 11 PID: 8805 Comm: ora_lg02_tpcc1 Not tainted
5.0.0-rc7core_sched #1
[ 5963.987775] Hardware name: Oracle Corporation ORACLE SERVER
X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[ 5963.987776] RIP: 0010:native_queued_spin_lock_slowpath+0x183/0x1e0
[ 5963.987777] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 00 3a 02
00 48 03 34 c5 20 98 13 82 48 89 16 8b 42 08 85 c0 75 09 f3 90 8b 42 08
<85> c0 74 f7 48 8b 32 48 85 f6 74 07 0f 0d 0e eb 02 f3 90 8b 07 66
[ 5963.987777] RSP: 0018:ffffc90023003760 EFLAGS: 00000046
[ 5963.987778] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000300000
[ 5963.987778] RDX: ffff88afbf2e3a00 RSI: ffff88dfbeae3a00 RDI:
ffff88dfbe1a2d40
[ 5963.987779] RBP: ffff88dfbe1a2d40 R08: 0000000000300000 R09:
00000fffffc00000
[ 5963.987779] R10: ffffc90023003778 R11: ffff88afb77b3340 R12:
000000000000001c
[ 5963.987779] R13: 0000000000022d40 R14: 0000000000000000 R15:
000000000000001c
[ 5963.987780] FS:  00007f4e14e73ae0(0000) GS:ffff88afbf2c0000(0000)
knlGS:0000000000000000
[ 5963.987780] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5963.987780] CR2: 00007fe503647850 CR3: 0000000d1b1ae002 CR4:
00000000003606e0
[ 5963.987781] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 5963.987781] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 5963.987781] Call Trace:
[ 5963.987781]  _raw_spin_lock_irqsave+0x39/0x40
[ 5963.987782]  update_blocked_averages+0x32/0x610
[ 5963.987782]  update_nohz_stats+0x4d/0x60
[ 5963.987782]  update_sd_lb_stats+0x2e5/0x7d0
[ 5963.987783]  find_busiest_group+0x3e/0x5b0
[ 5963.987783]  load_balance+0x18c/0xc00
[ 5963.987783]  newidle_balance+0x278/0x490
[ 5963.987783]  __schedule+0xd16/0x1060
[ 5963.987784]  ? lock_timer_base+0x66/0x80
[ 5963.987784]  schedule+0x32/0x70
[ 5963.987784]  schedule_timeout+0x16d/0x360
[ 5963.987785]  ? __next_timer_interrupt+0xc0/0xc0
[ 5963.987785]  do_semtimedop+0x966/0x1180
[ 5963.987785]  ? xas_load+0x9/0x80
[ 5963.987786]  ? find_get_entry+0x5d/0x1e0
[ 5963.987786]  ? pagecache_get_page+0x1b4/0x2d0
[ 5963.987786]  ? __vfs_getxattr+0x2a/0x70
[ 5963.987786]  ? enqueue_task_rt+0x98/0xb0
[ 5963.987787]  ? check_preempt_curr+0x50/0x90
[ 5963.987787]  ? push_rt_tasks+0x20/0x20
[ 5963.987787]  ? ttwu_do_wakeup+0x5e/0x160
[ 5963.987788]  ? try_to_wake_up+0x54/0x470
[ 5963.987788]  ? wake_up_q+0x2d/0x70
[ 5963.987788]  ? semctl_setval+0x26d/0x400
[ 5963.987788]  ? ksys_semtimedop+0x52/0x80
[ 5963.987789]  ksys_semtimedop+0x52/0x80
[ 5963.987789]  do_syscall_64+0x5b/0x170
[ 5963.987789]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5963.987789] RIP: 0033:0x3b58ceb28a
[ 5963.987790] Code: 73 01 c3 48 8b 0d 3e 2d 2a 00 31 d2 48 29 c2 64 89 11
48 83 c8 ff eb ea 90 90 90 90 90 90 90 90 49 89 ca b8 dc 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0e 2d 2a 00 31 d2 48 29 c2 64
[ 5963.987790] RSP: 002b:00007fff79282ed8 EFLAGS: 00000206 ORIG_RAX:
00000000000000dc
[ 5963.987791] RAX: ffffffffffffffda RBX: ffffffffffd23940 RCX:
0000003b58ceb28a
[ 5963.987791] RDX: 0000000000000001 RSI: 00007fff792830b8 RDI:
0000000000058002
[ 5963.987791] RBP: 00007fff792830e0 R08: 0000000000000000 R09:
0000000171327788
[ 5963.987792] R10: 00007fff79283068 R11: 0000000000000206 R12:
00007fff792833c8
[ 5963.987792] R13: 0000000000058002 R14: 0000000168dc0770 R15:
0000000000000000
[ 5963.987796] Shutting down cpus with NMI
[ 5963.987796] Kernel Offset: disabled
[ 5963.987797] NMI watchdog: Watchdog detected hard LOCKUP on cpu 33
[ 5963.987797] Modules linked in: drbd lru_cache autofs4 cpufreq_powersave
ipv6 crc_ccitt mxm_wmi iTCO_wdt iTCO_vendor_support btrfs raid6_pq
zstd_compress zstd_decompress xor pcspkr i2c_i801 lpc_ich mfd_core ioatdma
ixgbe dca mdio sg ipmi_ssif i2c_core ipmi_si ipmi_msghandler wmi
pcc_cpufreq acpi_pad ext4 fscrypto jbd2 mbcache sd_mod ahci libahci nvme
nvme_core megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[ 5963.987805] CPU: 33 PID: 10303 Comm: oracle_10303_tp Not tainted
5.0.0-rc7core_sched #1
[ 5963.987806] Hardware name: Oracle Corporation ORACLE
SERVER X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[ 5963.987806] RIP: 0010:native_queued_spin_lock_slowpath+0x180/0x1e0
[ 5963.987807] Code: c1 e8 12 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81
c6 00 3a 02 00 48 03 34 c5 20 98 13 82 48 89 16 8b 42 08 85 c0 75 09 f3 90
<8b> 42 08 85 c0 74 f7 48 8b 32 48 85 f6 74 07 0f 0d 0e eb 02 f3 90
[ 5963.987807] RSP: 0018:ffffc90024833980 EFLAGS: 00000046
[ 5963.987808] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000880000
[ 5963.987808] RDX: ffff88dfbe2e3a00 RSI: ffff88dfbe763a00 RDI:
ffff88dfbe3e2d40
[ 5963.987809] RBP: ffff88dfbe3e2d40 R08: 0000000000880000 R09:
0000002000000000
[ 5963.987809] R10: 0000000000000004 R11: ffff88dfb6ffd2c0 R12:
0000000000000025
[ 5963.987809] R13: 0000000000022d40 R14: 0000000000000000 R15:
0000000000000025
[ 5963.987810] FS:  00007f0b7e5feae0(0000) GS:ffff88dfbe2c0000(0000)
knlGS:0000000000000000
[ 5963.987810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5963.987810] CR2: 000000007564d0e7 CR3: 0000003debf6a001 CR4:
00000000003606e0
[ 5963.987811] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 5963.987811] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 5963.987811] Call Trace:
[ 5963.987812]  _raw_spin_lock_irqsave+0x39/0x40
[ 5963.987812]  update_blocked_averages+0x32/0x610
[ 5963.987812]  update_nohz_stats+0x4d/0x60
[ 5963.987812]  update_sd_lb_stats+0x2e5/0x7d0
[ 5963.987813]  find_busiest_group+0x3e/0x5b0
[ 5963.987813]  load_balance+0x18c/0xc00
[ 5963.987813]  ? __switch_to_asm+0x40/0x70
[ 5963.987813]  ? __switch_to_asm+0x34/0x70
[ 5963.987814]  newidle_balance+0x278/0x490
[ 5963.987814]  __schedule+0xd16/0x1060
[ 5963.987814]  ? enqueue_hrtimer+0x3a/0x90
[ 5963.987814]  schedule+0x32/0x70
[ 5963.987815]  do_nanosleep+0x81/0x180
[ 5963.987815]  hrtimer_nanosleep+0xce/0x1f0
[ 5963.987815]  ? __hrtimer_init+0xb0/0xb0
[ 5963.987816]  __x64_sys_nanosleep+0x8d/0xa0
[ 5963.987816]  do_syscall_64+0x5b/0x170
[ 5963.987816]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5963.987816] RIP: 0033:0x3b5900eff0
[ 5963.987817] Code: 73 01 c3 48 8b 0d b8 8f 20 00 31 d2 48 29 c2 64 89 11
48 83 c8 ff eb ea 90 90 83 3d b1 d3 20 00 00 75 10 b8 23 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f2 ff ff 48 89 04 24
[ 5963.987817] RSP: 002b:00007ffe359b5158 EFLAGS: 00000246 ORIG_RAX:
0000000000000023
[ 5963.987818] RAX: ffffffffffffffda RBX: 0000000000169d10 RCX:
0000003b5900eff0
[ 5963.987818] RDX: 0000000000000000 RSI: 00007ffe359b5170 RDI:
00007ffe359b5160
[ 5963.987818] RBP: 00007ffe359b51c0 R08: 0000000000000000 R09:
0000000000000000
[ 5963.987819] R10: 00000001512241f8 R11: 0000000000000246 R12:
0000000000000000
[ 5963.987819] R13: 00007ffe359b5280 R14: 00000000000005ca R15:
0000000000000000
[ 5963.987827] NMI watchdog: Watchdog detected hard LOCKUP on cpu 75
[ 5963.987828] Modules linked in: drbd lru_cache autofs4 cpufreq_powersave
ipv6 crc_ccitt mxm_wmi iTCO_wdt iTCO_vendor_support btrfs raid6_pq
zstd_compress zstd_decompress xor pcspkr i2c_i801 lpc_ich mfd_core ioatdma
ixgbe dca mdio sg ipmi_ssif i2c_core ipmi_si ipmi_msghandler wmi
pcc_cpufreq acpi_pad ext4 fscrypto jbd2 mbcache sd_mod ahci libahci nvme
nvme_core megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[ 5963.987835] CPU: 75 PID: 0 Comm: swapper/75 Not tainted
5.0.0-rc7core_sched #1
[ 5963.987836] Hardware name: Oracle Corporation
ORACLE SERVER X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[ 5963.987836] RIP: 0010:native_queued_spin_lock_slowpath+0x5e/0x1e0
[ 5963.987837] Code: ff 75 40 f0 0f ba 2f 08 0f 82 e7 00 00 00 8b 07 30 e4
09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74 08 f3 90 8b 07
<84> c0 75 f8 b8 01 00 00 00 66 89 07 c3 81 e6 00 ff 00 00 75 04 c6
[ 5963.987837] RSP: 0000:ffffc9000c77bd78 EFLAGS: 00000002
[ 5963.987838] RAX: 0000000001240101 RBX: 000000000000004b RCX:
0000000000000001
[ 5963.987838] RDX: ffff88dfbe522d40 RSI: 0000000000000001 RDI:
ffff88dfbe262d40
[ 5963.987838] RBP: 0000000000022d40 R08: 0000000000000000 R09:
0000000000000001
[ 5963.987839] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff88dfb4e40000
[ 5963.987839] R13: ffff88dfbe7e2d40 R14: 000000000000002a R15:
ffff88dfbe522d40
[ 5963.987840] FS:  0000000000000000(0000) GS:ffff88dfbe7c0000(0000)
knlGS:0000000000000000
[ 5963.987840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5963.987840] CR2: 0000000f4b348000 CR3: 0000003c45ed6001 CR4:
00000000003606e0
[ 5963.987841] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 5963.987841] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 5963.987841] Call Trace:
[ 5963.987842]  _raw_spin_lock+0x24/0x30
[ 5963.987842]  sched_core_balance+0x15c/0x4f0
[ 5963.987842]  __balance_callback+0x49/0xa0
[ 5963.987843]  __schedule+0xdc0/0x1060
[ 5963.987843]  schedule_idle+0x28/0x40
[ 5963.987843]  do_idle+0x164/0x260
[ 5963.987843]  cpu_startup_entry+0x19/0x20
[ 5963.987844]  start_secondary+0x17d/0x1d0
[ 5963.987844]  secondary_startup_64+0xa4/0xb0
[ 5963.987845] NMI watchdog: Watchdog detected hard LOCKUP on cpu 81
[ 5963.987845] Modules linked in: drbd lru_cache autofs4 cpufreq_powersave
ipv6 crc_ccitt mxm_wmi iTCO_wdt iTCO_vendor_support btrfs raid6_pq
zstd_compress zstd_decompress xor pcspkr i2c_i801 lpc_ich mfd_core ioatdma
ixgbe dca mdio sg ipmi_ssif i2c_core ipmi_si ipmi_msghandler wmi
pcc_cpufreq acpi_pad ext4 fscrypto jbd2 mbcache sd_mod ahci libahci nvme
nvme_core megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[ 5963.987853] CPU: 81 PID: 0 Comm: swapper/81 Not tainted
5.0.0-rc7core_sched #1
[ 5963.987854] Hardware name: Oracle Corporation ORACLE SERVER
X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[ 5963.987854] RIP: 0010:native_queued_spin_lock_slowpath+0x183/0x1e0
[ 5963.987854] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 00 3a 02
00 48 03 34 c5 20 98 13 82 48 89 16 8b 42 08 85 c0 75 09 f3 90 8b 42 08
<85> c0 74 f7 48 8b 32 48 85 f6 74 07 0f 0d 0e eb 02 f3 90 8b 07 66
[ 5963.987855] RSP: 0000:ffffc9000c7abd78 EFLAGS: 00000046
[ 5963.987855] RAX: 0000000000000000 RBX: 0000000000000051 RCX:
0000000001480000
[ 5963.987856] RDX: ffff88dfbe963a00 RSI: ffff88dfbe523a00 RDI:
ffff88dfbe522d40
[ 5963.987856] RBP: 0000000000022d40 R08: 0000000001480000 R09:
0000000000000001
[ 5963.987856] R10: ffff88dfb7a41680 R11: 0000000000000001 R12:
0000000000000001
[ 5963.987857] R13: ffff88dfbe962d40 R14: 0000000000000056 R15:
ffff88dfbeaa2d40
[ 5963.987857] FS:  0000000000000000(0000) GS:ffff88dfbe940000(0000)
knlGS:0000000000000000
[ 5963.987857] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5963.987857] CR2: 0000000f4a7a8000 CR3: 0000003b67e2a002 CR4:
00000000003606e0
[ 5963.987858] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 5963.987858] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 5963.987858] Call Trace:
[ 5963.987859]  _raw_spin_lock+0x24/0x30
[ 5963.987859]  sched_core_balance+0x15c/0x4f0
[ 5963.987859]  __balance_callback+0x49/0xa0
[ 5963.987859]  __schedule+0xdc0/0x1060
[ 5963.987860]  schedule_idle+0x28/0x40
[ 5963.987860]  do_idle+0x164/0x260
[ 5963.987860]  cpu_startup_entry+0x19/0x20
[ 5963.987860]  start_secondary+0x17d/0x1d0
[ 5963.987861]  secondary_startup_64+0xa4/0xb0
[ 5983.129164] ---[ end Kernel panic - not syncing: Hard LOCKUP ]---




