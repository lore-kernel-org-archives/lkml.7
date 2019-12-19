Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D538C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AC221655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLSRdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:33:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfLSRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:33:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJGDAx3078458;
        Thu, 19 Dec 2019 12:33:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0a8rb8vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 12:33:39 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJGDErt079168;
        Thu, 19 Dec 2019 12:33:39 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0a8rb8ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 12:33:39 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJHVGL9028014;
        Thu, 19 Dec 2019 17:33:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 2wvqc705nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 17:33:37 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJHXbAR59834808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 17:33:37 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E68AE136051;
        Thu, 19 Dec 2019 17:33:36 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5AA013604F;
        Thu, 19 Dec 2019 17:33:36 +0000 (GMT)
Received: from localhost (unknown [9.41.179.32])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 17:33:36 +0000 (GMT)
Date:   Thu, 19 Dec 2019 11:33:36 -0600
From:   Scott Cheloha <cheloha@linux.vnet.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20191219173336.v6uvlu4gqz26gvmm@rascal.austin.ibm.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <ac56b850-adab-0801-e583-f1e76949aa2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac56b850-adab-0801-e583-f1e76949aa2b@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_04:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:00:49AM +0100, David Hildenbrand wrote:
> On 17.12.19 20:32, Scott Cheloha wrote:
> > Searching for a particular memory block by id is slow because each block
> > device is kept in an unsorted linked list on the subsystem bus.
> > 
> > Lookup is much faster if we cache the blocks in a radix tree.  Memory
> > subsystem initialization and hotplug/hotunplug is at least a little faster
> > for any machine with more than ~100 blocks, and the speedup grows with
> > the block count.
> > 
> > Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> > v2 incorporates suggestions from David Hildenbrand.
> > 
> > v3 changes:
> >   - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"
> > 
> >   - Be conservative: don't use radix_tree_for_each_slot() in
> >     walk_memory_blocks() yet.  It introduces RCU which could
> >     change behavior.  Walking the tree "by hand" with
> >     find_memory_block_by_id() is slower but keeps the patch
> >     simple.
> 
> Fine with me (splitting it out, e.g., into an addon patch), however, as
> readers/writers run mutually exclusive, there is nothing to worry about
> here. RCU will not make a difference.

Oh.  In that case, can you make heads or tails of this CI failure
email I got about the v2 patch?  I've inlined it at the end of this
mail.  "Suspicious RCU usage".  Unclear if it's a false positive.  My
thinking was that I'd hold off on using radix_tree_for_each_slot() and
introducing a possible regression until I understood what was
triggering the robot.

Also, is there anyone else I should shop this patch to?  I copied the
maintainers reported by scripts/get_maintainer.pl but are there others
who might be interested?

--

Here's that CI mail.  I've stripped the attached config because it's
huge.

Date: Sun, 1 Dec 2019 23:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc: 0day robot <lkp@intel.com>, LKP <lkp@lists.01.org>
Subject: 86dc301f7b ("drivers/base/memory.c: cache blocks in radix tree .."):
 [    1.341517] WARNING: suspicious RCU usage
Message-ID: <20191201150523.GE18573@shao2-debian>

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://github.com/0day-ci/linux/commits/Scott-Cheloha/drivers-base-memory-c-cache-blocks-in-radix-tree-to-accelerate-lookup/20191124-104557

commit 86dc301f7b4815d90e3a7843ffed655d64efe445
Author:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
AuthorDate: Thu Nov 21 13:59:52 2019 -0600
Commit:     0day robot <lkp@intel.com>
CommitDate: Sun Nov 24 10:45:59 2019 +0800

    drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
    
    Searching for a particular memory block by id is slow because each block
    device is kept in an unsorted linked list on the subsystem bus.
    
    Lookup is much faster if we cache the blocks in a radix tree.  Memory
    subsystem initialization and hotplug/hotunplug is at least a little faster
    for any machine with more than ~100 blocks, and the speedup grows with
    the block count.
    
    Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
    Acked-by: David Hildenbrand <david@redhat.com>

0e4a459f56  tracing: Remove unnecessary DEBUG_FS dependency
86dc301f7b  drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
+---------------------------------------------------------------------+------------+------------+
|                                                                     | 0e4a459f56 | 86dc301f7b |
+---------------------------------------------------------------------+------------+------------+
| boot_successes                                                      | 8          | 0          |
| boot_failures                                                       | 25         | 11         |
| WARNING:possible_circular_locking_dependency_detected               | 25         | 8          |
| WARNING:suspicious_RCU_usage                                        | 0          | 11         |
| include/linux/radix-tree.h:#suspicious_rcu_dereference_check()usage | 0          | 11         |
+---------------------------------------------------------------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    1.335279] random: get_random_bytes called from kcmp_cookies_init+0x29/0x4c with crng_init=0
[    1.336883] ACPI: bus type PCI registered
[    1.338295] PCI: Using configuration type 1 for base access
[    1.340735] 
[    1.341049] =============================
[    1.341517] WARNING: suspicious RCU usage
[    1.342266] 5.4.0-rc5-00070-g86dc301f7b481 #1 Tainted: G                T
[    1.343494] -----------------------------
[    1.344226] include/linux/radix-tree.h:167 suspicious rcu_dereference_check() usage!
[    1.345516] 
[    1.345516] other info that might help us debug this:
[    1.345516] 
[    1.346962] 
[    1.346962] rcu_scheduler_active = 2, debug_locks = 1
[    1.348134] no locks held by swapper/0/1.
[    1.348866] 
[    1.348866] stack backtrace:
[    1.349525] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc5-00070-g86dc301f7b481 #1
[    1.351230] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    1.352720] Call Trace:
[    1.353187]  ? dump_stack+0x9a/0xde
[    1.353507]  ? node_access_release+0x19/0x19
[    1.353507]  ? walk_memory_blocks+0xe6/0x184
[    1.353507]  ? set_debug_rodata+0x20/0x20
[    1.353507]  ? link_mem_sections+0x39/0x3d
[    1.353507]  ? topology_init+0x74/0xc8
[    1.353507]  ? enable_cpu0_hotplug+0x15/0x15
[    1.353507]  ? do_one_initcall+0x13d/0x30a
[    1.353507]  ? kernel_init_freeable+0x18e/0x23b
[    1.353507]  ? rest_init+0x173/0x173
[    1.353507]  ? kernel_init+0x10/0x151
[    1.353507]  ? rest_init+0x173/0x173
[    1.353507]  ? ret_from_fork+0x3a/0x50
[    1.410829] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.427389] cryptd: max_cpu_qlen set to 1000
[    1.457792] ACPI: Added _OSI(Module Device)
[    1.458615] ACPI: Added _OSI(Processor Device)
[    1.459428] ACPI: Added _OSI(3.0 _SCP Extensions)

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 1d5f18079cb10420c4e4b67f571b998ec861a20c 219d54332a09e8d8741c1e1982f5eae56099de85 --
git bisect good 00e5729fc7309fd1da26659b7dce0fcc0b46ab7e  # 23:10  G     11     0    9   9  Merge 'linux-review/Daniel-W-S-Almeida/media-dummy_dvb_fe-register-adapter-frontend/20191127-043813' into devel-hourly-2019113015
git bisect  bad da795b1ad310518d9100105235c9ba3ff4ee2524  # 23:32  B      0    11   27   0  Merge 'linux-review/Krzysztof-Kozlowski/media-Fix-Kconfig-indentation/20191122-055026' into devel-hourly-2019113015
git bisect  bad 53f2832a6bf7103957815cef4ad58be22255ea7a  # 00:21  B      0     7   24   0  Merge 'linux-review/Luc-Van-Oostenryck/misc-xilinx_sdfec-add-missing-__user-annotation/20191124-052749' into devel-hourly-2019113015
git bisect good 03a04e32f16a2c4bd267b48e8ab4aaf71c507050  # 00:55  G     11     0    8   8  Merge 'linux-review/Helmut-Grohne/mdio_bus-revert-inadvertent-error-code-change/20191124-171049' into devel-hourly-2019113015
git bisect  bad 03403c59a591b12556bd0db1243eb0503112a0df  # 02:22  B      0    10   26   0  Merge 'linux-review/Navid-Emamdoost/EDAC-Fix-memory-leak-in-i5100_init_one/20191124-103621' into devel-hourly-2019113015
git bisect good fae5c4b30fda35cbcc8389f432dcaac20f9b3a12  # 03:02  G     11     0    7   7  Merge 'linux-review/David-Gow/kunit-Always-print-actual-pointer-values-in-asserts/20191124-131742' into devel-hourly-2019113015
git bisect  bad 1e0c725d2bb21789330a2fe1a360c37ae753eb18  # 04:01  B      0    10   26   0  Merge 'linux-review/Scott-Cheloha/drivers-base-memory-c-cache-blocks-in-radix-tree-to-accelerate-lookup/20191124-104557' into devel-hourly-2019113015
git bisect good 0902b87758e830e857e11f1538e50b218743f4b0  # 04:29  G     10     0    7   7  Merge 'linux-review/Julio-Faracco/drivers-net-virtio_net-Implement-a-dev_watchdog-handler/20191124-135051' into devel-hourly-2019113015
git bisect good 2d0c894673b55b51915ea858eabcf7c97c9b8ccb  # 05:33  G     10     0    6   6  Merge 'linux-review/Maciej-enczykowski/net-ipv6-IPV6_TRANSPARENT-check-NET_RAW-prior-to-NET_ADMIN/20191124-120121' into devel-hourly-2019113015
git bisect good 3c095c856fb84271e56e1869aface37af1b078f1  # 05:58  G     11     0   10  10  Merge 'linux-review/Navid-Emamdoost/Bluetooth-Fix-memory-leak-in-hci_connect_le_scan/20191124-111255' into devel-hourly-2019113015
git bisect  bad 86dc301f7b4815d90e3a7843ffed655d64efe445  # 06:39  B      0    11   27   0  drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
# first bad commit: [86dc301f7b4815d90e3a7843ffed655d64efe445] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
git bisect good 0e4a459f56c32d3e52ae69a4b447db2f48a65f44  # 07:25  G     33     0   25  25  tracing: Remove unnecessary DEBUG_FS dependency
# extra tests with debug options
git bisect good 86dc301f7b4815d90e3a7843ffed655d64efe445  # 09:13  G     11     0    0   0  drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
# extra tests on head commit of linux-review/Scott-Cheloha/drivers-base-memory-c-cache-blocks-in-radix-tree-to-accelerate-lookup/20191124-104557
git bisect  bad 86dc301f7b4815d90e3a7843ffed655d64efe445  # 09:16  B      0    11   27   0  drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
# bad: [86dc301f7b4815d90e3a7843ffed655d64efe445] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
# extra tests on revert first bad commit
git bisect good 65bba365eabe04a22e5d68012a45b92eee26860c  # 10:18  G     10     0    9   9  Revert "drivers/base/memory.c: cache blocks in radix tree to accelerate lookup"
# good: [65bba365eabe04a22e5d68012a45b92eee26860c] Revert "drivers/base/memory.c: cache blocks in radix tree to accelerate lookup"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
