Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470E8C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022BB20828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfG0CPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:15:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:17777 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfG0CPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:15:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 19:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,313,1559545200"; 
   d="scan'208";a="182067575"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2019 19:15:44 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        Maor Gottlieb <maorg@mellanox.com>,
        Ran Rozenstein <ranro@mellanox.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Failure to recreate virtual functions
To:     Vlad Buslov <vladbu@mellanox.com>
References: <vbf8sskwyiv.fsf@mellanox.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d4166595-ec4a-fc4a-3b5f-463b79c42936@linux.intel.com>
Date:   Sat, 27 Jul 2019 10:15:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <vbf8sskwyiv.fsf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vilad,

On 7/27/19 12:30 AM, Vlad Buslov wrote:
> Hi Lu Baolu,
> 
> Our mlx5 driver fails to recreate VFs when cmdline includes
> "intel_iommu=on iommu=pt" after recent merge of patch set "iommu/vt-d:
> Delegate DMA domain to generic iommu". I've bisected the failure to
> patch b7297783c2bb ("iommu/vt-d: Remove duplicated code for device
> hotplug"). Here is the dmesg log for following case: enable switchdev
> mode, set number of VFs to 0, then set it back to any value
>> 0.
> 
> [  223.525282] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (1)
> [  223.562027] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
> [  223.663766] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
> [  223.663864] pci 0000:81:00.2: enabling Extended Tags
> [  223.665143] pci 0000:81:00.2: Adding to iommu group 52
> [  223.665215] pci 0000:81:00.2: Using iommu direct mapping
> [  223.665771] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
> [  223.665890] mlx5_core 0000:81:00.2: firmware version: 16.26.148
> [  223.889908] mlx5_core 0000:81:00.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
> [  223.896438] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  223.896636] mlx5_core 0000:81:00.2: Assigned random MAC address 56:1f:95:e0:51:d6
> [  224.012905] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
> [  224.041651] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
> [  224.041711] pci 0000:81:00.3: enabling Extended Tags
> [  224.043660] pci 0000:81:00.3: Adding to iommu group 53
> [  224.043738] pci 0000:81:00.3: Using iommu direct mapping
> [  224.044196] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
> [  224.044298] mlx5_core 0000:81:00.3: firmware version: 16.26.148
> [  224.268099] mlx5_core 0000:81:00.3: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
> [  224.274983] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  224.275195] mlx5_core 0000:81:00.3: Assigned random MAC address a6:1e:56:0a:d9:f2
> [  224.388359] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
> [  236.325027] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active vports(3) mode(1)
> [  236.362766] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (2)
> [  237.290066] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  237.350215] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  237.373052] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
> [  237.390768] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  237.447846] ens1f0_0: renamed from eth0
> [  237.460399] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
> [  237.526880] ens1f0_1: renamed from eth1
> [  248.953873] pci 0000:81:00.2: Removing from iommu group 52
> [  248.954114] pci 0000:81:00.3: Removing from iommu group 53
> [  249.960570] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active vports(3) mode(2)
> [  250.319135] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  250.559431] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
> [  258.819162] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (1)
> [  258.831625] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
> [  258.936160] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
> [  258.936258] pci 0000:81:00.2: enabling Extended Tags
> [  258.937438] pci 0000:81:00.2: Failed to add to iommu group 52: -16

It seems that an EBUSY error returned from iommu_group_add_device(). Can
you please hack some debug messages in iommu_group_add_device() so that
we can know where the EBUSY returns?

Best regards,
Baolu


> [  258.938053] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
> [  258.938196] mlx5_core 0000:81:00.2: firmware version: 16.26.148
> [  258.938229] mlx5_core 0000:81:00.2: mlx5_function_setup:923:(pid 265): Failed initializing command interface, aborting
> [  258.938315] mlx5_core 0000:81:00.2: init_one:1308:(pid 265): mlx5_load_one failed with error code -12
> [  258.938540] mlx5_core: probe of 0000:81:00.2 failed with error -12
> [  258.938597] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
> [  258.938657] pci 0000:81:00.3: enabling Extended Tags
> [  258.939431] pci 0000:81:00.3: Failed to add to iommu group 52: -16
> [  258.939928] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
> [  258.940039] mlx5_core 0000:81:00.3: firmware version: 16.26.148
> [  258.940071] mlx5_core 0000:81:00.3: mlx5_function_setup:923:(pid 265): Failed initializing command interface, aborting
> [  258.940158] mlx5_core 0000:81:00.3: init_one:1308:(pid 265): mlx5_load_one failed with error code -12
> [  258.940400] mlx5_core: probe of 0000:81:00.3 failed with error -12
> 
> 
> On previous patch 0e31a7266508 ("iommu/vt-d: Remove startup parameter
> from device_def_domain_type()") in the series same sequence of actions
> doesn't trigger any iommu errors:
> 
> [  164.252254] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (1)
> [  164.288724] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
> [  164.394839] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
> [  164.394938] pci 0000:81:00.2: enabling Extended Tags
> [  164.396087] pci 0000:81:00.2: Adding to iommu group 52
> [  164.396154] pci 0000:81:00.2: Using iommu direct mapping
> [  164.396679] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
> [  164.396803] mlx5_core 0000:81:00.2: firmware version: 16.26.148
> [  164.619320] mlx5_core 0000:81:00.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
> [  164.625754] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  164.625922] mlx5_core 0000:81:00.2: Assigned random MAC address 5e:1e:9b:ca:c8:e5
> [  164.739694] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
> [  164.774637] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
> [  164.774709] pci 0000:81:00.3: enabling Extended Tags
> [  164.775816] pci 0000:81:00.3: Adding to iommu group 53
> [  164.775886] pci 0000:81:00.3: Using iommu direct mapping
> [  164.776610] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
> [  164.776734] mlx5_core 0000:81:00.3: firmware version: 16.26.148
> [  164.999360] mlx5_core 0000:81:00.3: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
> [  165.007118] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  165.007327] mlx5_core 0000:81:00.3: Assigned random MAC address 82:4a:7a:5f:81:55
> [  165.123927] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
> [  172.063665] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active vports(3) mode(1)
> [  172.103306] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (2)
> [  173.033033] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  173.091605] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  173.129258] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
> [  173.129863] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  173.203879] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
> [  173.204002] ens1f0_0: renamed from eth1
> [  173.289454] ens1f0_1: renamed from eth0
> [  186.720692] pci 0000:81:00.2: Removing from iommu group 52
> [  186.720994] pci 0000:81:00.3: Removing from iommu group 53
> [  187.771549] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active vports(3) mode(2)
> [  188.141758] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  188.394072] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
> [  191.116400] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (1)
> [  191.128965] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
> [  191.235151] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
> [  191.235250] pci 0000:81:00.2: enabling Extended Tags
> [  191.236463] pci 0000:81:00.2: Adding to iommu group 52
> [  191.236531] pci 0000:81:00.2: Using iommu direct mapping
> [  191.237037] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
> [  191.237161] mlx5_core 0000:81:00.2: firmware version: 16.26.148
> [  191.457369] mlx5_core 0000:81:00.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
> [  191.463355] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  191.463509] mlx5_core 0000:81:00.2: Assigned random MAC address e6:f2:0c:b4:e3:2e
> [  191.572884] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
> [  191.608592] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
> [  191.608664] pci 0000:81:00.3: enabling Extended Tags
> [  191.609434] pci 0000:81:00.3: Adding to iommu group 53
> [  191.609466] pci 0000:81:00.3: Using iommu direct mapping
> [  191.609760] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
> [  191.609862] mlx5_core 0000:81:00.3: firmware version: 16.26.148
> [  191.826324] mlx5_core 0000:81:00.3: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
> [  191.832558] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
> [  191.832730] mlx5_core 0000:81:00.3: Assigned random MAC address a2:dc:76:30:18:6c
> [  191.949625] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
> 
> Thanks,
> Vlad
> 
