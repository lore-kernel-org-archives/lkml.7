Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37456C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 02:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E972080F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 02:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juw3scxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfJGCY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 22:24:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38047 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJGCY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 22:24:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so17129776qta.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EiPKO2x+8WmMGpkwQAjsCJ/PCxrP2liaNXYszw2WHfc=;
        b=juw3scxmuLr6XyKVjNVmTpglHIxfxlLpZGOwrh+LVXw0qd6Apks4mcOkSXQCYuSSYZ
         fsdP/FNi/sNd7Zocw8Tdzj07u0vISQnseDAx8j4j9DW5AbF+Cqn/+T7xH0e1b+/EK9vx
         9Yy0qcbwKxmG/LvM2KV7YkvqgLvxDLYZoFL8NCxJrtxNzqAIVXTqhv+XUxd0Cb9+C3sN
         CfdPvgyTzyR4ccIr5ToaA2mGBHf1E/gMdF+0agVGvlTLFrGR2Hrx3Vml7u7oO05OJcsz
         mSSNcE0OJdwVXr1HHBgVbDw+YsEYM697FCHam+n8P/WRtHBg6sFJqS7RGjlJFDAD9VGG
         /FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=EiPKO2x+8WmMGpkwQAjsCJ/PCxrP2liaNXYszw2WHfc=;
        b=DIZmK775eO+5jgHzfZsT/M7XXSpRYY4EHMM7J2Nx1W9S/5R6ovG8AMYyBpDKxofcc6
         nBM/8nOO3XIKWHYLNaQxkBzsZeBZ/s11IST8rAM4H5ivq6w+wUPmxQrn75BHaIgqbC2o
         33f4UtKUfkhmZVMe4j3D+H4S/F5nMaHKcJtIffez4KG3VGAMup3X27TQZCQL8S87HR+U
         ds5M2xEGIfSZezburm00HEJW4PYRW2V+CYhCNcQdkRPga1LE8iXbPV250Jxw80yCDcAh
         sJctIuOUhGBoD0QNGOhKxr6adY2l/Doy64X20QGLIyArUZF5iSeMjqV9KwATGSG8d8ci
         w7YQ==
X-Gm-Message-State: APjAAAWrdeHIg8PKcAkkbaNHMDoAp2HbE74p/2SBFg+gUKMSS2FiAxZu
        71OGnFqx8JCqepl3cRQVVXvmJL0EP5A=
X-Google-Smtp-Source: APXvYqzjVry2k2R3oNkgdSqu87fmlHQhnNLP6NWLlEkSVzGXqnmzA3TX9d7yGyvkSRdNyzPJ7jfwoQ==
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr27750604qtb.41.1570415096999;
        Sun, 06 Oct 2019 19:24:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p53sm7578049qtk.23.2019.10.06.19.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 19:24:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 6 Oct 2019 22:24:54 -0400
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007022454.GA5270@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Commit 249baa547901 ("dma-mapping: provide a better default
->get_required_mask") causes an error on ehci-pci for me.

Either reverting the commit or disabling iommu=pt seems to fix this.

[    9.000081] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    9.000755] ehci-pci 0000:00:1a.0: swiotlb buffer is full (sz: 8 bytes), total 0 (slots), used 0 (slots)
[    9.001179] ehci-pci 0000:00:1a.0: overflow 0x000000042f541790+8 of DMA mask ffffffff bus mask 0
[    9.001552] ------------[ cut here ]------------
[    9.001933] WARNING: CPU: 0 PID: 7 at kernel/dma/direct.c:35 report_addr+0x3c/0x70
[    9.002355] Modules linked in:
[    9.002802] CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.4.0-rc2-stable-rani-zfs+ #67
[    9.003270] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D8 WS/Z10PE-D8 WS, BIOS 3703 04/13/2018
[    9.003761] Workqueue: usb_hub_wq hub_event
[    9.004241] RIP: 0010:report_addr+0x3c/0x70
[    9.004722] Code: 48 89 34 24 48 8b 85 e8 01 00 00 48 85 c0 74 30 4c 8b 00 b8 fe ff ff ff 49 39 c0 76 17 80 3d 86 6f 23 01 00 0f 84 df 06 00 00 <0f> 0b 48 83 c4 08 5d 41 5c c3 48 83 bd f8 01 00 00 00 74 ec eb dd
[    9.005743] RSP: 0000:ffffb25706307af8 EFLAGS: 00010286
[    9.006261] RAX: 0000000000000000 RBX: ffffe0e3d0bd5040 RCX: 00000000000006fc
[    9.006783] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffffffffab163fe8
[    9.007301] RBP: ffffa38c678a00b0 R08: 0000000000000000 R09: 00000000000006fc
[    9.007826] R10: 0000000000aaaaaa R11: 00000000ff000000 R12: 0000000000000008
[    9.008339] R13: 0000000000000000 R14: 0000000000000790 R15: ffffa38c678a00b0
[    9.008849] FS:  0000000000000000(0000) GS:ffffa38b5f600000(0000) knlGS:0000000000000000
[    9.009355] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.009866] CR2: ffffa396b4001000 CR3: 00000013b340a001 CR4: 00000000003606f0
[    9.010498] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.011034] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.011580] Call Trace:
[    9.012110]  dma_direct_map_page+0xf8/0x110
[    9.012632]  usb_hcd_map_urb_for_dma+0x204/0x530
[    9.013149]  usb_hcd_submit_urb+0x375/0xb70
[    9.013668]  usb_start_wait_urb+0x8a/0x190
[    9.014188]  usb_control_msg+0xe5/0x150
[    9.014693]  hub_port_init+0x21b/0xb40
[    9.015190]  hub_event+0xb21/0x14f0
[    9.015710]  process_one_work+0x1e5/0x390
[    9.016215]  worker_thread+0x4d/0x3d0
[    9.016720]  kthread+0xfd/0x130
[    9.017207]  ? process_one_work+0x390/0x390
[    9.017687]  ? kthread_park+0x90/0x90
[    9.018163]  ret_from_fork+0x3a/0x50
[    9.018642] ---[ end trace 55eaa8968ea11ab5 ]---
[    9.019124] ehci-pci 0000:00:1a.0: swiotlb buffer is full (sz: 8 bytes), total 0 (slots), used 0 (slots)

cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 79
model name	: Intel(R) Xeon(R) CPU E5-2696 v4 @ 2.20GHz
stepping	: 1
microcode	: 0xb000038
cpu MHz		: 3353.679
cache size	: 28160 KB
physical id	: 0
siblings	: 44
core id		: 0
cpu cores	: 22
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 20
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 invpcid_single pti intel_ppin ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsaveopt cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp md_clear flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs
bogomips	: 4390.26
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

lspci:

00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. C610/X99 series chipset USB Enhanced Host Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 19
	NUMA node: 0
	Region 0: Memory at bc112000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

