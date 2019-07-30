Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C31C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF432087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfG3E3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:29:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:19912 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfG3E3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:29:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 21:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,325,1559545200"; 
   d="scan'208";a="183002215"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2019 21:29:15 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        Maor Gottlieb <maorg@mellanox.com>,
        Ran Rozenstein <ranro@mellanox.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Failure to recreate virtual functions
To:     Vlad Buslov <vladbu@mellanox.com>
References: <vbf8sskwyiv.fsf@mellanox.com>
 <d4166595-ec4a-fc4a-3b5f-463b79c42936@linux.intel.com>
 <vbfzhkx9n32.fsf@mellanox.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <838a00c4-d5bd-08db-e39c-5f00686858b5@linux.intel.com>
Date:   Tue, 30 Jul 2019 12:28:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <vbfzhkx9n32.fsf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/29/19 6:05 PM, Vlad Buslov wrote:
> On Sat 27 Jul 2019 at 05:15, Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>> Hi Vilad,
>>
>> On 7/27/19 12:30 AM, Vlad Buslov wrote:
>>> Hi Lu Baolu,
>>>
>>> Our mlx5 driver fails to recreate VFs when cmdline includes
>>> "intel_iommu=on iommu=pt" after recent merge of patch set "iommu/vt-d:
>>> Delegate DMA domain to generic iommu". I've bisected the failure to
>>> patch b7297783c2bb ("iommu/vt-d: Remove duplicated code for device
>>> hotplug"). Here is the dmesg log for following case: enable switchdev
>>> mode, set number of VFs to 0, then set it back to any value
>>>> 0.
>>> [  223.525282] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (1)
>>> [  223.562027] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
>>> [  223.663766] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>>> [  223.663864] pci 0000:81:00.2: enabling Extended Tags
>>> [  223.665143] pci 0000:81:00.2: Adding to iommu group 52
>>> [  223.665215] pci 0000:81:00.2: Using iommu direct mapping
>>> [  223.665771] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
>>> [  223.665890] mlx5_core 0000:81:00.2: firmware version: 16.26.148
>>> [  223.889908] mlx5_core 0000:81:00.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
>>> [  223.896438] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>>> [  223.896636] mlx5_core 0000:81:00.2: Assigned random MAC address 56:1f:95:e0:51:d6
>>> [  224.012905] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
>>> [  224.041651] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
>>> [  224.041711] pci 0000:81:00.3: enabling Extended Tags
>>> [  224.043660] pci 0000:81:00.3: Adding to iommu group 53
>>> [  224.043738] pci 0000:81:00.3: Using iommu direct mapping
>>> [  224.044196] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
>>> [  224.044298] mlx5_core 0000:81:00.3: firmware version: 16.26.148
>>> [  224.268099] mlx5_core 0000:81:00.3: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
>>> [  224.274983] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>>> [  224.275195] mlx5_core 0000:81:00.3: Assigned random MAC address a6:1e:56:0a:d9:f2
>>> [  224.388359] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
>>> [  236.325027] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active vports(3) mode(1)
>>> [  236.362766] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (2)
>>> [  237.290066] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>>> [  237.350215] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>>> [  237.373052] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>>> [  237.390768] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>>> [  237.447846] ens1f0_0: renamed from eth0
>>> [  237.460399] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
>>> [  237.526880] ens1f0_1: renamed from eth1
>>> [  248.953873] pci 0000:81:00.2: Removing from iommu group 52
>>> [  248.954114] pci 0000:81:00.3: Removing from iommu group 53
>>> [  249.960570] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active vports(3) mode(2)
>>> [  250.319135] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>>> [  250.559431] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>>> [  258.819162] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: nvfs(2) mode (1)
>>> [  258.831625] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active vports(3)
>>> [  258.936160] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>>> [  258.936258] pci 0000:81:00.2: enabling Extended Tags
>>> [  258.937438] pci 0000:81:00.2: Failed to add to iommu group 52: -16
>> It seems that an EBUSY error returned from iommu_group_add_device(). Can
>> you please hack some debug messages in iommu_group_add_device() so that
>> we can know where the EBUSY returns?
>>
>> Best regards,
>> Baolu
> The error code is returned by __iommu_attach_device().
> 

Thanks!

It looks like the system has already a domain for specific pci bdf
device. Does this VF share the bdf with other devices? Or has been
previously created, and system failed to get chance to remove it?

Best regards,
Baolu
