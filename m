Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1C20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEOP3r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:29:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbfEOP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:29:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FFSDPQ132539
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:29:06 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgm6xmjcv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:29:03 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 15 May 2019 16:29:02 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 16:28:59 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FFSwDO30081278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 15:28:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2D47B2065;
        Wed, 15 May 2019 15:28:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B485B2067;
        Wed, 15 May 2019 15:28:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 15:28:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DE47216C6B88; Wed, 15 May 2019 08:28:58 -0700 (PDT)
Date:   Wed, 15 May 2019 08:28:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "x86@kernel.org" <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: `rcu: INFO: rcu_sched detected stalls on CPUs/tasks` on AMD EPYC
 server
Reply-To: paulmck@linux.ibm.com
References: <8e3041f5-4e57-acd0-027b-f1ef59c37bb0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8e3041f5-4e57-acd0-027b-f1ef59c37bb0@molgen.mpg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051515-0040-0000-0000-000004F00EED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011102; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203720; UDB=6.00631857; IPR=6.00984646;
 MB=3.00026906; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-15 15:29:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051515-0041-0000-0000-000008FC1DD7
Message-Id: <20190515152858.GA28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:22:06PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Building a Linux kernel (like 5.1.2) on a 128 thread AMD EPYC server with 126, 127,
> or 128 threads *sometimes* the server becomes unusable and logging in over network
> is not possible anymore. Only logging in over tty1 works, and the server needs to
> be rebooted.
> 
> ```
> [    0.000000] Linux version 4.19.19.mx64.244 (root@theinternet.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Tue Feb 5 13:01:13 CET 2019
> […]
> [2418051.367223] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418051.367231] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=14323 
> [2418051.367235] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=14323 
> [2418051.367236] rcu: 	(detected by 2, t=60002 jiffies, g=298982765, q=7633949)
> [2418051.367254] Sending NMI from CPU 2 to CPUs 30:
> [2418061.370201] Sending NMI from CPU 2 to CPUs 94:

Huh.  Neither CPU 30 nor CPU 94 responded to the NMI.  This usually means
that either NMIs aren't working or that the target CPUs are so deeply
in trouble that they cannot respond to NMIs.  One historic reason that
the CPUs could be so deeply in trouble would be if the stack pointer
started referencing unmapped memory, but I have no idea whether that
applies to your particular CPUs.

For whatever it is worth, the most extreme case of a CPU being in trouble
was once long ago when the CPU simply failstopped, so that it was no
longer executing instructions at all.

On trick that might (or might not) get you more information is to force
RCU to dump the stack remotely instead of sending NMIs.  Here is an
(untested) patch that should do the trick:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acd6ccf56faf..a4225c2f24f4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1220,8 +1220,7 @@ static void rcu_dump_cpu_stacks(void)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
-				if (!trigger_single_cpu_backtrace(cpu))
-					dump_cpu_task(cpu);
+				dump_cpu_task(cpu);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }

Please let me know how it goes!

							Thanx, Paul

> [2418071.372935] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=106
> [2418071.372936] rcu: RCU grace-period kthread stack dump:
> [2418071.372938] rcu_sched       R  running task        0    11      2 0x80000000
> [2418071.372940] Call Trace:
> [2418071.372947]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418071.372950]  ? force_qs_rnp+0x11e/0x140
> [2418071.372952]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418071.372953]  ? __schedule+0x1f8/0x7b0
> [2418071.372955]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418071.372957]  ? kthread+0x113/0x130
> [2418071.372958]  ? kthread_park+0x90/0x90
> [2418071.372960]  ? ret_from_fork+0x22/0x40
> [2418231.372935] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418231.372943] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=52808 
> [2418231.372946] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=52808 
> [2418231.372947] rcu: 	(detected by 5, t=240007 jiffies, g=298982765, q=8914782)
> [2418231.372959] Sending NMI from CPU 5 to CPUs 30:
> [2418241.375808] Sending NMI from CPU 5 to CPUs 94:
> [2418251.378374] rcu: rcu_sched kthread starved for 20002 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=60
> [2418251.378376] rcu: RCU grace-period kthread stack dump:
> [2418251.378378] rcu_sched       R  running task        0    11      2 0x80000000
> [2418251.378381] Call Trace:
> [2418251.378388]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418251.378392]  ? force_qs_rnp+0x11e/0x140
> [2418251.378393]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418251.378395]  ? __schedule+0x1f8/0x7b0
> [2418251.378397]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418251.378399]  ? kthread+0x113/0x130
> [2418251.378400]  ? kthread_park+0x90/0x90
> [2418251.378402]  ? ret_from_fork+0x22/0x40
> [2418411.378841] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418411.378849] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=91376 
> [2418411.378852] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=91376 
> [2418411.378853] rcu: 	(detected by 3, t=420012 jiffies, g=298982765, q=10176682)
> [2418411.378866] Sending NMI from CPU 3 to CPUs 30:
> [2418421.381889] Sending NMI from CPU 3 to CPUs 94:
> [2418431.384518] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=107
> [2418431.384520] rcu: RCU grace-period kthread stack dump:
> [2418431.384521] rcu_sched       R  running task        0    11      2 0x80000000
> [2418431.384523] Call Trace:
> [2418431.384530]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418431.384533]  ? force_qs_rnp+0x11e/0x140
> [2418431.384535]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418431.384537]  ? __schedule+0x1f8/0x7b0
> [2418431.384538]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418431.384540]  ? kthread+0x113/0x130
> [2418431.384541]  ? kthread_park+0x90/0x90
> [2418431.384543]  ? ret_from_fork+0x22/0x40
> […]
> ```
> 
> Do you see anything in the attached logs, which could cause this?
> 
> 
> Kind regards,
> 
> Paul

> [    0.000000] Linux version 4.19.19.mx64.244 (root@theinternet.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Tue Feb 5 13:01:13 CET 2019
> [    0.000000] Command line: BOOT_IMAGE=/boot/bzImage-4.19.19.mx64.244 crashkernel=256M root=LABEL=root ro console=ttyS1,115200n8 console=tty0 init=/bin/systemd audit=0
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000076daffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000076db0000-0x0000000076ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000077000000-0x00000000c9d5efff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000c9d5f000-0x00000000c9dd1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000c9dd2000-0x00000000c9e84fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000c9e85000-0x00000000ca210fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000ca211000-0x00000000cacc8fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000cacc9000-0x00000000cbffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000cc000000-0x00000000cfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ddc00000-0x00000000ddc7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ddd00000-0x00000000ddd7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000dddf0000-0x00000000dddf0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e007ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0100000-0x00000000e017ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e01f0000-0x00000000e01f0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e2700000-0x00000000e277ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e2800000-0x00000000e287ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e28f0000-0x00000000e28f0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e4b00000-0x00000000e4b7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e4c00000-0x00000000e4c7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e4cf0000-0x00000000e4cf0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e6f00000-0x00000000e6f7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e7000000-0x00000000e707ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e70f0000-0x00000000e70f0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e9300000-0x00000000e937ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e9400000-0x00000000e947ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e94f0000-0x00000000e94f0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000eb700000-0x00000000eb77ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000eb800000-0x00000000eb87ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000eb8f0000-0x00000000eb8f0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000eff00000-0x00000000eff7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000efff0000-0x00000000efff0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000fedc0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedc5fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc7000-0x00000000fedc7fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc9000-0x00000000fedcafff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000202f37ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000202f380000-0x000000202fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000002030000000-0x000000402ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000402ff80000-0x000000402fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000004030000000-0x000000602ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000602ff80000-0x000000602fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000006030000000-0x000000802ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000802ff80000-0x000000802fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000008030000000-0x000000a02ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000a02ff80000-0x000000a02fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000a030000000-0x000000c02ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000c02ff80000-0x000000c02fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000c030000000-0x000000e02ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000e02ff80000-0x000000e02fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000e030000000-0x000001002ff7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000001002ff80000-0x000001002fffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 3.1.1 present.
> [    0.000000] DMI: Supermicro AS -2023US-TR4/H11DSU-iN, BIOS 1.1 02/07/2018
> [    0.000000] tsc: Fast TSC calibration failed
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] last_pfn = 0x1002ff80 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF write-through
> [    0.000000]   C0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
> [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
> [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
> [    0.000000]   3 base 0000CC000000 mask FFFFFC000000 uncachable
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] TOM2: 0000010030000000 aka 1049344M
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000000] e820: update [mem 0xcc000000-0xffffffff] usable ==> reserved
> [    0.000000] last_pfn = 0xcc000 max_arch_pfn = 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000fd660-0x000fd66f] mapped at [(____ptrval____)]
> [    0.000000] Base memory trampoline at [(____ptrval____)] 93000 size 24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] BRK [0x02c02000, 0x02c02fff] PGTABLE
> [    0.000000] BRK [0x02c03000, 0x02c03fff] PGTABLE
> [    0.000000] BRK [0x02c04000, 0x02c04fff] PGTABLE
> [    0.000000] BRK [0x02c05000, 0x02c05fff] PGTABLE
> [    0.000000] BRK [0x02c06000, 0x02c06fff] PGTABLE
> [    0.000000] BRK [0x02c07000, 0x02c07fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x375e7000-0x37aeafff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 SUPERM)
> [    0.000000] ACPI: XSDT 0x00000000C9E850A8 0000D4 (v01 SUPERM SUPERM   03242016 AMI  00010013)
> [    0.000000] ACPI: FACP 0x00000000C9E916E8 000114 (v06                 03242016 AMI  00010013)
> [    0.000000] ACPI: DSDT 0x00000000C9E85218 00C4CB (v02 SUPERM SMCI     03242016 INTL 20120913)
> [    0.000000] ACPI: FACS 0x00000000CA210E80 000040
> [    0.000000] ACPI: APIC 0x00000000C9E91800 0004B2 (v04                 03242016 AMI  00010013)
> [    0.000000] ACPI: FPDT 0x00000000C9E91CB8 000044 (v01                 03242016 AMI  00010013)
> [    0.000000] ACPI: FIDT 0x00000000C9E91D00 00009C (v01 SUPERM SMCI     03242016 AMI  00010013)
> [    0.000000] ACPI: SSDT 0x00000000C9E91DA0 0000D2 (v02 SUPERM AMD ALIB 00000002 MSFT 04000000)
> [    0.000000] ACPI: SPMI 0x00000000C9E91E78 000041 (v05 SUPERM SMCI     00000000 AMI. 00000000)
> [    0.000000] ACPI: SSDT 0x00000000C9E91EC0 0006AC (v02 SUPERM CPUSSDT  03242016 AMI  03242016)
> [    0.000000] ACPI: MCFG 0x00000000C9E92570 00003C (v01 SUPERM SMCI     03242016 MSFT 00010013)
> [    0.000000] ACPI: SSDT 0x00000000C9E925B0 0117A4 (v01 SUPERM AMD CPU  00000001 AMD  00000001)
> [    0.000000] ACPI: SRAT 0x00000000C9EA3D58 0009C0 (v03 SUPERM AMD SRAT 00000001 AMD  00000001)
> [    0.000000] ACPI: MSCT 0x00000000C9EA4718 00004E (v01 SUPERM AMD MSCT 00000000 AMD  00000001)
> [    0.000000] ACPI: SLIT 0x00000000C9EA4768 00006C (v01 SUPERM AMD SLIT 00000001 AMD  00000001)
> [    0.000000] ACPI: CRAT 0x00000000C9EA47D8 007700 (v01 SUPERM AMD CRAT 00000001 AMD  00000001)
> [    0.000000] ACPI: CDIT 0x00000000C9EABED8 000068 (v01 SUPERM AMD CDIT 00000001 AMD  00000001)
> [    0.000000] ACPI: BERT 0x00000000C9EABF40 000030 (v01 AMD    AMD BERT 00000001 AMD  00000001)
> [    0.000000] ACPI: EINJ 0x00000000C9EABF70 000150 (v01 AMD    AMD EINJ 00000001 AMD  00000001)
> [    0.000000] ACPI: HEST 0x00000000C9EAC0C0 000608 (v01 AMD    AMD HEST 00000001 AMD  00000001)
> [    0.000000] ACPI: HPET 0x00000000C9EAC6C8 000038 (v01 SUPERM SMCI     03242016 AMI  00000005)
> [    0.000000] ACPI: SSDT 0x00000000C9EAC700 000024 (v01 AMDFCH FCHZP    00001000 INTL 20120913)
> [    0.000000] ACPI: UEFI 0x00000000C9EAC728 000042 (v01                 00000000      00000000)
> [    0.000000] ACPI: SSDT 0x00000000C9EAC770 001630 (v01 AMD    CPMCMN   00000001 INTL 20120913)
> [    0.000000] ACPI: WSMT 0x00000000C9EADDA0 000028 (v01 \xfe\xca              03242016 AMI  00010013)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x0e -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x0f -> Node 0
> [    0.000000] SRAT: PXM 1 -> APIC 0x10 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x11 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x12 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x13 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x14 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x15 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x16 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x17 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x18 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x19 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x1a -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x1b -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x1c -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x1d -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x1e -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x1f -> Node 1
> [    0.000000] SRAT: PXM 2 -> APIC 0x20 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x21 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x22 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x23 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x24 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x25 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x26 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x27 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x28 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x29 -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x2a -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x2b -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x2c -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x2d -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x2e -> Node 2
> [    0.000000] SRAT: PXM 2 -> APIC 0x2f -> Node 2
> [    0.000000] SRAT: PXM 3 -> APIC 0x30 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x31 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x32 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x33 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x34 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x35 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x36 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x37 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x38 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x39 -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x3a -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x3b -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x3c -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x3d -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x3e -> Node 3
> [    0.000000] SRAT: PXM 3 -> APIC 0x3f -> Node 3
> [    0.000000] SRAT: PXM 4 -> APIC 0x40 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x41 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x42 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x43 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x44 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x45 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x46 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x47 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x48 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x49 -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x4a -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x4b -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x4c -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x4d -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x4e -> Node 4
> [    0.000000] SRAT: PXM 4 -> APIC 0x4f -> Node 4
> [    0.000000] SRAT: PXM 5 -> APIC 0x50 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x51 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x52 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x53 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x54 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x55 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x56 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x57 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x58 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x59 -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x5a -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x5b -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x5c -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x5d -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x5e -> Node 5
> [    0.000000] SRAT: PXM 5 -> APIC 0x5f -> Node 5
> [    0.000000] SRAT: PXM 6 -> APIC 0x60 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x61 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x62 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x63 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x64 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x65 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x66 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x67 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x68 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x69 -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x6a -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x6b -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x6c -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x6d -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x6e -> Node 6
> [    0.000000] SRAT: PXM 6 -> APIC 0x6f -> Node 6
> [    0.000000] SRAT: PXM 7 -> APIC 0x70 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x71 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x72 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x73 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x74 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x75 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x76 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x77 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x78 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x79 -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x7a -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x7b -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x7c -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x7d -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x7e -> Node 7
> [    0.000000] SRAT: PXM 7 -> APIC 0x7f -> Node 7
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xcfffffff]
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x202fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x2030000000-0x402fffffff]
> [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x4030000000-0x602fffffff]
> [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x6030000000-0x802fffffff]
> [    0.000000] ACPI: SRAT: Node 4 PXM 4 [mem 0x8030000000-0xa02fffffff]
> [    0.000000] ACPI: SRAT: Node 5 PXM 5 [mem 0xa030000000-0xc02fffffff]
> [    0.000000] ACPI: SRAT: Node 6 PXM 6 [mem 0xc030000000-0xe02fffffff]
> [    0.000000] ACPI: SRAT: Node 7 PXM 7 [mem 0xe030000000-0x1002fffffff]
> [    0.000000] NUMA: Initialized distance table, cnt=8
> [    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xcfffffff] -> [mem 0x00000000-0xcfffffff]
> [    0.000000] NUMA: Node 0 [mem 0x00000000-0xcfffffff] + [mem 0x100000000-0x202fffffff] -> [mem 0x00000000-0x202fffffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x202f37c000-0x202f37ffff]
> [    0.000000] NODE_DATA(1) allocated [mem 0x402ff7c000-0x402ff7ffff]
> [    0.000000] NODE_DATA(2) allocated [mem 0x602ff7c000-0x602ff7ffff]
> [    0.000000] NODE_DATA(3) allocated [mem 0x802ff7c000-0x802ff7ffff]
> [    0.000000] NODE_DATA(4) allocated [mem 0xa02ff7c000-0xa02ff7ffff]
> [    0.000000] NODE_DATA(5) allocated [mem 0xc02ff7c000-0xc02ff7ffff]
> [    0.000000] NODE_DATA(6) allocated [mem 0xe02ff7c000-0xe02ff7ffff]
> [    0.000000] NODE_DATA(7) allocated [mem 0x1002ff7b000-0x1002ff7efff]
> [    0.000000] Reserving 256MB of memory at 624MB for crashkernel (System RAM: 1048478MB)
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000001002ff7ffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x0000000076daffff]
> [    0.000000]   node   0: [mem 0x0000000077000000-0x00000000c9d5efff]
> [    0.000000]   node   0: [mem 0x00000000c9dd2000-0x00000000c9e84fff]
> [    0.000000]   node   0: [mem 0x00000000cacc9000-0x00000000cbffffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000202f37ffff]
> [    0.000000]   node   1: [mem 0x0000002030000000-0x000000402ff7ffff]
> [    0.000000]   node   2: [mem 0x0000004030000000-0x000000602ff7ffff]
> [    0.000000]   node   3: [mem 0x0000006030000000-0x000000802ff7ffff]
> [    0.000000]   node   4: [mem 0x0000008030000000-0x000000a02ff7ffff]
> [    0.000000]   node   5: [mem 0x000000a030000000-0x000000c02ff7ffff]
> [    0.000000]   node   6: [mem 0x000000c030000000-0x000000e02ff7ffff]
> [    0.000000]   node   7: [mem 0x000000e030000000-0x000001002ff7ffff]
> [    0.000000] Reserved but unavailable: 104 pages
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000202f37ffff]
> [    0.000000] On node 0 totalpages: 33530385
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3992 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 12924 pages used for memmap
> [    0.000000]   DMA32 zone: 827129 pages, LIFO batch:63
> [    0.000000]   Normal zone: 510926 pages used for memmap
> [    0.000000]   Normal zone: 32699264 pages, LIFO batch:63
> [    0.000000] Initmem setup node 1 [mem 0x0000002030000000-0x000000402ff7ffff]
> [    0.000000] On node 1 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] Initmem setup node 2 [mem 0x0000004030000000-0x000000602ff7ffff]
> [    0.000000] On node 2 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] Initmem setup node 3 [mem 0x0000006030000000-0x000000802ff7ffff]
> [    0.000000] On node 3 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] Initmem setup node 4 [mem 0x0000008030000000-0x000000a02ff7ffff]
> [    0.000000] On node 4 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] Initmem setup node 5 [mem 0x000000a030000000-0x000000c02ff7ffff]
> [    0.000000] On node 5 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] Initmem setup node 6 [mem 0x000000c030000000-0x000000e02ff7ffff]
> [    0.000000] On node 6 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] Initmem setup node 7 [mem 0x000000e030000000-0x000001002ff7ffff]
> [    0.000000] On node 7 totalpages: 33554304
> [    0.000000]   Normal zone: 524286 pages used for memmap
> [    0.000000]   Normal zone: 33554304 pages, LIFO batch:63
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] IOAPIC[1]: apic_id 129, version 33, address 0xefff0000, GSI 24-55
> [    0.000000] IOAPIC[2]: apic_id 130, version 33, address 0xeb8f0000, GSI 56-87
> [    0.000000] IOAPIC[3]: apic_id 131, version 33, address 0xe94f0000, GSI 88-119
> [    0.000000] IOAPIC[4]: apic_id 132, version 33, address 0xe70f0000, GSI 120-151
> [    0.000000] IOAPIC[5]: apic_id 133, version 33, address 0xe4cf0000, GSI 152-183
> [    0.000000] IOAPIC[6]: apic_id 134, version 33, address 0xe28f0000, GSI 184-215
> [    0.000000] IOAPIC[7]: apic_id 135, version 33, address 0xe01f0000, GSI 216-247
> [    0.000000] IOAPIC[8]: apic_id 136, version 33, address 0xdddf0000, GSI 248-279
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
> [    0.000000] smpboot: Allowing 128 CPUs, 0 hotplug CPUs
> [    0.000000] [mem 0xefff1000-0xfe9fffff] available for PCI devices
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.000000] random: get_random_bytes called from start_kernel+0x90/0x4a7 with crng_init=0
> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:128 nr_node_ids:8
> [    0.000000] percpu: Embedded 42 pages/cpu @(____ptrval____) s134104 r8192 d29736 u262144
> [    0.000000] pcpu-alloc: s134104 r8192 d29736 u262144 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 
> [    0.000000] pcpu-alloc: [0] 064 065 066 067 068 069 070 071 
> [    0.000000] pcpu-alloc: [1] 008 009 010 011 012 013 014 015 
> [    0.000000] pcpu-alloc: [1] 072 073 074 075 076 077 078 079 
> [    0.000000] pcpu-alloc: [2] 016 017 018 019 020 021 022 023 
> [    0.000000] pcpu-alloc: [2] 080 081 082 083 084 085 086 087 
> [    0.000000] pcpu-alloc: [3] 024 025 026 027 028 029 030 031 
> [    0.000000] pcpu-alloc: [3] 088 089 090 091 092 093 094 095 
> [    0.000000] pcpu-alloc: [4] 032 033 034 035 036 037 038 039 
> [    0.000000] pcpu-alloc: [4] 096 097 098 099 100 101 102 103 
> [    0.000000] pcpu-alloc: [5] 040 041 042 043 044 045 046 047 
> [    0.000000] pcpu-alloc: [5] 104 105 106 107 108 109 110 111 
> [    0.000000] pcpu-alloc: [6] 048 049 050 051 052 053 054 055 
> [    0.000000] pcpu-alloc: [6] 112 113 114 115 116 117 118 119 
> [    0.000000] pcpu-alloc: [7] 056 057 058 059 060 061 062 063 
> [    0.000000] pcpu-alloc: [7] 120 121 122 123 124 125 126 127 
> [    0.000000] Built 8 zonelists, mobility grouping on.  Total pages: 264216576
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/bzImage-4.19.19.mx64.244 crashkernel=256M root=LABEL=root ro console=ttyS1,115200n8 console=tty0 init=/bin/systemd audit=0
> [    0.000000] audit: disabled (until reboot)
> [    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
> [    0.000000] log_buf_len total cpu_extra contributions: 520192 bytes
> [    0.000000] log_buf_len min size: 131072 bytes
> [    0.000000] log_buf_len: 1048576 bytes
> [    0.000000] early log buf free: 105316(80%)
> [    0.000000] Memory: 1056475592K/1073642052K available (14348K kernel code, 1379K rwdata, 3520K rodata, 1564K init, 1200K bss, 17166460K reserved, 0K cma-reserved)
> [    0.000000] ftrace: allocating 41809 entries in 164 pages
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU event tracing is enabled.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=128.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
> [    0.000000] NR_IRQS: 16640, nr_irqs: 5800, preallocated irqs: 16
> [    0.000000] spurious 8259A interrupt: IRQ7.
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] console [ttyS1] enabled
> [    0.000000] ACPI: Core revision 20180810
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.000000] hpet clockevent registered
> [    0.000000] APIC: Switch to symmetric I/O mode setup
> [    0.001000] Switched APIC routing to physical flat.
> [    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.011000] tsc: PIT calibration matches HPET. 2 loops
> [    0.012000] tsc: Detected 2199.727 MHz processor
> [    0.000011] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fb530ff3a9, max_idle_ns: 440795312110 ns
> [    0.011738] Calibrating delay loop (skipped), value calculated using timer frequency.. 4399.45 BogoMIPS (lpj=2199727)
> [    0.012738] pid_max: default: 131072 minimum: 1024
> [    0.076267] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes)
> [    0.107119] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes)
> [    0.108806] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.110856] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.113471] mce: CPU supports 23 MCE banks
> [    0.114749] LVT offset 2 assigned for vector 0xf4
> [    0.115746] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.116737] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
> [    0.117738] Spectre V2 : Mitigation: Full AMD retpoline
> [    0.118737] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.119737] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.120737] Spectre V2 : User space: Vulnerable
> [    0.121738] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.122980] Freeing SMP alternatives memory: 44K
> [    0.126736] smpboot: CPU0: AMD EPYC 7601 32-Core Processor (family: 0x17, model: 0x1, stepping: 0x2)
> [    0.126912] Performance Events: Fam17h core perfctr, AMD PMU driver.
> [    0.127739] ... version:                0
> [    0.128737] ... bit width:              48
> [    0.129737] ... generic registers:      6
> [    0.130737] ... value mask:             0000ffffffffffff
> [    0.131737] ... max period:             00007fffffffffff
> [    0.132737] ... fixed-purpose events:   0
> [    0.133737] ... event mask:             000000000000003f
> [    0.134866] rcu: Hierarchical SRCU implementation.
> [    0.135888] MCE: In-kernel MCE decoding enabled.
> [    0.138834] smp: Bringing up secondary CPUs ...
> [    0.139856] x86: Booting SMP configuration:
> [    0.140738] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7
> [    0.151739] .... node  #1, CPUs:     #8   #9  #10  #11  #12  #13  #14  #15
> [    0.163739] .... node  #2, CPUs:    #16  #17  #18  #19  #20  #21  #22  #23
> [    0.175739] .... node  #3, CPUs:    #24  #25  #26  #27  #28  #29  #30  #31
> [    0.188738] .... node  #4, CPUs:    #32  #33  #34  #35  #36  #37  #38  #39
> [    0.211739] .... node  #5, CPUs:    #40  #41  #42  #43  #44  #45  #46  #47
> [    0.224740] .... node  #6, CPUs:    #48  #49  #50  #51  #52  #53  #54  #55
> [    0.238740] .... node  #7, CPUs:    #56  #57  #58  #59  #60  #61  #62  #63
> [    0.252739] .... node  #0, CPUs:    #64  #65  #66  #67  #68  #69  #70  #71
> [    0.266739] .... node  #1, CPUs:    #72  #73  #74  #75  #76  #77  #78  #79
> [    0.280739] .... node  #2, CPUs:    #80  #81  #82  #83  #84  #85  #86  #87
> [    0.293739] .... node  #3, CPUs:    #88  #89  #90  #91  #92  #93  #94  #95
> [    0.307738] .... node  #4, CPUs:    #96  #97  #98  #99 #100 #101 #102 #103
> [    0.322740] .... node  #5, CPUs:   #104 #105 #106 #107 #108 #109 #110 #111
> [    0.336739] .... node  #6, CPUs:   #112 #113 #114 #115 #116 #117 #118 #119
> [    0.351739] .... node  #7, CPUs:   #120 #121 #122 #123 #124 #125 #126 #127
> [    0.366090] smp: Brought up 8 nodes, 128 CPUs
> [    0.367738] smpboot: Max logical packages: 2
> [    0.368749] smpboot: Total of 128 processors activated (561534.84 BogoMIPS)
> [    0.424551] devtmpfs: initialized
> [    0.425119] PM: Registering ACPI NVS region [mem 0xc9e85000-0xca210fff] (3719168 bytes)
> [    0.427247] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.427862] futex hash table entries: 32768 (order: 9, 2097152 bytes)
> [    0.430174] xor: automatically using best checksumming function   avx       
> [    0.433072] NET: Registered protocol family 16
> [    0.435219] cpuidle: using governor ladder
> [    0.441227] ACPI: bus type PCI registered
> [    0.444795] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.454741] PCI: not using MMCONFIG
> [    0.458738] PCI: Using configuration type 1 for base access
> [    0.463737] PCI: Using configuration type 1 for extended access
> [    0.479529] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.504586] raid6: sse2x1   gen()  6148 MB/s
> [    0.525584] raid6: sse2x1   xor()  5927 MB/s
> [    0.546584] raid6: sse2x2   gen() 12933 MB/s
> [    0.567585] raid6: sse2x2   xor()  8167 MB/s
> [    0.588585] raid6: sse2x4   gen() 13082 MB/s
> [    0.609584] raid6: sse2x4   xor()  7277 MB/s
> [    0.630584] raid6: avx2x1   gen() 15167 MB/s
> [    0.651585] raid6: avx2x1   xor() 10974 MB/s
> [    0.672584] raid6: avx2x2   gen() 20281 MB/s
> [    0.693585] raid6: avx2x2   xor() 11878 MB/s
> [    0.714585] raid6: avx2x4   gen() 20710 MB/s
> [    0.735584] raid6: avx2x4   xor()  9943 MB/s
> [    0.739737] raid6: using algorithm avx2x4 gen() 20710 MB/s
> [    0.745737] raid6: .... xor() 9943 MB/s, rmw enabled
> [    0.750737] raid6: using avx2x2 recovery algorithm
> [    0.756274] ACPI: Added _OSI(Module Device)
> [    0.760738] ACPI: Added _OSI(Processor Device)
> [    0.764737] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.769737] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.774737] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.779737] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.805434] ACPI: 6 ACPI AML tables successfully acquired and loaded
> [    0.819689] ACPI: Interpreter enabled
> [    0.822753] ACPI: (supports S0 S5)
> [    0.826737] ACPI: Using IOAPIC for interrupt routing
> [    0.832029] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.841789] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in ACPI motherboard resources
> [    0.850751] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.860183] ACPI: Enabled 2 GPEs in block 00 to 1F
> [    0.868793] ACPI: Power Resource [P0SA] (off)
> [    0.872766] ACPI: Power Resource [P3SA] (off)
> [    0.881879] ACPI: Power Resource [P0SA] (off)
> [    0.885767] ACPI: Power Resource [P3SA] (off)
> [    0.892098] ACPI: Power Resource [P0SA] (off)
> [    0.896762] ACPI: Power Resource [P3SA] (off)
> [    0.902635] ACPI: Power Resource [P0SA] (off)
> [    0.906764] ACPI: Power Resource [P3SA] (off)
> [    0.912765] ACPI: Power Resource [P0SA] (off)
> [    0.916765] ACPI: Power Resource [P3SA] (off)
> [    0.922990] ACPI: Power Resource [P0SA] (off)
> [    0.926765] ACPI: Power Resource [P3SA] (off)
> [    0.933219] ACPI: Power Resource [P0SA] (off)
> [    0.937763] ACPI: Power Resource [P3SA] (off)
> [    0.943381] ACPI: Power Resource [P0SA] (off)
> [    0.947764] ACPI: Power Resource [P3SA] (off)
> [    0.955885] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-0f])
> [    0.961741] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.970770] acpi PNP0A08:00: _OSC: platform does not support [AER LTR]
> [    0.976904] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
> [    0.983939] PCI host bridge to bus 0000:00
> [    0.988741] pci_bus 0000:00: root bus resource [io  0x0000-0x02ff window]
> [    0.995738] pci_bus 0000:00: root bus resource [io  0x0300-0x03af window]
> [    1.002738] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [    1.008738] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
> [    1.015739] pci_bus 0000:00: root bus resource [io  0x0d00-0x1fff window]
> [    1.022738] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    1.030738] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
> [    1.038738] pci_bus 0000:00: root bus resource [mem 0xec000000-0xefffffff window]
> [    1.045738] pci_bus 0000:00: root bus resource [mem 0x1e006000000-0x1ffffffffff window]
> [    1.054738] pci_bus 0000:00: root bus resource [bus 00-0f]
> [    1.059745] pci 0000:00:00.0: [1022:1450] type 00 class 0x060000
> [    1.059837] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
> [    1.059910] pci 0000:00:01.3: [1022:1453] type 01 class 0x060400
> [    1.060033] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
> [    1.060122] pci 0000:00:01.4: [1022:1453] type 01 class 0x060400
> [    1.060822] pci 0000:00:01.4: PME# supported from D0 D3hot D3cold
> [    1.060911] pci 0000:00:01.6: [1022:1453] type 01 class 0x060400
> [    1.061798] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
> [    1.061885] pci 0000:00:02.0: [1022:1452] type 00 class 0x060000
> [    1.061965] pci 0000:00:03.0: [1022:1452] type 00 class 0x060000
> [    1.062740] pci 0000:00:04.0: [1022:1452] type 00 class 0x060000
> [    1.062823] pci 0000:00:07.0: [1022:1452] type 00 class 0x060000
> [    1.062887] pci 0000:00:07.1: [1022:1454] type 01 class 0x060400
> [    1.063445] pci 0000:00:07.1: enabling Extended Tags
> [    1.067819] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
> [    1.067918] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
> [    1.068794] pci 0000:00:08.1: [1022:1454] type 01 class 0x060400
> [    1.069434] pci 0000:00:08.1: enabling Extended Tags
> [    1.073820] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [    1.074745] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [    1.074958] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [    1.075184] pci 0000:00:18.0: [1022:1460] type 00 class 0x060000
> [    1.075234] pci 0000:00:18.1: [1022:1461] type 00 class 0x060000
> [    1.075287] pci 0000:00:18.2: [1022:1462] type 00 class 0x060000
> [    1.075339] pci 0000:00:18.3: [1022:1463] type 00 class 0x060000
> [    1.075389] pci 0000:00:18.4: [1022:1464] type 00 class 0x060000
> [    1.075438] pci 0000:00:18.5: [1022:1465] type 00 class 0x060000
> [    1.075489] pci 0000:00:18.6: [1022:1466] type 00 class 0x060000
> [    1.075541] pci 0000:00:18.7: [1022:1467] type 00 class 0x060000
> [    1.075591] pci 0000:00:19.0: [1022:1460] type 00 class 0x060000
> [    1.075656] pci 0000:00:19.1: [1022:1461] type 00 class 0x060000
> [    1.075712] pci 0000:00:19.2: [1022:1462] type 00 class 0x060000
> [    1.075770] pci 0000:00:19.3: [1022:1463] type 00 class 0x060000
> [    1.075825] pci 0000:00:19.4: [1022:1464] type 00 class 0x060000
> [    1.075878] pci 0000:00:19.5: [1022:1465] type 00 class 0x060000
> [    1.075934] pci 0000:00:19.6: [1022:1466] type 00 class 0x060000
> [    1.075989] pci 0000:00:19.7: [1022:1467] type 00 class 0x060000
> [    1.076044] pci 0000:00:1a.0: [1022:1460] type 00 class 0x060000
> [    1.076102] pci 0000:00:1a.1: [1022:1461] type 00 class 0x060000
> [    1.076156] pci 0000:00:1a.2: [1022:1462] type 00 class 0x060000
> [    1.076210] pci 0000:00:1a.3: [1022:1463] type 00 class 0x060000
> [    1.076263] pci 0000:00:1a.4: [1022:1464] type 00 class 0x060000
> [    1.076317] pci 0000:00:1a.5: [1022:1465] type 00 class 0x060000
> [    1.076375] pci 0000:00:1a.6: [1022:1466] type 00 class 0x060000
> [    1.076436] pci 0000:00:1a.7: [1022:1467] type 00 class 0x060000
> [    1.076489] pci 0000:00:1b.0: [1022:1460] type 00 class 0x060000
> [    1.076552] pci 0000:00:1b.1: [1022:1461] type 00 class 0x060000
> [    1.076606] pci 0000:00:1b.2: [1022:1462] type 00 class 0x060000
> [    1.076660] pci 0000:00:1b.3: [1022:1463] type 00 class 0x060000
> [    1.076715] pci 0000:00:1b.4: [1022:1464] type 00 class 0x060000
> [    1.076773] pci 0000:00:1b.5: [1022:1465] type 00 class 0x060000
> [    1.076830] pci 0000:00:1b.6: [1022:1466] type 00 class 0x060000
> [    1.076885] pci 0000:00:1b.7: [1022:1467] type 00 class 0x060000
> [    1.076939] pci 0000:00:1c.0: [1022:1460] type 00 class 0x060000
> [    1.077001] pci 0000:00:1c.1: [1022:1461] type 00 class 0x060000
> [    1.077064] pci 0000:00:1c.2: [1022:1462] type 00 class 0x060000
> [    1.077128] pci 0000:00:1c.3: [1022:1463] type 00 class 0x060000
> [    1.077190] pci 0000:00:1c.4: [1022:1464] type 00 class 0x060000
> [    1.077252] pci 0000:00:1c.5: [1022:1465] type 00 class 0x060000
> [    1.077317] pci 0000:00:1c.6: [1022:1466] type 00 class 0x060000
> [    1.077385] pci 0000:00:1c.7: [1022:1467] type 00 class 0x060000
> [    1.077449] pci 0000:00:1d.0: [1022:1460] type 00 class 0x060000
> [    1.077513] pci 0000:00:1d.1: [1022:1461] type 00 class 0x060000
> [    1.077576] pci 0000:00:1d.2: [1022:1462] type 00 class 0x060000
> [    1.077638] pci 0000:00:1d.3: [1022:1463] type 00 class 0x060000
> [    1.077700] pci 0000:00:1d.4: [1022:1464] type 00 class 0x060000
> [    1.077765] pci 0000:00:1d.5: [1022:1465] type 00 class 0x060000
> [    1.077829] pci 0000:00:1d.6: [1022:1466] type 00 class 0x060000
> [    1.077893] pci 0000:00:1d.7: [1022:1467] type 00 class 0x060000
> [    1.077956] pci 0000:00:1e.0: [1022:1460] type 00 class 0x060000
> [    1.078019] pci 0000:00:1e.1: [1022:1461] type 00 class 0x060000
> [    1.078078] pci 0000:00:1e.2: [1022:1462] type 00 class 0x060000
> [    1.078139] pci 0000:00:1e.3: [1022:1463] type 00 class 0x060000
> [    1.078197] pci 0000:00:1e.4: [1022:1464] type 00 class 0x060000
> [    1.078255] pci 0000:00:1e.5: [1022:1465] type 00 class 0x060000
> [    1.078315] pci 0000:00:1e.6: [1022:1466] type 00 class 0x060000
> [    1.078372] pci 0000:00:1e.7: [1022:1467] type 00 class 0x060000
> [    1.078431] pci 0000:00:1f.0: [1022:1460] type 00 class 0x060000
> [    1.078494] pci 0000:00:1f.1: [1022:1461] type 00 class 0x060000
> [    1.078557] pci 0000:00:1f.2: [1022:1462] type 00 class 0x060000
> [    1.078622] pci 0000:00:1f.3: [1022:1463] type 00 class 0x060000
> [    1.078683] pci 0000:00:1f.4: [1022:1464] type 00 class 0x060000
> [    1.078749] pci 0000:00:1f.5: [1022:1465] type 00 class 0x060000
> [    1.078812] pci 0000:00:1f.6: [1022:1466] type 00 class 0x060000
> [    1.078875] pci 0000:00:1f.7: [1022:1467] type 00 class 0x060000
> [    1.079488] pci 0000:01:00.0: [1b21:1142] type 00 class 0x0c0330
> [    1.079519] pci 0000:01:00.0: reg 0x10: [mem 0xef800000-0xef807fff 64bit]
> [    1.079636] pci 0000:01:00.0: PME# supported from D3cold
> [    1.079724] pci 0000:00:01.3: PCI bridge to [bus 01]
> [    1.084741] pci 0000:00:01.3:   bridge window [mem 0xef800000-0xef8fffff]
> [    1.085439] pci 0000:02:00.0: [1b21:1142] type 00 class 0x0c0330
> [    1.085469] pci 0000:02:00.0: reg 0x10: [mem 0xef700000-0xef707fff 64bit]
> [    1.085584] pci 0000:02:00.0: PME# supported from D3cold
> [    1.085766] pci 0000:00:01.4: PCI bridge to [bus 02]
> [    1.090741] pci 0000:00:01.4:   bridge window [mem 0xef700000-0xef7fffff]
> [    1.091317] pci 0000:03:00.0: [1a03:1150] type 01 class 0x060400
> [    1.091419] pci 0000:03:00.0: supports D1 D2
> [    1.091420] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    1.094756] pci 0000:00:01.6: PCI bridge to [bus 03-04]
> [    1.099742] pci 0000:00:01.6:   bridge window [io  0x1000-0x1fff]
> [    1.099745] pci 0000:00:01.6:   bridge window [mem 0xee000000-0xef0fffff]
> [    1.099784] pci_bus 0000:04: extended config space not accessible
> [    1.105764] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030000
> [    1.105785] pci 0000:04:00.0: reg 0x10: [mem 0xee000000-0xeeffffff]
> [    1.105797] pci 0000:04:00.0: reg 0x14: [mem 0xef000000-0xef01ffff]
> [    1.105808] pci 0000:04:00.0: reg 0x18: [io  0x1000-0x107f]
> [    1.105897] pci 0000:04:00.0: supports D1 D2
> [    1.105898] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    1.105984] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    1.111743] pci 0000:03:00.0:   bridge window [io  0x1000-0x1fff]
> [    1.111746] pci 0000:03:00.0:   bridge window [mem 0xee000000-0xef0fffff]
> [    1.112459] pci 0000:05:00.0: [1022:145a] type 00 class 0x130000
> [    1.112497] pci 0000:05:00.0: enabling Extended Tags
> [    1.117817] pci 0000:05:00.2: [1022:1456] type 00 class 0x108000
> [    1.117837] pci 0000:05:00.2: reg 0x18: [mem 0xef300000-0xef3fffff]
> [    1.117849] pci 0000:05:00.2: reg 0x24: [mem 0xef400000-0xef401fff]
> [    1.117857] pci 0000:05:00.2: enabling Extended Tags
> [    1.122818] pci 0000:05:00.3: [1022:145f] type 00 class 0x0c0330
> [    1.122833] pci 0000:05:00.3: reg 0x10: [mem 0xef200000-0xef2fffff 64bit]
> [    1.122856] pci 0000:05:00.3: enabling Extended Tags
> [    1.127769] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold
> [    1.127842] pci 0000:00:07.1: PCI bridge to [bus 05]
> [    1.132741] pci 0000:00:07.1:   bridge window [mem 0xef200000-0xef4fffff]
> [    1.132972] pci 0000:06:00.0: [1022:1455] type 00 class 0x130000
> [    1.133013] pci 0000:06:00.0: enabling Extended Tags
> [    1.138823] pci 0000:06:00.1: [1022:1468] type 00 class 0x108000
> [    1.138844] pci 0000:06:00.1: reg 0x18: [mem 0xef500000-0xef5fffff]
> [    1.138844] pci 0000:06:00.1: reg 0x24: [mem 0xef600000-0xef601fff]
> [    1.138844] pci 0000:06:00.1: enabling Extended Tags
> [    1.143841] pci 0000:00:08.1: PCI bridge to [bus 06]
> [    1.148741] pci 0000:00:08.1:   bridge window [mem 0xef500000-0xef6fffff]
> [    1.148768] pci_bus 0000:00: on NUMA node 0
> [    1.150201] ACPI: PCI Root Bridge [S0D1] (domain 0000 [bus 10-1f])
> [    1.155740] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.164913] acpi PNP0A08:01: _OSC: platform does not support [AER LTR]
> [    1.171900] acpi PNP0A08:01: _OSC: OS now controls [PME PCIeCapability]
> [    1.178800] PCI host bridge to bus 0000:10
> [    1.182738] pci_bus 0000:10: root bus resource [io  0x2000-0x3fff window]
> [    1.189738] pci_bus 0000:10: root bus resource [mem 0xe9900000-0xebffffff window]
> [    1.197738] pci_bus 0000:10: root bus resource [mem 0x1c00c000000-0x1e005ffffff window]
> [    1.205738] pci_bus 0000:10: root bus resource [bus 10-1f]
> [    1.210742] pci 0000:10:00.0: [1022:1450] type 00 class 0x060000
> [    1.210828] pci 0000:10:01.0: [1022:1452] type 00 class 0x060000
> [    1.210895] pci 0000:10:01.1: [1022:1453] type 01 class 0x060400
> [    1.211830] pci 0000:10:01.1: PME# supported from D0 D3hot D3cold
> [    1.211931] pci 0000:10:02.0: [1022:1452] type 00 class 0x060000
> [    1.212013] pci 0000:10:03.0: [1022:1452] type 00 class 0x060000
> [    1.212092] pci 0000:10:04.0: [1022:1452] type 00 class 0x060000
> [    1.212174] pci 0000:10:07.0: [1022:1452] type 00 class 0x060000
> [    1.212237] pci 0000:10:07.1: [1022:1454] type 01 class 0x060400
> [    1.212740] pci 0000:10:07.1: enabling Extended Tags
> [    1.217822] pci 0000:10:07.1: PME# supported from D0 D3hot D3cold
> [    1.217917] pci 0000:10:08.0: [1022:1452] type 00 class 0x060000
> [    1.217979] pci 0000:10:08.1: [1022:1454] type 01 class 0x060400
> [    1.218015] pci 0000:10:08.1: enabling Extended Tags
> [    1.223796] pci 0000:10:08.1: PME# supported from D0 D3hot D3cold
> [    1.224423] pci 0000:11:00.0: [8086:1521] type 00 class 0x020000
> [    1.225554] pci 0000:11:00.0: reg 0x10: [mem 0xeba80000-0xebafffff]
> [    1.226122] pci 0000:11:00.0: reg 0x18: [io  0x3060-0x307f]
> [    1.226395] pci 0000:11:00.0: reg 0x1c: [mem 0xebb0c000-0xebb0ffff]
> [    1.229704] pci 0000:11:00.0: PME# supported from D0 D3hot D3cold
> [    1.230892] pci 0000:11:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.230894] pci 0000:11:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
> [    1.243289] pci 0000:11:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.243291] pci 0000:11:00.0: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
> [    1.256332] pci 0000:11:00.1: [8086:1521] type 00 class 0x020000
> [    1.257164] pci 0000:11:00.1: reg 0x10: [mem 0xeba00000-0xeba7ffff]
> [    1.257707] pci 0000:11:00.1: reg 0x18: [io  0x3040-0x305f]
> [    1.257969] pci 0000:11:00.1: reg 0x1c: [mem 0xebb08000-0xebb0bfff]
> [    1.261161] pci 0000:11:00.1: PME# supported from D0 D3hot D3cold
> [    1.262195] pci 0000:11:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.262197] pci 0000:11:00.1: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
> [    1.273274] pci 0000:11:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.273276] pci 0000:11:00.1: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
> [    1.286121] pci 0000:11:00.2: [8086:1521] type 00 class 0x020000
> [    1.286970] pci 0000:11:00.2: reg 0x10: [mem 0xeb980000-0xeb9fffff]
> [    1.287511] pci 0000:11:00.2: reg 0x18: [io  0x3020-0x303f]
> [    1.287775] pci 0000:11:00.2: reg 0x1c: [mem 0xebb04000-0xebb07fff]
> [    1.290969] pci 0000:11:00.2: PME# supported from D0 D3hot D3cold
> [    1.292056] pci 0000:11:00.2: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.292059] pci 0000:11:00.2: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
> [    1.303095] pci 0000:11:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.303097] pci 0000:11:00.2: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
> [    1.315931] pci 0000:11:00.3: [8086:1521] type 00 class 0x020000
> [    1.316775] pci 0000:11:00.3: reg 0x10: [mem 0xeb900000-0xeb97ffff]
> [    1.317318] pci 0000:11:00.3: reg 0x18: [io  0x3000-0x301f]
> [    1.317590] pci 0000:11:00.3: reg 0x1c: [mem 0xebb00000-0xebb03fff]
> [    1.320776] pci 0000:11:00.3: PME# supported from D0 D3hot D3cold
> [    1.321893] pci 0000:11:00.3: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.321894] pci 0000:11:00.3: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
> [    1.332969] pci 0000:11:00.3: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
> [    1.332971] pci 0000:11:00.3: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
> [    1.346596] pci 0000:10:01.1: PCI bridge to [bus 11]
> [    1.351741] pci 0000:10:01.1:   bridge window [io  0x3000-0x3fff]
> [    1.351744] pci 0000:10:01.1:   bridge window [mem 0xeb900000-0xebbfffff]
> [    1.352051] pci 0000:12:00.0: [1022:145a] type 00 class 0x130000
> [    1.352094] pci 0000:12:00.0: enabling Extended Tags
> [    1.356823] pci 0000:12:00.2: [1022:1456] type 00 class 0x108000
> [    1.356845] pci 0000:12:00.2: reg 0x18: [mem 0xebe00000-0xebefffff]
> [    1.356860] pci 0000:12:00.2: reg 0x24: [mem 0xebf00000-0xebf01fff]
> [    1.356869] pci 0000:12:00.2: enabling Extended Tags
> [    1.361843] pci 0000:10:07.1: PCI bridge to [bus 12]
> [    1.367742] pci 0000:10:07.1:   bridge window [mem 0xebe00000-0xebffffff]
> [    1.367783] pci 0000:13:00.0: [1022:1455] type 00 class 0x130000
> [    1.367828] pci 0000:13:00.0: enabling Extended Tags
> [    1.372825] pci 0000:13:00.1: [1022:1468] type 00 class 0x108000
> [    1.372849] pci 0000:13:00.1: reg 0x18: [mem 0xebc00000-0xebcfffff]
> [    1.372864] pci 0000:13:00.1: reg 0x24: [mem 0xebd00000-0xebd01fff]
> [    1.372873] pci 0000:13:00.1: enabling Extended Tags
> [    1.377833] pci 0000:13:00.2: [1022:7901] type 00 class 0x010601
> [    1.377870] pci 0000:13:00.2: reg 0x24: [mem 0xebd02000-0xebd02fff]
> [    1.377879] pci 0000:13:00.2: enabling Extended Tags
> [    1.383774] pci 0000:13:00.2: PME# supported from D3hot D3cold
> [    1.383798] pci 0000:10:08.1: PCI bridge to [bus 13]
> [    1.388741] pci 0000:10:08.1:   bridge window [mem 0xebc00000-0xebdfffff]
> [    1.388759] pci_bus 0000:10: on NUMA node 1
> [    1.389094] ACPI: PCI Root Bridge [S0D2] (domain 0000 [bus 20-2f])
> [    1.394740] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.403907] acpi PNP0A08:02: _OSC: platform does not support [AER LTR]
> [    1.410897] acpi PNP0A08:02: _OSC: OS now controls [PME PCIeCapability]
> [    1.417852] PCI host bridge to bus 0000:20
> [    1.421738] pci_bus 0000:20: root bus resource [io  0x4000-0x5fff window]
> [    1.428739] pci_bus 0000:20: root bus resource [mem 0xe7500000-0xe98fffff window]
> [    1.436738] pci_bus 0000:20: root bus resource [mem 0x1a012000000-0x1c00bffffff window]
> [    1.444738] pci_bus 0000:20: root bus resource [bus 20-2f]
> [    1.449743] pci 0000:20:00.0: [1022:1450] type 00 class 0x060000
> [    1.449827] pci 0000:20:01.0: [1022:1452] type 00 class 0x060000
> [    1.449905] pci 0000:20:02.0: [1022:1452] type 00 class 0x060000
> [    1.450773] pci 0000:20:03.0: [1022:1452] type 00 class 0x060000
> [    1.450851] pci 0000:20:04.0: [1022:1452] type 00 class 0x060000
> [    1.450931] pci 0000:20:07.0: [1022:1452] type 00 class 0x060000
> [    1.450993] pci 0000:20:07.1: [1022:1454] type 01 class 0x060400
> [    1.451103] pci 0000:20:07.1: enabling Extended Tags
> [    1.455824] pci 0000:20:07.1: PME# supported from D0 D3hot D3cold
> [    1.455923] pci 0000:20:08.0: [1022:1452] type 00 class 0x060000
> [    1.455990] pci 0000:20:08.1: [1022:1454] type 01 class 0x060400
> [    1.456025] pci 0000:20:08.1: enabling Extended Tags
> [    1.461803] pci 0000:20:08.1: PME# supported from D0 D3hot D3cold
> [    1.462011] pci 0000:21:00.0: [1022:145a] type 00 class 0x130000
> [    1.462054] pci 0000:21:00.0: enabling Extended Tags
> [    1.466817] pci 0000:21:00.2: [1022:1456] type 00 class 0x108000
> [    1.466839] pci 0000:21:00.2: reg 0x18: [mem 0xe9700000-0xe97fffff]
> [    1.466853] pci 0000:21:00.2: reg 0x24: [mem 0xe9800000-0xe9801fff]
> [    1.466862] pci 0000:21:00.2: enabling Extended Tags
> [    1.472838] pci 0000:20:07.1: PCI bridge to [bus 21]
> [    1.477741] pci 0000:20:07.1:   bridge window [mem 0xe9700000-0xe98fffff]
> [    1.477936] pci 0000:22:00.0: [1022:1455] type 00 class 0x130000
> [    1.477981] pci 0000:22:00.0: enabling Extended Tags
> [    1.482827] pci 0000:22:00.1: [1022:1468] type 00 class 0x108000
> [    1.482851] pci 0000:22:00.1: reg 0x18: [mem 0xe9500000-0xe95fffff]
> [    1.482865] pci 0000:22:00.1: reg 0x24: [mem 0xe9600000-0xe9601fff]
> [    1.482875] pci 0000:22:00.1: enabling Extended Tags
> [    1.487855] pci 0000:20:08.1: PCI bridge to [bus 22]
> [    1.493742] pci 0000:20:08.1:   bridge window [mem 0xe9500000-0xe96fffff]
> [    1.493748] pci_bus 0000:20: on NUMA node 2
> [    1.494059] ACPI: PCI Root Bridge [S0D3] (domain 0000 [bus 30-3f])
> [    1.499740] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.508903] acpi PNP0A08:03: _OSC: platform does not support [AER LTR]
> [    1.515745] acpi PNP0A08:03: _OSC: OS now controls [PME PCIeCapability]
> [    1.521885] PCI host bridge to bus 0000:30
> [    1.526740] pci_bus 0000:30: root bus resource [io  0x6000-0x7fff window]
> [    1.533738] pci_bus 0000:30: root bus resource [mem 0xe5100000-0xe74fffff window]
> [    1.540738] pci_bus 0000:30: root bus resource [mem 0x18018000000-0x1a011ffffff window]
> [    1.549738] pci_bus 0000:30: root bus resource [bus 30-3f]
> [    1.554743] pci 0000:30:00.0: [1022:1450] type 00 class 0x060000
> [    1.554827] pci 0000:30:01.0: [1022:1452] type 00 class 0x060000
> [    1.554905] pci 0000:30:02.0: [1022:1452] type 00 class 0x060000
> [    1.554982] pci 0000:30:03.0: [1022:1452] type 00 class 0x060000
> [    1.555057] pci 0000:30:04.0: [1022:1452] type 00 class 0x060000
> [    1.555138] pci 0000:30:07.0: [1022:1452] type 00 class 0x060000
> [    1.555784] pci 0000:30:07.1: [1022:1454] type 01 class 0x060400
> [    1.556247] pci 0000:30:07.1: enabling Extended Tags
> [    1.560822] pci 0000:30:07.1: PME# supported from D0 D3hot D3cold
> [    1.560915] pci 0000:30:08.0: [1022:1452] type 00 class 0x060000
> [    1.560979] pci 0000:30:08.1: [1022:1454] type 01 class 0x060400
> [    1.561014] pci 0000:30:08.1: enabling Extended Tags
> [    1.566804] pci 0000:30:08.1: PME# supported from D0 D3hot D3cold
> [    1.567020] pci 0000:31:00.0: [1022:145a] type 00 class 0x130000
> [    1.567062] pci 0000:31:00.0: enabling Extended Tags
> [    1.572818] pci 0000:31:00.2: [1022:1456] type 00 class 0x108000
> [    1.572818] pci 0000:31:00.2: reg 0x18: [mem 0xe7300000-0xe73fffff]
> [    1.572818] pci 0000:31:00.2: reg 0x24: [mem 0xe7400000-0xe7401fff]
> [    1.572818] pci 0000:31:00.2: enabling Extended Tags
> [    1.577839] pci 0000:30:07.1: PCI bridge to [bus 31]
> [    1.582742] pci 0000:30:07.1:   bridge window [mem 0xe7300000-0xe74fffff]
> [    1.582932] pci 0000:32:00.0: [1022:1455] type 00 class 0x130000
> [    1.582977] pci 0000:32:00.0: enabling Extended Tags
> [    1.587825] pci 0000:32:00.1: [1022:1468] type 00 class 0x108000
> [    1.587849] pci 0000:32:00.1: reg 0x18: [mem 0xe7100000-0xe71fffff]
> [    1.587864] pci 0000:32:00.1: reg 0x24: [mem 0xe7200000-0xe7201fff]
> [    1.587874] pci 0000:32:00.1: enabling Extended Tags
> [    1.593767] pci 0000:30:08.1: PCI bridge to [bus 32]
> [    1.598741] pci 0000:30:08.1:   bridge window [mem 0xe7100000-0xe72fffff]
> [    1.598754] pci_bus 0000:30: on NUMA node 3
> [    1.599073] ACPI: PCI Root Bridge [S1D0] (domain 0000 [bus 40-4f])
> [    1.604741] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.613905] acpi PNP0A08:04: _OSC: platform does not support [AER LTR]
> [    1.620891] acpi PNP0A08:04: _OSC: OS now controls [PME PCIeCapability]
> [    1.627793] PCI host bridge to bus 0000:40
> [    1.631738] pci_bus 0000:40: root bus resource [io  0x8000-0x9fff window]
> [    1.638738] pci_bus 0000:40: root bus resource [mem 0xe2d00000-0xe50fffff window]
> [    1.646738] pci_bus 0000:40: root bus resource [mem 0x1601e000000-0x18017ffffff window]
> [    1.654740] pci_bus 0000:40: root bus resource [bus 40-4f]
> [    1.659743] pci 0000:40:00.0: [1022:1450] type 00 class 0x060000
> [    1.659835] pci 0000:40:01.0: [1022:1452] type 00 class 0x060000
> [    1.659922] pci 0000:40:02.0: [1022:1452] type 00 class 0x060000
> [    1.660739] pci 0000:40:03.0: [1022:1452] type 00 class 0x060000
> [    1.660825] pci 0000:40:04.0: [1022:1452] type 00 class 0x060000
> [    1.660916] pci 0000:40:07.0: [1022:1452] type 00 class 0x060000
> [    1.660987] pci 0000:40:07.1: [1022:1454] type 01 class 0x060400
> [    1.661361] pci 0000:40:07.1: enabling Extended Tags
> [    1.665832] pci 0000:40:07.1: PME# supported from D0 D3hot D3cold
> [    1.665931] pci 0000:40:08.0: [1022:1452] type 00 class 0x060000
> [    1.666008] pci 0000:40:08.1: [1022:1454] type 01 class 0x060400
> [    1.667369] pci 0000:40:08.1: enabling Extended Tags
> [    1.671832] pci 0000:40:08.1: PME# supported from D0 D3hot D3cold
> [    1.672783] pci 0000:41:00.0: [1022:145a] type 00 class 0x130000
> [    1.672836] pci 0000:41:00.0: enabling Extended Tags
> [    1.677836] pci 0000:41:00.2: [1022:1456] type 00 class 0x108000
> [    1.677863] pci 0000:41:00.2: reg 0x18: [mem 0xe4f00000-0xe4ffffff]
> [    1.677880] pci 0000:41:00.2: reg 0x24: [mem 0xe5000000-0xe5001fff]
> [    1.677891] pci 0000:41:00.2: enabling Extended Tags
> [    1.683860] pci 0000:40:07.1: PCI bridge to [bus 41]
> [    1.688742] pci 0000:40:07.1:   bridge window [mem 0xe4f00000-0xe50fffff]
> [    1.689108] pci 0000:42:00.0: [1022:1455] type 00 class 0x130000
> [    1.689163] pci 0000:42:00.0: enabling Extended Tags
> [    1.693841] pci 0000:42:00.1: [1022:1468] type 00 class 0x108000
> [    1.693869] pci 0000:42:00.1: reg 0x18: [mem 0xe4d00000-0xe4dfffff]
> [    1.693887] pci 0000:42:00.1: reg 0x24: [mem 0xe4e00000-0xe4e01fff]
> [    1.693898] pci 0000:42:00.1: enabling Extended Tags
> [    1.699845] pci 0000:42:00.2: [1022:7901] type 00 class 0x010601
> [    1.699890] pci 0000:42:00.2: reg 0x24: [mem 0xe4e02000-0xe4e02fff]
> [    1.699901] pci 0000:42:00.2: enabling Extended Tags
> [    1.704782] pci 0000:42:00.2: PME# supported from D3hot D3cold
> [    1.704876] pci 0000:40:08.1: PCI bridge to [bus 42]
> [    1.709742] pci 0000:40:08.1:   bridge window [mem 0xe4d00000-0xe4efffff]
> [    1.709758] pci_bus 0000:40: on NUMA node 4
> [    1.710072] ACPI: PCI Root Bridge [S1D1] (domain 0000 [bus 50-5f])
> [    1.716740] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.724906] acpi PNP0A08:05: _OSC: platform does not support [AER LTR]
> [    1.731896] acpi PNP0A08:05: _OSC: OS now controls [PME PCIeCapability]
> [    1.738885] PCI host bridge to bus 0000:50
> [    1.742739] pci_bus 0000:50: root bus resource [io  0xa000-0xbfff window]
> [    1.749739] pci_bus 0000:50: root bus resource [mem 0xe0900000-0xe2cfffff window]
> [    1.758011] pci_bus 0000:50: root bus resource [mem 0x14024000000-0x1601dffffff window]
> [    1.765739] pci_bus 0000:50: root bus resource [bus 50-5f]
> [    1.771743] pci 0000:50:00.0: [1022:1450] type 00 class 0x060000
> [    1.771838] pci 0000:50:01.0: [1022:1452] type 00 class 0x060000
> [    1.771927] pci 0000:50:02.0: [1022:1452] type 00 class 0x060000
> [    1.772013] pci 0000:50:03.0: [1022:1452] type 00 class 0x060000
> [    1.772096] pci 0000:50:04.0: [1022:1452] type 00 class 0x060000
> [    1.772189] pci 0000:50:07.0: [1022:1452] type 00 class 0x060000
> [    1.772261] pci 0000:50:07.1: [1022:1454] type 01 class 0x060400
> [    1.772308] pci 0000:50:07.1: enabling Extended Tags
> [    1.777840] pci 0000:50:07.1: PME# supported from D0 D3hot D3cold
> [    1.777840] pci 0000:50:08.0: [1022:1452] type 00 class 0x060000
> [    1.777886] pci 0000:50:08.1: [1022:1454] type 01 class 0x060400
> [    1.778296] pci 0000:50:08.1: enabling Extended Tags
> [    1.782835] pci 0000:50:08.1: PME# supported from D0 D3hot D3cold
> [    1.783055] pci 0000:51:00.0: [1022:145a] type 00 class 0x130000
> [    1.783767] pci 0000:51:00.0: enabling Extended Tags
> [    1.788833] pci 0000:51:00.2: [1022:1456] type 00 class 0x108000
> [    1.788860] pci 0000:51:00.2: reg 0x18: [mem 0xe2b00000-0xe2bfffff]
> [    1.788877] pci 0000:51:00.2: reg 0x24: [mem 0xe2c00000-0xe2c01fff]
> [    1.788888] pci 0000:51:00.2: enabling Extended Tags
> [    1.793861] pci 0000:50:07.1: PCI bridge to [bus 51]
> [    1.798742] pci 0000:50:07.1:   bridge window [mem 0xe2b00000-0xe2cfffff]
> [    1.798818] pci 0000:52:00.0: [1022:1455] type 00 class 0x130000
> [    1.798873] pci 0000:52:00.0: enabling Extended Tags
> [    1.803840] pci 0000:52:00.1: [1022:1468] type 00 class 0x108000
> [    1.803869] pci 0000:52:00.1: reg 0x18: [mem 0xe2900000-0xe29fffff]
> [    1.803887] pci 0000:52:00.1: reg 0x24: [mem 0xe2a00000-0xe2a01fff]
> [    1.804738] pci 0000:52:00.1: enabling Extended Tags
> [    1.809871] pci 0000:50:08.1: PCI bridge to [bus 52]
> [    1.814742] pci 0000:50:08.1:   bridge window [mem 0xe2900000-0xe2afffff]
> [    1.814759] pci_bus 0000:50: on NUMA node 5
> [    1.815056] ACPI: PCI Root Bridge [S1D2] (domain 0000 [bus 60-6f])
> [    1.821740] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.829906] acpi PNP0A08:06: _OSC: platform does not support [AER LTR]
> [    1.836896] acpi PNP0A08:06: _OSC: OS now controls [PME PCIeCapability]
> [    1.843881] PCI host bridge to bus 0000:60
> [    1.847738] pci_bus 0000:60: root bus resource [io  0xc000-0xdfff window]
> [    1.854738] pci_bus 0000:60: root bus resource [mem 0xde200000-0xe08fffff window]
> [    1.862739] pci_bus 0000:60: root bus resource [mem 0x1202a000000-0x14023ffffff window]
> [    1.870740] pci_bus 0000:60: root bus resource [bus 60-6f]
> [    1.876744] pci 0000:60:00.0: [1022:1450] type 00 class 0x060000
> [    1.876744] pci 0000:60:01.0: [1022:1452] type 00 class 0x060000
> [    1.876826] pci 0000:60:02.0: [1022:1452] type 00 class 0x060000
> [    1.876908] pci 0000:60:03.0: [1022:1452] type 00 class 0x060000
> [    1.876977] pci 0000:60:03.1: [1022:1453] type 01 class 0x060400
> [    1.877175] pci 0000:60:03.1: PME# supported from D0 D3hot D3cold
> [    1.877275] pci 0000:60:04.0: [1022:1452] type 00 class 0x060000
> [    1.877364] pci 0000:60:07.0: [1022:1452] type 00 class 0x060000
> [    1.877431] pci 0000:60:07.1: [1022:1454] type 01 class 0x060400
> [    1.877468] pci 0000:60:07.1: enabling Extended Tags
> [    1.882808] pci 0000:60:07.1: PME# supported from D0 D3hot D3cold
> [    1.882908] pci 0000:60:08.0: [1022:1452] type 00 class 0x060000
> [    1.882978] pci 0000:60:08.1: [1022:1454] type 01 class 0x060400
> [    1.883017] pci 0000:60:08.1: enabling Extended Tags
> [    1.887830] pci 0000:60:08.1: PME# supported from D0 D3hot D3cold
> [    1.888953] pci 0000:61:00.0: [8086:10fb] type 00 class 0x020000
> [    1.888979] pci 0000:61:00.0: reg 0x10: [mem 0xe0380000-0xe03fffff 64bit]
> [    1.888988] pci 0000:61:00.0: reg 0x18: [io  0xd020-0xd03f]
> [    1.889007] pci 0000:61:00.0: reg 0x20: [mem 0xe0404000-0xe0407fff 64bit]
> [    1.889016] pci 0000:61:00.0: reg 0x30: [mem 0xe0300000-0xe037ffff pref]
> [    1.889075] pci 0000:61:00.0: PME# supported from D0 D3hot
> [    1.889109] pci 0000:61:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
> [    1.889111] pci 0000:61:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
> [    1.898755] pci 0000:61:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
> [    1.898756] pci 0000:61:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
> [    1.909796] pci 0000:61:00.1: [8086:10fb] type 00 class 0x020000
> [    1.909821] pci 0000:61:00.1: reg 0x10: [mem 0xe0280000-0xe02fffff 64bit]
> [    1.909830] pci 0000:61:00.1: reg 0x18: [io  0xd000-0xd01f]
> [    1.909849] pci 0000:61:00.1: reg 0x20: [mem 0xe0400000-0xe0403fff 64bit]
> [    1.909857] pci 0000:61:00.1: reg 0x30: [mem 0xe0200000-0xe027ffff pref]
> [    1.909917] pci 0000:61:00.1: PME# supported from D0 D3hot
> [    1.909945] pci 0000:61:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
> [    1.909947] pci 0000:61:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
> [    1.919755] pci 0000:61:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
> [    1.919757] pci 0000:61:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
> [    1.929980] pci 0000:60:03.1: PCI bridge to [bus 61]
> [    1.934741] pci 0000:60:03.1:   bridge window [io  0xd000-0xdfff]
> [    1.934743] pci 0000:60:03.1:   bridge window [mem 0xe0200000-0xe04fffff]
> [    1.934815] pci 0000:62:00.0: [1022:145a] type 00 class 0x130000
> [    1.934863] pci 0000:62:00.0: enabling Extended Tags
> [    1.940827] pci 0000:62:00.2: [1022:1456] type 00 class 0x108000
> [    1.940852] pci 0000:62:00.2: reg 0x18: [mem 0xe0700000-0xe07fffff]
> [    1.940867] pci 0000:62:00.2: reg 0x24: [mem 0xe0800000-0xe0801fff]
> [    1.940867] pci 0000:62:00.2: enabling Extended Tags
> [    1.945852] pci 0000:60:07.1: PCI bridge to [bus 62]
> [    1.950742] pci 0000:60:07.1:   bridge window [mem 0xe0700000-0xe08fffff]
> [    1.950819] pci 0000:63:00.0: [1022:1455] type 00 class 0x130000
> [    1.950869] pci 0000:63:00.0: enabling Extended Tags
> [    1.955831] pci 0000:63:00.1: [1022:1468] type 00 class 0x108000
> [    1.955857] pci 0000:63:00.1: reg 0x18: [mem 0xe0500000-0xe05fffff]
> [    1.955874] pci 0000:63:00.1: reg 0x24: [mem 0xe0600000-0xe0601fff]
> [    1.955884] pci 0000:63:00.1: enabling Extended Tags
> [    1.960864] pci 0000:60:08.1: PCI bridge to [bus 63]
> [    1.966742] pci 0000:60:08.1:   bridge window [mem 0xe0500000-0xe06fffff]
> [    1.966761] pci_bus 0000:60: on NUMA node 6
> [    1.967059] ACPI: PCI Root Bridge [S1D3] (domain 0000 [bus 70-ff])
> [    1.972740] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    1.981906] acpi PNP0A08:07: _OSC: platform does not support [AER LTR]
> [    1.988777] acpi PNP0A08:07: _OSC: OS now controls [PME PCIeCapability]
> [    1.994751] acpi PNP0A08:07: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-7f] only partially covers this bridge
> [    2.005874] PCI host bridge to bus 0000:70
> [    2.010738] pci_bus 0000:70: root bus resource [io  0xe000-0xffff window]
> [    2.016739] pci_bus 0000:70: root bus resource [mem 0xdbe00000-0xde1fffff window]
> [    2.024738] pci_bus 0000:70: root bus resource [mem 0x10030000000-0x12029ffffff window]
> [    2.032738] pci_bus 0000:70: root bus resource [bus 70-ff]
> [    2.038742] pci 0000:70:00.0: [1022:1450] type 00 class 0x060000
> [    2.038834] pci 0000:70:01.0: [1022:1452] type 00 class 0x060000
> [    2.038918] pci 0000:70:02.0: [1022:1452] type 00 class 0x060000
> [    2.039004] pci 0000:70:03.0: [1022:1452] type 00 class 0x060000
> [    2.039089] pci 0000:70:04.0: [1022:1452] type 00 class 0x060000
> [    2.039181] pci 0000:70:07.0: [1022:1452] type 00 class 0x060000
> [    2.039252] pci 0000:70:07.1: [1022:1454] type 01 class 0x060400
> [    2.039741] pci 0000:70:07.1: enabling Extended Tags
> [    2.044844] pci 0000:70:07.1: PME# supported from D0 D3hot D3cold
> [    2.044942] pci 0000:70:08.0: [1022:1452] type 00 class 0x060000
> [    2.045013] pci 0000:70:08.1: [1022:1454] type 01 class 0x060400
> [    2.045054] pci 0000:70:08.1: enabling Extended Tags
> [    2.050811] pci 0000:70:08.1: PME# supported from D0 D3hot D3cold
> [    2.051030] pci 0000:71:00.0: [1022:145a] type 00 class 0x130000
> [    2.051081] pci 0000:71:00.0: enabling Extended Tags
> [    2.055836] pci 0000:71:00.2: [1022:1456] type 00 class 0x108000
> [    2.055863] pci 0000:71:00.2: reg 0x18: [mem 0xde000000-0xde0fffff]
> [    2.055879] pci 0000:71:00.2: reg 0x24: [mem 0xde100000-0xde101fff]
> [    2.055890] pci 0000:71:00.2: enabling Extended Tags
> [    2.061859] pci 0000:70:07.1: PCI bridge to [bus 71]
> [    2.066742] pci 0000:70:07.1:   bridge window [mem 0xde000000-0xde1fffff]
> [    2.066865] pci 0000:72:00.0: [1022:1455] type 00 class 0x130000
> [    2.066918] pci 0000:72:00.0: enabling Extended Tags
> [    2.071839] pci 0000:72:00.1: [1022:1468] type 00 class 0x108000
> [    2.071867] pci 0000:72:00.1: reg 0x18: [mem 0xdde00000-0xddefffff]
> [    2.071884] pci 0000:72:00.1: reg 0x24: [mem 0xddf00000-0xddf01fff]
> [    2.071895] pci 0000:72:00.1: enabling Extended Tags
> [    2.076866] pci 0000:70:08.1: PCI bridge to [bus 72]
> [    2.082743] pci 0000:70:08.1:   bridge window [mem 0xdde00000-0xddffffff]
> [    2.082758] pci_bus 0000:70: on NUMA node 7
> [    2.083042] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 *11 14 15)
> [    2.089800] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 *5 7 10 11 14 15)
> [    2.095791] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 *10 11 14 15)
> [    2.102804] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 *5 7 10 11 14 15)
> [    2.108797] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 *11 14 15)
> [    2.115786] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 *10 11 14 15)
> [    2.122787] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 *11 14 15)
> [    2.128788] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 *10 11 14 15)
> [    2.136293] pci 0000:04:00.0: vgaarb: setting as boot VGA device
> [    2.136736] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    2.150754] pci 0000:04:00.0: vgaarb: bridge control possible
> [    2.156737] vgaarb: loaded
> [    2.159816] SCSI subsystem initialized
> [    2.164270] libata version 3.00 loaded.
> [    2.164270] ACPI: bus type USB registered
> [    2.168740] usbcore: registered new interface driver usbfs
> [    2.173746] usbcore: registered new interface driver hub
> [    2.180395] usbcore: registered new device driver usb
> [    2.184755] pps_core: LinuxPPS API ver. 1 registered
> [    2.190737] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    2.199741] PTP clock support registered
> [    2.204736] EDAC MC: Ver: 3.0.0
> [    2.208528] Advanced Linux Sound Architecture Driver Initialized.
> [    2.214750] PCI: Using ACPI for IRQ routing
> [    2.227378] PCI: pci_cache_line_size set to 64 bytes
> [    2.227921] e820: reserve RAM buffer [mem 0x00099800-0x0009ffff]
> [    2.227923] e820: reserve RAM buffer [mem 0x76db0000-0x77ffffff]
> [    2.227924] e820: reserve RAM buffer [mem 0xc9d5f000-0xcbffffff]
> [    2.227925] e820: reserve RAM buffer [mem 0xc9e85000-0xcbffffff]
> [    2.227926] e820: reserve RAM buffer [mem 0x202f380000-0x202fffffff]
> [    2.227927] e820: reserve RAM buffer [mem 0x402ff80000-0x402fffffff]
> [    2.227928] e820: reserve RAM buffer [mem 0x602ff80000-0x602fffffff]
> [    2.227929] e820: reserve RAM buffer [mem 0x802ff80000-0x802fffffff]
> [    2.227930] e820: reserve RAM buffer [mem 0xa02ff80000-0xa02fffffff]
> [    2.227930] e820: reserve RAM buffer [mem 0xc02ff80000-0xc02fffffff]
> [    2.227931] e820: reserve RAM buffer [mem 0xe02ff80000-0xe02fffffff]
> [    2.227932] e820: reserve RAM buffer [mem 0x1002ff80000-0x1002fffffff]
> [    2.228233] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    2.234739] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    2.243156] clocksource: Switched to clocksource tsc-early
> [    2.264686] VFS: Disk quotas dquot_6.6.0
> [    2.268819] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    2.276030] FS-Cache: Loaded
> [    2.279159] CacheFiles: Loaded
> [    2.282358] pnp: PnP ACPI init
> [    2.285863] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
> [    2.292619] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    2.292879] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    2.293202] system 00:02: [io  0x0a00-0x0a0f] has been reserved
> [    2.299263] system 00:02: [io  0x0a10-0x0a1f] has been reserved
> [    2.305323] system 00:02: [io  0x0a20-0x0a2f] has been reserved
> [    2.311381] system 00:02: [io  0x0a30-0x0a3f] has been reserved
> [    2.317441] system 00:02: [io  0x0a40-0x0a4f] has been reserved
> [    2.323505] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    2.323744] pnp 00:03: [dma 0 disabled]
> [    2.323789] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [    2.324008] pnp 00:04: [dma 0 disabled]
> [    2.324052] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
> [    2.324436] system 00:05: [io  0x04d0-0x04d1] has been reserved
> [    2.330495] system 00:05: [io  0x040b] has been reserved
> [    2.335947] system 00:05: [io  0x04d6] has been reserved
> [    2.341397] system 00:05: [io  0x0c00-0x0c01] has been reserved
> [    2.347458] system 00:05: [io  0x0c14] has been reserved
> [    2.352908] system 00:05: [io  0x0c50-0x0c51] has been reserved
> [    2.358967] system 00:05: [io  0x0c52] has been reserved
> [    2.364412] system 00:05: [io  0x0c6c] has been reserved
> [    2.369863] system 00:05: [io  0x0c6f] has been reserved
> [    2.375315] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
> [    2.381374] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
> [    2.387433] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
> [    2.393493] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
> [    2.399549] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
> [    2.405608] system 00:05: [io  0x0800-0x089f] has been reserved
> [    2.411668] system 00:05: [io  0x0b00-0x0b0f] has been reserved
> [    2.417725] system 00:05: [io  0x0b20-0x0b3f] has been reserved
> [    2.423794] system 00:05: [io  0x0900-0x090f] has been reserved
> [    2.429853] system 00:05: [io  0x0910-0x091f] has been reserved
> [    2.435913] system 00:05: [io  0xfe00-0xfefe] has been reserved
> [    2.441970] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    2.449068] system 00:05: [mem 0xfec01000-0xfec01fff] has been reserved
> [    2.455822] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
> [    2.462573] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
> [    2.469326] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
> [    2.476426] system 00:05: [mem 0xfed61000-0xfed70fff] has been reserved
> [    2.483178] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
> [    2.489930] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> [    2.496685] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    2.498456] pnp: PnP ACPI: found 6 devices
> [    2.508589] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    2.517716] pci 0000:00:01.3: PCI bridge to [bus 01]
> [    2.522834] pci 0000:00:01.3:   bridge window [mem 0xef800000-0xef8fffff]
> [    2.529769] pci 0000:00:01.4: PCI bridge to [bus 02]
> [    2.534872] pci 0000:00:01.4:   bridge window [mem 0xef700000-0xef7fffff]
> [    2.541802] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    2.546903] pci 0000:03:00.0:   bridge window [io  0x1000-0x1fff]
> [    2.553138] pci 0000:03:00.0:   bridge window [mem 0xee000000-0xef0fffff]
> [    2.560075] pci 0000:00:01.6: PCI bridge to [bus 03-04]
> [    2.565433] pci 0000:00:01.6:   bridge window [io  0x1000-0x1fff]
> [    2.571667] pci 0000:00:01.6:   bridge window [mem 0xee000000-0xef0fffff]
> [    2.578605] pci 0000:00:07.1: PCI bridge to [bus 05]
> [    2.583705] pci 0000:00:07.1:   bridge window [mem 0xef200000-0xef4fffff]
> [    2.590642] pci 0000:00:08.1: PCI bridge to [bus 06]
> [    2.595761] pci 0000:00:08.1:   bridge window [mem 0xef500000-0xef6fffff]
> [    2.602697] pci_bus 0000:00: resource 4 [io  0x0000-0x02ff window]
> [    2.602699] pci_bus 0000:00: resource 5 [io  0x0300-0x03af window]
> [    2.602700] pci_bus 0000:00: resource 6 [io  0x03e0-0x0cf7 window]
> [    2.602702] pci_bus 0000:00: resource 7 [io  0x03b0-0x03df window]
> [    2.602703] pci_bus 0000:00: resource 8 [io  0x0d00-0x1fff window]
> [    2.602705] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
> [    2.602707] pci_bus 0000:00: resource 10 [mem 0x000c0000-0x000dffff window]
> [    2.602708] pci_bus 0000:00: resource 11 [mem 0xec000000-0xefffffff window]
> [    2.602709] pci_bus 0000:00: resource 12 [mem 0x1e006000000-0x1ffffffffff window]
> [    2.602711] pci_bus 0000:01: resource 1 [mem 0xef800000-0xef8fffff]
> [    2.602712] pci_bus 0000:02: resource 1 [mem 0xef700000-0xef7fffff]
> [    2.602714] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
> [    2.602715] pci_bus 0000:03: resource 1 [mem 0xee000000-0xef0fffff]
> [    2.602717] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
> [    2.602718] pci_bus 0000:04: resource 1 [mem 0xee000000-0xef0fffff]
> [    2.602719] pci_bus 0000:05: resource 1 [mem 0xef200000-0xef4fffff]
> [    2.602721] pci_bus 0000:06: resource 1 [mem 0xef500000-0xef6fffff]
> [    2.602764] pci 0000:10:01.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 11] add_size 100000 add_align 100000
> [    2.602789] pci 0000:10:01.1: BAR 15: assigned [mem 0x1c00c000000-0x1c00c0fffff 64bit pref]
> [    2.611352] pci 0000:11:00.0: BAR 7: assigned [mem 0x1c00c000000-0x1c00c01ffff 64bit pref]
> [    2.619939] pci 0000:11:00.0: BAR 10: assigned [mem 0x1c00c020000-0x1c00c03ffff 64bit pref]
> [    2.628606] pci 0000:11:00.1: BAR 7: assigned [mem 0x1c00c040000-0x1c00c05ffff 64bit pref]
> [    2.637196] pci 0000:11:00.1: BAR 10: assigned [mem 0x1c00c060000-0x1c00c07ffff 64bit pref]
> [    2.645865] pci 0000:11:00.2: BAR 7: assigned [mem 0x1c00c080000-0x1c00c09ffff 64bit pref]
> [    2.654455] pci 0000:11:00.2: BAR 10: assigned [mem 0x1c00c0a0000-0x1c00c0bffff 64bit pref]
> [    2.663128] pci 0000:11:00.3: BAR 7: assigned [mem 0x1c00c0c0000-0x1c00c0dffff 64bit pref]
> [    2.671709] pci 0000:11:00.3: BAR 10: assigned [mem 0x1c00c0e0000-0x1c00c0fffff 64bit pref]
> [    2.680381] pci 0000:10:01.1: PCI bridge to [bus 11]
> [    2.685484] pci 0000:10:01.1:   bridge window [io  0x3000-0x3fff]
> [    2.691715] pci 0000:10:01.1:   bridge window [mem 0xeb900000-0xebbfffff]
> [    2.698649] pci 0000:10:01.1:   bridge window [mem 0x1c00c000000-0x1c00c0fffff 64bit pref]
> [    2.707130] pci 0000:10:07.1: PCI bridge to [bus 12]
> [    2.712234] pci 0000:10:07.1:   bridge window [mem 0xebe00000-0xebffffff]
> [    2.719163] pci 0000:10:08.1: PCI bridge to [bus 13]
> [    2.724265] pci 0000:10:08.1:   bridge window [mem 0xebc00000-0xebdfffff]
> [    2.731193] pci_bus 0000:10: resource 4 [io  0x2000-0x3fff window]
> [    2.731194] pci_bus 0000:10: resource 5 [mem 0xe9900000-0xebffffff window]
> [    2.731195] pci_bus 0000:10: resource 6 [mem 0x1c00c000000-0x1e005ffffff window]
> [    2.731197] pci_bus 0000:11: resource 0 [io  0x3000-0x3fff]
> [    2.731198] pci_bus 0000:11: resource 1 [mem 0xeb900000-0xebbfffff]
> [    2.731199] pci_bus 0000:11: resource 2 [mem 0x1c00c000000-0x1c00c0fffff 64bit pref]
> [    2.731200] pci_bus 0000:12: resource 1 [mem 0xebe00000-0xebffffff]
> [    2.731201] pci_bus 0000:13: resource 1 [mem 0xebc00000-0xebdfffff]
> [    2.731250] pci 0000:20:07.1: PCI bridge to [bus 21]
> [    2.736357] pci 0000:20:07.1:   bridge window [mem 0xe9700000-0xe98fffff]
> [    2.743289] pci 0000:20:08.1: PCI bridge to [bus 22]
> [    2.748396] pci 0000:20:08.1:   bridge window [mem 0xe9500000-0xe96fffff]
> [    2.755324] pci_bus 0000:20: resource 4 [io  0x4000-0x5fff window]
> [    2.755326] pci_bus 0000:20: resource 5 [mem 0xe7500000-0xe98fffff window]
> [    2.755327] pci_bus 0000:20: resource 6 [mem 0x1a012000000-0x1c00bffffff window]
> [    2.755328] pci_bus 0000:21: resource 1 [mem 0xe9700000-0xe98fffff]
> [    2.755329] pci_bus 0000:22: resource 1 [mem 0xe9500000-0xe96fffff]
> [    2.755355] pci 0000:30:07.1: PCI bridge to [bus 31]
> [    2.760459] pci 0000:30:07.1:   bridge window [mem 0xe7300000-0xe74fffff]
> [    2.767389] pci 0000:30:08.1: PCI bridge to [bus 32]
> [    2.772491] pci 0000:30:08.1:   bridge window [mem 0xe7100000-0xe72fffff]
> [    2.779420] pci_bus 0000:30: resource 4 [io  0x6000-0x7fff window]
> [    2.779421] pci_bus 0000:30: resource 5 [mem 0xe5100000-0xe74fffff window]
> [    2.779422] pci_bus 0000:30: resource 6 [mem 0x18018000000-0x1a011ffffff window]
> [    2.779424] pci_bus 0000:31: resource 1 [mem 0xe7300000-0xe74fffff]
> [    2.779425] pci_bus 0000:32: resource 1 [mem 0xe7100000-0xe72fffff]
> [    2.779452] pci 0000:40:07.1: PCI bridge to [bus 41]
> [    2.784558] pci 0000:40:07.1:   bridge window [mem 0xe4f00000-0xe50fffff]
> [    2.791486] pci 0000:40:08.1: PCI bridge to [bus 42]
> [    2.796589] pci 0000:40:08.1:   bridge window [mem 0xe4d00000-0xe4efffff]
> [    2.803515] pci_bus 0000:40: resource 4 [io  0x8000-0x9fff window]
> [    2.803517] pci_bus 0000:40: resource 5 [mem 0xe2d00000-0xe50fffff window]
> [    2.803518] pci_bus 0000:40: resource 6 [mem 0x1601e000000-0x18017ffffff window]
> [    2.803519] pci_bus 0000:41: resource 1 [mem 0xe4f00000-0xe50fffff]
> [    2.803521] pci_bus 0000:42: resource 1 [mem 0xe4d00000-0xe4efffff]
> [    2.803545] pci 0000:50:07.1: PCI bridge to [bus 51]
> [    2.808644] pci 0000:50:07.1:   bridge window [mem 0xe2b00000-0xe2cfffff]
> [    2.815584] pci 0000:50:08.1: PCI bridge to [bus 52]
> [    2.820684] pci 0000:50:08.1:   bridge window [mem 0xe2900000-0xe2afffff]
> [    2.827621] pci_bus 0000:50: resource 4 [io  0xa000-0xbfff window]
> [    2.827623] pci_bus 0000:50: resource 5 [mem 0xe0900000-0xe2cfffff window]
> [    2.827624] pci_bus 0000:50: resource 6 [mem 0x14024000000-0x1601dffffff window]
> [    2.827626] pci_bus 0000:51: resource 1 [mem 0xe2b00000-0xe2cfffff]
> [    2.827628] pci_bus 0000:52: resource 1 [mem 0xe2900000-0xe2afffff]
> [    2.827661] pci 0000:61:00.0: BAR 7: no space for [mem size 0x00100000 64bit]
> [    2.834933] pci 0000:61:00.0: BAR 7: failed to assign [mem size 0x00100000 64bit]
> [    2.842624] pci 0000:61:00.0: BAR 10: no space for [mem size 0x00100000 64bit]
> [    2.850057] pci 0000:61:00.0: BAR 10: failed to assign [mem size 0x00100000 64bit]
> [    2.857834] pci 0000:61:00.1: BAR 7: no space for [mem size 0x00100000 64bit]
> [    2.865115] pci 0000:61:00.1: BAR 7: failed to assign [mem size 0x00100000 64bit]
> [    2.872805] pci 0000:61:00.1: BAR 10: no space for [mem size 0x00100000 64bit]
> [    2.880229] pci 0000:61:00.1: BAR 10: failed to assign [mem size 0x00100000 64bit]
> [    2.888004] pci 0000:60:03.1: PCI bridge to [bus 61]
> [    2.893102] pci 0000:60:03.1:   bridge window [io  0xd000-0xdfff]
> [    2.899336] pci 0000:60:03.1:   bridge window [mem 0xe0200000-0xe04fffff]
> [    2.906272] pci 0000:60:07.1: PCI bridge to [bus 62]
> [    2.911377] pci 0000:60:07.1:   bridge window [mem 0xe0700000-0xe08fffff]
> [    2.918313] pci 0000:60:08.1: PCI bridge to [bus 63]
> [    2.923414] pci 0000:60:08.1:   bridge window [mem 0xe0500000-0xe06fffff]
> [    2.930344] pci_bus 0000:60: Some PCI device resources are unassigned, try booting with pci=realloc
> [    2.939596] pci_bus 0000:60: resource 4 [io  0xc000-0xdfff window]
> [    2.939598] pci_bus 0000:60: resource 5 [mem 0xde200000-0xe08fffff window]
> [    2.939600] pci_bus 0000:60: resource 6 [mem 0x1202a000000-0x14023ffffff window]
> [    2.939601] pci_bus 0000:61: resource 0 [io  0xd000-0xdfff]
> [    2.939602] pci_bus 0000:61: resource 1 [mem 0xe0200000-0xe04fffff]
> [    2.939603] pci_bus 0000:62: resource 1 [mem 0xe0700000-0xe08fffff]
> [    2.939605] pci_bus 0000:63: resource 1 [mem 0xe0500000-0xe06fffff]
> [    2.939631] pci 0000:70:07.1: PCI bridge to [bus 71]
> [    2.944740] pci 0000:70:07.1:   bridge window [mem 0xde000000-0xde1fffff]
> [    2.951683] pci 0000:70:08.1: PCI bridge to [bus 72]
> [    2.956785] pci 0000:70:08.1:   bridge window [mem 0xdde00000-0xddffffff]
> [    2.963714] pci_bus 0000:70: resource 4 [io  0xe000-0xffff window]
> [    2.963715] pci_bus 0000:70: resource 5 [mem 0xdbe00000-0xde1fffff window]
> [    2.963717] pci_bus 0000:70: resource 6 [mem 0x10030000000-0x12029ffffff window]
> [    2.963719] pci_bus 0000:71: resource 1 [mem 0xde000000-0xde1fffff]
> [    2.963721] pci_bus 0000:72: resource 1 [mem 0xdde00000-0xddffffff]
> [    2.964067] NET: Registered protocol family 2
> [    2.969097] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes)
> [    2.977782] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
> [    2.986284] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    2.993312] TCP: Hash tables configured (established 524288 bind 65536)
> [    3.000304] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
> [    3.007160] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
> [    3.015202] pci 0000:04:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    3.024255] PCI: CLS 64 bytes, default 64
> [    3.024307] Trying to unpack rootfs image as initramfs...
> [    3.113260] Freeing initrd memory: 5136K
> [    3.117326] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    3.123912] software IO TLB: mapped [mem 0xc5d5f000-0xc9d5f000] (64MB)
> [    3.130752] amd_uncore: AMD NB counters detected
> [    3.135642] amd_uncore: AMD LLC counters detected
> [    3.147712] workingset: timestamp_bits=40 max_order=28 bucket_order=0
> [    3.156615] SGI XFS with ACLs, security attributes, realtime, no debug enabled
> [    3.166360] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
> [    3.174285] io scheduler noop registered
> [    3.178342] io scheduler deadline registered
> [    3.182795] io scheduler cfq registered (default)
> [    3.187634] io scheduler mq-deadline registered
> [    3.192305] io scheduler kyber registered
> [    3.212474] pcieport 0000:00:01.3: Signaling PME with IRQ 25
> [    3.218396] pcieport 0000:00:01.4: Signaling PME with IRQ 26
> [    3.224394] pcieport 0000:00:01.6: Signaling PME with IRQ 27
> [    3.230405] pcieport 0000:00:07.1: Signaling PME with IRQ 28
> [    3.236398] pcieport 0000:00:08.1: Signaling PME with IRQ 30
> [    3.242257] pcieport 0000:10:01.1: Signaling PME with IRQ 31
> [    3.248096] pcieport 0000:10:07.1: Signaling PME with IRQ 33
> [    3.253956] pcieport 0000:10:08.1: Signaling PME with IRQ 35
> [    3.260052] pcieport 0000:20:07.1: Signaling PME with IRQ 37
> [    3.266039] pcieport 0000:20:08.1: Signaling PME with IRQ 39
> [    3.272386] pcieport 0000:30:07.1: Signaling PME with IRQ 41
> [    3.278238] pcieport 0000:30:08.1: Signaling PME with IRQ 43
> [    3.284294] pcieport 0000:40:07.1: Signaling PME with IRQ 45
> [    3.290295] pcieport 0000:40:08.1: Signaling PME with IRQ 47
> [    3.296224] pcieport 0000:50:07.1: Signaling PME with IRQ 49
> [    3.302227] pcieport 0000:50:08.1: Signaling PME with IRQ 51
> [    3.308073] pcieport 0000:60:03.1: Signaling PME with IRQ 52
> [    3.314002] pcieport 0000:60:07.1: Signaling PME with IRQ 54
> [    3.320013] pcieport 0000:60:08.1: Signaling PME with IRQ 56
> [    3.325996] pcieport 0000:70:07.1: Signaling PME with IRQ 58
> [    3.331995] pcieport 0000:70:08.1: Signaling PME with IRQ 60
> [    3.337829] version 39.2
> [    3.340503] ipmi device interface
> [    3.343983] IPMI System Interface driver.
> [    3.348136] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [    3.355961] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> [    3.362021] ipmi_si: Adding SMBIOS-specified kcs state machine
> [    3.368007] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
> [    3.374095] ipmi_si IPI0001:00: [io  0x0ca4] regsize 1 spacing 1 irq 0
> [    3.380771] ipmi_si: Adding ACPI-specified kcs state machine
> [    3.386610] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
> [    3.465821] ipmi_si dmi-ipmi-si.0: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
> [    3.494712] ipmi_si dmi-ipmi-si.0: Found new BMC (man_id: 0x002a7c, prod_id: 0x0963, dev_id: 0x20)
> [    3.508563] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
> [    3.515705] IPMI Watchdog: driver initialized
> [    3.520216] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
> [    3.528573] IPMI poweroff: ATCA Detect mfg 0x2A7C prod 0x963
> [    3.534371] IPMI poweroff: Found a chassis style poweroff function
> [    3.540909] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    3.549477] ACPI: Power Button [PWRB]
> [    3.553328] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    3.560998] ACPI: Power Button [PWRF]
> [    3.564850] Monitor-Mwait will be used to enter C-1 state
> [    3.586705] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    3.615117] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    3.644456] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    3.653153] lp: driver loaded but no devices found
> [    3.658500] Linux agpgart interface v0.103
> [    3.696220] brd: module loaded
> [    3.708242] loop: module loaded
> [    3.732115] drbd: initialized. Version: 8.4.10 (api:1/proto:86-101)
> [    3.738996] drbd: built-in
> [    3.742219] drbd: registered as block device major 147
> [    3.747767] Uniform Multi-Platform E-IDE driver
> [    3.753518] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> [    3.764607] Probing IDE interface ide0...
> [    4.188869] tsc: Refined TSC clocksource calibration: 2199.989 MHz
> [    4.196227] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb628b0c45, max_idle_ns: 440795313293 ns
> [    4.207399] clocksource: Switched to clocksource tsc
> [    4.290082] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [    4.295075] Probing IDE interface ide1...
> [    4.822055] ide1 at 0x170-0x177,0x376 on irq 15
> [    4.827159] ide-gd driver 1.18
> [    4.830446] ide-cd driver 5.00
> [    4.834397] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
> [    4.842446] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
> [    4.850182] megasas: 07.706.03.00-rc1
> [    4.854501] mpt3sas version 26.100.00.00 loaded
> [    4.860226] ahci 0000:13:00.2: version 3.0
> [    4.860467] ahci 0000:13:00.2: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    4.869494] ahci 0000:13:00.2: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ems sxs 
> [    4.881070] scsi host0: ahci
> [    4.884535] scsi host1: ahci
> [    4.888139] scsi host2: ahci
> [    4.891468] scsi host3: ahci
> [    4.895128] scsi host4: ahci
> [    4.898438] scsi host5: ahci
> [    4.902135] scsi host6: ahci
> [    4.905527] scsi host7: ahci
> [    4.908964] ata1: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02100 irq 62
> [    4.917262] ata2: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02180 irq 62
> [    4.925425] ata3: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02200 irq 62
> [    4.933916] ata4: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02280 irq 62
> [    4.942222] ata5: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02300 irq 62
> [    4.950411] ata6: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02380 irq 62
> [    4.958585] ata7: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02400 irq 62
> [    4.967067] ata8: SATA max UDMA/133 abar m4096@0xebd02000 port 0xebd02480 irq 62
> [    4.975664] ahci 0000:42:00.2: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    4.985046] ahci 0000:42:00.2: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ems sxs 
> [    4.996194] scsi host8: ahci
> [    5.000092] scsi host9: ahci
> [    5.003517] scsi host10: ahci
> [    5.007223] scsi host11: ahci
> [    5.010658] scsi host12: ahci
> [    5.014496] scsi host13: ahci
> [    5.018130] scsi host14: ahci
> [    5.021673] scsi host15: ahci
> [    5.025406] ata9: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02100 irq 64
> [    5.033578] ata10: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02180 irq 64
> [    5.042160] ata11: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02200 irq 64
> [    5.050506] ata12: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02280 irq 64
> [    5.059060] ata13: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02300 irq 64
> [    5.067258] ata14: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02380 irq 64
> [    5.075585] ata15: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02400 irq 64
> [    5.084167] ata16: SATA max UDMA/133 abar m4096@0xe4e02000 port 0xe4e02480 irq 64
> [    5.093209] tun: Universal TUN/TAP device driver, 1.6
> [    5.098845] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
> [    5.109330] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [    5.116067] e100: Copyright(c) 1999-2006 Intel Corporation
> [    5.122094] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    5.130063] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    5.136353] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    5.142996] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    5.149552] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [    5.157226] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    5.256771] igb 0000:11:00.0: added PHC on eth0
> [    5.262058] igb 0000:11:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    5.269488] igb 0000:11:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 0c:c4:7a:fb:1f:20
> [    5.277380] igb 0000:11:00.0: eth0: PBA No: 010A00-000
> [    5.282344] ata7: SATA link down (SStatus 0 SControl 300)
> [    5.283054] igb 0000:11:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> [    5.297245] ata8: SATA link down (SStatus 0 SControl 300)
> [    5.303110] ata4: SATA link down (SStatus 0 SControl 300)
> [    5.379232] igb 0000:11:00.1: added PHC on eth1
> [    5.384158] igb 0000:11:00.1: Intel(R) Gigabit Ethernet Network Connection
> [    5.391498] igb 0000:11:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 0c:c4:7a:fb:1f:21
> [    5.399323] igb 0000:11:00.1: eth1: PBA No: 010A00-000
> [    5.402158] ata13: SATA link down (SStatus 0 SControl 300)
> [    5.405052] igb 0000:11:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> [    5.419201] ata15: SATA link down (SStatus 0 SControl 300)
> [    5.425192] ata9: SATA link down (SStatus 0 SControl 300)
> [    5.431083] ata16: SATA link down (SStatus 0 SControl 300)
> [    5.437126] ata14: SATA link down (SStatus 0 SControl 300)
> [    5.443087] ata12: SATA link down (SStatus 0 SControl 300)
> [    5.449089] ata11: SATA link down (SStatus 0 SControl 300)
> [    5.455058] ata10: SATA link down (SStatus 0 SControl 300)
> [    5.468976] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.475667] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.482548] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.489246] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.496011] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.501124] igb 0000:11:00.2: added PHC on eth2
> [    5.503223] ata2.00: ATA-10: ST2000NM0055-1V4104, TN02, max UDMA/133
> [    5.507670] igb 0000:11:00.2: Intel(R) Gigabit Ethernet Network Connection
> [    5.514928] ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    5.522504] igb 0000:11:00.2: eth2: (PCIe:5.0Gb/s:Width x4) 0c:c4:7a:fb:1f:22
> [    5.530049] ata3.00: ATA-10: ST2000NM0055-1V4104, TN02, max UDMA/133
> [    5.538081] igb 0000:11:00.2: eth2: PBA No: 010A00-000
> [    5.545007] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    5.545012] ata6.00: ATA-10: ST8000NM0045-1RL112, NN02, max UDMA/133
> [    5.550662] igb 0000:11:00.2: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> [    5.573502] ata6.00: 1953506646 sectors, multi 2: LBA48 NCQ (depth 32), AA
> [    5.581284] ata1.00: ATA-9: SAMSUNG MZ7KM960HMJP-00005, GXM5104Q, max UDMA/133
> [    5.589164] ata1.00: 1875385008 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    5.597084] ata5.00: ATA-10: ST8000NM0045-1RL112, NN02, max UDMA/133
> [    5.604057] ata5.00: 1953506646 sectors, multi 2: LBA48 NCQ (depth 32), AA
> [    5.611407] ata2.00: configured for UDMA/133
> [    5.616057] ata3.00: configured for UDMA/133
> [    5.620677] ata6.00: configured for UDMA/133
> [    5.626292] ata1.00: configured for UDMA/133
> [    5.631482] ata5.00: configured for UDMA/133
> [    5.647151] igb 0000:11:00.3: added PHC on eth3
> [    5.652228] igb 0000:11:00.3: Intel(R) Gigabit Ethernet Network Connection
> [    5.659907] igb 0000:11:00.3: eth3: (PCIe:5.0Gb/s:Width x4) 0c:c4:7a:fb:1f:23
> [    5.668213] igb 0000:11:00.3: eth3: PBA No: 010A00-000
> [    5.674050] igb 0000:11:00.3: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> [    5.682520] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> [    5.691523] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    5.698139] sky2: driver version 1.30
> [    5.702429] Fusion MPT base driver 3.04.20
> [    5.707096] Copyright (c) 1999-2008 LSI Corporation
> [    5.714355] Fusion MPT SPI Host driver 3.04.20
> [    5.719436] Fusion MPT FC Host driver 3.04.20
> [    5.724188] Fusion MPT SAS Host driver 3.04.20
> [    5.729123] Fusion MPT misc device (ioctl) driver 3.04.20
> [    5.735185] mptctl: Registered with Fusion MPT base driver
> [    5.741166] mptctl: /dev/mptctl @ (major,minor=10,220)
> [    5.746710] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    5.754155] ehci-pci: EHCI PCI platform driver
> [    5.759206] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.766061] ohci-pci: OHCI PCI platform driver
> [    5.771097] uhci_hcd: USB Universal Host Controller Interface driver
> [    5.778293] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    5.784074] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
> [    5.853089] xhci_hcd 0000:01:00.0: hcc params 0x0200e081 hci version 0x100 quirks 0x0000000010000410
> [    5.863439] hub 1-0:1.0: USB hub found
> [    5.867682] hub 1-0:1.0: 2 ports detected
> [    5.872433] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    5.878200] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
> [    5.886423] xhci_hcd 0000:01:00.0: Host supports USB 3.0  SuperSpeed
> [    5.893376] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    5.902503] hub 2-0:1.0: USB hub found
> [    5.906597] hub 2-0:1.0: 2 ports detected
> [    5.911490] xhci_hcd 0000:02:00.0: xHCI Host Controller
> [    5.917341] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 3
> [    5.986161] xhci_hcd 0000:02:00.0: hcc params 0x0200e081 hci version 0x100 quirks 0x0000000010000410
> [    5.996622] hub 3-0:1.0: USB hub found
> [    6.001080] hub 3-0:1.0: 2 ports detected
> [    6.005509] xhci_hcd 0000:02:00.0: xHCI Host Controller
> [    6.011427] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 4
> [    6.019596] xhci_hcd 0000:02:00.0: Host supports USB 3.0  SuperSpeed
> [    6.026718] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [    6.036086] hub 4-0:1.0: USB hub found
> [    6.040263] hub 4-0:1.0: 2 ports detected
> [    6.045155] xhci_hcd 0000:05:00.3: xHCI Host Controller
> [    6.050971] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 5
> [    6.059286] xhci_hcd 0000:05:00.3: hcc params 0x0270f665 hci version 0x100 quirks 0x0000000000000410
> [    6.069647] hub 5-0:1.0: USB hub found
> [    6.074141] hub 5-0:1.0: 2 ports detected
> [    6.078527] xhci_hcd 0000:05:00.3: xHCI Host Controller
> [    6.084356] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 6
> [    6.092649] xhci_hcd 0000:05:00.3: Host supports USB 3.0  SuperSpeed
> [    6.100129] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
> [    6.109148] hub 6-0:1.0: USB hub found
> [    6.113215] hub 6-0:1.0: 2 ports detected
> [    6.118137] usbcore: registered new interface driver usb-storage
> [    6.124694] usbcore: registered new interface driver ftdi_sio
> [    6.131250] usbserial: USB Serial support registered for FTDI USB Serial Device
> [    6.139381] usbcore: registered new interface driver omninet
> [    6.145620] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
> [    6.154541] i8042: PNP: No PS/2 controller found.
> [    6.160182] rtc_cmos 00:01: RTC can wake from S4
> [    6.165509] rtc_cmos 00:01: registered as rtc0
> [    6.170387] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    6.179162] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [    6.187421] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
> [    6.196302] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [    6.202346] iTCO_vendor_support: vendor-support=0
> [    6.207721] nv_tco: NV TCO WatchDog Timer Driver v0.01
> [    6.214403] EDAC amd64: Node 0: DRAM ECC enabled.
> [    6.219420] EDAC amd64: F17h detected (node 0).
> [    6.224435] EDAC MC: UMC0 chip selects:
> [    6.224436] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.229918] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.235076] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.240187] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.245493] EDAC MC: UMC1 chip selects:
> [    6.245493] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.247748] usb 1-1: new full-speed USB device number 2 using xhci_hcd
> [    6.250677] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.250677] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.250678] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.250680] EDAC amd64: using x8 syndromes.
> [    6.278573] EDAC amd64: MCT channel count: 2
> [    6.283507] EDAC MC0: Giving out device to module amd64_edac controller F17h: DEV 0000:00:18.3 (INTERRUPT)
> [    6.294052] EDAC amd64: Node 1: DRAM ECC enabled.
> [    6.299242] EDAC amd64: F17h detected (node 1).
> [    6.304192] EDAC MC: UMC0 chip selects:
> [    6.304193] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.309419] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.314470] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.319663] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.325158] EDAC MC: UMC1 chip selects:
> [    6.325158] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.330246] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.335446] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.341006] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.346165] EDAC amd64: using x8 syndromes.
> [    6.350679] EDAC amd64: MCT channel count: 2
> [    6.355851] EDAC MC1: Giving out device to module amd64_edac controller F17h: DEV 0000:00:19.3 (INTERRUPT)
> [    6.366607] EDAC amd64: Node 2: DRAM ECC enabled.
> [    6.372183] EDAC amd64: F17h detected (node 2).
> [    6.377294] EDAC MC: UMC0 chip selects:
> [    6.377295] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.382399] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.387668] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.393156] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.398333] EDAC MC: UMC1 chip selects:
> [    6.398334] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.403503] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.408670] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.414163] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.414747] usb 5-2: new high-speed USB device number 2 using xhci_hcd
> [    6.419165] EDAC amd64: using x8 syndromes.
> [    6.419166] EDAC amd64: MCT channel count: 2
> [    6.419341] EDAC MC2: Giving out device to module amd64_edac controller F17h: DEV 0000:00:1a.3 (INTERRUPT)
> [    6.446531] EDAC amd64: Node 3: DRAM ECC enabled.
> [    6.452066] EDAC amd64: F17h detected (node 3).
> [    6.457048] EDAC MC: UMC0 chip selects:
> [    6.457049] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.462351] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.467689] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.473071] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.478237] EDAC MC: UMC1 chip selects:
> [    6.478238] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.483324] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.488511] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.494129] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.499351] EDAC amd64: using x8 syndromes.
> [    6.504046] EDAC amd64: MCT channel count: 2
> [    6.509259] EDAC MC3: Giving out device to module amd64_edac controller F17h: DEV 0000:00:1b.3 (INTERRUPT)
> [    6.519671] EDAC amd64: Node 4: DRAM ECC enabled.
> [    6.525237] EDAC amd64: F17h detected (node 4).
> [    6.530258] EDAC MC: UMC0 chip selects:
> [    6.530259] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.535266] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.540664] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.546055] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.551230] EDAC MC: UMC1 chip selects:
> [    6.551231] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.556411] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.561596] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.567065] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.572107] EDAC amd64: using x8 syndromes.
> [    6.576994] EDAC amd64: MCT channel count: 2
> [    6.582198] EDAC MC4: Giving out device to module amd64_edac controller F17h: DEV 0000:00:1c.3 (INTERRUPT)
> [    6.593001] EDAC amd64: Node 5: DRAM ECC enabled.
> [    6.598237] EDAC amd64: F17h detected (node 5).
> [    6.603222] EDAC MC: UMC0 chip selects:
> [    6.603223] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.608500] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.612287] hub 5-2:1.0: USB hub found
> [    6.613588] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.613589] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.613592] EDAC MC: UMC1 chip selects:
> [    6.618000] hub 5-2:1.0: 4 ports detected
> [    6.623267] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.623268] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.623268] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.623270] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.654251] EDAC amd64: using x8 syndromes.
> [    6.658985] EDAC amd64: MCT channel count: 2
> [    6.664060] EDAC MC5: Giving out device to module amd64_edac controller F17h: DEV 0000:00:1d.3 (INTERRUPT)
> [    6.674591] EDAC amd64: Node 6: DRAM ECC enabled.
> [    6.680047] EDAC amd64: F17h detected (node 6).
> [    6.685120] EDAC MC: UMC0 chip selects:
> [    6.685121] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.690235] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.695486] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.700599] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.705998] EDAC MC: UMC1 chip selects:
> [    6.705999] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.711139] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.716339] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.721488] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.726739] EDAC amd64: using x8 syndromes.
> [    6.731592] EDAC amd64: MCT channel count: 2
> [    6.734668] random: fast init done
> [    6.736600] EDAC MC6: Giving out device to module amd64_edac controller F17h: DEV 0000:00:1e.3 (INTERRUPT)
> [    6.749074] floppy0: no floppy controllers found
> [    6.750723] EDAC amd64: Node 7: DRAM ECC enabled.
> [    6.756808] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG MZ7KM960 104Q PQ: 0 ANSI: 5
> [    6.763343] EDAC amd64: F17h detected (node 7).
> [    6.772401] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    6.772412] ata1.00: Enabling discard_zeroes_data
> [    6.772431] sd 0:0:0:0: [sda] 1875385008 512-byte logical blocks: (960 GB/894 GiB)
> [    6.772437] sd 0:0:0:0: [sda] Write Protect is off
> [    6.772439] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    6.772446] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.772556] ata1.00: Enabling discard_zeroes_data
> [    6.773063]  sda: sda1 sda2
> [    6.774048] ata1.00: Enabling discard_zeroes_data
> [    6.774073] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [    6.777160] EDAC MC: UMC0 chip selects:
> [    6.783374] scsi 1:0:0:0: Direct-Access     ATA      ST2000NM0055-1V4 TN02 PQ: 0 ANSI: 5
> [    6.788129] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.788130] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.788134] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.796596] sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [    6.796633] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [    6.796921] scsi 2:0:0:0: Direct-Access     ATA      ST2000NM0055-1V4 TN02 PQ: 0 ANSI: 5
> [    6.797043] sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [    6.797047] sd 2:0:0:0: [sdc] Write Protect is off
> [    6.797048] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    6.797053] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.797059] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [    6.797358] scsi 4:0:0:0: Direct-Access     ATA      ST8000NM0045-1RL NN02 PQ: 0 ANSI: 5
> [    6.797463] sd 4:0:0:0: [sdd] 1953506646 4096-byte logical blocks: (8.00 TB/7.28 TiB)
> [    6.797468] sd 4:0:0:0: [sdd] Write Protect is off
> [    6.797469] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    6.797476] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.797504] sd 4:0:0:0: Attached scsi generic sg3 type 0
> [    6.797786] scsi 5:0:0:0: Direct-Access     ATA      ST8000NM0045-1RL NN02 PQ: 0 ANSI: 5
> [    6.797927] sd 5:0:0:0: [sde] 1953506646 4096-byte logical blocks: (8.00 TB/7.28 TiB)
> [    6.797931] sd 5:0:0:0: [sde] Write Protect is off
> [    6.797932] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [    6.797937] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.798012] sd 5:0:0:0: Attached scsi generic sg4 type 0
> [    6.801647] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.801652] EDAC MC: UMC1 chip selects:
> [    6.812062] sd 1:0:0:0: [sdb] Write Protect is off
> [    6.813370] sd 2:0:0:0: [sdc] Attached SCSI removable disk
> [    6.817144] EDAC amd64: MC: 0: 65535MB 1: 65535MB
> [    6.817148] EDAC amd64: MC: 2: 65535MB 3: 65535MB
> [    6.818303] sd 5:0:0:0: [sde] Attached SCSI removable disk
> [    6.820324] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    6.823076] sd 4:0:0:0: [sdd] Attached SCSI removable disk
> [    6.825497] EDAC amd64: MC: 4:     0MB 5:     0MB
> [    6.825500] EDAC amd64: MC: 6:     0MB 7:     0MB
> [    6.831519] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.840413] EDAC amd64: using x8 syndromes.
> [    6.867886] sd 1:0:0:0: [sdb] Attached SCSI removable disk
> [    6.870893] EDAC amd64: MCT channel count: 2
> [    6.920748] usb 5-2.1: new low-speed USB device number 3 using xhci_hcd
> [    6.927825] EDAC MC7: Giving out device to module amd64_edac controller F17h: DEV 0000:00:1f.3 (INTERRUPT)
> [    7.081075] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
> [    7.093077] AMD64 EDAC driver v3.5.0
> [    7.097011] hidraw: raw HID events driver (C) Jiri Kosina
> [    7.104678] input: Peppercon AG Multidevice as /devices/pci0000:00/0000:00:01.3/0000:01:00.0/usb1/1-1/1-1:1.0/0003:14DD:0002.0001/input/input2
> [    7.128838] input: HID 0557:2419 as /devices/pci0000:00/0000:00:07.1/0000:05:00.3/usb5/5-2/5-2.1/5-2.1:1.0/0003:0557:2419.0002/input/input3
> [    7.171071] hid-generic 0003:14DD:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Peppercon AG Multidevice] on usb-0000:01:00.0-1/input0
> [    7.185851] input: Peppercon AG Multidevice as /devices/pci0000:00/0000:00:01.3/0000:01:00.0/usb1/1-1/1-1:1.1/0003:14DD:0002.0003/input/input4
> [    7.222971] hid-generic 0003:0557:2419.0002: input,hidraw1: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:05:00.3-2.1/input0
> [    7.223070] hid-generic 0003:14DD:0002.0003: input,hidraw2: USB HID v1.01 Mouse [Peppercon AG Multidevice] on usb-0000:01:00.0-1/input1
> [    7.240191] input: HID 0557:2419 as /devices/pci0000:00/0000:00:07.1/0000:05:00.3/usb5/5-2/5-2.1/5-2.1:1.1/0003:0557:2419.0004/input/input5
> [    7.263077] hid-generic 0003:0557:2419.0004: input,hidraw3: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:05:00.3-2.1/input1
> [    7.276100] usbcore: registered new interface driver usbhid
> [    7.282165] usbhid: USB HID core driver
> [    7.287354] Key type dns_resolver registered
> [    7.300313] microcode: CPU0: patch_level=0x08001213
> [    7.305531] microcode: CPU1: patch_level=0x08001213
> [    7.311056] microcode: CPU2: patch_level=0x08001213
> [    7.316452] microcode: CPU3: patch_level=0x08001213
> [    7.322064] microcode: CPU4: patch_level=0x08001213
> [    7.327342] microcode: CPU5: patch_level=0x08001213
> [    7.332610] microcode: CPU6: patch_level=0x08001213
> [    7.338356] microcode: CPU7: patch_level=0x08001213
> [    7.344049] microcode: CPU8: patch_level=0x08001213
> [    7.349416] microcode: CPU9: patch_level=0x08001213
> [    7.355069] microcode: CPU10: patch_level=0x08001213
> [    7.360501] microcode: CPU11: patch_level=0x08001213
> [    7.366175] microcode: CPU12: patch_level=0x08001213
> [    7.371684] microcode: CPU13: patch_level=0x08001213
> [    7.377496] microcode: CPU14: patch_level=0x08001213
> [    7.383055] microcode: CPU15: patch_level=0x08001213
> [    7.388524] microcode: CPU16: patch_level=0x08001213
> [    7.394165] microcode: CPU17: patch_level=0x08001213
> [    7.399590] microcode: CPU18: patch_level=0x08001213
> [    7.405412] microcode: CPU19: patch_level=0x08001213
> [    7.411059] microcode: CPU20: patch_level=0x08001213
> [    7.416447] microcode: CPU21: patch_level=0x08001213
> [    7.422083] microcode: CPU22: patch_level=0x08001213
> [    7.427592] microcode: CPU23: patch_level=0x08001213
> [    7.433332] microcode: CPU24: patch_level=0x08001213
> [    7.439064] microcode: CPU25: patch_level=0x08001213
> [    7.444525] microcode: CPU26: patch_level=0x08001213
> [    7.450169] microcode: CPU27: patch_level=0x08001213
> [    7.455602] microcode: CPU28: patch_level=0x08001213
> [    7.461582] microcode: CPU29: patch_level=0x08001213
> [    7.467251] microcode: CPU30: patch_level=0x08001213
> [    7.472696] microcode: CPU31: patch_level=0x08001213
> [    7.478348] microcode: CPU32: patch_level=0x08001213
> [    7.484060] microcode: CPU33: patch_level=0x08001213
> [    7.489694] microcode: CPU34: patch_level=0x08001213
> [    7.495516] microcode: CPU35: patch_level=0x08001213
> [    7.501084] microcode: CPU36: patch_level=0x08001213
> [    7.506595] microcode: CPU37: patch_level=0x08001213
> [    7.512329] microcode: CPU38: patch_level=0x08001213
> [    7.518051] microcode: CPU39: patch_level=0x08001213
> [    7.523496] microcode: CPU40: patch_level=0x08001213
> [    7.529068] microcode: CPU41: patch_level=0x08001213
> [    7.534698] microcode: CPU42: patch_level=0x08001213
> [    7.540696] microcode: CPU43: patch_level=0x08001213
> [    7.546504] microcode: CPU44: patch_level=0x08001213
> [    7.552072] microcode: CPU45: patch_level=0x08001213
> [    7.557500] microcode: CPU46: patch_level=0x08001213
> [    7.563159] microcode: CPU47: patch_level=0x08001213
> [    7.568615] microcode: CPU48: patch_level=0x08001213
> [    7.574435] microcode: CPU49: patch_level=0x08001213
> [    7.580162] microcode: CPU50: patch_level=0x08001213
> [    7.585596] microcode: CPU51: patch_level=0x08001213
> [    7.591520] microcode: CPU52: patch_level=0x08001213
> [    7.597261] microcode: CPU53: patch_level=0x08001213
> [    7.602692] microcode: CPU54: patch_level=0x08001213
> [    7.608612] microcode: CPU55: patch_level=0x08001213
> [    7.614608] microcode: CPU56: patch_level=0x08001213
> [    7.620510] microcode: CPU57: patch_level=0x08001213
> [    7.626079] microcode: CPU58: patch_level=0x08001213
> [    7.631521] microcode: CPU59: patch_level=0x08001213
> [    7.637077] microcode: CPU60: patch_level=0x08001213
> [    7.642504] microcode: CPU61: patch_level=0x08001213
> [    7.648163] microcode: CPU62: patch_level=0x08001213
> [    7.653678] microcode: CPU63: patch_level=0x08001213
> [    7.659498] microcode: CPU64: patch_level=0x08001213
> [    7.665062] microcode: CPU65: patch_level=0x08001213
> [    7.670430] microcode: CPU66: patch_level=0x08001213
> [    7.676035] microcode: CPU67: patch_level=0x08001213
> [    7.681441] microcode: CPU68: patch_level=0x08001213
> [    7.686705] microcode: CPU69: patch_level=0x08001213
> [    7.692507] microcode: CPU70: patch_level=0x08001213
> [    7.698060] microcode: CPU71: patch_level=0x08001213
> [    7.703430] microcode: CPU72: patch_level=0x08001213
> [    7.709161] microcode: CPU73: patch_level=0x08001213
> [    7.714574] microcode: CPU74: patch_level=0x08001213
> [    7.720056] microcode: CPU75: patch_level=0x08001213
> [    7.725579] microcode: CPU76: patch_level=0x08001213
> [    7.731264] microcode: CPU77: patch_level=0x08001213
> [    7.737071] microcode: CPU78: patch_level=0x08001213
> [    7.742508] microcode: CPU79: patch_level=0x08001213
> [    7.748055] microcode: CPU80: patch_level=0x08001213
> [    7.753515] microcode: CPU81: patch_level=0x08001213
> [    7.759175] microcode: CPU82: patch_level=0x08001213
> [    7.764600] microcode: CPU83: patch_level=0x08001213
> [    7.770423] microcode: CPU84: patch_level=0x08001213
> [    7.776058] microcode: CPU85: patch_level=0x08001213
> [    7.781517] microcode: CPU86: patch_level=0x08001213
> [    7.787075] microcode: CPU87: patch_level=0x08001213
> [    7.792418] microcode: CPU88: patch_level=0x08001213
> [    7.798067] microcode: CPU89: patch_level=0x08001213
> [    7.803588] microcode: CPU90: patch_level=0x08001213
> [    7.809431] microcode: CPU91: patch_level=0x08001213
> [    7.815062] microcode: CPU92: patch_level=0x08001213
> [    7.820694] microcode: CPU93: patch_level=0x08001213
> [    7.828499] microcode: CPU94: patch_level=0x08001213
> [    7.834064] microcode: CPU95: patch_level=0x08001213
> [    7.839525] microcode: CPU96: patch_level=0x08001213
> [    7.845074] microcode: CPU97: patch_level=0x08001213
> [    7.850506] microcode: CPU98: patch_level=0x08001213
> [    7.856157] microcode: CPU99: patch_level=0x08001213
> [    7.861676] microcode: CPU100: patch_level=0x08001213
> [    7.867598] microcode: CPU101: patch_level=0x08001213
> [    7.873508] microcode: CPU102: patch_level=0x08001213
> [    7.879166] microcode: CPU103: patch_level=0x08001213
> [    7.885060] microcode: CPU104: patch_level=0x08001213
> [    7.890695] microcode: CPU105: patch_level=0x08001213
> [    7.896518] microcode: CPU106: patch_level=0x08001213
> [    7.902246] microcode: CPU107: patch_level=0x08001213
> [    7.908067] microcode: CPU108: patch_level=0x08001213
> [    7.914060] microcode: CPU109: patch_level=0x08001213
> [    7.919537] microcode: CPU110: patch_level=0x08001213
> [    7.925256] microcode: CPU111: patch_level=0x08001213
> [    7.930952] microcode: CPU112: patch_level=0x08001213
> [    7.936688] microcode: CPU113: patch_level=0x08001213
> [    7.942978] microcode: CPU114: patch_level=0x08001213
> [    7.948701] microcode: CPU115: patch_level=0x08001213
> [    7.954559] microcode: CPU116: patch_level=0x08001213
> [    7.960078] microcode: CPU117: patch_level=0x08001213
> [    7.965975] microcode: CPU118: patch_level=0x08001213
> [    7.971684] microcode: CPU119: patch_level=0x08001213
> [    7.977508] microcode: CPU120: patch_level=0x08001213
> [    7.983160] microcode: CPU121: patch_level=0x08001213
> [    7.988601] microcode: CPU122: patch_level=0x08001213
> [    7.994494] microcode: CPU123: patch_level=0x08001213
> [    8.000052] microcode: CPU124: patch_level=0x08001213
> [    8.006049] microcode: CPU125: patch_level=0x08001213
> [    8.011587] microcode: CPU126: patch_level=0x08001213
> [    8.017498] microcode: CPU127: patch_level=0x08001213
> [    8.023202] microcode: Microcode Update Driver: v2.2.
> [    8.023217] sched_clock: Marking stable (8025459444, -2263544)->(8689047708, -665851808)
> [    8.038196] registered taskstats version 1
> [    8.044646] rtc_cmos 00:01: setting system clock to 2019-04-17 08:17:22 UTC (1555489042)
> [    8.053471] ALSA device list:
> [    8.056991]   No soundcards found.
> [    8.063841] Freeing unused kernel image memory: 1564K
> [    8.073990] Write protecting the kernel read-only data: 20480k
> [    8.081892] Freeing unused kernel image memory: 2008K
> [    8.087819] Freeing unused kernel image memory: 576K
> [    8.093094] Run /init as init process
> [    8.275538] XFS (sda1): Mounting V5 Filesystem
> [    8.293123] XFS (sda1): Starting recovery (logdev: internal)
> [    8.310436] XFS (sda1): Ending recovery (logdev: internal)
> [    8.457847] NET: Registered protocol family 10
> [    8.463866] Segment Routing with IPv6
> [    8.480927] NET: Registered protocol family 1
> [    8.525386] systemd[1]: systemd 239 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [    8.566174] systemd[1]: Detected architecture x86-64.
> [    8.577268] systemd[1]: Set hostname to <holidayincambodia.molgen.mpg.de>.
> [    8.613097] systemd[1]: File /lib/systemd/system/systemd-journald.service:36 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
> [    8.632013] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
> [    8.693419] random: systemd: uninitialized urandom read (16 bytes read)
> [    8.701731] systemd[1]: Created slice system-serial\x2dlog.slice.
> [    8.709499] random: systemd: uninitialized urandom read (16 bytes read)
> [    8.717474] systemd[1]: Created slice User and Session Slice.
> [    8.727661] random: systemd: uninitialized urandom read (16 bytes read)
> [    8.735656] systemd[1]: Listening on RPCbind Server Activation Socket.
> [    8.743619] systemd[1]: Listening on udev Control Socket.
> [    8.750762] systemd[1]: Created slice system-getty.slice.
> [    8.823976] RPC: Registered named UNIX socket transport module.
> [    8.830329] RPC: Registered udp transport module.
> [    8.835415] RPC: Registered tcp transport module.
> [    8.840658] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    8.878230] random: crng init done
> [    8.881969] random: 7 urandom warning(s) missed due to ratelimiting
> [    8.952978] systemd-journald[946]: Received request to flush runtime journal from PID 1
> [    8.968215] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [    9.019753] acpi_cpufreq: overriding BIOS provided _PSD data
> [    9.170603] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> [    9.178932] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [    9.388105] ixgbe 0000:61:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> [    9.418387] ixgbe 0000:61:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> [    9.444859] ixgbe 0000:61:00.0: MAC: 2, PHY: 20, SFP+: 5, PBA No: Unknown
> [    9.444862] ixgbe 0000:61:00.0: 00:1b:21:bc:f2:d8
> [    9.446393] ixgbe 0000:61:00.0: Intel(R) 10 Gigabit Network Connection
> [    9.523377] kvm: Nested Virtualization enabled
> [    9.528039] kvm: Nested Paging enabled
> [    9.532268] SVM: Virtual VMLOAD VMSAVE supported
> [    9.537347] SVM: Virtual GIF supported
> [    9.632938] ixgbe 0000:61:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> [    9.644357] ixgbe 0000:61:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> [    9.653285] ixgbe 0000:61:00.1: MAC: 2, PHY: 20, SFP+: 6, PBA No: Unknown
> [    9.661061] ixgbe 0000:61:00.1: 00:1b:21:bc:f2:da
> [    9.667623] ixgbe 0000:61:00.1: Intel(R) 10 Gigabit Network Connection
> [    9.864281] igb 0000:11:00.0 net00: renamed from eth0
> [    9.887970] igb 0000:11:00.1 net01: renamed from eth1
> [    9.903261] igb 0000:11:00.2 net02: renamed from eth2
> [    9.938886] igb 0000:11:00.3 net03: renamed from eth3
> [    9.962016] md: md0 stopped.
> [    9.967534] md0: detected capacity change from 0 to 16002857304064
> [    9.973176] ixgbe 0000:61:00.0 net04: renamed from eth4
> [   10.007330] ixgbe 0000:61:00.1 net05: renamed from eth5
> [   10.070539] XFS (sda2): Mounting V5 Filesystem
> [   10.087969] XFS (sda2): Starting recovery (logdev: internal)
> [   10.092412] XFS (sda2): Ending recovery (logdev: internal)
> [   10.252994] XFS (md0): Mounting V5 Filesystem
> [   10.288917] ixgbe 0000:61:00.1: registered PHC device on net05
> [   10.371114] XFS (md0): Starting recovery (logdev: internal)
> [   10.461005] ixgbe 0000:61:00.1 net05: detected SFP+: 6
> [   10.462359] 8021q: 802.1Q VLAN Support v1.8
> [   10.462373] 8021q: adding VLAN 0 to HW filter on device net05
> [   10.479702] NFSD: starting 90-second grace period (net f0000098)
> [   10.666642] XFS (md0): Ending recovery (logdev: internal)
> [   10.709867] ixgbe 0000:61:00.1 net05: NIC Link is Up 10 Gbps, Flow Control: RX/TX
> [  574.471145] FS-Cache: Netfs 'nfs' registered for caching
> [  574.518223] NFS: Registering the id_resolver key type
> [  574.518235] Key type id_resolver registered
> [  574.518236] Key type id_legacy registered
> [87819.183233] systemd[1]: systemd 242 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [87819.195804] systemd[1]: Detected architecture x86-64.
> [87819.226397] systemd[1]: File /lib/systemd/system/systemd-journald.service:12 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
> [87819.226408] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
> [87819.448646] systemd[1]: Stopping Journal Service...
> [87819.448651] systemd-journald[946]: Received SIGTERM from PID 1 (systemd).
> [87819.449439] systemd[1]: systemd-journald.service: Succeeded.
> [87819.449892] systemd[1]: Stopped Journal Service.
> [87819.450971] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
> [87819.452261] systemd[1]: Starting Journal Service...
> [87819.466325] systemd[1]: Started Journal Service.
> [702214.922171] systemd[1]: systemd 242 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [702214.934717] systemd[1]: Detected architecture x86-64.
> [702214.965199] systemd[1]: File /lib/systemd/system/systemd-journald.service:12 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
> [702214.965203] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
> [702215.134733] systemd-journald[47249]: Received SIGTERM from PID 1 (systemd).
> [702215.134816] systemd[1]: Stopping Journal Service...
> [702215.136857] systemd[1]: systemd-journald.service: Succeeded.
> [702215.137315] systemd[1]: Stopped Journal Service.
> [702215.138652] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
> [702215.140106] systemd[1]: Starting Journal Service...
> [702215.371872] systemd[1]: Started Journal Service.
> [773137.977875] fuse init (API version 7.27)
> [2418016.948202] cgroup: fork rejected by pids controller in /user.slice/user-5272.slice/session-1608.scope
> [2418051.367223] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418051.367231] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=14323 
> [2418051.367235] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=14323 
> [2418051.367236] rcu: 	(detected by 2, t=60002 jiffies, g=298982765, q=7633949)
> [2418051.367254] Sending NMI from CPU 2 to CPUs 30:
> [2418061.370201] Sending NMI from CPU 2 to CPUs 94:
> [2418071.372935] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=106
> [2418071.372936] rcu: RCU grace-period kthread stack dump:
> [2418071.372938] rcu_sched       R  running task        0    11      2 0x80000000
> [2418071.372940] Call Trace:
> [2418071.372947]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418071.372950]  ? force_qs_rnp+0x11e/0x140
> [2418071.372952]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418071.372953]  ? __schedule+0x1f8/0x7b0
> [2418071.372955]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418071.372957]  ? kthread+0x113/0x130
> [2418071.372958]  ? kthread_park+0x90/0x90
> [2418071.372960]  ? ret_from_fork+0x22/0x40
> [2418231.372935] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418231.372943] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=52808 
> [2418231.372946] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=52808 
> [2418231.372947] rcu: 	(detected by 5, t=240007 jiffies, g=298982765, q=8914782)
> [2418231.372959] Sending NMI from CPU 5 to CPUs 30:
> [2418241.375808] Sending NMI from CPU 5 to CPUs 94:
> [2418251.378374] rcu: rcu_sched kthread starved for 20002 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=60
> [2418251.378376] rcu: RCU grace-period kthread stack dump:
> [2418251.378378] rcu_sched       R  running task        0    11      2 0x80000000
> [2418251.378381] Call Trace:
> [2418251.378388]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418251.378392]  ? force_qs_rnp+0x11e/0x140
> [2418251.378393]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418251.378395]  ? __schedule+0x1f8/0x7b0
> [2418251.378397]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418251.378399]  ? kthread+0x113/0x130
> [2418251.378400]  ? kthread_park+0x90/0x90
> [2418251.378402]  ? ret_from_fork+0x22/0x40
> [2418411.378841] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418411.378849] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=91376 
> [2418411.378852] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=91376 
> [2418411.378853] rcu: 	(detected by 3, t=420012 jiffies, g=298982765, q=10176682)
> [2418411.378866] Sending NMI from CPU 3 to CPUs 30:
> [2418421.381889] Sending NMI from CPU 3 to CPUs 94:
> [2418431.384518] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=107
> [2418431.384520] rcu: RCU grace-period kthread stack dump:
> [2418431.384521] rcu_sched       R  running task        0    11      2 0x80000000
> [2418431.384523] Call Trace:
> [2418431.384530]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418431.384533]  ? force_qs_rnp+0x11e/0x140
> [2418431.384535]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418431.384537]  ? __schedule+0x1f8/0x7b0
> [2418431.384538]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418431.384540]  ? kthread+0x113/0x130
> [2418431.384541]  ? kthread_park+0x90/0x90
> [2418431.384543]  ? ret_from_fork+0x22/0x40
> [2418591.384966] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418591.384975] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=129879 
> [2418591.384979] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=129879 
> [2418591.384981] rcu: 	(detected by 117, t=600017 jiffies, g=298982765, q=11435854)
> [2418591.384996] Sending NMI from CPU 117 to CPUs 30:
> [2418601.333399] Sending NMI from CPU 117 to CPUs 94:
> [2418611.281815] rcu: rcu_sched kthread starved for 19893 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=112
> [2418611.281816] rcu: RCU grace-period kthread stack dump:
> [2418611.281818] rcu_sched       R  running task        0    11      2 0x80000000
> [2418611.281822] Call Trace:
> [2418611.281833]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418611.281838]  ? force_qs_rnp+0x11e/0x140
> [2418611.281840]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418611.281842]  ? __schedule+0x1f8/0x7b0
> [2418611.281845]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418611.281848]  ? kthread+0x113/0x130
> [2418611.281849]  ? kthread_park+0x90/0x90
> [2418611.281851]  ? ret_from_fork+0x22/0x40
> [2418771.390650] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418771.390658] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=168465 
> [2418771.390662] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=168465 
> [2418771.390663] rcu: 	(detected by 2, t=780022 jiffies, g=298982765, q=12749884)
> [2418771.390675] Sending NMI from CPU 2 to CPUs 30:
> [2418781.393428] Sending NMI from CPU 2 to CPUs 94:
> [2418791.396135] rcu: rcu_sched kthread starved for 20003 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=113
> [2418791.396137] rcu: RCU grace-period kthread stack dump:
> [2418791.396138] rcu_sched       R  running task        0    11      2 0x80000000
> [2418791.396140] Call Trace:
> [2418791.396147]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418791.396150]  ? force_qs_rnp+0x11e/0x140
> [2418791.396152]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418791.396153]  ? __schedule+0x1f8/0x7b0
> [2418791.396156]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418791.396157]  ? kthread+0x113/0x130
> [2418791.396158]  ? kthread_park+0x90/0x90
> [2418791.396160]  ? ret_from_fork+0x22/0x40
> [2418951.396753] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2418951.396762] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=207049 
> [2418951.396766] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=207049 
> [2418951.396767] rcu: 	(detected by 95, t=960027 jiffies, g=298982765, q=14022082)
> [2418951.396781] Sending NMI from CPU 95 to CPUs 30:
> [2418961.403197] Sending NMI from CPU 95 to CPUs 94:
> [2418971.409357] rcu: rcu_sched kthread starved for 20010 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=113
> [2418971.409358] rcu: RCU grace-period kthread stack dump:
> [2418971.409360] rcu_sched       R  running task        0    11      2 0x80000000
> [2418971.409363] Call Trace:
> [2418971.409372]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2418971.409376]  ? force_qs_rnp+0x11e/0x140
> [2418971.409378]  ? rcu_gp_kthread+0x62b/0xdf0
> [2418971.409380]  ? __schedule+0x1f8/0x7b0
> [2418971.409382]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2418971.409384]  ? kthread+0x113/0x130
> [2418971.409385]  ? kthread_park+0x90/0x90
> [2418971.409387]  ? ret_from_fork+0x22/0x40
> [2419131.402607] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2419131.402616] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=245486 
> [2419131.402620] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=245486 
> [2419131.402621] rcu: 	(detected by 0, t=1140032 jiffies, g=298982765, q=15279806)
> [2419131.402644] Sending NMI from CPU 0 to CPUs 30:
> [2419141.405246] Sending NMI from CPU 0 to CPUs 94:
> [2419311.408357] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2419311.408364] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=283962 
> [2419311.408368] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=283962 
> [2419311.408369] rcu: 	(detected by 2, t=1320037 jiffies, g=298982765, q=16540012)
> [2419311.408383] Sending NMI from CPU 2 to CPUs 30:
> [2419321.411197] Sending NMI from CPU 2 to CPUs 94:
> [2419331.413807] rcu: rcu_sched kthread starved for 20002 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=48
> [2419331.413808] rcu: RCU grace-period kthread stack dump:
> [2419331.413810] rcu_sched       R  running task        0    11      2 0x80000000
> [2419331.413813] Call Trace:
> [2419331.413819]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2419331.413822]  ? force_qs_rnp+0x11e/0x140
> [2419331.413824]  ? rcu_gp_kthread+0x62b/0xdf0
> [2419331.413826]  ? __schedule+0x1f8/0x7b0
> [2419331.413828]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2419331.413830]  ? kthread+0x113/0x130
> [2419331.413831]  ? kthread_park+0x90/0x90
> [2419331.413833]  ? ret_from_fork+0x22/0x40
> [2419491.414259] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2419491.414267] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=322489 
> [2419491.414271] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=322489 
> [2419491.414272] rcu: 	(detected by 0, t=1500042 jiffies, g=298982765, q=17795214)
> [2419491.414286] Sending NMI from CPU 0 to CPUs 30:
> [2419501.416916] Sending NMI from CPU 0 to CPUs 94:
> [2419671.420450] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2419671.420458] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=360966 
> [2419671.420463] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=360966 
> [2419671.420464] rcu: 	(detected by 2, t=1680047 jiffies, g=298982765, q=19059675)
> [2419671.420481] Sending NMI from CPU 2 to CPUs 30:
> [2419681.423600] Sending NMI from CPU 2 to CPUs 94:
> [2419691.426232] rcu: rcu_sched kthread starved for 20002 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=55
> [2419691.426233] rcu: RCU grace-period kthread stack dump:
> [2419691.426235] rcu_sched       R  running task        0    11      2 0x80000000
> [2419691.426238] Call Trace:
> [2419691.426244]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2419691.426247]  ? force_qs_rnp+0x11e/0x140
> [2419691.426249]  ? rcu_gp_kthread+0x62b/0xdf0
> [2419691.426251]  ? __schedule+0x1f8/0x7b0
> [2419691.426253]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2419691.426255]  ? kthread+0x113/0x130
> [2419691.426256]  ? kthread_park+0x90/0x90
> [2419691.426258]  ? ret_from_fork+0x22/0x40
> [2419851.426506] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2419851.426513] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=399478 
> [2419851.426517] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=399478 
> [2419851.426518] rcu: 	(detected by 69, t=1860052 jiffies, g=298982765, q=20325818)
> [2419851.426531] Sending NMI from CPU 69 to CPUs 30:
> [2419861.432199] Sending NMI from CPU 69 to CPUs 94:
> [2419871.436312] rcu: rcu_sched kthread starved for 20007 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=48
> [2419871.436314] rcu: RCU grace-period kthread stack dump:
> [2419871.436315] rcu_sched       R  running task        0    11      2 0x80000000
> [2419871.436318] Call Trace:
> [2419871.436325]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2419871.436328]  ? force_qs_rnp+0x11e/0x140
> [2419871.436330]  ? rcu_gp_kthread+0x62b/0xdf0
> [2419871.436332]  ? __schedule+0x1f8/0x7b0
> [2419871.436334]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2419871.436335]  ? kthread+0x113/0x130
> [2419871.436336]  ? kthread_park+0x90/0x90
> [2419871.436338]  ? ret_from_fork+0x22/0x40
> [2420031.432860] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2420031.432868] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=437905 
> [2420031.432872] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=437905 
> [2420031.432873] rcu: 	(detected by 0, t=2040057 jiffies, g=298982765, q=21597869)
> [2420031.432892] Sending NMI from CPU 0 to CPUs 30:
> [2420041.435433] Sending NMI from CPU 0 to CPUs 94:
> [2420211.438955] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2420211.438963] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=476480 
> [2420211.438968] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=476480 
> [2420211.438969] rcu: 	(detected by 71, t=2220062 jiffies, g=298982765, q=22864522)
> [2420211.438986] Sending NMI from CPU 71 to CPUs 30:
> [2420221.444735] Sending NMI from CPU 71 to CPUs 94:
> [2420231.450496] rcu: rcu_sched kthread starved for 20009 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=54
> [2420231.450497] rcu: RCU grace-period kthread stack dump:
> [2420231.450499] rcu_sched       R  running task        0    11      2 0x80000000
> [2420231.450501] Call Trace:
> [2420231.450508]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2420231.450512]  ? force_qs_rnp+0x11e/0x140
> [2420231.450513]  ? rcu_gp_kthread+0x62b/0xdf0
> [2420231.450515]  ? __schedule+0x1f8/0x7b0
> [2420231.450517]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2420231.450519]  ? kthread+0x113/0x130
> [2420231.450520]  ? kthread_park+0x90/0x90
> [2420231.450522]  ? ret_from_fork+0x22/0x40
> [2420391.444919] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2420391.444928] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=514939 
> [2420391.444932] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=514939 
> [2420391.444933] rcu: 	(detected by 5, t=2400067 jiffies, g=298982765, q=24132122)
> [2420391.444951] Sending NMI from CPU 5 to CPUs 30:
> [2420401.447572] Sending NMI from CPU 5 to CPUs 94:
> [2420411.450162] rcu: rcu_sched kthread starved for 20002 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=53
> [2420411.450163] rcu: RCU grace-period kthread stack dump:
> [2420411.450165] rcu_sched       R  running task        0    11      2 0x80000000
> [2420411.450167] Call Trace:
> [2420411.450173]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2420411.450177]  ? force_qs_rnp+0x11e/0x140
> [2420411.450179]  ? rcu_gp_kthread+0x62b/0xdf0
> [2420411.450181]  ? __schedule+0x1f8/0x7b0
> [2420411.450183]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2420411.450186]  ? kthread+0x113/0x130
> [2420411.450187]  ? kthread_park+0x90/0x90
> [2420411.450188]  ? ret_from_fork+0x22/0x40
> [2420571.450902] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2420571.450910] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=553528 
> [2420571.450914] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=553528 
> [2420571.450915] rcu: 	(detected by 2, t=2580072 jiffies, g=298982765, q=25413731)
> [2420571.450934] Sending NMI from CPU 2 to CPUs 30:
> [2420581.453723] Sending NMI from CPU 2 to CPUs 94:
> [2420591.456378] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=53
> [2420591.456379] rcu: RCU grace-period kthread stack dump:
> [2420591.456381] rcu_sched       R  running task        0    11      2 0x80000000
> [2420591.456383] Call Trace:
> [2420591.456390]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2420591.456393]  ? force_qs_rnp+0x11e/0x140
> [2420591.456395]  ? rcu_gp_kthread+0x62b/0xdf0
> [2420591.456396]  ? __schedule+0x1f8/0x7b0
> [2420591.456398]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2420591.456400]  ? kthread+0x113/0x130
> [2420591.456402]  ? kthread_park+0x90/0x90
> [2420591.456403]  ? ret_from_fork+0x22/0x40
> [2420751.456642] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2420751.456650] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=592230 
> [2420751.456654] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=592230 
> [2420751.456655] rcu: 	(detected by 65, t=2760077 jiffies, g=298982765, q=26682249)
> [2420751.456669] Sending NMI from CPU 65 to CPUs 30:
> [2420761.461624] Sending NMI from CPU 65 to CPUs 94:
> [2420771.465151] rcu: rcu_sched kthread starved for 20006 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=53
> [2420771.465152] rcu: RCU grace-period kthread stack dump:
> [2420771.465154] rcu_sched       R  running task        0    11      2 0x80000000
> [2420771.465157] Call Trace:
> [2420771.465164]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2420771.465167]  ? force_qs_rnp+0x11e/0x140
> [2420771.465169]  ? rcu_gp_kthread+0x62b/0xdf0
> [2420771.465170]  ? __schedule+0x1f8/0x7b0
> [2420771.465172]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2420771.465174]  ? kthread+0x113/0x130
> [2420771.465175]  ? kthread_park+0x90/0x90
> [2420771.465176]  ? ret_from_fork+0x22/0x40
> [2420931.462613] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2420931.462623] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=630826 
> [2420931.462628] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=630826 
> [2420931.462630] rcu: 	(detected by 29, t=2940082 jiffies, g=298982765, q=27954074)
> [2420931.462644] Sending NMI from CPU 29 to CPUs 30:
> [2420941.465381] Sending NMI from CPU 29 to CPUs 94:
> [2420951.467932] rcu: rcu_sched kthread starved for 20001 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=116
> [2420951.467933] rcu: RCU grace-period kthread stack dump:
> [2420951.467934] rcu_sched       R  running task        0    11      2 0x80000000
> [2420951.467937] Call Trace:
> [2420951.467947]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2420951.467951]  ? force_qs_rnp+0x11e/0x140
> [2420951.467953]  ? rcu_gp_kthread+0x62b/0xdf0
> [2420951.467954]  ? __schedule+0x1f8/0x7b0
> [2420951.467956]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2420951.467959]  ? kthread+0x113/0x130
> [2420951.467960]  ? kthread_park+0x90/0x90
> [2420951.467961]  ? ret_from_fork+0x22/0x40
> [2421111.468728] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2421111.468738] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=669369 
> [2421111.468744] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=669369 
> [2421111.468745] rcu: 	(detected by 58, t=3120087 jiffies, g=298982765, q=29219785)
> [2421111.468766] Sending NMI from CPU 58 to CPUs 30:
> [2421121.414865] Sending NMI from CPU 58 to CPUs 94:
> [2421131.360719] rcu: rcu_sched kthread starved for 19889 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=53
> [2421131.360720] rcu: RCU grace-period kthread stack dump:
> [2421131.360723] rcu_sched       R  running task        0    11      2 0x80000000
> [2421131.360727] Call Trace:
> [2421131.360743]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2421131.360749]  ? force_qs_rnp+0x11e/0x140
> [2421131.360752]  ? rcu_gp_kthread+0x62b/0xdf0
> [2421131.360754]  ? __schedule+0x1f8/0x7b0
> [2421131.360756]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2421131.360760]  ? kthread+0x113/0x130
> [2421131.360761]  ? kthread_park+0x90/0x90
> [2421131.360763]  ? ret_from_fork+0x22/0x40
> [2421291.474758] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2421291.474766] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=707948 
> [2421291.474770] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=707948 
> [2421291.474772] rcu: 	(detected by 0, t=3300092 jiffies, g=298982765, q=30431789)
> [2421291.474789] Sending NMI from CPU 0 to CPUs 30:
> [2421301.477329] Sending NMI from CPU 0 to CPUs 94:
> [2421471.480515] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2421471.480522] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=746525 
> [2421471.480526] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=746525 
> [2421471.480528] rcu: 	(detected by 3, t=3480097 jiffies, g=298982765, q=31703111)
> [2421471.480580] Sending NMI from CPU 3 to CPUs 30:
> [2421481.483440] Sending NMI from CPU 3 to CPUs 94:
> [2421491.486064] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=116
> [2421491.486065] rcu: RCU grace-period kthread stack dump:
> [2421491.486067] rcu_sched       R  running task        0    11      2 0x80000000
> [2421491.486070] Call Trace:
> [2421491.486076]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2421491.486080]  ? force_qs_rnp+0x11e/0x140
> [2421491.486081]  ? rcu_gp_kthread+0x62b/0xdf0
> [2421491.486083]  ? __schedule+0x1f8/0x7b0
> [2421491.486085]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2421491.486087]  ? kthread+0x113/0x130
> [2421491.486088]  ? kthread_park+0x90/0x90
> [2421491.486089]  ? ret_from_fork+0x22/0x40
> [2421651.486563] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2421651.486571] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=785061 
> [2421651.486576] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=785061 
> [2421651.486577] rcu: 	(detected by 0, t=3660102 jiffies, g=298982765, q=32979051)
> [2421651.486595] Sending NMI from CPU 0 to CPUs 30:
> [2421661.489249] Sending NMI from CPU 0 to CPUs 94:
> [2421831.492721] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2421831.492729] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=823630 
> [2421831.492733] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=823630 
> [2421831.492734] rcu: 	(detected by 0, t=3840107 jiffies, g=298982765, q=34249300)
> [2421831.492752] Sending NMI from CPU 0 to CPUs 30:
> [2421841.495356] Sending NMI from CPU 0 to CPUs 94:
> [2422011.498835] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2422011.498844] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=861983 
> [2422011.498848] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=861983 
> [2422011.498849] rcu: 	(detected by 0, t=4020112 jiffies, g=298982765, q=35529553)
> [2422011.498869] Sending NMI from CPU 0 to CPUs 30:
> [2422021.501474] Sending NMI from CPU 0 to CPUs 94:
> [2422191.504978] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2422191.504986] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=900458 
> [2422191.504990] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=900458 
> [2422191.504992] rcu: 	(detected by 67, t=4200117 jiffies, g=298982765, q=36802901)
> [2422191.505011] Sending NMI from CPU 67 to CPUs 30:
> [2422201.510651] Sending NMI from CPU 67 to CPUs 94:
> [2422211.516377] rcu: rcu_sched kthread starved for 20011 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=116
> [2422211.516379] rcu: RCU grace-period kthread stack dump:
> [2422211.516380] rcu_sched       R  running task        0    11      2 0x80000000
> [2422211.516383] Call Trace:
> [2422211.516390]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2422211.516393]  ? force_qs_rnp+0x11e/0x140
> [2422211.516395]  ? rcu_gp_kthread+0x62b/0xdf0
> [2422211.516397]  ? __schedule+0x1f8/0x7b0
> [2422211.516399]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2422211.516401]  ? kthread+0x113/0x130
> [2422211.516402]  ? kthread_park+0x90/0x90
> [2422211.516403]  ? ret_from_fork+0x22/0x40
> [2422371.511040] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2422371.511049] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=938887 
> [2422371.511054] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=938887 
> [2422371.511055] rcu: 	(detected by 2, t=4380122 jiffies, g=298982765, q=38085353)
> [2422371.511072] Sending NMI from CPU 2 to CPUs 30:
> [2422381.513716] Sending NMI from CPU 2 to CPUs 94:
> [2422391.516380] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=116
> [2422391.516382] rcu: RCU grace-period kthread stack dump:
> [2422391.516384] rcu_sched       R  running task        0    11      2 0x80000000
> [2422391.516386] Call Trace:
> [2422391.516393]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2422391.516397]  ? force_qs_rnp+0x11e/0x140
> [2422391.516399]  ? rcu_gp_kthread+0x62b/0xdf0
> [2422391.516401]  ? __schedule+0x1f8/0x7b0
> [2422391.516403]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2422391.516405]  ? kthread+0x113/0x130
> [2422391.516406]  ? kthread_park+0x90/0x90
> [2422391.516408]  ? ret_from_fork+0x22/0x40
> [2422551.516991] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2422551.516999] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=977253 
> [2422551.517004] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=977253 
> [2422551.517005] rcu: 	(detected by 0, t=4560127 jiffies, g=298982765, q=39373902)
> [2422551.517022] Sending NMI from CPU 0 to CPUs 30:
> [2422561.519580] Sending NMI from CPU 0 to CPUs 94:
> [2422731.522922] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2422731.522935] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1015653 
> [2422731.522939] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1015653 
> [2422731.522941] rcu: 	(detected by 38, t=4740132 jiffies, g=298982765, q=40662635)
> [2422731.522961] Sending NMI from CPU 38 to CPUs 30:
> [2422741.468812] Sending NMI from CPU 38 to CPUs 94:
> [2422751.414668] rcu: rcu_sched kthread starved for 19888 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=53
> [2422751.414669] rcu: RCU grace-period kthread stack dump:
> [2422751.414672] rcu_sched       R  running task        0    11      2 0x80000000
> [2422751.414675] Call Trace:
> [2422751.414692]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2422751.414698]  ? force_qs_rnp+0x11e/0x140
> [2422751.414700]  ? rcu_gp_kthread+0x62b/0xdf0
> [2422751.414702]  ? __schedule+0x1f8/0x7b0
> [2422751.414704]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2422751.414708]  ? kthread+0x113/0x130
> [2422751.414709]  ? kthread_park+0x90/0x90
> [2422751.414710]  ? ret_from_fork+0x22/0x40
> [2422911.528964] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2422911.528973] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1054142 
> [2422911.528977] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1054142 
> [2422911.528978] rcu: 	(detected by 2, t=4920137 jiffies, g=298982765, q=41943663)
> [2422911.528997] Sending NMI from CPU 2 to CPUs 30:
> [2422921.531625] Sending NMI from CPU 2 to CPUs 94:
> [2422931.534333] rcu: rcu_sched kthread starved for 20000 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=113
> [2422931.534334] rcu: RCU grace-period kthread stack dump:
> [2422931.534336] rcu_sched       R  running task        0    11      2 0x80000000
> [2422931.534338] Call Trace:
> [2422931.534345]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2422931.534349]  ? force_qs_rnp+0x11e/0x140
> [2422931.534350]  ? rcu_gp_kthread+0x62b/0xdf0
> [2422931.534352]  ? __schedule+0x1f8/0x7b0
> [2422931.534354]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2422931.534356]  ? kthread+0x113/0x130
> [2422931.534357]  ? kthread_park+0x90/0x90
> [2422931.534359]  ? ret_from_fork+0x22/0x40
> [2423091.534892] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2423091.534900] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1092524 
> [2423091.534904] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1092524 
> [2423091.534905] rcu: 	(detected by 0, t=5100142 jiffies, g=298982765, q=43235292)
> [2423091.534924] Sending NMI from CPU 0 to CPUs 30:
> [2423101.537466] Sending NMI from CPU 0 to CPUs 94:
> [2423271.540682] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2423271.540688] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1130948 
> [2423271.540692] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1130948 
> [2423271.540693] rcu: 	(detected by 0, t=5280147 jiffies, g=298982765, q=44618199)
> [2423271.540706] Sending NMI from CPU 0 to CPUs 30:
> [2423281.543345] Sending NMI from CPU 0 to CPUs 94:
> [2423451.546861] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2423451.546869] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1169491 
> [2423451.546874] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1169491 
> [2423451.546875] rcu: 	(detected by 3, t=5460152 jiffies, g=298982765, q=46124027)
> [2423451.546892] Sending NMI from CPU 3 to CPUs 30:
> [2423461.550052] Sending NMI from CPU 3 to CPUs 94:
> [2423471.552711] rcu: rcu_sched kthread starved for 20005 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=115
> [2423471.552712] rcu: RCU grace-period kthread stack dump:
> [2423471.552714] rcu_sched       R  running task        0    11      2 0x80000000
> [2423471.552717] Call Trace:
> [2423471.552724]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2423471.552727]  ? force_qs_rnp+0x11e/0x140
> [2423471.552729]  ? rcu_gp_kthread+0x62b/0xdf0
> [2423471.552731]  ? __schedule+0x1f8/0x7b0
> [2423471.552733]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2423471.552735]  ? kthread+0x113/0x130
> [2423471.552736]  ? kthread_park+0x90/0x90
> [2423471.552738]  ? ret_from_fork+0x22/0x40
> [2423631.552784] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2423631.552793] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1207772 
> [2423631.552797] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1207772 
> [2423631.552798] rcu: 	(detected by 2, t=5640157 jiffies, g=298982765, q=47631805)
> [2423631.552817] Sending NMI from CPU 2 to CPUs 30:
> [2423641.555452] Sending NMI from CPU 2 to CPUs 94:
> [2423651.558092] rcu: rcu_sched kthread starved for 20004 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=55
> [2423651.558094] rcu: RCU grace-period kthread stack dump:
> [2423651.558095] rcu_sched       R  running task        0    11      2 0x80000000
> [2423651.558097] Call Trace:
> [2423651.558104]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2423651.558108]  ? force_qs_rnp+0x11e/0x140
> [2423651.558109]  ? rcu_gp_kthread+0x62b/0xdf0
> [2423651.558111]  ? __schedule+0x1f8/0x7b0
> [2423651.558113]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2423651.558115]  ? kthread+0x113/0x130
> [2423651.558116]  ? kthread_park+0x90/0x90
> [2423651.558118]  ? ret_from_fork+0x22/0x40
> [2423811.558652] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [2423811.558658] rcu: 	30-...0: (1 GPs behind) idle=4c2/1/0x4000000000000000 softirq=187416321/187416325 fqs=1246280 
> [2423811.558662] rcu: 	94-...0: (1 GPs behind) idle=bba/1/0x4000000000000000 softirq=187177539/187177544 fqs=1246280 
> [2423811.558663] rcu: 	(detected by 2, t=5820162 jiffies, g=298982765, q=49130512)
> [2423811.558677] Sending NMI from CPU 2 to CPUs 30:
> [2423821.561437] Sending NMI from CPU 2 to CPUs 94:
> [2423831.564061] rcu: rcu_sched kthread starved for 20003 jiffies! g298982765 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=53
> [2423831.564063] rcu: RCU grace-period kthread stack dump:
> [2423831.564065] rcu_sched       R  running task        0    11      2 0x80000000
> [2423831.564068] Call Trace:
> [2423831.564075]  ? _raw_spin_unlock_irqrestore+0xa/0x10
> [2423831.564078]  ? force_qs_rnp+0x11e/0x140
> [2423831.564080]  ? rcu_gp_kthread+0x62b/0xdf0
> [2423831.564082]  ? __schedule+0x1f8/0x7b0
> [2423831.564084]  ? rcu_gp_slow.isra.40.part.41+0x30/0x30
> [2423831.564086]  ? kthread+0x113/0x130
> [2423831.564087]  ? kthread_park+0x90/0x90
> [2423831.564088]  ? ret_from_fork+0x22/0x40

> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root          1  0.0  0.0 197604  7568 ?        Ss   Apr17   1:37 /lib/systemd/systemd --system --deserialize 22
> root          2  0.0  0.0      0     0 ?        S    Apr17   0:11 [kthreadd]
> root          3  0.0  0.0      0     0 ?        I<   Apr17   0:00 [rcu_gp]
> root          4  0.0  0.0      0     0 ?        I<   Apr17   0:00 [rcu_par_gp]
> root          6  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/0:0H-kb]
> root          9  0.0  0.0      0     0 ?        I<   Apr17   0:00 [mm_percpu_wq]
> root         10  0.0  0.0      0     0 ?        S    Apr17   0:26 [ksoftirqd/0]
> root         11  0.0  0.0      0     0 ?        R    Apr17  29:40 [rcu_sched]
> root         12  0.0  0.0      0     0 ?        I    Apr17   0:00 [rcu_bh]
> root         13  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/0]
> root         14  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/0]
> root         15  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/1]
> root         16  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/1]
> root         17  0.0  0.0      0     0 ?        S    Apr17   0:05 [ksoftirqd/1]
> root         19  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/1:0H-kb]
> root         20  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/2]
> root         21  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/2]
> root         22  0.0  0.0      0     0 ?        S    Apr17   0:06 [ksoftirqd/2]
> root         24  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/2:0H-kb]
> root         25  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/3]
> root         26  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/3]
> root         27  0.0  0.0      0     0 ?        S    Apr17   0:07 [ksoftirqd/3]
> root         29  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/3:0H-kb]
> root         30  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/4]
> root         31  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/4]
> root         32  0.0  0.0      0     0 ?        S    Apr17   0:07 [ksoftirqd/4]
> root         34  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/4:0H]
> root         35  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/5]
> root         36  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/5]
> root         37  0.0  0.0      0     0 ?        S    Apr17   1:01 [ksoftirqd/5]
> root         39  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/5:0H-kb]
> root         40  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/6]
> root         41  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/6]
> root         42  0.0  0.0      0     0 ?        S    Apr17   0:25 [ksoftirqd/6]
> root         44  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/6:0H]
> root         45  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/7]
> root         46  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/7]
> root         47  0.0  0.0      0     0 ?        S    Apr17   0:07 [ksoftirqd/7]
> root         49  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/7:0H-kb]
> root         50  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/8]
> root         51  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/8]
> root         52  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/8]
> root         54  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/8:0H-kb]
> root         56  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/9]
> root         57  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/9]
> root         58  0.0  0.0      0     0 ?        S    Apr17   0:07 [ksoftirqd/9]
> root         60  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/9:0H-kb]
> root         61  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/10]
> root         62  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/10]
> root         63  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/10]
> root         65  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/10:0H-k]
> root         66  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/11]
> root         67  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/11]
> root         68  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/11]
> root         70  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/11:0H-k]
> root         71  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/12]
> root         72  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/12]
> root         73  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/12]
> root         75  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/12:0H-k]
> root         76  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/13]
> root         77  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/13]
> root         78  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/13]
> root         80  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/13:0H-k]
> root         81  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/14]
> root         82  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/14]
> root         83  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/14]
> root         85  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/14:0H-k]
> root         86  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/15]
> root         87  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/15]
> root         88  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/15]
> root         90  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/15:0H-k]
> root         91  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/16]
> root         92  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/16]
> root         93  0.0  0.0      0     0 ?        S    Apr17   0:07 [ksoftirqd/16]
> root         95  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/16:0H-k]
> root         97  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/17]
> root         98  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/17]
> root         99  0.0  0.0      0     0 ?        S    Apr17   0:05 [ksoftirqd/17]
> root        101  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/17:0H-k]
> root        102  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/18]
> root        103  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/18]
> root        104  0.0  0.0      0     0 ?        S    Apr17   0:11 [ksoftirqd/18]
> root        106  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/18:0H-k]
> root        107  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/19]
> root        108  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/19]
> root        109  0.0  0.0      0     0 ?        S    Apr17   0:14 [ksoftirqd/19]
> root        111  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/19:0H-k]
> root        112  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/20]
> root        113  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/20]
> root        114  0.0  0.0      0     0 ?        S    Apr17   0:06 [ksoftirqd/20]
> root        116  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/20:0H-k]
> root        117  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/21]
> root        118  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/21]
> root        119  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/21]
> root        121  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/21:0H-k]
> root        122  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/22]
> root        123  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/22]
> root        124  0.0  0.0      0     0 ?        S    Apr17   0:05 [ksoftirqd/22]
> root        126  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/22:0H]
> root        127  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/23]
> root        128  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/23]
> root        129  0.0  0.0      0     0 ?        S    Apr17   0:41 [ksoftirqd/23]
> root        131  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/23:0H-k]
> root        132  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/24]
> root        133  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/24]
> root        134  0.0  0.0      0     0 ?        S    Apr17   0:13 [ksoftirqd/24]
> root        136  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/24:0H-k]
> root        138  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/25]
> root        139  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/25]
> root        140  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/25]
> root        142  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/25:0H]
> root        143  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/26]
> root        144  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/26]
> root        145  0.0  0.0      0     0 ?        S    Apr17   0:06 [ksoftirqd/26]
> root        147  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/26:0H-k]
> root        148  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/27]
> root        149  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/27]
> root        150  0.0  0.0      0     0 ?        S    Apr17   0:05 [ksoftirqd/27]
> root        152  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/27:0H-k]
> root        153  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/28]
> root        154  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/28]
> root        155  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/28]
> root        157  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/28:0H-k]
> root        158  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/29]
> root        159  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/29]
> root        160  0.0  0.0      0     0 ?        R    Apr17   0:03 [ksoftirqd/29]
> root        162  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/29:0H-k]
> root        163  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/30]
> root        164  0.0  0.0      0     0 ?        R    Apr17   0:00 [migration/30]
> root        165  0.0  0.0      0     0 ?        S    Apr17   1:15 [ksoftirqd/30]
> root        167  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/30:0H-k]
> root        168  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/31]
> root        169  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/31]
> root        170  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/31]
> root        172  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/31:0H-k]
> root        173  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/32]
> root        174  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/32]
> root        175  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/32]
> root        177  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/32:0H-k]
> root        179  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/33]
> root        180  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/33]
> root        181  0.0  0.0      0     0 ?        S    Apr17   0:15 [ksoftirqd/33]
> root        183  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/33:0H-k]
> root        184  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/34]
> root        185  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/34]
> root        186  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/34]
> root        188  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/34:0H]
> root        189  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/35]
> root        190  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/35]
> root        191  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/35]
> root        193  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/35:0H-k]
> root        194  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/36]
> root        195  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/36]
> root        196  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/36]
> root        198  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/36:0H-k]
> root        199  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/37]
> root        200  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/37]
> root        201  0.0  0.0      0     0 ?        S    Apr17   0:05 [ksoftirqd/37]
> root        203  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/37:0H-k]
> root        204  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/38]
> root        205  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/38]
> root        206  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/38]
> root        208  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/38:0H-k]
> root        209  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/39]
> root        210  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/39]
> root        211  0.0  0.0      0     0 ?        S    Apr17   0:08 [ksoftirqd/39]
> root        213  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/39:0H-k]
> root        214  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/40]
> root        215  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/40]
> root        216  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/40]
> root        218  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/40:0H-k]
> root        220  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/41]
> root        221  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/41]
> root        222  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/41]
> root        224  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/41:0H-k]
> root        225  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/42]
> root        226  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/42]
> root        227  0.0  0.0      0     0 ?        S    Apr17   0:05 [ksoftirqd/42]
> root        229  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/42:0H-k]
> root        230  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/43]
> root        231  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/43]
> root        232  0.0  0.0      0     0 ?        S    Apr17   0:26 [ksoftirqd/43]
> root        234  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/43:0H-k]
> root        235  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/44]
> root        236  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/44]
> root        237  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/44]
> root        239  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/44:0H-k]
> root        240  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/45]
> root        241  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/45]
> root        242  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/45]
> root        244  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/45:0H-k]
> root        245  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/46]
> root        246  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/46]
> root        247  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/46]
> root        249  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/46:0H-k]
> root        250  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/47]
> root        251  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/47]
> root        252  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/47]
> root        254  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/47:0H-k]
> root        255  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/48]
> root        256  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/48]
> root        257  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/48]
> root        259  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/48:0H-k]
> root        261  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/49]
> root        262  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/49]
> root        263  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/49]
> root        265  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/49:0H-k]
> root        266  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/50]
> root        267  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/50]
> root        268  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/50]
> root        270  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/50:0H-k]
> root        271  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/51]
> root        272  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/51]
> root        273  0.0  0.0      0     0 ?        S    Apr17   0:21 [ksoftirqd/51]
> root        275  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/51:0H-k]
> root        276  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/52]
> root        277  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/52]
> root        278  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/52]
> root        280  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/52:0H-k]
> root        281  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/53]
> root        282  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/53]
> root        283  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/53]
> root        285  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/53:0H-k]
> root        286  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/54]
> root        287  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/54]
> root        288  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/54]
> root        290  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/54:0H-k]
> root        291  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/55]
> root        292  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/55]
> root        293  0.0  0.0      0     0 ?        S    Apr17   0:03 [ksoftirqd/55]
> root        295  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/55:0H-k]
> root        296  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/56]
> root        297  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/56]
> root        298  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/56]
> root        300  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/56:0H-k]
> root        302  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/57]
> root        303  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/57]
> root        304  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/57]
> root        306  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/57:0H-k]
> root        307  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/58]
> root        308  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/58]
> root        309  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/58]
> root        311  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/58:0H-k]
> root        312  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/59]
> root        313  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/59]
> root        314  0.0  0.0      0     0 ?        S    Apr17   0:04 [ksoftirqd/59]
> root        316  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/59:0H-k]
> root        317  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/60]
> root        318  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/60]
> root        319  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/60]
> root        321  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/60:0H-k]
> root        322  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/61]
> root        323  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/61]
> root        324  0.0  0.0      0     0 ?        S    Apr17   0:06 [ksoftirqd/61]
> root        326  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/61:0H-k]
> root        327  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/62]
> root        328  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/62]
> root        329  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/62]
> root        331  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/62:0H-k]
> root        332  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/63]
> root        333  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/63]
> root        334  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/63]
> root        336  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/63:0H-k]
> root        337  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/64]
> root        338  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/64]
> root        339  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/64]
> root        341  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/64:0H-k]
> root        342  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/65]
> root        343  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/65]
> root        344  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/65]
> root        346  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/65:0H-k]
> root        347  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/66]
> root        348  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/66]
> root        349  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/66]
> root        351  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/66:0H-k]
> root        352  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/67]
> root        353  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/67]
> root        354  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/67]
> root        356  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/67:0H-k]
> root        357  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/68]
> root        358  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/68]
> root        359  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/68]
> root        361  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/68:0H-k]
> root        362  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/69]
> root        363  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/69]
> root        364  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/69]
> root        366  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/69:0H-k]
> root        367  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/70]
> root        368  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/70]
> root        369  0.0  0.0      0     0 ?        S    Apr17   0:02 [ksoftirqd/70]
> root        371  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/70:0H-k]
> root        372  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/71]
> root        373  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/71]
> root        374  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/71]
> root        376  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/71:0H]
> root        377  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/72]
> root        378  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/72]
> root        379  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/72]
> root        381  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/72:0H-k]
> root        382  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/73]
> root        383  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/73]
> root        384  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/73]
> root        386  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/73:0H-k]
> root        387  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/74]
> root        388  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/74]
> root        389  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/74]
> root        391  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/74:0H-k]
> root        392  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/75]
> root        393  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/75]
> root        394  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/75]
> root        396  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/75:0H-k]
> root        397  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/76]
> root        398  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/76]
> root        399  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/76]
> root        401  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/76:0H-k]
> root        402  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/77]
> root        403  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/77]
> root        404  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/77]
> root        406  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/77:0H-k]
> root        407  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/78]
> root        408  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/78]
> root        409  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/78]
> root        411  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/78:0H-k]
> root        412  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/79]
> root        413  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/79]
> root        414  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/79]
> root        416  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/79:0H-k]
> root        417  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/80]
> root        418  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/80]
> root        419  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/80]
> root        421  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/80:0H-k]
> root        422  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/81]
> root        423  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/81]
> root        424  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/81]
> root        426  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/81:0H]
> root        427  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/82]
> root        428  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/82]
> root        429  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/82]
> root        431  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/82:0H-k]
> root        432  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/83]
> root        433  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/83]
> root        434  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/83]
> root        436  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/83:0H-k]
> root        437  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/84]
> root        438  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/84]
> root        439  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/84]
> root        441  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/84:0H-k]
> root        442  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/85]
> root        443  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/85]
> root        444  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/85]
> root        446  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/85:0H-k]
> root        447  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/86]
> root        448  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/86]
> root        449  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/86]
> root        451  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/86:0H-k]
> root        452  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/87]
> root        453  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/87]
> root        454  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/87]
> root        456  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/87:0H-k]
> root        457  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/88]
> root        458  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/88]
> root        459  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/88]
> root        461  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/88:0H-k]
> root        462  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/89]
> root        463  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/89]
> root        464  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/89]
> root        466  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/89:0H-k]
> root        467  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/90]
> root        468  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/90]
> root        469  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/90]
> root        471  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/90:0H-k]
> root        472  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/91]
> root        473  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/91]
> root        474  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/91]
> root        476  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/91:0H-k]
> root        477  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/92]
> root        478  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/92]
> root        479  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/92]
> root        481  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/92:0H-k]
> root        482  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/93]
> root        483  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/93]
> root        484  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/93]
> root        486  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/93:0H-k]
> root        487  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/94]
> root        488  0.0  0.0      0     0 ?        R    Apr17   0:00 [migration/94]
> root        489  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/94]
> root        491  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/94:0H-k]
> root        492  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/95]
> root        493  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/95]
> root        494  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/95]
> root        496  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/95:0H-k]
> root        497  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/96]
> root        498  0.0  0.0      0     0 ?        R    Apr17   0:00 [migration/96]
> root        499  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/96]
> root        501  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/96:0H-k]
> root        502  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/97]
> root        503  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/97]
> root        504  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/97]
> root        506  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/97:0H-k]
> root        507  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/98]
> root        508  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/98]
> root        509  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/98]
> root        511  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/98:0H-k]
> root        512  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/99]
> root        513  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/99]
> root        514  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/99]
> root        516  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/99:0H-k]
> root        517  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/100]
> root        518  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/100]
> root        519  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/100]
> root        521  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/100:0H-]
> root        522  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/101]
> root        523  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/101]
> root        524  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/101]
> root        526  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/101:0H-]
> root        527  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/102]
> root        528  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/102]
> root        529  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/102]
> root        531  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/102:0H-]
> root        532  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/103]
> root        533  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/103]
> root        534  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/103]
> root        536  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/103:0H-]
> root        537  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/104]
> root        538  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/104]
> root        539  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/104]
> root        541  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/104:0H]
> root        542  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/105]
> root        543  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/105]
> root        544  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/105]
> root        546  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/105:0H]
> root        547  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/106]
> root        548  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/106]
> root        549  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/106]
> root        551  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/106:0H-]
> root        552  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/107]
> root        553  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/107]
> root        554  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/107]
> root        556  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/107:0H-]
> root        557  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/108]
> root        558  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/108]
> root        559  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/108]
> root        561  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/108:0H]
> root        562  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/109]
> root        563  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/109]
> root        564  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/109]
> root        566  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/109:0H]
> root        567  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/110]
> root        568  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/110]
> root        569  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/110]
> root        571  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/110:0H-]
> root        572  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/111]
> root        573  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/111]
> root        574  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/111]
> root        576  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/111:0H-]
> root        577  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/112]
> root        578  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/112]
> root        579  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/112]
> root        581  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/112:0H-]
> root        582  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/113]
> root        583  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/113]
> root        584  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/113]
> root        586  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/113:0H-]
> root        587  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/114]
> root        588  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/114]
> root        589  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/114]
> root        591  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/114:0H-]
> root        592  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/115]
> root        593  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/115]
> root        594  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/115]
> root        596  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/115:0H-]
> root        597  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/116]
> root        598  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/116]
> root        599  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/116]
> root        601  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/116:0H-]
> root        602  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/117]
> root        603  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/117]
> root        604  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/117]
> root        606  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/117:0H-]
> root        607  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/118]
> root        608  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/118]
> root        609  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/118]
> root        611  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/118:0H-]
> root        612  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/119]
> root        613  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/119]
> root        614  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/119]
> root        616  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/119:0H-]
> root        617  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/120]
> root        618  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/120]
> root        619  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/120]
> root        621  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/120:0H-]
> root        622  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/121]
> root        623  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/121]
> root        624  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/121]
> root        626  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/121:0H-]
> root        627  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/122]
> root        628  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/122]
> root        629  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/122]
> root        631  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/122:0H-]
> root        632  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/123]
> root        633  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/123]
> root        634  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/123]
> root        636  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/123:0H-]
> root        637  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/124]
> root        638  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/124]
> root        639  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/124]
> root        641  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/124:0H-]
> root        642  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/125]
> root        643  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/125]
> root        644  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/125]
> root        646  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/125:0H-]
> root        647  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/126]
> root        648  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/126]
> root        649  0.0  0.0      0     0 ?        S    Apr17   0:01 [ksoftirqd/126]
> root        651  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/126:0H-]
> root        652  0.0  0.0      0     0 ?        S    Apr17   0:00 [cpuhp/127]
> root        653  0.0  0.0      0     0 ?        S    Apr17   0:00 [migration/127]
> root        654  0.0  0.0      0     0 ?        S    Apr17   0:00 [ksoftirqd/127]
> root        656  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/127:0H-]
> root        657  0.0  0.0      0     0 ?        S    Apr17   0:00 [kdevtmpfs]
> root        658  0.0  0.0      0     0 ?        I<   Apr17   0:00 [netns]
> root        668  0.0  0.0      0     0 ?        S    Apr17   0:00 [oom_reaper]
> root        669  0.0  0.0      0     0 ?        I<   Apr17   0:00 [writeback]
> root        670  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd0]
> root        671  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd1]
> root        672  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd2]
> root        673  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd3]
> root        674  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd4]
> root        675  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd5]
> root        676  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd6]
> root        677  0.0  0.0      0     0 ?        S    Apr17   0:00 [kcompactd7]
> root        678  0.2  0.0      0     0 ?        RN   Apr17  84:24 [khugepaged]
> root        680  0.0  0.0      0     0 ?        I<   Apr17   0:00 [crypto]
> root        681  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kintegrityd]
> root        682  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kblockd]
> root        690  0.0  0.0      0     0 ?        I<   Apr17   0:00 [ata_sff]
> root        691  0.0  0.0      0     0 ?        I<   Apr17   0:00 [md]
> root        692  0.0  0.0      0     0 ?        I<   Apr17   0:00 [edac-poller]
> root        693  0.0  0.0      0     0 ?        S    Apr17   0:00 [watchdogd]
> root        696  0.0  0.0      0     0 ?        S    Apr17   4:08 [kswapd0]
> root        697  0.0  0.0      0     0 ?        S    Apr17   3:59 [kswapd1]
> root        698  0.0  0.0      0     0 ?        S    Apr17   4:12 [kswapd2]
> root        699  0.0  0.0      0     0 ?        S    Apr17   4:16 [kswapd3]
> root        700  0.0  0.0      0     0 ?        S    Apr17   4:29 [kswapd4]
> root        701  0.0  0.0      0     0 ?        S    Apr17   4:05 [kswapd5]
> root        702  0.0  0.0      0     0 ?        S    Apr17   4:34 [kswapd6]
> root        703  0.0  0.0      0     0 ?        S    Apr17   4:06 [kswapd7]
> root        704  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfsalloc]
> root        705  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs_mru_cache]
> root        717  0.0  0.0      0     0 ?        I    06:52   0:00 [kworker/65:2]
> root        722  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kthrotld]
> root        723  0.6  0.0      0     0 ?        SN   Apr17 266:20 [kipmi0]
> root        725  0.0  0.0      0     0 ?        I    06:52   0:00 [kworker/8:1-eve]
> root        760  0.0  0.0      0     0 ?        I    06:53   0:07 [kworker/0:0-eve]
> root        789  0.0  0.0      0     0 ?        I    06:54   0:02 [kworker/1:1-eve]
> root        834  0.0  0.0      0     0 ?        I<   Apr17   0:00 [acpi_thermal_pm]
> root        838  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/u265:0]
> root        847  0.0  0.0      0     0 ?        I<   Apr17   0:00 [knbd-recv]
> root        848  0.0  0.0      0     0 ?        I<   Apr17   0:00 [drbd-reissue]
> root        849  0.0  0.0      0     0 ?        I<   Apr17   0:00 [nvme-wq]
> root        850  0.0  0.0      0     0 ?        I<   Apr17   0:00 [nvme-reset-wq]
> root        851  0.0  0.0      0     0 ?        I<   Apr17   0:00 [nvme-delete-wq]
> root        852  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_0]
> root        853  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_0]
> root        854  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_1]
> root        855  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_1]
> root        856  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_2]
> root        857  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_2]
> root        858  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_3]
> root        859  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_3]
> root        860  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_4]
> root        861  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_4]
> root        862  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_5]
> root        863  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_5]
> root        864  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_6]
> root        865  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_6]
> root        866  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_7]
> root        867  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_7]
> root        876  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_8]
> root        877  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_8]
> root        878  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_9]
> root        879  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_9]
> root        880  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_10]
> root        881  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_10]
> root        882  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_11]
> root        883  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_11]
> root        884  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_12]
> root        885  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_12]
> root        886  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_13]
> root        887  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_13]
> root        888  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_14]
> root        889  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_14]
> root        890  0.0  0.0      0     0 ?        S    Apr17   0:00 [scsi_eh_15]
> root        891  0.0  0.0      0     0 ?        I<   Apr17   0:00 [scsi_tmf_15]
> root        900  0.0  0.0      0     0 ?        I<   Apr17   0:00 [bnx2x]
> root        901  0.0  0.0      0     0 ?        I<   Apr17   0:00 [bnx2x_iov]
> root        904  0.0  0.0      0     0 ?        I<   Apr17   0:00 [raid5wq]
> root        906  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/9:1H-kb]
> root        907  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/72:1H-k]
> root        908  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/73:1H-k]
> root        909  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/10:1H-k]
> root        917  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/66:1H-x]
> root        918  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-buf/sda1]
> root        919  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-data/sda1]
> root        920  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-conv/sda1]
> root        921  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-cil/sda1]
> root        922  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-reclaim/sda]
> root        923  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-log/sda1]
> root        924  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-eofblocks/s]
> root        925  0.0  0.0      0     0 ?        S    Apr17   3:41 [xfsaild/sda1]
> root        926  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/0:1H-kb]
> root        927  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/65:1H-k]
> root        928  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/67:1H-k]
> root        931  0.0  0.0      0     0 ?        I<   Apr17   0:00 [ipv6_addrconf]
> root        956  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/82:1H-k]
> root        957  0.0  0.0      0     0 ?        I<   Apr17   0:00 [rpciod]
> root        958  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xprtiod]
> root       1055  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/70:1H-k]
> root       1145  0.0  0.0      0     0 ?        I<   Apr17   0:00 [ixgbe]
> root       1274  0.0  0.0  96664  3848 ?        Ss   Apr17   0:46 /usr/bin/ntpd --nofork --ipv4 --panicgate
> root       1276  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/8:1H-kb]
> root       1278  0.0  0.0 254476  2944 ?        Ssl  Apr17   0:02 /usr/sbin/rsyslogd -n -c5
> root       1293  0.0  0.0  16056  1704 ?        Ss   Apr17   0:00 /bin/bash /usr/libexec/serial-log ttyS1
> dbus       1298  0.0  0.0  40076  4392 ?        Ss   Apr17   0:39 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
> root       1303  0.0  0.0  11500  2224 ?        Ss   Apr17   0:04 /usr/sbin/crond -n
> nobody     1304  0.0  0.0  16056  2300 ?        Ss   Apr17   1:15 /bin/bash /usr/sbin/mxloadmonitor-collectd
> root       1323  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/95:1H-k]
> root       1326  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/94:1H-k]
> root       1329  0.0  0.0   4296   720 ?        S    Apr17   0:00 cat /dev/ttyS1
> root       1330  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/91:1H-k]
> root       1335  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/34:1H-k]
> root       1336  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/81:1H-k]
> root       1337  0.0  0.0  26720   236 ?        Ss   Apr17   0:00 /usr/sbin/saslauthd -a pam
> root       1338  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/6:1H-kb]
> root       1339  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/80:1H-k]
> root       1343  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/25:1H-k]
> root       1344  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/71:1H-x]
> root       1345  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/22:1H-x]
> root       1347  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/4:1H-kb]
> root       1348  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/83:1H-k]
> root       1349  0.0  0.0  26720   256 ?        S    Apr17   0:00 /usr/sbin/saslauthd -a pam
> root       1350  0.0  0.0  26720   256 ?        S    Apr17   0:00 /usr/sbin/saslauthd -a pam
> root       1351  0.0  0.0  26720   256 ?        S    Apr17   0:00 /usr/sbin/saslauthd -a pam
> root       1352  0.0  0.0  26720   256 ?        S    Apr17   0:00 /usr/sbin/saslauthd -a pam
> nobody     1361  0.0  0.0  21528  2408 ?        Ss   Apr17   0:24 /usr/sbin/lighttpd -D -f /etc/mxloadmonitor-lighttpd.conf
> root       1366  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/28:1H-k]
> root       1378  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/3:1H-kb]
> root       1381  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/15:1H-x]
> root       1403  0.0  0.0      0     0 ?        R    07:09   0:00 [kworker/96:2-mm]
> root       1405  0.0  0.0      0     0 ?        I    07:09   0:01 [kworker/33:1-ev]
> root       1414  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-buf/sda2]
> root       1415  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-data/sda2]
> root       1416  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-conv/sda2]
> root       1417  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-cil/sda2]
> root       1418  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-reclaim/sda]
> root       1419  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-log/sda2]
> root       1420  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-eofblocks/s]
> root       1421  0.0  0.0      0     0 ?        S    Apr17   0:05 [xfsaild/sda2]
> root       1424  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/27:1H-k]
> root       1436  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-buf/md0]
> root       1437  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-data/md0]
> root       1438  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-conv/md0]
> root       1439  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-cil/md0]
> root       1440  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-reclaim/md0]
> root       1441  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-log/md0]
> root       1442  0.0  0.0      0     0 ?        I<   Apr17   0:00 [xfs-eofblocks/m]
> root       1443  0.0  0.0      0     0 ?        S    Apr17   0:16 [xfsaild/md0]
> unbound    1465  0.0  0.0  29392  7276 ?        Ss   Apr17   0:04 /usr/sbin/unbound
> root       1466  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/31:1H-k]
> root       1470  0.0  0.0  31528  2972 ?        Ss   Apr17   0:00 /usr/sbin/rpc.mountd --foreground --manage-gids
> root       1473  0.0  0.0  50264  3248 ?        Ss   Apr17   0:01 /usr/sbin/rpcbind -w -f
> root       1482  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1483  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1484  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1485  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1486  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1487  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1488  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1489  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1490  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1491  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1492  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1493  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1494  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1495  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1496  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1497  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1498  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1499  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1500  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1501  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1502  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1503  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1504  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1505  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1506  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1507  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1508  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1509  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1510  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1511  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1512  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1513  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1514  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1515  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1516  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1517  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1518  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1519  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1520  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1521  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1522  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1523  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1524  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1525  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1526  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1527  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1528  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1529  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1530  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1531  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1532  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1533  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1534  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1535  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1536  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1537  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1538  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1539  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1540  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1541  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1542  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1543  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1544  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1545  0.0  0.0      0     0 ?        S    Apr17   0:00 [nfsd]
> root       1559  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/29:1H-k]
> root       1597  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/64:1H-k]
> root       1618  0.0  0.0 1372048 7364 ?        Ssl  Apr17   1:49 /usr/sbin/automount -v
> root       1642  0.0  0.0  46040  8552 ?        Ss   Apr17   4:18 /usr/bin/perl /usr/sbin/netlog --daemon --foreground --kill --syslog /var/log/messages /var/log/mail.log
> root       1644  0.0  0.0  27308  3260 ?        Ss   Apr17   0:00 /usr/sbin/sshd -D
> root       1645  0.0  0.0  49984 10660 ?        Ss   Apr17  15:25 /usr/bin/perl /usr/sbin/clusterd --daemon --foreground --kill --syslog
> root       1647  0.0  0.0  69396  2972 tty1     Ss   Apr17   0:00 /bin/login -p --
> root       1648  0.0  0.0  90544   868 ?        Ssl  Apr17   0:10 /usr/sbin/ypbind -foreground
> root       1661  0.0  0.0      0     0 ?        I<   Apr17   0:05 [kworker/11:1H-k]
> root       1662  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/12:1H-k]
> root       1663  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/13:1H-k]
> root       1664  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/14:1H-k]
> root       1665  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/77:1H-k]
> root       1666  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/78:1H-k]
> root       1675  0.0  0.0      0     0 ?        I<   Apr17   0:05 [kworker/24:1H-x]
> root       1676  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/74:1H-k]
> root       1696  0.0  0.0      0     0 ?        I<   Apr17   0:14 [kworker/30:1H-k]
> root       1697  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/76:1H-k]
> root       1698  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/79:1H-k]
> root       1782  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/16:1H-k]
> root       1845  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/2:1H-kb]
> root       1869  0.0  0.0      0     0 ?        I<   Apr17   0:00 [nfsiod]
> root       1875  0.0  0.0      0     0 ?        S    Apr17   0:00 [NFSv4 callback]
> root       1913  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/17:1H-x]
> root       1968  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/85:1H-x]
> root       2015  0.0  0.0      0     0 ?        S    Apr17   0:00 [NFSv4 callback]
> root       2019  0.0  0.0      0     0 ?        I    07:20   0:00 [kworker/106:0-e]
> root       2060  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/89:1H-k]
> root       2070  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/26:1H-k]
> root       2142  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/19:1H-k]
> root       2158  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/92:1H-k]
> root       2180  0.0  0.0      0     0 ?        S    Apr17   0:01 [NFSv4 callback]
> root       2339  0.0  0.0      0     0 ?        I    07:27   0:01 [kworker/7:2-eve]
> root       2571  0.0  0.0      0     0 ?        I    07:34   0:00 [kworker/98:0-ev]
> root       2832  0.0  0.0      0     0 ?        I    07:37   0:00 [kworker/37:2-ev]
> root       2842  0.0  0.0      0     0 ?        I    07:38   0:00 [kworker/114:1]
> root       3450  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/7:1H-kb]
> root       3454  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/69:1H-k]
> root       3459  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/68:1H-k]
> root       3461  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/1:1H-xf]
> root       3530  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/5:1H-kb]
> root       3672  0.0  0.0      0     0 ?        I    07:53   0:00 [kworker/70:0-ev]
> root       3812  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/60:1H-k]
> root       3813  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/61:1H-k]
> root       3814  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/122:1H-]
> root       3815  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/123:1H-]
> root       3816  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/57:1H-k]
> root       3817  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/63:1H-k]
> root       3818  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/124:1H-]
> root       3830  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/127:1H-]
> root       3836  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/125:1H-]
> root       3837  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/62:1H-k]
> root       3844  0.0  0.0      0     0 ?        I    May14   0:00 [kworker/47:6-nf]
> root       3906  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/126:1H-]
> root       3930  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/100:1H-]
> root       4105  0.0  0.0      0     0 ?        I    08:02   0:00 [kworker/88:0]
> root       4112  0.0  0.0      0     0 ?        I    08:02   0:00 [kworker/91:1-cg]
> root       4226  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/93:1H-k]
> root       4344  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/90:1H-k]
> root       4735  0.0  0.0      0     0 ?        I    08:12   0:01 [kworker/32:0-ev]
> root       4956  0.0  0.0      0     0 ?        I    08:20   0:00 [kworker/6:0-eve]
> root       5120  0.0  0.0      0     0 ?        I    08:23   0:00 [kworker/50:2-ev]
> root       5153  0.0  0.0      0     0 ?        I    08:24   0:00 [kworker/102:2-e]
> root       5317  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/88:1H-k]
> root       5357  0.0  0.0      0     0 ?        I    08:28   0:00 [kworker/27:0-xf]
> root       5516  0.0  0.0      0     0 ?        I    08:31   0:00 [kworker/83:0-mm]
> root       5523  0.1  0.0      0     0 ?        I    May14   1:07 [kworker/107:1-e]
> root       5571  0.0  0.0      0     0 ?        I    08:33   0:00 [kworker/25:0-xf]
> root       5681  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/75:1H-k]
> root       5918  0.0  0.0      0     0 ?        I    08:46   0:00 [kworker/8:0-eve]
> root       5998  0.0  0.0      0     0 ?        I    02:46   0:00 [kworker/102:0]
> root       6016  9.1  0.0      0     0 ?        R    May14  88:37 [kworker/29:0+ev]
> root       6127  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/96:1H-k]
> root       6128  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/97:1H-k]
> root       6129  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/32:1H-k]
> root       6131  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/33:1H-k]
> root       6308  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/99:1H-k]
> root       6397  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/35:1H-k]
> root       6431  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/98:1H-k]
> root       6601  0.0  0.0      0     0 ?        I    08:59   0:00 [kworker/27:2-ev]
> root       6642  0.0  0.0      0     0 ?        I    09:00   0:00 [kworker/29:2-cg]
> root       6653  0.0  0.0      0     0 ?        I    09:00   0:00 [kworker/31:2-cg]
> root       6714  0.0  0.0      0     0 ?        I    03:02   0:05 [kworker/30:2-ev]
> root       6729  0.0  0.0      0     0 ?        I    09:02   0:00 [kworker/95:2-cg]
> root       6757  0.0  0.0      0     0 ?        I    09:03   0:00 [kworker/113:0-e]
> root       6907  0.0  0.0      0     0 ?        I    09:08   0:00 [kworker/28:1-ev]
> root       6962  0.0  0.0      0     0 ?        I    May14   0:19 [kworker/55:3-nf]
> root       7149  0.0  0.0      0     0 ?        I<   09:10   0:00 [kworker/u271:2-]
> root       7331  0.0  0.0      0     0 ?        I<   Apr24   0:00 [kworker/59:1H-k]
> root       7360  0.0  0.0      0     0 ?        I    00:04   0:00 [kworker/81:1-cg]
> root       7457  0.0  0.0      0     0 ?        I    09:14   0:00 [kworker/79:2-ev]
> uuuuuuuu   7973  0.0  0.0  32216  2992 pts/13   S+   09:19   0:00 screen -rx
> root       8015  0.0  0.0      0     0 ?        I    09:21   0:00 [kworker/64:0-ev]
> root       8699  0.0  0.0      0     0 ?        I    09:24   0:00 [kworker/13:2-ev]
> root       8958  0.0  0.0      0     0 ?        I    May14   0:51 [kworker/43:2-ev]
> root       9147  0.0  0.0      0     0 ?        I    09:27   0:00 [kworker/17:2-ev]
> root       9218  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/103:1H-]
> root       9386  0.0  0.0      0     0 ?        I    00:36   0:07 [kworker/37:1-ev]
> root       9389  0.0  0.0      0     0 ?        I<   09:28   0:00 [kworker/u269:2-]
> root       9477  0.0  0.0      0     0 ?        I    09:28   0:01 [kworker/93:1-ev]
> pmenzel    9490  0.0  0.0  48988  5356 ?        Ss   May07   0:30 /lib/systemd/systemd --user
> pmenzel    9491  0.0  0.0 220980  2412 ?        S    May07   0:00 (sd-pam)
> root       9507  0.0  0.0  38996  9564 ?        Ss   May07   0:02 SCREEN -Rd
> pmenzel    9508  0.0  0.0  28624  5896 pts/7    Ss   May07   0:00 /usr/bin/bash
> root       9671  0.0  0.0      0     0 ?        I    09:29   0:00 [kworker/101:0-e]
> root      10007  0.0  0.0      0     0 ?        I    09:31   0:00 [kworker/30:0-xf]
> root      10224  0.0  0.0      0     0 ?        I    09:34   0:00 [kworker/99:2-ev]
> root      10369  0.0  0.0      0     0 ?        I    09:37   0:00 [kworker/14:1-ev]
> root      10412  0.0  0.0      0     0 ?        I    09:39   0:00 [kworker/34:2-ev]
> root      10482  0.0  0.0      0     0 ?        I    09:41   0:00 [kworker/15:0]
> root      10509  0.0  0.0      0     0 ?        I    09:42   0:00 [kworker/9:1]
> root      10539  0.0  0.0      0     0 ?        I<   09:42   0:00 [kworker/u269:0-]
> root      10581  0.0  0.0      0     0 ?        I    02:46   0:04 [kworker/80:0-ev]
> root      10686  0.0  0.0      0     0 ?        I<   09:42   0:00 [kworker/u272:2-]
> root      10824  0.0  0.0      0     0 ?        I<   09:42   0:00 [kworker/u266:1-]
> root      10864  0.0  0.0      0     0 ?        I    09:43   0:00 [kworker/76:0-ev]
> root      10889  0.0  0.0      0     0 ?        I<   09:43   0:00 [kworker/u270:2-]
> root      11322  0.0  0.0      0     0 ?        I<   09:46   0:00 [kworker/u271:1-]
> root      11323  0.0  0.0      0     0 ?        I    09:46   0:00 [kworker/u262:4-]
> root      11405  0.0  0.0      0     0 ?        I    09:48   0:00 [kworker/89:1-ev]
> pmenzel   11627  0.0  0.0   4140   800 pts/7    S+   09:56   0:00 /usr/bin/time sudo BEE_TMP_TMPDIR=/scratch/local2 BEE_TMP_BUILDROOT=/scratch/local2/bee-root BEE_MAKEFLAGS=-j127 ./linux-5.1.2-265.bee -c
> root      11628  0.0  0.0  48636  3480 pts/7    S+   09:56   0:00 sudo BEE_TMP_TMPDIR=/scratch/local2 BEE_TMP_BUILDROOT=/scratch/local2/bee-root BEE_MAKEFLAGS=-j127 ./linux-5.1.2-265.bee -c
> root      11630  0.0  0.0  24948  4212 pts/7    S+   09:56   0:00 /bin/bash /usr/bin/beesh ./linux-5.1.2-265.bee -c
> root      12052  0.0  0.0  18092  3548 pts/7    S+   09:56   0:00 make -j127
> root      12390  0.0  0.0      0     0 ?        I    May12   0:00 [kworker/56:1]
> root      12602  0.0  0.0  34324  4656 ?        Ss   May10   0:00 SCREEN
> uuuu      12603  0.0  0.0  26404  3560 pts/17   Ss+  May10   0:00 /usr/bin/bash
> root      12657  0.0  0.0  34324  4552 ?        Ss   May10   0:00 SCREEN
> uuuu      12658  0.0  0.0  26404  3588 pts/19   Ss+  May10   0:00 /usr/bin/bash
> root      12717  0.0  0.0  34324  4484 ?        Ss   May10   0:00 SCREEN
> uuuu      12718  0.0  0.0  26404  3628 pts/20   Ss+  May10   0:00 /usr/bin/bash
> root      12822  0.0  0.0  34720  4912 ?        Ss   May10   0:00 SCREEN
> uuuu      12823  0.0  0.0  26404  3728 pts/21   Ss+  May10   0:00 /usr/bin/bash
> root      12942  0.0  0.0  34720  4972 ?        Ss   May10   0:00 SCREEN
> uuuu      12943  0.0  0.0  26404  3608 pts/22   Ss+  May10   0:00 /usr/bin/bash
> root      13230  0.0  0.0      0     0 ?        I<   Apr18   0:00 [kworker/44:1H-k]
> root      13634  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/39:1H-k]
> root      13720  0.0  0.0  34876  5008 ?        Ss   May13   0:00 SCREEN
> uuuu      13721  0.0  0.0  26404  3676 pts/26   Ss+  May13   0:00 /usr/bin/bash
> root      13727  0.0  0.0      0     0 ?        I    04:01   0:00 [kworker/117:0]
> root      14167  0.0  0.0  33532  3768 ?        Ss   May13   0:00 SCREEN
> uuuu      14168  0.0  0.0  26524  3780 pts/29   Ss+  May13   0:00 /usr/bin/bash
> root      14295  0.0  0.0  33532  3836 ?        Ss   May13   0:00 SCREEN
> uuuu      14296  0.0  0.0  26404  3356 pts/30   Ss+  May13   0:00 /usr/bin/bash
> root      14317  0.0  0.0  33532  3796 ?        Ss   May13   0:00 SCREEN
> uuuu      14318  0.0  0.0  26404  3660 pts/31   Ss+  May13   0:00 /usr/bin/bash
> root      14392  0.0  0.0  35524  5688 ?        Ss   May13   0:00 SCREEN
> uuuu      14393  0.0  0.0  26404  3728 pts/32   Ss+  May13   0:00 /usr/bin/bash
> uuuuuuuu  14911  0.0  0.0  49000  6068 ?        Ss   May13   0:07 /lib/systemd/systemd --user
> uuuuuuuu  14912  0.0  0.0 221076  2508 ?        S    May13   0:00 (sd-pam)
> root      14978  0.0  0.0      0     0 ?        I    May14   0:35 [kworker/31:0-ev]
> root      15151  0.0  0.0      0     0 ?        I    May13   0:50 [kworker/52:1-ev]
> root      15464  0.0  0.0  63032  4644 ?        Ss   May10   0:00 sshd: bbbb [priv]
> bbbb      15483  0.0  0.0  49004  6064 ?        Ss   May10   0:16 /lib/systemd/systemd --user
> bbbb      15484  0.0  0.0 221076  2504 ?        S    May10   0:00 (sd-pam)
> bbbb      15490  0.0  0.0  63032  3460 ?        S    May10   0:00 sshd: bbbb@pts/5
> bbbb      15492  0.0  0.0  26536  3704 pts/5    Ss+  May10   0:00 -bash
> root      15507  0.0  0.0      0     0 ?        I    May13   0:00 [kworker/52:0]
> root      15595  0.0  0.0      0     0 ?        I    May13   0:00 [kworker/54:14-n]
> ccccccc   16979  0.0  0.0  49000  4392 ?        Ds   Apr25   0:43 /lib/systemd/systemd --user
> ccccccc   16981  0.0  0.0 221744  2288 ?        S    Apr25   0:00 (sd-pam)
> root      17187  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/4:0-eve]
> root      17269  0.1  0.0      0     0 ?        I    May14   1:12 [kworker/110:5-e]
> root      17663  0.0  0.0      0     0 ?        I    00:02   0:00 [kworker/17:0-ev]
> YYYYYYY   17670  0.0  0.1 2676904 2047484 ?     S    May07   0:13 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17671  0.0  0.1 2676844 2047424 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17672  0.0  0.1 2676848 2047552 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17673  0.0  0.1 2677076 2047752 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17674  0.0  0.1 2677204 2047752 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17675  0.0  0.1 2677096 2047832 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17676  0.0  0.1 2677076 2047716 ?     S    May07   0:13 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17677  0.0  0.1 2676908 2047488 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17678  0.0  0.1 2677096 2047676 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17679  0.0  0.1 2677032 2047604 ?     S    May07   0:12 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-10fd92b4-4801-41ef-a500-68b01c33885d.json
> YYYYYYY   17791  0.0  0.0  24152  2948 pts/6    S+   May07   0:00 /bin/bash /usr/bin/jupyter lab --no-browser --port 7788
> YYYYYYY   17793  0.0  0.0 979824 231004 pts/6   Sl+  May07   5:43 /pkg/python-2.7.15-1/bin/python /home/YYYYYYY/.local/bin/jupyter-lab --no-browser --port 7788
> root      17804  0.0  0.0      0     0 ?        I    May13   0:38 [kworker/62:1-ev]
> YYYYYYY   17832  0.0  0.0 3463240 84776 ?       Ssl  May07   0:27 /pkg/python-2.7.15-1/bin/python -m ipykernel_launcher -f /run/user/8403/jupyter/kernel-41936edd-b66e-4686-8041-3b6394200ec8.json
> YYYYYYY   17835  0.0  0.7 8130040 7501252 ?     Ssl  May07  10:06 /pkg/R-3.5.1-1/lib64/R/bin/exec/R --slave -e IRkernel::main() --args /run/user/8403/jupyter/kernel-f845803b-20ee-44af-be4b-26faa3201519.json
> root      18542  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/18:1H-k]
> root      18574  0.0  0.0  69836  3564 ?        Ss   Apr17   0:00 sshd: aaaaa [priv]
> aaaaa     18597  0.0  0.0  48772  4572 ?        Ss   Apr17   0:45 /lib/systemd/systemd --user
> aaaaa     18598  0.0  0.0  73088  2224 ?        S    Apr17   0:00 (sd-pam)
> aaaaa     18605  0.0  0.0  69836  3120 ?        S    Apr17   0:14 sshd: aaaaa@pts/2
> aaaaa     18612  0.0  0.0  26516  3308 pts/2    Ss+  Apr17   0:00 -bash
> root      18876  0.0  0.0  63028  4628 ?        Ss   May13   0:00 sshd: uuuuuuuu [priv]
> uuuuuuuu  18878  0.0  0.0  63028  3580 ?        S    May13   0:00 sshd: uuuuuuuu@pts/13
> uuuuuuuu  18879  0.0  0.0  31616  8740 pts/13   Ss   May13   0:00 -bash
> root      19247  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/45:0-md]
> root      19686  0.0  0.0      0     0 ?        I    May14   0:36 [kworker/45:8-ev]
> root      19899  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/41:1H-x]
> root      19900  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/56:1H-k]
> root      19931  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/86:1H-x]
> root      19932  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/87:1H-k]
> root      20128  0.0  0.0      0     0 ?        I    00:04   0:16 [kworker/21:0-ev]
> root      20522  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/109:1H-]
> root      20644  0.0  0.0  17448  2948 pts/7    S+   09:56   0:00 make -f ./scripts/Makefile.build obj=fs need-builtin=1
> root      21040  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/20:1H-k]
> root      21041  0.0  0.0      0     0 ?        I<   Apr17   0:01 [kworker/21:1H-k]
> root      21042  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/23:1H-k]
> root      21044  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/84:1H-x]
> root      21641  0.0  0.0      0     0 ?        I    May14   1:03 [kworker/108:4-e]
> root      21642  0.0  0.0      0     0 ?        I    May14   0:00 [kworker/108:5-e]
> root      21739  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/116:1-e]
> root      22108  0.0  0.0      0     0 ?        I    03:37   0:06 [kworker/115:0-e]
> root      22223  0.0  0.0      0     0 ?        I    00:40   0:25 [kworker/66:2-ev]
> root      22689  0.0  0.0      0     0 ?        I    00:13   0:22 [kworker/85:1-ev]
> root      22873  0.0  0.0      0     0 ?        I    May14   0:49 [kworker/40:0-ev]
> root      22918  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/117:1H-]
> root      22928  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/118:1H-]
> root      23003  0.0  0.0      0     0 ?        I    00:17   0:00 [kworker/112:3-x]
> root      23330  0.0  0.0  34720  4868 ?        Ss   May10   0:00 SCREEN
> uuuu      23331  0.0  0.0  26404  3636 pts/3    Ss+  May10   0:00 /usr/bin/bash
> root      23394  0.0  0.0  34720  5016 ?        Ss   May10   0:00 SCREEN
> uuuu      23395  0.0  0.0  26404  3608 pts/9    Ss+  May10   0:00 /usr/bin/bash
> root      23446  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/101:1H-]
> root      23447  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/102:1H-]
> root      23449  0.0  0.0  34720  4972 ?        Ss   May10   0:00 SCREEN
> uuuu      23450  0.0  0.0  26404  3572 pts/11   Ss+  May10   0:00 /usr/bin/bash
> root      23488  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/36:1H-k]
> root      23489  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/37:1H-k]
> root      24171  0.0  0.0      0     0 ?        I    May14   0:02 [kworker/69:2-xf]
> root      24197  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/38:1H-k]
> root      24459  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/14:2-md]
> root      25072  0.0  0.0      0     0 ?        I<   Apr17   0:00 [kworker/51:1H-k]
> root      26368  0.0  0.0      0     0 ?        I    01:33   0:23 [kworker/51:0-ev]
> root      26408  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/52:1H-k]
> root      26581  0.0  0.0  34720  5056 ?        Ss   May13   0:01 SCREEN -S alf
> YYYYYYY   26582  0.0  0.0  26512  3656 pts/37   Ss+  May13   0:00 /usr/bin/bash
> root      26764  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/30:1-md]
> root      26785  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/30:3-md]
> root      27179  0.0  0.0      0     0 ?        I    May10   0:02 [kworker/120:2-e]
> root      27246  0.0  0.0      0     0 ?        I    May10   0:49 [kworker/56:0-ev]
> root      27611  0.0  0.0  17548  3132 pts/7    S+   09:56   0:00 make -f ./scripts/Makefile.build obj=drivers need-builtin=1
> root      27939  0.0  0.0      0     0 ?        I    02:46   0:00 [kworker/94:0]
> root      28185  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/48:1-md]
> root      28707  0.0  0.0      0     0 ?        I    May13   0:59 [kworker/118:0-e]
> root      28968  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/121:1H-]
> root      29071  0.0  0.0      0     0 ?        I    May13   0:13 [kworker/127:0-x]
> root      29279  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/70:1-ev]
> root      30281  0.1  0.0      0     0 ?        I    May14   1:10 [kworker/111:1-e]
> root      30746  0.0  0.0      0     0 ?        I    03:54   0:03 [kworker/88:1-ev]
> root      31518  0.0  0.0      0     0 ?        I    May14   0:47 [kworker/119:0-e]
> root      31983  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/28:2-md]
> root      32405  0.0  0.0  54720  4536 ?        Ss   Apr25   0:05 /lib/systemd/systemd-udevd
> root      32411  0.0  0.0 409872 115136 ?       Ss   Apr25   0:20 /lib/systemd/systemd-journald
> systemd+  32416  0.0  0.0  48848  1652 ?        Ss   Apr25   0:01 /lib/systemd/systemd-resolved
> systemd+  32422  0.0  0.0 126408  2996 ?        Ssl  Apr25   0:02 /lib/systemd/systemd-timesyncd
> root      32428  0.0  0.0  45240  4440 ?        Ss   Apr25   0:08 /lib/systemd/systemd-logind
> root      32568  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/108:1H-]
> root      32945  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/53:2-md]
> root      34066  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/111:1H-]
> root      34155  0.0  0.0      0     0 ?        I    03:04   0:01 [kworker/92:2-ip]
> root      34345  0.0  0.0      0     0 ?        I    May14   0:00 [kworker/111:12-]
> root      34354  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/120:1H-]
> root      35175  0.0  0.0      0     0 ?        I    03:56   0:03 [kworker/39:1-ev]
> root      35324  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/115:1H-]
> root      36056  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/105:1H-]
> root      36134  0.0  0.0      0     0 ?        I    May14   0:52 [kworker/127:2-e]
> root      36482  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/18:1-md]
> root      36629  0.0  0.0      0     0 ?        I<   Apr22   0:00 [kworker/119:1H-]
> root      36639  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/104:1H-]
> root      36967  0.0  0.0      0     0 ?        I    01:59   0:10 [kworker/53:1-ev]
> root      37573  0.0  0.0      0     0 ?        I    May10   1:11 [kworker/126:2-e]
> root      38110  0.0  0.0      0     0 ?        I    00:06   0:13 [kworker/23:1-me]
> root      38491  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/110:1H-]
> root      38512  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/45:1H-k]
> root      39219  0.0  0.0      0     0 ?        I    May14   0:11 [kworker/22:1-xf]
> root      39981  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/99:1]
> root      40185  0.0  0.0      0     0 ?        I    02:33   0:00 [kworker/19:1-xf]
> root      40209  0.0  0.0      0     0 ?        I    00:12   0:16 [kworker/55:0-ev]
> root      40521  0.0  0.0      0     0 ?        I    May14   0:00 [kworker/107:0-e]
> root      40669  0.0  0.0      0     0 ?        I    May14   0:00 [kworker/110:7-n]
> root      40765  0.0  0.0  17840  3544 pts/7    S+   09:56   0:00 make -f ./scripts/Makefile.build obj=lib need-builtin=1
> root      40874  0.0  0.0      0     0 ?        I    02:45   0:09 [kworker/117:1-e]
> root      40962  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/40:1H-k]
> root      40968  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/42:1H-k]
> root      40989  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/43:1H-x]
> root      40998  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/106:1H-]
> root      41142  0.0  0.0  17476  3112 pts/7    S+   09:56   0:00 make -f ./scripts/Makefile.build obj=lib/raid6 need-builtin=1
> root      43155  0.0  0.0      0     0 ?        I    09:56   0:00 [kworker/21:2-md]
> root      43666  0.0  0.0      0     0 ?        I    May14   0:04 [kworker/39:2-ev]
> root      43680  0.0  0.0      0     0 ?        I<   Apr25   0:00 [kworker/114:1H-]
> root      43732  0.0  0.0  17580  3108 pts/7    S+   09:56   0:00 make -f ./scripts/Makefile.build obj=fs/ecryptfs need-builtin=
> root      43901  0.0  0.0  24292  3304 pts/7    S+   09:56   0:00 /bin/sh -c set -e;  echo '  CC [M]  fs/ecryptfs/dentry.o'; gcc -Wp,-MD,fs/ecryptfs/.dentry.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-pc-linux-gnu/7.3.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DC
 ONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init  -DMODULE  -DKBUILD_BASENAME='"dentry"' -DKBUILD_MODNAME='"ecryptfs"' -c -o fs/ecryptfs/dentry.o fs/ecryptfs/dentry.c; scripts/basic/fixdep fs/ecryptfs/.dentry.o.d fs/ecryptfs/dentry.o 'gcc -Wp,-MD,f
 s/ecryptfs/.dentry.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-pc-linux-gnu/7.3.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wno-sign-compare -fno-asynchronous-un
 wind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init  -DMODULE  -DKBUILD_BASENAME='\''"dentry"'\'' -DKBUILD_MODNAME='\''"ecryptfs"'\'' -c -o fs/ecryptfs/dentry.o fs/ecryptfs/dentry.c' > fs/ecryptfs/.dentry.o.cmd; rm -f fs/ecryptfs/.dentry.o.d
> root      43943  0.0  0.0  19140  1228 pts/7    R+   09:56   0:00 gcc -Wp,-MD,fs/ecryptfs/.dentry.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-pc-linux-gnu/7.3.0/include -I./arch/x86/include -I./arch/x86/include/generated -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONF
 IG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -DMODULE -DKBUILD_BASENAME="dentry" -DKBUILD_MODNAME="ecryptfs" -c -o fs/ecryptfs/dentry.o fs/ecryptfs/dentry.c
> root      43960  0.0  0.0      0     0 pts/7    Z+   09:56   0:00 [cc1] <defunct>
> root      44169  0.0  0.0  24288  3272 pts/7    S+   09:56   0:00 /bin/sh -c set -e;  echo '  CC      lib/raid6/avx2.o'; gcc -Wp,-MD,lib/raid6/.avx2.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-pc-linux-gnu/7.3.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS
 _AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init    -DKBUILD_BASENAME='"avx2"' -DKBUILD_MODNAME='"raid6_pq"' -c -o lib/raid6/avx2.o lib/raid6/avx2.c; scripts/basic/fixdep lib/raid6/.avx2.o.d lib/raid6/avx2.o 'gcc -Wp,-MD,lib/raid6/.avx2.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-pc-l
 inux-gnu/7.3.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-regist
 er -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign



