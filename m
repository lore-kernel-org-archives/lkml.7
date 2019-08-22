Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F81CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF586233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7++SBcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbfHVVLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:11:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfHVVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:11:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7ML95An050485;
        Thu, 22 Aug 2019 21:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=V/UdnTS7lyVVO5p65hJ5rSBASuO8fpdFDdciSM3QEFk=;
 b=Y7++SBcQc1obr2ogljzFRVRYJGkQFm+RNF4npRFuJg6g9pTURt/XrKj+pz4cEpz0AYs+
 4C1lNBrJ3rUI1EjPZNOA3/NtUz25lT0dy2Hg4Uh7wzfX+CFi03HfVvZf3V+fhGJkmB0y
 9OGwrHq12QAh5FJ1XtmhGl7GrY2CpuHQJeCHOx5e1DhcgLa3N5uyUh86oipnkEW77jyF
 6EEl2hH0k2qzmtHZWigJiHxdp7VxM7sK6HNUpYP0CpmaGIAw14uUALuAn438b4X26IsD
 NXDjH6V0afMwSVkgkLR4jmrTXyT6dHfq6/aYuJpLTHQLIUzfpWY3j1oKuLP2jbsim9x/ YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ue90u0s8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 21:11:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7ML8vKP039248;
        Thu, 22 Aug 2019 21:11:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uj1xys8jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 21:11:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7MLB8nZ021572;
        Thu, 22 Aug 2019 21:11:09 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 14:11:08 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, ashok.raj@intel.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com, mihai.carabas@oracle.com
Subject: [PATCH] Parallel microcode update in Linux
Date:   Thu, 22 Aug 2019 23:43:46 +0300
Message-Id: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9357 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9357 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables parallel microcode loading. In order to measure the
improvements of parallel vs serial, we have used the following diff:

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 577b223..1ea08d8 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -614,17 +614,25 @@ static int __reload_late(void *info)
  */
 static int microcode_reload_late(void)
 {
+       u64 p0, p1;
        int ret;

        atomic_set(&late_cpus_in,  0);
        atomic_set(&late_cpus_out, 0);

+       p0 = rdtsc_ordered();
+
        ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+
+       p1 = rdtsc_ordered();
+
        if (ret > 0)
                microcode_check();

        pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);

+       pr_info("p0: %lld, p1: %lld, diff: %lld\n", p0, p1, p1 - p0);
+
        return ret;
 }

We have used a machine with a broken microcode in BIOS and no microcode in
initramfs (to bypass early loading).

Here are the results for parallel loading (we made two measurements):

[root@ovs108 ~]# uname -a
Linux ovs108 5.3.0-rc5.master.parallel.el7.dev.x86_64 #1 SMP Thu Aug 22 10:17:04 GMT 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@ovs108 ~]# dmesg | grep microcode
[    0.000000] Intel Spectre v2 broken microcode detected; disabling Speculation Control
[    0.197658] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    2.114135] microcode: sig=0x50654, pf=0x80, revision=0x200003a
[    2.117555] microcode: Microcode Update Driver: v2.2.
[   18.197760] microcode: updated to revision 0x200005e, date = 2019-04-02
[   18.201225] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   18.201230] microcode: Reload completed, microcode revision: 0x200005e
[   18.201232] microcode: p0: 118138123843052, p1: 118138153732656, diff: 29889604


[root@ovs108 ~]# dmesg | grep microcode
[    0.000000] Intel Spectre v2 broken microcode detected; disabling Speculation Control
[    0.195218] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    2.111882] microcode: sig=0x50654, pf=0x80, revision=0x200003a
[    2.115265] microcode: Microcode Update Driver: v2.2.
[   18.033397] microcode: updated to revision 0x200005e, date = 2019-04-02
[   18.036590] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   18.036595] microcode: Reload completed, microcode revision: 0x200005e
[   18.036597] microcode: p0: 118947162428414, p1: 118947191490162, diff: 29061748

Here are the results of serial loading:

[root@ovs108 ~]# uname -a
Linux ovs108 5.3.0-rc5.master.serial.el7.dev.x86_64 #1 SMP Thu Aug 22 12:22:18 GMT 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@ovs108 ~]# dmesg | grep microcode
[    0.000000] Intel Spectre v2 broken microcode detected; disabling Speculation Control
[    0.195158] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    2.111353] microcode: sig=0x50654, pf=0x80, revision=0x200003a
[    2.114834] microcode: Microcode Update Driver: v2.2.
[   17.542518] microcode: updated to revision 0x200005e, date = 2019-04-02
[   17.898365] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   17.898370] microcode: Reload completed, microcode revision: 0x200005e
[   17.898372] microcode: p0: 149220216047388, p1: 149221058945422, diff: 842898034

[root@ovs108 ~]# dmesg | grep microcode
[    0.000000] Intel Spectre v2 broken microcode detected; disabling Speculation Control
[    0.197158] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    2.114005] microcode: sig=0x50654, pf=0x80, revision=0x200003a
[    2.117451] microcode: Microcode Update Driver: v2.2.
[   17.732026] microcode: updated to revision 0x200005e, date = 2019-04-02
[   18.041398] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   18.041404] microcode: Reload completed, microcode revision: 0x200005e
[   18.041407] microcode: p0: 149835792698162, p1: 149836532930286, diff: 740232124


One can see that the difference is an order magnitude.

---

I also tested microcode loading with cpu hotplug.
- I unplugged the last two CPUs  (basically the last core with 2 hyperthreads)
[ 1077.756759] IRQ 324: no longer affine to CPU71
[ 1077.756889] IRQ 619: no longer affine to CPU71
[ 1077.756908] IRQ 645: no longer affine to CPU71
[ 1077.761213] smpboot: CPU 71 is now offline
[ 1082.702759] IRQ 289: no longer affine to CPU70
[ 1082.702771] IRQ 305: no longer affine to CPU70
[ 1082.702827] IRQ 521: no longer affine to CPU70
[ 1082.702860] IRQ 636: no longer affine to CPU70
[ 1082.702876] IRQ 679: no longer affine to CPU70
[ 1082.706897] smpboot: CPU 70 is now offline

- I did the microcode update:
[ 1123.818741] microcode: updated to revision 0x200005e, date = 2019-04-02
[ 1123.821013] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[ 1123.821014] x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
[ 1123.821014] microcode: Reload completed, microcode revision: 0x200005e
[ 1123.821015] microcode: p0: 197460831869308, p1: 197460853607904, diff: 21738596

- Than I onlined CPU 70/71
[ 1151.170814] smpboot: Booting Node 1 Processor 70 APIC 0x75
[ 1151.177199] microcode: sig=0x50654, pf=0x80, revision=0x200005e
[ 1182.523811] smpboot: Booting Node 1 Processor 71 APIC 0x77

root@ovs108 ~]# cat /proc/cpuinfo | tr "\t" " " | grep -A 6 "processor : 70" | grep microcode
microcode : 0x200005e

[root@ovs108 ~]# cat /proc/cpuinfo | tr "\t" " " | grep -A 6 "processor : 71" | grep microcode
microcode : 0x200005e


We can see that both CPUs have been updated to the same microcode revision.

Thank you,
Mihai

Ashok Raj (1):
  x86/microcode: Update microcode for all cores in parallel

 arch/x86/kernel/cpu/microcode/core.c  | 44 ++++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/microcode/intel.c | 14 ++++-------
 2 files changed, 36 insertions(+), 22 deletions(-)

-- 
1.8.3.1

