Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F242C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B67206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="GSXYiWZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGBJwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:52:37 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:56238 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfGBJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:52:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6592C27E11B0;
        Tue,  2 Jul 2019 11:52:36 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g4ytjSJq8QjE; Tue,  2 Jul 2019 11:52:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C62D327EB8F4;
        Tue,  2 Jul 2019 11:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu C62D327EB8F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1562061155;
        bh=nVmNsGz6xn4Ojs+spz2qmKajm+Raw6vfOPlD+P8UQI0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GSXYiWZSlzwScgaKn3Vxf3XzEyMs3pD5JxxWN169X0XPTPAGaPriUb7g4soGC4+mv
         SX6sKmHszVv+CH2PFlp4r6m8WzgJNsM06fHN6By8SXd5eNvDMUcs9MDztB8xIrkxfb
         6nsn0OAcQx568TE7/FuxU3d68bIbobH5WXKGSi9M=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fw7GEHU8IQhE; Tue,  2 Jul 2019 11:52:35 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id ABA5227E11B0;
        Tue,  2 Jul 2019 11:52:35 +0200 (CEST)
Date:   Tue, 2 Jul 2019 11:52:35 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Message-ID: <1229162251.30096937.1562061155630.JavaMail.zimbra@kalray.eu>
In-Reply-To: <6416b503-aa20-0094-6acf-101c60e9e3c9@suse.de>
References: <708068303.29979589.1561975811341.JavaMail.zimbra@kalray.eu> <6416b503-aa20-0094-6acf-101c60e9e3c9@suse.de>
Subject: Re: [PATCH] nvme: fix multipath crash when ANA deactivated
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: fix multipath crash when ANA deactivated
Thread-Index: eSH13vlfBakBGkBLl7ravYk5RUBUZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On 2 Jul, 2019, at 11:31, Hannes Reinecke hare@suse.de wrote:

> On 7/1/19 12:10 PM, Marta Rybczynska wrote:
>> Fix a crash with multipath activated. It happends when ANA log
>> page is larger than MDTS and because of that ANA is disabled.
>> When connecting the target, the driver in nvme_parse_ana_log
>> then tries to access nvme_mpath_init.ctrl->ana_log_buf that is
>> unallocated. The signature is as follows:
>> 
>> [  300.433586] nvme nvme0: ANA log page size (8208) larger than MDTS (8192).
>> [  300.435387] nvme nvme0: disabling ANA support.
>> [  300.437835] nvme nvme0: creating 4 I/O queues.
>> [  300.459132] nvme nvme0: new ctrl: NQN "nqn.0.0.0", addr 10.91.0.1:8009
>> [  300.464609] BUG: unable to handle kernel NULL pointer dereference at
>> 0000000000000008
>> [  300.466342] #PF error: [normal kernel read fault]
>> [  300.467385] PGD 0 P4D 0
>> [  300.467987] Oops: 0000 [#1] SMP PTI
>> [  300.468787] CPU: 3 PID: 50 Comm: kworker/u8:1 Not tainted 5.0.20kalray+ #4
>> [  300.470264] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>> [  300.471532] Workqueue: nvme-wq nvme_scan_work [nvme_core]
>> [  300.472724] RIP: 0010:nvme_parse_ana_log+0x21/0x140 [nvme_core]
>> [  300.474038] Code: 45 01 d2 d8 48 98 c3 66 90 0f 1f 44 00 00 41 57 41 56 41 55
>> 41 54 55 53 48 89 fb 48 83 ec 08 48 8b af 20 0a 00 00 48 89 34 24 <66> 83 7d 08
>> 00 0f 84 c6 00 00 00 44 8b 7d 14 49 89 d5 8b 55 10 48
>> [  300.477374] RSP: 0018:ffffa50e80fd7cb8 EFLAGS: 00010296
>> [  300.478334] RAX: 0000000000000001 RBX: ffff9130f1872258 RCX: 0000000000000000
>> [  300.479784] RDX: ffffffffc06c4c30 RSI: ffff9130edad4280 RDI: ffff9130f1872258
>> [  300.481488] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
>> [  300.483203] R10: 0000000000000220 R11: 0000000000000040 R12: ffff9130f18722c0
>> [  300.484928] R13: ffff9130f18722d0 R14: ffff9130edad4280 R15: ffff9130f18722c0
>> [  300.486626] FS:  0000000000000000(0000) GS:ffff9130f7b80000(0000)
>> knlGS:0000000000000000
>> [  300.488538] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  300.489907] CR2: 0000000000000008 CR3: 00000002365e6000 CR4: 00000000000006e0
>> [  300.491612] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  300.493303] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  300.494991] Call Trace:
>> [  300.495645]  nvme_mpath_add_disk+0x5c/0xb0 [nvme_core]
>> [  300.496880]  nvme_validate_ns+0x2ef/0x550 [nvme_core]
>> [  300.498105]  ? nvme_identify_ctrl.isra.45+0x6a/0xb0 [nvme_core]
>> [  300.499539]  nvme_scan_work+0x2b4/0x370 [nvme_core]
>> [  300.500717]  ? __switch_to_asm+0x35/0x70
>> [  300.501663]  process_one_work+0x171/0x380
>> [  300.502340]  worker_thread+0x49/0x3f0
>> [  300.503079]  kthread+0xf8/0x130
>> [  300.503795]  ? max_active_store+0x80/0x80
>> [  300.504690]  ? kthread_bind+0x10/0x10
>> [  300.505502]  ret_from_fork+0x35/0x40
>> [  300.506280] Modules linked in: nvme_tcp nvme_rdma rdma_cm iw_cm ib_cm ib_core
>> nvme_fabrics nvme_core xt_physdev ip6table_raw ip6table_mangle ip6table_filter
>> ip6_tables xt_comment iptable_nat nf_nat_ipv4 nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle iptable_filter veth
>> ebtable_filter ebtable_nat ebtables iptable_raw vxlan ip6_udp_tunnel udp_tunnel
>> sunrpc joydev pcspkr virtio_balloon br_netfilter bridge stp llc ip_tables xfs
>> libcrc32c ata_generic pata_acpi virtio_net virtio_console net_failover
>> virtio_blk failover ata_piix serio_raw libata virtio_pci virtio_ring virtio
>> [  300.514984] CR2: 0000000000000008
>> [  300.515569] ---[ end trace faa2eefad7e7f218 ]---
>> [  300.516354] RIP: 0010:nvme_parse_ana_log+0x21/0x140 [nvme_core]
>> [  300.517330] Code: 45 01 d2 d8 48 98 c3 66 90 0f 1f 44 00 00 41 57 41 56 41 55
>> 41 54 55 53 48 89 fb 48 83 ec 08 48 8b af 20 0a 00 00 48 89 34 24 <66> 83 7d 08
>> 00 0f 84 c6 00 00 00 44 8b 7d 14 49 89 d5 8b 55 10 48
>> [  300.520353] RSP: 0018:ffffa50e80fd7cb8 EFLAGS: 00010296
>> [  300.521229] RAX: 0000000000000001 RBX: ffff9130f1872258 RCX: 0000000000000000
>> [  300.522399] RDX: ffffffffc06c4c30 RSI: ffff9130edad4280 RDI: ffff9130f1872258
>> [  300.523560] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
>> [  300.524734] R10: 0000000000000220 R11: 0000000000000040 R12: ffff9130f18722c0
>> [  300.525915] R13: ffff9130f18722d0 R14: ffff9130edad4280 R15: ffff9130f18722c0
>> [  300.527084] FS:  0000000000000000(0000) GS:ffff9130f7b80000(0000)
>> knlGS:0000000000000000
>> [  300.528396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  300.529440] CR2: 0000000000000008 CR3: 00000002365e6000 CR4: 00000000000006e0
>> [  300.530739] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  300.531989] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  300.533264] Kernel panic - not syncing: Fatal exception
>> [  300.534338] Kernel Offset: 0x17c00000 from 0xffffffff81000000 (relocation
>> range: 0xffffffff80000000-0xffffffffbfffffff)
>> [  300.536227] ---[ end Kernel panic - not syncing: Fatal exception ]---
>> 
>> Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
>> Tested-by: Jean-Baptiste Riaux <jbriaux@kalray.eu>
>> ---
>>  drivers/nvme/host/multipath.c | 12 ++++++++++--
>>  drivers/nvme/host/nvme.h      |  1 +
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 499acf0..61dae87 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -12,11 +12,16 @@
>>  MODULE_PARM_DESC(multipath,
>>  	"turn on native support for multiple controllers per subsystem");
>>  
>> -inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>> +inline bool nvme_ctrl_has_ana_cap(struct nvme_ctrl *ctrl)
>>  {
>>  	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
>>  }
>>  
>> +inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>> +{
>> +	return nvme_ctrl_has_ana_cap(ctrl) && ctrl->ana_enabled;
>> +}
>> +
>>  /*
>>   * If multipathing is enabled we need to always use the subsystem instance
>>   * number for numbering our devices to avoid conflicts between subsystems that
>> @@ -614,7 +619,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct
>> nvme_id_ctrl *id)
>>  {
>>  	int error;
>>  
>> -	if (!nvme_ctrl_use_ana(ctrl))
>> +	if (!nvme_ctrl_has_ana_cap(ctrl))
>>  		return 0;
>>  
>>  	ctrl->anacap = id->anacap;
>> @@ -647,6 +652,8 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct
>> nvme_id_ctrl *id)
>>  	error = nvme_read_ana_log(ctrl, true);
>>  	if (error)
>>  		goto out_free_ana_log_buf;
>> +
>> +	ctrl->ana_enabled = true;
>>  	return 0;
>>  out_free_ana_log_buf:
>>  	kfree(ctrl->ana_log_buf);
>> @@ -659,5 +666,6 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>>  {
>>  	kfree(ctrl->ana_log_buf);
>>  	ctrl->ana_log_buf = NULL;
>> +	ctrl->ana_enabled = false;
>>  }
>>  
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 55553d2..8daefeb 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -219,6 +219,7 @@ struct nvme_ctrl {
>>  	u8 anatt;
>>  	u32 anagrpmax;
>>  	u32 nanagrpid;
>> +	bool ana_enabled;
>>  	struct mutex ana_lock;
>>  	struct nvme_ana_rsp_hdr *ana_log_buf;
>>  	size_t ana_log_size;
>> 
> They idea was to use a 'ana_log_buf == NULL' as an indicator that ANA is
> disabled, so there is no need to have an additional flag.

OK, still keeping the split of the helper functions?

Marta
