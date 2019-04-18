Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F205C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A05206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610446;
	bh=GFjuDMQCP0A4y3j7A46HYApIlOgHZp/J8BhcYEPU4X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GlDNeGzZa4Y0/U/KdsLK4IiGzWZ2dm6IMBIohhm32ffIIRRvgHWYXNp8uVcUWoCew
	 JlzlYu7tov+JhZ0nYL3tZ7fSevgP0PoOUYqEruPN2V+If3sctyVGZA+nNq22OR21Bo
	 cdKqoYq/oSGeM8RD2BGcyPAgRcEEMBEN+kkbkA38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbfDRSAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390406AbfDRSAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF06206B6;
        Thu, 18 Apr 2019 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610440;
        bh=GFjuDMQCP0A4y3j7A46HYApIlOgHZp/J8BhcYEPU4X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk8/qsMGgg5Ga6q2iTWODKgR9EhpyvTwnE8PhitPhSQq9tOwhhkjGVXY3gySiMfuj
         N8Mfj40uCtzlJPwZjtsDxNkaHRjmHU3EcBtk0dv+L7MH03JniLDzR1Bush0yBa4+nZ
         vuQSgAxirtLSPVZu5Y7Jhyy/JcftVu/R1u7/psP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Allen <jallen@linux.ibm.com>,
        Haren Myneni <haren@us.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/110] powerpc/pseries: Remove prrn_work workqueue
Date:   Thu, 18 Apr 2019 19:56:52 +0200
Message-Id: <20190418160444.413611951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cd24e457fd8b2d087d9236700c8d2957054598bf ]

When a PRRN event is received we are already running in a worker
thread. Instead of spawning off another worker thread on the prrn_work
workqueue to handle the PRRN event we can just call the PRRN handler
routine directly.

With this update we can also pass the scope variable for the PRRN
event directly to the handler instead of it being a global variable.

This patch fixes the following oops mnessage we are seeing in PRRN testing:

  Oops: Bad kernel stack pointer, sig: 6 [#1]
  SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache binfmt_misc reiserfs vfat fat rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag af_packet xfs libcrc32c dm_service_time ibmveth(X) ses enclosure scsi_transport_sas rtc_generic btrfs xor raid6_pq sd_mod ibmvscsi(X) scsi_transport_srp ipr(X) libata sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod autofs4
  Supported: Yes, External                                                     54
  CPU: 7 PID: 18967 Comm: kworker/u96:0 Tainted: G                 X 4.4.126-94.22-default #1
  Workqueue: pseries hotplug workque pseries_hp_work_fn
  task: c000000775367790 ti: c00000001ebd4000 task.ti: c00000070d140000
  NIP: 0000000000000000 LR: 000000001fb3d050 CTR: 0000000000000000
  REGS: c00000001ebd7d40 TRAP: 0700   Tainted: G                 X  (4.4.126-94.22-default)
  MSR: 8000000102081000 <41,VEC,ME5  CR: 28000002  XER: 20040018   4
  CFAR: 000000001fb3d084 40 419   1                                3
  GPR00: 000000000000000040000000000010007 000000001ffff400 000000041fffe200
  GPR04: 000000000000008050000000000000000 000000001fb15fa8 0000000500000500
  GPR08: 000000000001f40040000000000000001 0000000000000000 000005:5200040002
  GPR12: 00000000000000005c000000007a05400 c0000000000e89f8 000000001ed9f668
  GPR16: 000000001fbeff944000000001fbeff94 000000001fb545e4 0000006000000060
  GPR20: ffffffffffffffff4ffffffffffffffff 0000000000000000 0000000000000000
  GPR24: 00000000000000005400000001fb3c000 0000000000000000 000000001fb1b040
  GPR28: 000000001fb240004000000001fb440d8 0000000000000008 0000000000000000
  NIP [0000000000000000] 5         (null)
  LR [000000001fb3d050] 031fb3d050
  Call Trace:            4
  Instruction dump:      4                                       5:47 12    2
  XXXXXXXX XXXXXXXX XXXXX4XX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
  XXXXXXXX XXXXXXXX XXXXX5XX XXXXXXXX 60000000 60000000 60000000 60000000
  ---[ end trace aa5627b04a7d9d6b ]---                                       3NMI watchdog: BUG: soft lockup - CPU#27 stuck for 23s! [kworker/27:0:13903]
  Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache binfmt_misc reiserfs vfat fat rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag af_packet xfs libcrc32c dm_service_time ibmveth(X) ses enclosure scsi_transport_sas rtc_generic btrfs xor raid6_pq sd_mod ibmvscsi(X) scsi_transport_srp ipr(X) libata sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod autofs4
  Supported: Yes, External
  CPU: 27 PID: 13903 Comm: kworker/27:0 Tainted: G      D          X 4.4.126-94.22-default #1
  Workqueue: events prrn_work_fn
  task: c000000747cfa390 ti: c00000074712c000 task.ti: c00000074712c000
  NIP: c0000000008002a8 LR: c000000000090770 CTR: 000000000032e088
  REGS: c00000074712f7b0 TRAP: 0901   Tainted: G      D          X  (4.4.126-94.22-default)
  MSR: 8000000100009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22482044  XER: 20040000
  CFAR: c0000000008002c4 SOFTE: 1
  GPR00: c000000000090770 c00000074712fa30 c000000000f09800 c000000000fa1928 6:02
  GPR04: c000000775f5e000 fffffffffffffffe 0000000000000001 c000000000f42db8
  GPR08: 0000000000000001 0000000080000007 0000000000000000 0000000000000000
  GPR12: 8006210083180000 c000000007a14400
  NIP [c0000000008002a8] _raw_spin_lock+0x68/0xd0
  LR [c000000000090770] mobility_rtas_call+0x50/0x100
  Call Trace:            59                                        5
  [c00000074712fa60] [c000000000090770] mobility_rtas_call+0x50/0x100
  [c00000074712faf0] [c000000000090b08] pseries_devicetree_update+0xf8/0x530
  [c00000074712fc20] [c000000000031ba4] prrn_work_fn+0x34/0x50
  [c00000074712fc40] [c0000000000e0390] process_one_work+0x1a0/0x4e0
  [c00000074712fcd0] [c0000000000e0870] worker_thread+0x1a0/0x6105:57       2
  [c00000074712fd80] [c0000000000e8b18] kthread+0x128/0x150
  [c00000074712fe30] [c0000000000096f8] ret_from_kernel_thread+0x5c/0x64
  Instruction dump:
  2c090000 40c20010 7d40192d 40c2fff0 7c2004ac 2fa90000 40de0018 5:540030   3
  e8010010 ebe1fff8 7c0803a6 4e800020 <7c210b78> e92d0000 89290009 792affe3

Signed-off-by: John Allen <jallen@linux.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtasd.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 44d66c33d59d..23b88b923f06 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -274,27 +274,16 @@ void pSeries_log_error(char *buf, unsigned int err_type, int fatal)
 }
 
 #ifdef CONFIG_PPC_PSERIES
-static s32 prrn_update_scope;
-
-static void prrn_work_fn(struct work_struct *work)
+static void handle_prrn_event(s32 scope)
 {
 	/*
 	 * For PRRN, we must pass the negative of the scope value in
 	 * the RTAS event.
 	 */
-	pseries_devicetree_update(-prrn_update_scope);
+	pseries_devicetree_update(-scope);
 	numa_update_cpu_topology(false);
 }
 
-static DECLARE_WORK(prrn_work, prrn_work_fn);
-
-static void prrn_schedule_update(u32 scope)
-{
-	flush_work(&prrn_work);
-	prrn_update_scope = scope;
-	schedule_work(&prrn_work);
-}
-
 static void handle_rtas_event(const struct rtas_error_log *log)
 {
 	if (rtas_error_type(log) != RTAS_TYPE_PRRN || !prrn_is_enabled())
@@ -303,7 +292,7 @@ static void handle_rtas_event(const struct rtas_error_log *log)
 	/* For PRRN Events the extended log length is used to denote
 	 * the scope for calling rtas update-nodes.
 	 */
-	prrn_schedule_update(rtas_error_extended_log_length(log));
+	handle_prrn_event(rtas_error_extended_log_length(log));
 }
 
 #else
-- 
2.19.1



