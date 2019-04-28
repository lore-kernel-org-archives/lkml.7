Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D388EC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED712067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="nUtxNmBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfD1Pkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:40:39 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:50650 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfD1Pkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=pps7OI5fvyYp6T9KUAKwGZSRnI4+VAW8mwAH3FxT1mk=;
        b=nUtxNmBqiuTqccb7AapvXQwIHN/G1Uji1YcgTttC1Fi2z8XM/BCn5WEHA4koAtsbcaqTmxd5w9jU6qVmjIbXgHHFl4TuofkIYTf9OzPJ1CWFJHbCjnQqEG1GMKnMnvq3MEuQlTAB89/bRtNe7r1RWmbdd2j21BDZXZo3EKUkbWxhftoMgiotJtlNA3XV05Z3PBvyViJgbYOEp4dZ3NAh1Fu2my/x+FfbljEzNwwV8zLbMkLuMv8KaNPq7TdZptshpwKpNp0CwD4si5dx35q7Nd/o/9llTv2uRzBuZYjZKtAI/3UPy07kcS+tUToePBfitGl3e8aYzvNg5ugNlojsPA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64291 helo=[192.168.10.178])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hKlus-0002hL-Hq; Sun, 28 Apr 2019 17:40:34 +0200
Subject: Re: [drm/i915/fbdev] 09ded8af57:
 dmesg.RIP:drm_setup_crtcs[drm_kms_helper]
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20190428095139.GA15857@shao2-debian>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <cb4c5608-301b-5ac9-09d6-52a19909c8a9@tronnes.org>
Date:   Sun, 28 Apr 2019 17:40:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428095139.GA15857@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 28.04.2019 11.51, skrev kernel test robot:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 09ded8af57bcef7287b8242087d3e7556380de62 ("drm/i915/fbdev: Move intel_fb_initial_config() to fbdev helper")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: plzip
> with following parameters:
> 
> 	nr_threads: 100%
> 	cpufreq_governor: performance
> 	ucode: 0x12
> 
> 
> 
> on test machine: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | e33898a207 | 09ded8af57 |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 14         | 4          |
> | boot_failures                                   | 3          |            |
> | BUG:kernel_reboot-without-warning_in_test_stage | 3          |            |
> | dmesg.RIP:drm_setup_crtcs[drm_kms_helper]       | 0          | 4          |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   35.625371] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> [   35.634549] #PF error: [normal kernel read fault]
> [   35.639800] PGD 0 P4D 0 
> [   35.639805] Oops: 0000 [#1] SMP PTI
> [   35.646527] CPU: 53 PID: 1179 Comm: systemd-udevd Not tainted 5.1.0-rc2-01104-g09ded8a #1
> [   35.655659] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRHSXSD1.86B.0067.R02.1507221722 07/22/2015
> [   35.667239] RIP: 0010:drm_setup_crtcs+0x3eb/0x1020 [drm_kms_helper]
> [   35.674236] Code: 44 24 60 48 8b 04 24 4c 01 f0 80 38 00 0f 84 a3 07 00 00 41 8b 8d 1c 03 00 00 83 f9 01 0f 84 5f 09 00 00 49 8b 95 e0 03 00 00 <48> 83 7a 10 00 0f 84 e0 01 00 00 48 8b 52 08 48 85 d2 0f 84 d1 01
> [   35.695199] RSP: 0000:ffffc9000f9938c0 EFLAGS: 00010297
> [   35.701035] RAX: ffff88c083da2198 RBX: ffff88c083da2180 RCX: 0000000000000000
> [   35.709000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c083da21a1
> [   35.716966] RBP: 0000000000000000 R08: ffff88e083ab7d48 R09: 0000000000000000
> [   35.724934] R10: 0000000000000000 R11: ffff889fed53ec18 R12: 0000000000000001
> [   35.732894] R13: ffff888103a92800 R14: 0000000000000000 R15: 0000000000000001
> [   35.740863] FS:  00007fe6402648c0(0000) GS:ffff88dfff640000(0000) knlGS:0000000000000000
> [   35.749898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   35.756312] CR2: 0000000000000010 CR3: 000000807c142003 CR4: 00000000001606e0
> [   35.764278] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   35.772235] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   35.780201] Call Trace:
> [   35.782946]  __drm_fb_helper_initial_config_and_unlock+0x46/0x540 [drm_kms_helper]
> [   35.791404]  mgag200_fbdev_init+0xc6/0xe0 [mgag200]
> [   35.796855]  mgag200_modeset_init+0x150/0x1b0 [mgag200]
> [   35.802694]  mgag200_driver_load+0x359/0x4d0 [mgag200]
> [   35.808470]  drm_dev_register+0x11c/0x1b0 [drm]
> [   35.813547]  drm_get_pci_dev+0x9d/0x180 [drm]
> [   35.814299] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   35.818417]  local_pci_probe+0x42/0x90
> [   35.818427]  ? _cond_resched+0x19/0x30
> [   35.827168] ata5.00: ATAPI: TEAC    DV-W28S-W, 1.0A, max UDMA/100
> [   35.829511]  pci_device_probe+0x141/0x1b0
> [   35.829521]  really_probe+0xf8/0x3e0
> [   35.835771] ata5.00: configured for UDMA/100
> [   35.840505]  driver_probe_device+0x10f/0x120
> [   35.840511]  device_driver_attach+0x50/0x60
> [   35.847061] scsi 5:0:0:0: CD-ROM            TEAC     DV-W28S-W        1.0A PQ: 0 ANSI: 5
> [   35.848979]  __driver_attach+0x9a/0x140
> [   35.848983]  ? device_driver_attach+0x60/0x60
> [   35.848987]  bus_for_each_dev+0x76/0xc0
> [   35.848996]  ? klist_add_tail+0x3b/0x70
> [   35.889929]  bus_add_driver+0x141/0x210
> [   35.894214]  ? 0xffffffffc078d000
> [   35.897914]  driver_register+0x5b/0xe0
> [   35.902093]  ? 0xffffffffc078d000
> [   35.905805]  do_one_initcall+0x46/0x1e4
> [   35.910089]  ? _cond_resched+0x19/0x30
> [   35.914279]  ? kmem_cache_alloc_trace+0x3b/0x1d0
> [   35.919439]  do_init_module+0x5b/0x210
> [   35.923630]  load_module+0x1838/0x1f00
> [   35.927822]  ? ima_post_read_file+0xe2/0x120
> [   35.932592]  ? __do_sys_finit_module+0xe9/0x110
> [   35.937650]  __do_sys_finit_module+0xe9/0x110
> [   35.942508]  do_syscall_64+0x5b/0x1a0
> [   35.946595]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   35.952226] RIP: 0033:0x7fe63f0e1229
> [   35.956210] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89 01 48
> [   35.977171] RSP: 002b:00007fff141d8258 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   35.985624] RAX: ffffffffffffffda RBX: 000055dca71ebe70 RCX: 00007fe63f0e1229
> [   35.993580] RDX: 0000000000000000 RSI: 00007fe63f9fa265 RDI: 0000000000000015
> [   36.001545] RBP: 00007fe63f9fa265 R08: 0000000000000000 R09: 00007fff141d87d0
> [   36.009511] R10: 0000000000000015 R11: 0000000000000246 R12: 0000000000000000
> [   36.017477] R13: 000055dca71ff2f0 R14: 0000000000020000 R15: 000055dca5594cbc
> [   36.025436] Modules linked in: irqbypass mgag200(+) ttm snd_pcm crct10dif_pclmul crc32_pclmul crc32c_intel snd_timer ipmi_ssif ghash_clmulni_intel drm_kms_helper ahci snd syscopyarea aesni_intel sysfillrect sysimgblt crypto_simd fb_sys_fops libahci soundcore cryptd mpt3sas(+) glue_helper pcspkr drm joydev libata ipmi_si raid_class lpc_ich i2c_i801 scsi_transport_sas ipmi_devintf wmi ipmi_msghandler acpi_pad pcc_cpufreq ip_tables
> [   36.067874] CR2: 0000000000000010
> [   36.071721] ---[ end trace d29a594eb030ca5d ]---
> 

mgag200 is a non-atomic driver and thus most likely fixed by commit
1de7259275ca ("drm/fb-helper: Fix drm_fb_helper_firmware_config() NULL
pointer deref").

Noralf.

> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Rong Chen
> 
