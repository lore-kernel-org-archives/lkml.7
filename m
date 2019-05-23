Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B9C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfEWNh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:37:59 -0400
Received: from foss.arm.com ([217.140.101.70]:46550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfEWNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:37:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1649D80D;
        Thu, 23 May 2019 06:37:58 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C54A3F575;
        Thu, 23 May 2019 06:37:57 -0700 (PDT)
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b45be0f7-5573-23fb-90c1-9a8e4fc6a5e1@arm.com>
Date:   Thu, 23 May 2019 14:37:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2019 11:34, Suzuki K Poulose wrote:
> This series adds the support for CoreSight devices on ACPI based
> platforms. The device connections are encoded as _DSD graph property[0],
> with CoreSight specific extensions to indicate the direction of data
> flow as described in [1]. Components attached to CPUs are listed
> as child devices of the corresponding CPU, removing explicit links
> to the CPU like we do in the DT.
> 
> The majority of the series cleans up the driver and prepares the subsystem
> for platform agnostic firwmare probing, naming scheme, searching etc.
> 
> We introduce platform independent helpers to parse the platform supplied
> information. Thus we rename the platform handling code from:
> 	of_coresight.c  => coresight-platform.c
> 
> The CoreSight driver creates shadow devices that appear on the Coresight
> bus, in addition to the real devices (e.g, AMBA bus devices). The name
> of these devices match the real device. This makes the device name
> a bit cryptic for ACPI platform. So this series also introduces a generic
> platform agnostic device naming scheme for the shadow Coresight devices.
> Towards this we also make changes to the way we lookup devices to resolve
> the connections, as we can't use the names to identify the devices. So,
> we use the "fwnode_handle" of the real device for the device lookups.
> Towards that we clean up the drivers to keep track of the "CoreSight"
> device rather than the "real" device. However, all real operations,
> like DMA allocation, Power management etc. must be performed on
> the real device which is the parent of the shadow device.
> 
> Finally we add the support for parsing the ACPI platform data. The power
> management support is missing in the ACPI (and this is not specific to
> CoreSight). The firmware must ensure that the respective power domains
> are turned on.
> 
> Applies on v5.2-rc1
> 
> Tested on a Juno-r0 board with ACPI bindings patch (Patch 31/30) added on
> top of [2]. You would need to make sure that the debug power domain is
> turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
> Juno board while at UEFI). arm32 code is only compile tested.
> 
> [0] ACPI Device Graphs using _DSD (Not available online yet, approved but
>      awaiting publish and eventually should be linked at).
>      https://uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
> [1] https://developer.arm.com/docs/den0067/latest/acpi-for-coresighttm-10-platform-design-document
> [2] https://github.com/tianocore/edk2-platforms.git

The kernel patches are also available at :

git://linux-arm.org/linux-skp.git coresight-acpi/v4

Suzuki
