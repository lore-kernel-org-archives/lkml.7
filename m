Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9000C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC982206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="IEnS2BL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHPBme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:42:34 -0400
Received: from aibo.runbox.com ([91.220.196.211]:48518 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfHPBmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
        bh=8VbhEcPGlD1jR06LiS0BPOdxImUFEJIhW0+NTt0heb4=; b=IEnS2BL/zufWxOFgwpg7ST+/4P
        ShC8HQuIFcoBnJUKuT3115ogqc3gDkdT7I6rLuSYk8Th1iSK5vJuydGewHgvvyEeixUBbF1AA5+/q
        m48IYLifzFZ+E6+gLAQg1DMnwoy3yuhTrcleLpMI1gaqhd5aNsYwRd4+f3EEgbRmFTjl9YNXAkdRH
        WGnAo9BbrnXTTUHlD8q6yr9efH2bQE5v7eJfVdhsply33F8KHwN1ssBWen8gz229PJ9sb1bNyWIVy
        rFt4mqc1MgOxZ4swfb4G6vqC6nqBbutRsLH6584yng9tf2XJ0YbteDeSPcPrx6Bjp3wqI8l2k/bDq
        /Xl9CrrQ==;
Received: from [10.9.9.202] (helo=mailfront20.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1hyRGA-0006Oa-9I; Fri, 16 Aug 2019 03:42:30 +0200
Received: by mailfront20.runbox with esmtpsa  [Authenticated alias (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1hyRFm-0008Lw-64; Fri, 16 Aug 2019 03:42:06 +0200
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>
Subject: [PATCH] platform/x86: intel_pmc_core_pltdrv: Module removal warning fix
Date:   Thu, 15 Aug 2019 21:41:40 -0400
Message-Id: <20190816014140.10687-2-m.v.b@runbox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816014140.10687-1-m.v.b@runbox.com>
References: <20190816014140.10687-1-m.v.b@runbox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this commit, removing the intel_pmc_core_pltdrv module
would cause the following warning:

  ------------[ cut here ]------------
  Device 'intel_pmc_core.0' does not have a release() function, \
    it is broken and must be fixed. See Documentation/kobject.txt.
  WARNING: CPU: 0 PID: 2202 at drivers/base/core.c:1238 device_release+0x6f/0x80
  Modules linked in: fuse intel_rapl_msr ip6table_filter ip6_tables ipt_REJECT \
    nf_reject_ipv4 xt_conntrack iptable_filter xt_MASQUERADE iptable_nat nf_nat \
    nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c intel_rapl_common \
    intel_pmc_core_pltdrv(-) xen_netfront intel_pmc_core crct10dif_pclmul \
    crc32_pclmul crc32c_intel ghash_clmulni_intel intel_rapl_perf pcspkr binfmt_misc \
    u2mfn(O) xenfs xen_gntdev xen_gntalloc xen_blkback xen_privcmd xen_evtchn \
    ip_tables overlay xen_blkfront
  CPU: 0 PID: 2202 Comm: rmmod Tainted: G        W  O      5.3.0-rc3-next-20190809-1 #2
  RIP: 0010:device_release+0x6f/0x80
  Code: 48 8b 85 c0 02 00 00 48 85 c0 74 09 48 8b 40 40 48 85 c0 75 c6 48 8b 75 50 48 85 f6 74 10 48 c7 c7 58 68 12 82 e8 5f 62 a9 ff <0f> 0b eb b5 48 8b 75 00 eb ea 0f 1f 80 00 00 00 00 0f 1f 44 00 00
  RSP: 0018:ffffc90000763ea8 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: ffffffff822da080 RCX: 0000000000000006
  RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88813ba17540
  RBP: ffffffffc0107010 R08: 0000000000000195 R09: 000000000000000d
  R10: 000000000000000a R11: ffffc90000763d65 R12: ffff88800c9e9000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  000071250bf142c0(0000) GS:ffff88813ba00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000060ab8fd82d49 CR3: 00000001273ba004 CR4: 00000000003606f0
  Call Trace:
   kobject_put+0x85/0x1b0
   __x64_sys_delete_module+0x14b/0x270
   do_syscall_64+0x5f/0x1a0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x71250c031c6b
  Code: 73 01 c3 48 8b 0d 1d 42 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed 41 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffec29e6038 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
  RAX: ffffffffffffffda RBX: 00006040bc3e07b0 RCX: 000071250c031c6b
  RDX: 000000000000000a RSI: 0000000000000800 RDI: 00006040bc3e0818
  RBP: 00007ffec29e6088 R08: 1999999999999999 R09: 0000000000000000
  R10: 000071250c0a6ac0 R11: 0000000000000206 R12: 00007ffec29e6250
  R13: 00007ffec29e67b7 R14: 00006040bc3e0260 R15: 00007ffec29e6090
  ---[ end trace 5e5421608729d6f5 ]---

This commit hence adds an empty release function for the driver.

Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
---
 drivers/platform/x86/intel_pmc_core_pltdrv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index a8754a6db1b8..186540014c48 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -18,8 +18,16 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
+static void intel_pmc_core_release(struct device *dev)
+{
+	/* Nothing to do. */
+}
+
 static struct platform_device pmc_core_device = {
 	.name = "intel_pmc_core",
+	.dev  = {
+		.release = intel_pmc_core_release,
+	},
 };
 
 /*
-- 
2.21.0

