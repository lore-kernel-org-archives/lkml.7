Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9E321955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNE7BPhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfGVXjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:39:17 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:46335 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:39:16 -0400
Received: by mail-pl1-f176.google.com with SMTP id c2so19785670plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W/BccuiM7d69PHjAdhfzZNvzMRcMxM+70zWW29uwpRQ=;
        b=vNE7BPhi5tx4jQaTaqo0MjPVOS5jumgvsLbmZa7kyT1ohF+acDab4c/pDsdWqW3Sm4
         V3OpwqWq67TOw1w5Uz55hVVR/hokov2xQLAkb3ncGtbxuxSqRgdEoI7qV5Ig+s5iuvth
         ILns5wv+Ft6Hcr5Sw+2sieF8GSUg2ba0YCdZL4H5wahiUJ9QwjkC59G2DFxYl/fOANAr
         +CiZ2Mtg50O5T1PS/FlzUR1R6LQnloJHsTfiwD8+4D+eVx1v3nSuI5ZrfYvPS0E9jS7Y
         uzKDnkOhdV0H9bn4k1WkQKxTTzpEHmHzszj3q7jq2OB+1st81YvHxEJJ5kf/J5G7uuPv
         fx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W/BccuiM7d69PHjAdhfzZNvzMRcMxM+70zWW29uwpRQ=;
        b=ug03n2VO8PrRzT5v+obTB2Rho1D22LCvS1rMTD3o9cVIHqCw2Z2W3T07o8IaOBqRsu
         9NSiN6rtxvo4oRpMeKrh/9lJd3h0NmBkIdeeExHYf8J7cgXMQQeg/VHFxrTyfDuepdN/
         kOekhIFLSQsJIAAnVIQSBrfT/PczPST3yBlPmNSYax8L2sUr93bC/GDcgiuTrtXYVI+d
         ZOawSJNWj4gzdUFATqr0k35u8nbpXD7bJ/v1lAR4X0vhm+XWXP1N3m0TkyYmeAL6ixs5
         VYWfm+Y/egSn6LH1RLXSzxMPz+8YbrlAHPcLWTre32k7eGGsnEio/SQS64KJqXS8pAjS
         PrCg==
X-Gm-Message-State: APjAAAWKIX8ouELUfUo9yTc+q5VUL7B/ckVczgmRPNuDJ5R/MNuZMppo
        lNOo54vwb8omxs4Hq/HTjHmQu5Lw
X-Google-Smtp-Source: APXvYqypds77VSImzRca94jNYaH4eEk02peqk0k/o8MravbBpXd/Bd0RACzYGyc2MFbs2vHnorCY4w==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr78235473plb.60.1563838755406;
        Mon, 22 Jul 2019 16:39:15 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m20sm39771853pff.79.2019.07.22.16.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 16:39:14 -0700 (PDT)
Date:   Tue, 23 Jul 2019 07:39:06 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: scsi_debug module panic
Message-ID: <20190722233906.5kkmqjcoapw4ev62@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-2148-008987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It reproduces every time. It's ok on v5.2. So it's a regression in v5.3-rc1.

Thanks,
M

[root@7u ~]# modprobe scsi_debug
[  244.084203] scsi host2: scsi_debug: version 0188 [20190125]
[  244.084203]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
[  244.093098] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  244.097625] #PF: supervisor read access in kernel mode
[  244.101175] #PF: error_code(0x0000) - not-present page
[  244.104670] PGD 0 P4D 0
[  244.106381] Oops: 0000 [#1] SMP PTI
[  244.108738] CPU: 17 PID: 182 Comm: kworker/u64:1 Not tainted 5.3.0-rc1-master-5f9e832 #112
[  244.114161] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  244.117854] Workqueue: events_unbound async_run_entry_fn
[  244.121025] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x65
[  244.124324] Code: 66 66 66 90 55 53 48 89 fb e8 f1 14 00 00 84 c0 75 0a 5b 48 c7 c0 ff ff ff ff 5d c3 48 8b 83 28 02 00 00 48 8b ab 38 02 00 00 <48> 8b 00 48 89 ea 48 85 c0 74 0f 48 85 d2 48 89 c5 74 07 48 39 d0
[  244.135752] RSP: 0018:ffffb3bd40733bf8 EFLAGS: 00010202
[  244.139237] RAX: 0000000000000000 RBX: ffffa027feb50c18 RCX: 0000000000000000
[  244.143966] RDX: 0000000000000800 RSI: 0000000000000800 RDI: ffffa027feb50c18
[  244.148748] RBP: 0000000000000000 R08: 00000000000300e0 R09: ffffa028104dd280
[  244.153399] R10: ffffa028104dd280 R11: ffffffffffffffa0 R12: ffffa027feb50c18
[  244.157982] R13: 00000000ffffffff R14: ffffa0280513c828 R15: 0000000000000000
[  244.162375] FS:  0000000000000000(0000) GS:ffffa02894640000(0000) knlGS:0000000000000000
[  244.167286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  244.170876] CR2: 0000000000000000 CR3: 000000003c20a000 CR4: 00000000000006e0
[  244.175116] Call Trace:
[  244.176622]  __scsi_init_queue+0x7a/0x130
[  244.178788]  scsi_mq_alloc_queue+0x34/0x50
[  244.181015]  scsi_alloc_sdev+0x1e4/0x2b0
[  244.183150]  scsi_probe_and_add_lun+0x8af/0xd60
[  244.185628]  ? kobject_set_name_vargs+0x6e/0x90
[  244.188168]  ? dev_set_name+0x53/0x70
[  244.190258]  ? _cond_resched+0x15/0x30
[  244.192416]  ? mutex_lock+0xe/0x30
[  244.194284]  __scsi_scan_target+0xf4/0x250
[  244.196527]  scsi_scan_channel.part.13+0x52/0x70
[  244.198830]  scsi_scan_host_selected+0xe3/0x190
[  244.201159]  ? __switch_to_asm+0x40/0x70
[  244.203124]  do_scan_async+0x17/0x180
[  244.204961]  async_run_entry_fn+0x39/0x160
[  244.207012]  process_one_work+0x171/0x380
[  244.209007]  worker_thread+0x49/0x3f0
[  244.210840]  kthread+0xf8/0x130
[  244.212419]  ? max_active_store+0x80/0x80
[  244.214426]  ? kthread_bind+0x10/0x10
[  244.216264]  ret_from_fork+0x35/0x40
[  244.218075] Modules linked in: scsi_debug sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec crct10dif_pclmul snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel snd_seq snd_seq_device snd_pcm aesni_intel crypto_simd snd_timer cryptd snd glue_helper sg pcspkr soundcore joydev virtio_balloon i2c_piix4 ip_tables xfs libcrc32c qxl drm_kms_helper syscopyarea sysfillrect sd_mod sysimgblt fb_sys_fops ttm ata_generic pata_acpi drm virtio_console 8139too ata_piix libata virtio_pci 8139cp virtio_ring crc32c_intel serio_raw mii virtio floppy dm_mirror dm_region_hash dm_log dm_mod
[  244.243647] CR2: 0000000000000000
[  244.245274] ---[ end trace 1209311dc64cb7fa ]---
[  244.247399] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x65
[  244.250145] Code: 66 66 66 90 55 53 48 89 fb e8 f1 14 00 00 84 c0 75 0a 5b 48 c7 c0 ff ff ff ff 5d c3 48 8b 83 28 02 00 00 48 8b ab 38 02 00 00 <48> 8b 00 48 89 ea 48 85 c0 74 0f 48 85 d2 48 89 c5 74 07 48 39 d0
[  244.258533] RSP: 0018:ffffb3bd40733bf8 EFLAGS: 00010202
[  244.260749] RAX: 0000000000000000 RBX: ffffa027feb50c18 RCX: 0000000000000000
[  244.263777] RDX: 0000000000000800 RSI: 0000000000000800 RDI: ffffa027feb50c18
[  244.266798] RBP: 0000000000000000 R08: 00000000000300e0 R09: ffffa028104dd280
[  244.269901] R10: ffffa028104dd280 R11: ffffffffffffffa0 R12: ffffa027feb50c18
[  244.272899] R13: 00000000ffffffff R14: ffffa0280513c828 R15: 0000000000000000
[  244.275909] FS:  0000000000000000(0000) GS:ffffa02894640000(0000) knlGS:0000000000000000
[  244.279131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  244.281655] CR2: 0000000000000000 CR3: 000000003c20a000 CR4: 00000000000006e0
[  244.284554] Kernel panic - not syncing: Fatal exception
[  244.287052] Kernel Offset: 0x22c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  244.291412] ---[ end Kernel panic - not syncing: Fatal exception ]---

