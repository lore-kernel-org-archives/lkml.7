Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859DAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DEB206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVBkI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:40:08 -0500
Received: from mail.windriver.com ([147.11.1.11]:64416 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:40:08 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id xAM1dqh2013247
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 21 Nov 2019 17:39:53 -0800 (PST)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.75]) by
 ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0468.000; Thu,
 21 Nov 2019 17:39:52 -0800
From:   "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To:     "Liu, Yongxin" <Yongxin.Liu@windriver.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "mario.limonciello@dell.com" <mario.limonciello@dell.com>
Subject: RE: [PATCH] Revert "platform/x86: wmi: Destroy on cleanup rather
 than unregister"
Thread-Topic: [PATCH] Revert "platform/x86: wmi: Destroy on cleanup rather
 than unregister"
Thread-Index: AQHVm3ZtvRF1oVEA1UCC8bXYi76Qu6eWcVmg
Date:   Fri, 22 Nov 2019 01:39:50 +0000
Message-ID: <597B109EC20B76429F71A8A97770610D19F0D0B8@ALA-MBD.corp.ad.wrs.com>
References: <20191115052710.46880-1-yongxin.liu@windriver.com>
In-Reply-To: <20191115052710.46880-1-yongxin.liu@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.158.159]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more logs for this issue.

When loading wmi driver module,

    device class 'wmi_bus': registering
    bus: 'wmi': registered
    bus: 'platform': add driver acpi-wmi
    bus: 'platform': driver_probe_device: matched device PNP0C14:00 with driver acpi-wmi
    bus: 'platform': really_probe: probing driver acpi-wmi with device PNP0C14:00
    acpi-wmi PNP0C14:00: no default pinctrl state
    device: 'wakeup28': device_add
    device: 'wmi_bus-PNP0C14:00': device_add
    PM: Adding info for No Bus:wmi_bus-PNP0C14:00
    device: '86CCFD48-205E-4A77-9C48-2021CBEDE341': device_add
    bus: 'wmi': add device 86CCFD48-205E-4A77-9C48-2021CBEDE341
    PM: Adding info for wmi:86CCFD48-205E-4A77-9C48-2021CBEDE341
    driver: 'acpi-wmi': driver_bound: bound to device 'PNP0C14:00'
    bus: 'platform': really_probe: bound device PNP0C14:00 to driver acpi-wmi
    bus: 'platform': driver_probe_device: matched device PNP0C14:01 with driver acpi-wmi
    bus: 'platform': really_probe: probing driver acpi-wmi with device PNP0C14:01
    acpi-wmi PNP0C14:01: no default pinctrl state
    device: 'wakeup29': device_add
    device: 'wmi_bus-PNP0C14:01': device_add
    PM: Adding info for No Bus:wmi_bus-PNP0C14:01
    device: '2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B': device_add
    bus: 'wmi': add device 2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B
    PM: Adding info for wmi:2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B
    device: 'A6FEA33E-DABF-46F5-BFC8-460D961BEC9F': device_add
    bus: 'wmi': add device A6FEA33E-DABF-46F5-BFC8-460D961BEC9F
    PM: Adding info for wmi:A6FEA33E-DABF-46F5-BFC8-460D961BEC9F
    device: '05901221-D566-11D1-B2F0-00A0C9062910': device_add
    bus: 'wmi': add device 05901221-D566-11D1-B2F0-00A0C9062910
    PM: Adding info for wmi:05901221-D566-11D1-B2F0-00A0C9062910
    driver: 'acpi-wmi': driver_bound: bound to device 'PNP0C14:01'
    bus: 'platform': really_probe: bound device PNP0C14:01 to driver acpi-wmi
    bus: 'platform': driver_probe_device: matched device PNP0C14:02 with driver acpi-wmi
    bus: 'platform': really_probe: probing driver acpi-wmi with device PNP0C14:02
    acpi-wmi PNP0C14:02: no default pinctrl state
    device: 'wakeup30': device_add
    device: 'wmi_bus-PNP0C14:02': device_add
    PM: Adding info for No Bus:wmi_bus-PNP0C14:02
    acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
    device: '1F13AB7F-6220-4210-8F8E-8BB5E71EE969': device_add
    bus: 'wmi': add device 1F13AB7F-6220-4210-8F8E-8BB5E71EE969
    PM: Adding info for wmi:1F13AB7F-6220-4210-8F8E-8BB5E71EE969
    driver: 'acpi-wmi': driver_bound: bound to device 'PNP0C14:02'
    bus: 'platform': really_probe: bound device PNP0C14:02 to driver acpi-wmi


When unloading wmi driver module, without this patch, there is calltrace.

    bus: 'platform': remove driver acpi-wmi
    device: '1F13AB7F-6220-4210-8F8E-8BB5E71EE969': device_unregister
    bus: 'wmi': remove device 1F13AB7F-6220-4210-8F8E-8BB5E71EE969
    PM: Removing info for wmi:1F13AB7F-6220-4210-8F8E-8BB5E71EE969
    device: 'wmi_bus-PNP0C14:00': device_unregister
    PM: Removing info for No Bus:wmi_bus-PNP0C14:00
    device: 'wakeup29': device_unregister
    device: '2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B': device_unregister
    bus: 'wmi': remove device 2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B
    PM: Removing info for wmi:2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B
    device: 'A6FEA33E-DABF-46F5-BFC8-460D961BEC9F': device_unregister
    bus: 'wmi': remove device A6FEA33E-DABF-46F5-BFC8-460D961BEC9F
    PM: Removing info for wmi:A6FEA33E-DABF-46F5-BFC8-460D961BEC9F
    device: '05901221-D566-11D1-B2F0-00A0C9062910': device_unregister
    bus: 'wmi': remove device 05901221-D566-11D1-B2F0-00A0C9062910
    PM: Removing info for wmi:05901221-D566-11D1-B2F0-00A0C9062910
    device: 'wmi_bus-PNP0C14:01': device_unregister
    PM: Removing info for No Bus:wmi_bus-PNP0C14:01
    device: 'wmi_bus-PNP0C14:01': device_create_release
    device: 'wakeup28': device_unregister
    device: '86CCFD48-205E-4A77-9C48-2021CBEDE341': device_unregister
    ------------[ cut here ]------------
    sysfs group 'power' not found for kobject '86CCFD48-205E-4A77-9C48-2021CBEDE341'
    WARNING: CPU: 8 PID: 636 at fs/sysfs/group.c:280 sysfs_remove_group+0x80/0x90
    Modules linked in: wmi(-) snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic i915 snd_hda_intel snd_intel_nhlt intel_rapl_msr snd_hda_codec intel_rapl_common   x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crct10dif_common snd_hda_core snd_pcm iTCO_wdt iTCO_vendor_support sch_fq_codel watchdog aesni_intel video thermal idma64 glue_helper efi_pstore snd_timer i2c_i801 crypto_simd backlight acpi_pad efivars openvswitch cryptd fan nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4     [last unloaded: wmi_bmof]
    CPU: 8 PID: 636 Comm: rmmod Tainted: G        W         5.4.0-rc7 #1
    Hardware name: Intel Corporation CoffeeLake Client Platform/CoffeeLake S 82 UDIMM RVP, BIOS CNLSFWX1.R00.X151.B01.1807201217 07/20/2018
    RIP: 0010:sysfs_remove_group+0x80/0x90
    Code: e8 a5 b3 ff ff 5b 41 5c 41 5d 5d c3 48 89 df e8 46 ae ff ff eb c6 49 8b 55 00 48 c7 c7 c8 9b bc 9b 49 8b 34 24 e8 30 7b cd ff <0f> 0b 5b 41 5c 41 5d 5d c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48
    RSP: 0018:ffffbaacc063bd38 EFLAGS: 00010282
    RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
    RDX: 0000000000000001 RSI: ffffffff9a586023 RDI: ffffffff9a586023
    RBP: ffffbaacc063bd50 R08: 0000000000000001 R09: 0000000000000000
    R10: 00000000ffba64cc R11: 0000000000000000 R12: ffffffff9b8d9d20
    R13: ffff9c3843c85000 R14: dead000000000100 R15: ffff9c384facc000
    FS:  00007f5a591fa740(0000) GS:ffff9c385ac00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000055b3f2513d28 CR3: 0000000441ed6005 CR4: 00000000003606e0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     dpm_sysfs_remove+0x58/0x60
     device_del+0x77/0x380
     ? acpi_ut_release_mutex+0x71/0x76
     device_unregister+0x41/0x60
     acpi_wmi_remove+0xdd/0x120 [wmi]
     platform_drv_remove+0x25/0x50
     device_release_driver_internal+0xec/0x1b0
     driver_detach+0x4d/0xa0
     bus_remove_driver+0x80/0xe0
     driver_unregister+0x2f/0x50
     platform_driver_unregister+0x12/0x20
     acpi_wmi_exit+0x10/0x169 [wmi]
     __x64_sys_delete_module+0x15b/0x240
     ? lockdep_hardirqs_on+0xe8/0x1c0
     ? do_syscall_64+0x17/0x1c0
     ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
    do_syscall_64+0x55/0x1c0
    entry_SYSCALL_64_after_hwframe+0x49/0xbe
    RIP: 0033:0x7f5a592f6767
    Code: 73 01 c3 48 8b 0d 19 c7 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 c6 0b 00 f7 d8 64 89 01 48
    RSP: 002b:00007ffd85909808 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
    RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5a592f6767
    RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b3f25097c8
    RBP: 00007ffd85909858 R08: 0000000000000000 R09: 0000000000000000
    R10: 00007f5a59366ac0 R11: 0000000000000206 R12: 00007ffd85909a20
    R13: 00007ffd85909e36 R14: 000055b3f25092a0 R15: 000055b3f2509760
    irq event stamp: 7152
    hardirqs last  enabled at (7151): [<ffffffff9b2b26ec>] _raw_spin_unlock_irq+0x2c/0x50
    hardirqs last disabled at (7152): [<ffffffff9a401eba>] trace_hardirqs_off_thunk+0x1a/0x20
    softirqs last  enabled at (7146): [<ffffffff9b6002d9>] __do_softirq+0x2d9/0x4ef
    softirqs last disabled at (7133): [<ffffffff9a504ba4>] irq_exit+0xc4/0xd0
    ---[ end trace 61882efbb33d050e ]---
    bus: 'wmi': remove device 86CCFD48-205E-4A77-9C48-2021CBEDE341
    PM: Removing info for wmi:86CCFD48-205E-4A77-9C48-2021CBEDE341
    device: 'wmi_bus-PNP0C14:00': device_create_release
    device: 'wmi_bus-PNP0C14:02': device_unregister
    PM: Removing info for No Bus:wmi_bus-PNP0C14:02
    device: 'wmi_bus-PNP0C14:02': device_create_release
    device: 'wakeup27': device_unregister
    driver: 'acpi-wmi': driver_release
    bus: 'wmi': unregistering
    device class 'wmi_bus': unregistering
    class 'wmi_bus': release.
    class 'wmi_bus' does not have a release() function, be careful


Thanks,
Yongxin


