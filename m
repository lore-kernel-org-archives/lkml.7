Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D7C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673122387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnsoVOKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfGWChx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:37:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39724 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfGWChw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lVluyFxlWoQ8eDqcaFLRysRoh7uf4b+K1Wbi1vRctJo=; b=ZnsoVOKlS95iZQP0O/qhtvLwAN
        RvpLaZC6gsCchkAzeno/6E0161JdBy0y4O64bBszrm2U8N+Lt/zNqg/2LmGlSUcQbAfbbuhheDYIU
        YHhJAPpnPnbrIeEQ9j0ZJQbNS0q4dopoyDe0yvCM22buHVJx/TL/NbPPE5TB0jJFz/YBGk3RyqVmb
        9WM/Q6yCdMxXNMK/K+t2d9lOy0Lvvtj7ZlUsEp0sVrTmE8bZq2UAiCDU5nLSPhvJ54kUktz1illmg
        DBPiDMiWI5IY20O04ti7prMTRumsnBG7FOxklnSooOQ7n4hq0yFrMomGgp7wo+u/eDri1aiByPA8T
        VUgguiNg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpkgY-0001ji-H4; Tue, 23 Jul 2019 02:37:50 +0000
Subject: Re: scsi_debug module panic
To:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20190722233906.5kkmqjcoapw4ev62@XZHOUW.usersys.redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cd82bbd5-a8b4-3aa4-e342-ac888273923f@infradead.org>
Date:   Mon, 22 Jul 2019 19:37:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722233906.5kkmqjcoapw4ev62@XZHOUW.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-scsi]

On 7/22/19 4:39 PM, Murphy Zhou wrote:
> 
> Hi,
> 
> It reproduces every time. It's ok on v5.2. So it's a regression in v5.3-rc1.
> 
> Thanks,
> M
> 
> [root@7u ~]# modprobe scsi_debug
> [  244.084203] scsi host2: scsi_debug: version 0188 [20190125]
> [  244.084203]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  244.093098] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  244.097625] #PF: supervisor read access in kernel mode
> [  244.101175] #PF: error_code(0x0000) - not-present page
> [  244.104670] PGD 0 P4D 0
> [  244.106381] Oops: 0000 [#1] SMP PTI
> [  244.108738] CPU: 17 PID: 182 Comm: kworker/u64:1 Not tainted 5.3.0-rc1-master-5f9e832 #112
> [  244.114161] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  244.117854] Workqueue: events_unbound async_run_entry_fn
> [  244.121025] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x65
> [  244.124324] Code: 66 66 66 90 55 53 48 89 fb e8 f1 14 00 00 84 c0 75 0a 5b 48 c7 c0 ff ff ff ff 5d c3 48 8b 83 28 02 00 00 48 8b ab 38 02 00 00 <48> 8b 00 48 89 ea 48 85 c0 74 0f 48 85 d2 48 89 c5 74 07 48 39 d0
> [  244.135752] RSP: 0018:ffffb3bd40733bf8 EFLAGS: 00010202
> [  244.139237] RAX: 0000000000000000 RBX: ffffa027feb50c18 RCX: 0000000000000000
> [  244.143966] RDX: 0000000000000800 RSI: 0000000000000800 RDI: ffffa027feb50c18
> [  244.148748] RBP: 0000000000000000 R08: 00000000000300e0 R09: ffffa028104dd280
> [  244.153399] R10: ffffa028104dd280 R11: ffffffffffffffa0 R12: ffffa027feb50c18
> [  244.157982] R13: 00000000ffffffff R14: ffffa0280513c828 R15: 0000000000000000
> [  244.162375] FS:  0000000000000000(0000) GS:ffffa02894640000(0000) knlGS:0000000000000000
> [  244.167286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  244.170876] CR2: 0000000000000000 CR3: 000000003c20a000 CR4: 00000000000006e0
> [  244.175116] Call Trace:
> [  244.176622]  __scsi_init_queue+0x7a/0x130
> [  244.178788]  scsi_mq_alloc_queue+0x34/0x50
> [  244.181015]  scsi_alloc_sdev+0x1e4/0x2b0
> [  244.183150]  scsi_probe_and_add_lun+0x8af/0xd60
> [  244.185628]  ? kobject_set_name_vargs+0x6e/0x90
> [  244.188168]  ? dev_set_name+0x53/0x70
> [  244.190258]  ? _cond_resched+0x15/0x30
> [  244.192416]  ? mutex_lock+0xe/0x30
> [  244.194284]  __scsi_scan_target+0xf4/0x250
> [  244.196527]  scsi_scan_channel.part.13+0x52/0x70
> [  244.198830]  scsi_scan_host_selected+0xe3/0x190
> [  244.201159]  ? __switch_to_asm+0x40/0x70
> [  244.203124]  do_scan_async+0x17/0x180
> [  244.204961]  async_run_entry_fn+0x39/0x160
> [  244.207012]  process_one_work+0x171/0x380
> [  244.209007]  worker_thread+0x49/0x3f0
> [  244.210840]  kthread+0xf8/0x130
> [  244.212419]  ? max_active_store+0x80/0x80
> [  244.214426]  ? kthread_bind+0x10/0x10
> [  244.216264]  ret_from_fork+0x35/0x40
> [  244.218075] Modules linked in: scsi_debug sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec crct10dif_pclmul snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel snd_seq snd_seq_device snd_pcm aesni_intel crypto_simd snd_timer cryptd snd glue_helper sg pcspkr soundcore joydev virtio_balloon i2c_piix4 ip_tables xfs libcrc32c qxl drm_kms_helper syscopyarea sysfillrect sd_mod sysimgblt fb_sys_fops ttm ata_generic pata_acpi drm virtio_console 8139too ata_piix libata virtio_pci 8139cp virtio_ring crc32c_intel serio_raw mii virtio floppy dm_mirror dm_region_hash dm_log dm_mod
> [  244.243647] CR2: 0000000000000000
> [  244.245274] ---[ end trace 1209311dc64cb7fa ]---
> [  244.247399] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x65
> [  244.250145] Code: 66 66 66 90 55 53 48 89 fb e8 f1 14 00 00 84 c0 75 0a 5b 48 c7 c0 ff ff ff ff 5d c3 48 8b 83 28 02 00 00 48 8b ab 38 02 00 00 <48> 8b 00 48 89 ea 48 85 c0 74 0f 48 85 d2 48 89 c5 74 07 48 39 d0
> [  244.258533] RSP: 0018:ffffb3bd40733bf8 EFLAGS: 00010202
> [  244.260749] RAX: 0000000000000000 RBX: ffffa027feb50c18 RCX: 0000000000000000
> [  244.263777] RDX: 0000000000000800 RSI: 0000000000000800 RDI: ffffa027feb50c18
> [  244.266798] RBP: 0000000000000000 R08: 00000000000300e0 R09: ffffa028104dd280
> [  244.269901] R10: ffffa028104dd280 R11: ffffffffffffffa0 R12: ffffa027feb50c18
> [  244.272899] R13: 00000000ffffffff R14: ffffa0280513c828 R15: 0000000000000000
> [  244.275909] FS:  0000000000000000(0000) GS:ffffa02894640000(0000) knlGS:0000000000000000
> [  244.279131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  244.281655] CR2: 0000000000000000 CR3: 000000003c20a000 CR4: 00000000000006e0
> [  244.284554] Kernel panic - not syncing: Fatal exception
> [  244.287052] Kernel Offset: 0x22c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  244.291412] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 


-- 
~Randy
