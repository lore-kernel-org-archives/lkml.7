Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245EBC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09B02229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="kJ0Ov8aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfGWFl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:41:27 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:38306 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfGWFl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:41:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 9AA1D27E19C9;
        Tue, 23 Jul 2019 07:41:25 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xf575f68-G2y; Tue, 23 Jul 2019 07:41:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 840A527F19BB;
        Tue, 23 Jul 2019 07:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 840A527F19BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1563860480;
        bh=Fz7ra1b4zGrcDB5Z4BDVsPsqAirfiT8ZjUF9b06G/1k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kJ0Ov8aIQ1R5H0fTS9/w9dv/JrdAY41phf5KcEYLlqh0xTbinFNYq9Bh6PCaM86iu
         VCPl572foLKQ/4sivLLlEZHK/J6+2ZfZFWfBSKvvlxOjvJxX0OglRkxPsKv6JzqbXX
         1gswxbcfVLMYcS7iLi1niPWjs+R0rRnyuf24kqOk=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3nSfphawIAOV; Tue, 23 Jul 2019 07:41:20 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 66D4727E19C9;
        Tue, 23 Jul 2019 07:41:20 +0200 (CEST)
Date:   Tue, 23 Jul 2019 07:41:20 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jean-Baptiste Riaux <jbriaux@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>
Message-ID: <504897239.41425939.1563860480394.JavaMail.zimbra@kalray.eu>
Subject: [PATCH v3] nvme: fix multipath crash when ANA deactivated
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Index: ROP7dx7VPLddMhRR6riNxV8QN4nYoA==
Thread-Topic: nvme: fix multipath crash when ANA deactivated
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a crash with multipath activated. It happends when ANA log
page is larger than MDTS and because of that ANA is disabled.
The driver then tries to access unallocated buffer when connecting
to a nvme target. The signature is as follows:

[  300.433586] nvme nvme0: ANA log page size (8208) larger than MDTS (8192).
[  300.435387] nvme nvme0: disabling ANA support.
[  300.437835] nvme nvme0: creating 4 I/O queues.
[  300.459132] nvme nvme0: new ctrl: NQN "nqn.0.0.0", addr 10.91.0.1:8009
[  300.464609] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[  300.466342] #PF error: [normal kernel read fault]
[  300.467385] PGD 0 P4D 0
[  300.467987] Oops: 0000 [#1] SMP PTI
[  300.468787] CPU: 3 PID: 50 Comm: kworker/u8:1 Not tainted 5.0.20kalray+ #4
[  300.470264] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  300.471532] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[  300.472724] RIP: 0010:nvme_parse_ana_log+0x21/0x140 [nvme_core]
[  300.474038] Code: 45 01 d2 d8 48 98 c3 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b af 20 0a 00 00 48 89 34 24 <66> 83 7d 08 00 0f 84 c6 00 00 00 44 8b 7d 14 49 89 d5 8b 55 10 48
[  300.477374] RSP: 0018:ffffa50e80fd7cb8 EFLAGS: 00010296
[  300.478334] RAX: 0000000000000001 RBX: ffff9130f1872258 RCX: 0000000000000000
[  300.479784] RDX: ffffffffc06c4c30 RSI: ffff9130edad4280 RDI: ffff9130f1872258
[  300.481488] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
[  300.483203] R10: 0000000000000220 R11: 0000000000000040 R12: ffff9130f18722c0
[  300.484928] R13: ffff9130f18722d0 R14: ffff9130edad4280 R15: ffff9130f18722c0
[  300.486626] FS:  0000000000000000(0000) GS:ffff9130f7b80000(0000) knlGS:0000000000000000
[  300.488538] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  300.489907] CR2: 0000000000000008 CR3: 00000002365e6000 CR4: 00000000000006e0
[  300.491612] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  300.493303] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  300.494991] Call Trace:
[  300.495645]  nvme_mpath_add_disk+0x5c/0xb0 [nvme_core]
[  300.496880]  nvme_validate_ns+0x2ef/0x550 [nvme_core]
[  300.498105]  ? nvme_identify_ctrl.isra.45+0x6a/0xb0 [nvme_core]
[  300.499539]  nvme_scan_work+0x2b4/0x370 [nvme_core]
[  300.500717]  ? __switch_to_asm+0x35/0x70
[  300.501663]  process_one_work+0x171/0x380
[  300.502340]  worker_thread+0x49/0x3f0
[  300.503079]  kthread+0xf8/0x130
[  300.503795]  ? max_active_store+0x80/0x80
[  300.504690]  ? kthread_bind+0x10/0x10
[  300.505502]  ret_from_fork+0x35/0x40
[  300.506280] Modules linked in: nvme_tcp nvme_rdma rdma_cm iw_cm ib_cm ib_core nvme_fabrics nvme_core xt_physdev ip6table_raw ip6table_mangle ip6table_filter ip6_tables xt_comment iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle iptable_filter veth ebtable_filter ebtable_nat ebtables iptable_raw vxlan ip6_udp_tunnel udp_tunnel sunrpc joydev pcspkr virtio_balloon br_netfilter bridge stp llc ip_tables xfs libcrc32c ata_generic pata_acpi virtio_net virtio_console net_failover virtio_blk failover ata_piix serio_raw libata virtio_pci virtio_ring virtio
[  300.514984] CR2: 0000000000000008
[  300.515569] ---[ end trace faa2eefad7e7f218 ]---
[  300.516354] RIP: 0010:nvme_parse_ana_log+0x21/0x140 [nvme_core]
[  300.517330] Code: 45 01 d2 d8 48 98 c3 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b af 20 0a 00 00 48 89 34 24 <66> 83 7d 08 00 0f 84 c6 00 00 00 44 8b 7d 14 49 89 d5 8b 55 10 48
[  300.520353] RSP: 0018:ffffa50e80fd7cb8 EFLAGS: 00010296
[  300.521229] RAX: 0000000000000001 RBX: ffff9130f1872258 RCX: 0000000000000000
[  300.522399] RDX: ffffffffc06c4c30 RSI: ffff9130edad4280 RDI: ffff9130f1872258
[  300.523560] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
[  300.524734] R10: 0000000000000220 R11: 0000000000000040 R12: ffff9130f18722c0
[  300.525915] R13: ffff9130f18722d0 R14: ffff9130edad4280 R15: ffff9130f18722c0
[  300.527084] FS:  0000000000000000(0000) GS:ffff9130f7b80000(0000) knlGS:0000000000000000
[  300.528396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  300.529440] CR2: 0000000000000008 CR3: 00000002365e6000 CR4: 00000000000006e0
[  300.530739] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  300.531989] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  300.533264] Kernel panic - not syncing: Fatal exception
[  300.534338] Kernel Offset: 0x17c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  300.536227] ---[ end Kernel panic - not syncing: Fatal exception ]---

Condition check refactoring from Christoph Hellwig.

Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
Tested-by: Jean-Baptiste Riaux <jbriaux@kalray.eu>
---
 drivers/nvme/host/multipath.c | 8 ++------
 drivers/nvme/host/nvme.h      | 6 +++++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 499acf0..e942b3e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -12,11 +12,6 @@
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
-inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-{
-	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
-}
-
 /*
  * If multipathing is enabled we need to always use the subsystem instance
  * number for numbering our devices to avoid conflicts between subsystems that
@@ -614,7 +609,8 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
 
-	if (!nvme_ctrl_use_ana(ctrl))
+	/* check if multipath is enabled and we have the capability */
+	if (!multipath || !ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
 		return 0;
 
 	ctrl->anacap = id->anacap;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55553d2..7391cd0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -472,7 +472,11 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl);
+static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
+{
+	return ctrl->ana_log_buf != NULL;
+}
+
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
-- 
1.8.3.1

