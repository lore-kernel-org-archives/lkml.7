Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC8C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F57420659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGBJba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:31:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfGBJba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:31:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EABAAAE15;
        Tue,  2 Jul 2019 09:31:26 +0000 (UTC)
Subject: Re: [PATCH] nvme: fix multipath crash when ANA deactivated
To:     Marta Rybczynska <mrybczyn@kalray.eu>, kbusch@kernel.org,
        axboe@fb.com, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
References: <708068303.29979589.1561975811341.JavaMail.zimbra@kalray.eu>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <6416b503-aa20-0094-6acf-101c60e9e3c9@suse.de>
Date:   Tue, 2 Jul 2019 11:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <708068303.29979589.1561975811341.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 12:10 PM, Marta Rybczynska wrote:
> Fix a crash with multipath activated. It happends when ANA log
> page is larger than MDTS and because of that ANA is disabled.
> When connecting the target, the driver in nvme_parse_ana_log
> then tries to access nvme_mpath_init.ctrl->ana_log_buf that is
> unallocated. The signature is as follows:
> 
> [  300.433586] nvme nvme0: ANA log page size (8208) larger than MDTS (8192).
> [  300.435387] nvme nvme0: disabling ANA support.
> [  300.437835] nvme nvme0: creating 4 I/O queues.
> [  300.459132] nvme nvme0: new ctrl: NQN "nqn.0.0.0", addr 10.91.0.1:8009
> [  300.464609] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [  300.466342] #PF error: [normal kernel read fault]
> [  300.467385] PGD 0 P4D 0
> [  300.467987] Oops: 0000 [#1] SMP PTI
> [  300.468787] CPU: 3 PID: 50 Comm: kworker/u8:1 Not tainted 5.0.20kalray+ #4
> [  300.470264] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  300.471532] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [  300.472724] RIP: 0010:nvme_parse_ana_log+0x21/0x140 [nvme_core]
> [  300.474038] Code: 45 01 d2 d8 48 98 c3 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b af 20 0a 00 00 48 89 34 24 <66> 83 7d 08 00 0f 84 c6 00 00 00 44 8b 7d 14 49 89 d5 8b 55 10 48
> [  300.477374] RSP: 0018:ffffa50e80fd7cb8 EFLAGS: 00010296
> [  300.478334] RAX: 0000000000000001 RBX: ffff9130f1872258 RCX: 0000000000000000
> [  300.479784] RDX: ffffffffc06c4c30 RSI: ffff9130edad4280 RDI: ffff9130f1872258
> [  300.481488] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
> [  300.483203] R10: 0000000000000220 R11: 0000000000000040 R12: ffff9130f18722c0
> [  300.484928] R13: ffff9130f18722d0 R14: ffff9130edad4280 R15: ffff9130f18722c0
> [  300.486626] FS:  0000000000000000(0000) GS:ffff9130f7b80000(0000) knlGS:0000000000000000
> [  300.488538] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  300.489907] CR2: 0000000000000008 CR3: 00000002365e6000 CR4: 00000000000006e0
> [  300.491612] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  300.493303] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  300.494991] Call Trace:
> [  300.495645]  nvme_mpath_add_disk+0x5c/0xb0 [nvme_core]
> [  300.496880]  nvme_validate_ns+0x2ef/0x550 [nvme_core]
> [  300.498105]  ? nvme_identify_ctrl.isra.45+0x6a/0xb0 [nvme_core]
> [  300.499539]  nvme_scan_work+0x2b4/0x370 [nvme_core]
> [  300.500717]  ? __switch_to_asm+0x35/0x70
> [  300.501663]  process_one_work+0x171/0x380
> [  300.502340]  worker_thread+0x49/0x3f0
> [  300.503079]  kthread+0xf8/0x130
> [  300.503795]  ? max_active_store+0x80/0x80
> [  300.504690]  ? kthread_bind+0x10/0x10
> [  300.505502]  ret_from_fork+0x35/0x40
> [  300.506280] Modules linked in: nvme_tcp nvme_rdma rdma_cm iw_cm ib_cm ib_core nvme_fabrics nvme_core xt_physdev ip6table_raw ip6table_mangle ip6table_filter ip6_tables xt_comment iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle iptable_filter veth ebtable_filter ebtable_nat ebtables iptable_raw vxlan ip6_udp_tunnel udp_tunnel sunrpc joydev pcspkr virtio_balloon br_netfilter bridge stp llc ip_tables xfs libcrc32c ata_generic pata_acpi virtio_net virtio_console net_failover virtio_blk failover ata_piix serio_raw libata virtio_pci virtio_ring virtio
> [  300.514984] CR2: 0000000000000008
> [  300.515569] ---[ end trace faa2eefad7e7f218 ]---
> [  300.516354] RIP: 0010:nvme_parse_ana_log+0x21/0x140 [nvme_core]
> [  300.517330] Code: 45 01 d2 d8 48 98 c3 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b af 20 0a 00 00 48 89 34 24 <66> 83 7d 08 00 0f 84 c6 00 00 00 44 8b 7d 14 49 89 d5 8b 55 10 48
> [  300.520353] RSP: 0018:ffffa50e80fd7cb8 EFLAGS: 00010296
> [  300.521229] RAX: 0000000000000001 RBX: ffff9130f1872258 RCX: 0000000000000000
> [  300.522399] RDX: ffffffffc06c4c30 RSI: ffff9130edad4280 RDI: ffff9130f1872258
> [  300.523560] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
> [  300.524734] R10: 0000000000000220 R11: 0000000000000040 R12: ffff9130f18722c0
> [  300.525915] R13: ffff9130f18722d0 R14: ffff9130edad4280 R15: ffff9130f18722c0
> [  300.527084] FS:  0000000000000000(0000) GS:ffff9130f7b80000(0000) knlGS:0000000000000000
> [  300.528396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  300.529440] CR2: 0000000000000008 CR3: 00000002365e6000 CR4: 00000000000006e0
> [  300.530739] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  300.531989] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  300.533264] Kernel panic - not syncing: Fatal exception
> [  300.534338] Kernel Offset: 0x17c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  300.536227] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
> Tested-by: Jean-Baptiste Riaux <jbriaux@kalray.eu>
> ---
>  drivers/nvme/host/multipath.c | 12 ++++++++++--
>  drivers/nvme/host/nvme.h      |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 499acf0..61dae87 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -12,11 +12,16 @@
>  MODULE_PARM_DESC(multipath,
>  	"turn on native support for multiple controllers per subsystem");
>  
> -inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
> +inline bool nvme_ctrl_has_ana_cap(struct nvme_ctrl *ctrl)
>  {
>  	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
>  }
>  
> +inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
> +{
> +	return nvme_ctrl_has_ana_cap(ctrl) && ctrl->ana_enabled;
> +}
> +
>  /*
>   * If multipathing is enabled we need to always use the subsystem instance
>   * number for numbering our devices to avoid conflicts between subsystems that
> @@ -614,7 +619,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  {
>  	int error;
>  
> -	if (!nvme_ctrl_use_ana(ctrl))
> +	if (!nvme_ctrl_has_ana_cap(ctrl))
>  		return 0;
>  
>  	ctrl->anacap = id->anacap;
> @@ -647,6 +652,8 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	error = nvme_read_ana_log(ctrl, true);
>  	if (error)
>  		goto out_free_ana_log_buf;
> +
> +	ctrl->ana_enabled = true;
>  	return 0;
>  out_free_ana_log_buf:
>  	kfree(ctrl->ana_log_buf);
> @@ -659,5 +666,6 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  {
>  	kfree(ctrl->ana_log_buf);
>  	ctrl->ana_log_buf = NULL;
> +	ctrl->ana_enabled = false;
>  }
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 55553d2..8daefeb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -219,6 +219,7 @@ struct nvme_ctrl {
>  	u8 anatt;
>  	u32 anagrpmax;
>  	u32 nanagrpid;
> +	bool ana_enabled;
>  	struct mutex ana_lock;
>  	struct nvme_ana_rsp_hdr *ana_log_buf;
>  	size_t ana_log_size;
> 
They idea was to use a 'ana_log_buf == NULL' as an indicator that ANA is
disabled, so there is no need to have an additional flag.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
