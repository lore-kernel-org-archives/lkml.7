Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F15C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF902190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfGVSIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfGVSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D074307D915;
        Mon, 22 Jul 2019 18:08:54 +0000 (UTC)
Received: from mail.happyassassin.net (ovpn-117-73.phx2.redhat.com [10.3.117.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8B5860600;
        Mon, 22 Jul 2019 18:08:53 +0000 (UTC)
Message-ID: <ea24edb0d81d8fd93ef3805699e4f4da264b093a.camel@redhat.com>
Authentication-Results: mail.happyassassin.net; dmarc=none (p=none dis=none) header.from=redhat.com
Subject: Re: 5.3-rc1 panic in dma_direct_max_mapping_size
From:   Adam Williamson <awilliam@redhat.com>
To:     davej@codemonkey.org.uk
Cc:     hch@lst.de, linux-kernel@vger.kernel.org, labbott@redhat.com,
        jforbes@redhat.com
Date:   Mon, 22 Jul 2019 11:08:53 -0700
In-Reply-To: <20190722163759.GA28686@codemonkey.org.uk>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.33.3 (3.33.3-2.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 22 Jul 2019 18:08:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing something similar but not identical here. I updated a Fedora
Rawhide virt-manager/libvirt VM (installed with the previous Fedora
kernel build) to the Fedora rc1 kernel build, and it doesn't boot any
more, with this trace:

[    3.018311] scsi host8: Virtio SCSI HBA
[    3.019234] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    3.020321] #PF: supervisor read access in kernel mode
[    3.021114] #PF: error_code(0x0000) - not-present page
[    3.021898] PGD 0 P4D 0 
[    3.022299] Oops: 0000 [#1] SMP PTI
[    3.022836] CPU: 1 PID: 164 Comm: kworker/u4:5 Not tainted 5.3.0-0.rc1.git0.1.fc31.x86_64 #1
[    3.024120] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190617_165236-buildvm-18.phx2.fedoraproject.org-1.fc31 04/01/2014
[    3.025924] Workqueue: events_unbound async_run_entry_fn
[    3.026727] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x64
[    3.027573] Code: 66 66 66 90 55 48 89 fd 53 e8 81 13 00 00 84 c0 75 0a 48 c7 c0 ff ff ff ff 5b 5d c3 48 8b 85 28 02 00 00 48 8b 9d 38 02 00 00 <48> 8b 00 48 85 c0 74 0c 48 85 db 74 27 48 39 c3 48 0f 47 d8 48 89
[    3.030444] RSP: 0000:ffffb60d001ebc20 EFLAGS: 00010202
[    3.031234] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    3.032269] RDX: ffff8ef87b3dbe80 RSI: 000000000000007e RDI: ffff8ef87535c810
[    3.033333] RBP: ffff8ef87535c810 R08: ffff8ef87bb2e0e0 R09: ffff8ef87b003340
[    3.034403] R10: 000000000002f3a0 R11: 0000000000000011 R12: ffff8ef87535c810
[    3.035469] R13: 000000000000ffff R14: ffff8ef87371c828 R15: 0000000000000000
[    3.036540] FS:  0000000000000000(0000) GS:ffff8ef87bb00000(0000) knlGS:0000000000000000
[    3.037748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.038612] CR2: 0000000000000000 CR3: 0000000134b24006 CR4: 0000000000060ee0
[    3.039689] Call Trace:
[    3.040073]  __scsi_init_queue+0x75/0x140
[    3.040685]  scsi_mq_alloc_queue+0x34/0x50
[    3.041307]  scsi_alloc_sdev+0x1f9/0x2c0
[    3.041902]  scsi_probe_and_add_lun+0x9a2/0xd70
[    3.042589]  ? _cond_resched+0x15/0x30
[    3.043148]  ? mutex_lock+0xe/0x30
[    3.043669]  __scsi_scan_target+0xec/0x5c0
[    3.044299]  ? __switch_to_asm+0x34/0x70
[    3.044896]  ? __switch_to_asm+0x40/0x70
[    3.045495]  ? __switch_to_asm+0x34/0x70
[    3.046092]  ? __switch_to_asm+0x34/0x70
[    3.046692]  ? __switch_to_asm+0x40/0x70
[    3.047292]  scsi_scan_channel+0x57/0x90
[    3.047890]  scsi_scan_host_selected+0xdb/0x110
[    3.048581]  do_scan_async+0x18/0x150
[    3.049140]  async_run_entry_fn+0x39/0x160
[    3.049765]  process_one_work+0x19d/0x340
[    3.050377]  worker_thread+0x50/0x3b0
[    3.050933]  kthread+0xfb/0x130
[    3.051418]  ? process_one_work+0x340/0x340
[    3.052052]  ? kthread_park+0x80/0x80
[    3.052613]  ret_from_fork+0x35/0x40
[    3.053157] Modules linked in: virtio_net ata_generic net_failover failover serio_raw virtio_scsi pata_acpi qemu_fw_cfg fuse
[    3.054832] CR2: 0000000000000000
[    3.055342] ---[ end trace c6389143c53d3973 ]---

Happens whether the disk image is attached to the VM as virtio or IDE.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net

