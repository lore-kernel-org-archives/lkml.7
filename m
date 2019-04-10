Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D87C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA35D2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfDJNCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbfDJNCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AF973D3A;
        Wed, 10 Apr 2019 13:02:38 +0000 (UTC)
Received: from [10.36.117.161] (ovpn-117-161.ams2.redhat.com [10.36.117.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D05FF619A2;
        Wed, 10 Apr 2019 13:02:26 +0000 (UTC)
Subject: Re: [PATCH v6 09/22] vfio: VFIO_IOMMU_BIND/UNBIND_MSI
To:     =?UTF-8?Q?Vincent_Stehl=c3=a9?= <vincent.stehle@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org
References: <20190317172232.1068-1-eric.auger@redhat.com>
 <20190317172232.1068-10-eric.auger@redhat.com>
 <20190321170159.38358f38@x1.home>
 <16931d58-9c88-8cfb-a392-408ea7afdf16@redhat.com>
 <20190322160947.3f8dacdb@x1.home>
 <b47128de-88d0-1971-1fbc-86e43439c7ee@redhat.com>
 <20190403113800.51503693@x1.home>
 <4b27b707-4917-2c3e-a13c-3b978e850d09@redhat.com>
 <20190410123531.GA19023@debian>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2cdd4142-98e5-14de-2f34-264244f24d01@redhat.com>
Date:   Wed, 10 Apr 2019 15:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190410123531.GA19023@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 10 Apr 2019 13:02:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 4/10/19 2:35 PM, Vincent Stehlé wrote:
> On Thu, Apr 04, 2019 at 08:55:25AM +0200, Auger Eric wrote:
>> Hi Marc, Robin, Alex,
> (..)
>> Do you think this is a reasonable assumption to consider devices within
>> the same host iommu group share the same MSI doorbell?
> 
> Hi Eric,
> 
> I am not sure this assumption always hold.
> 
> Marc, Robin and Alex can correct me, but for example I think the following
> topology is valid for Arm systems:
> 
>  +------------+  +------------+
>  | Endpoint A |  | Endpoint B |
>  +------------+  +------------+
>             v     v
>           /---------\
>          |  Non-ACS  |
>          |  Switch   |
>           \---------/
>                v
>        +---------------+
>        |     PCIe      |
>        | Root Complex  |
>        +---------------+
>                v
>          +-----------+
>          |   SMMU    |
>          +-----------+
>                v
>   +--------------------------+
>   |   System interconnect    |
>   +--------------------------+
>         v              v
>   +-----------+  +-----------+
>   |   ITS A   |  |   ITS B   |
>   +-----------+  +-----------+
> 
> All PCIe Endpoints and ITS could be in the same ITS Group 0, meaning
> devices could send their MSI at any ITS in hardware.
> 
> For Linux the two PCIe Endpoints would be in the same iommu group, because
> the switch in this example does not support ACS.
> 
> I think the devicetree msi-map property could be used to "map" the RID of
> Endpoint A to ITS A and the RID of Endpoint B to ITS B, which would violate
> the assumption.
> 
> See the monolithic example in [1], the example system in [2], appendices
> D, E and F in [3] and the msi-map property in [4].

Thank you for the review & links.

I understand the above topology is perfectly valid. Now the question is:
is it sufficiently common to care about it?

At the moment VFIO/vIOMMU assignment of devices belonging to the same
group isn't upstream yet. Work is ongoing by Alex to support it. It uses
a PCIe-to-PCI bridge on guest side and it looks this topology is not
supported by the SMMUv3 driver. Then comes the trouble of using several
ITS in nested mode.

If this topology is sufficiently rare I propose we to do not support it
in this VFIO/vIOMMU use case. in v7 I introduced a check that aims to
verify devices attached to the same nested iommu_domain share the same
msi_domain.

Thanks

Eric
> 
> Best regards,
> Vincent.
> 
> [1] https://static.docs.arm.com/100336/0102/corelink_gic600_generic_interrupt_controller_technical_reference_manual_100336_0102_00_en.pdf
> [2] http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> [3] https://static.docs.arm.com/den0029/50/Q1-DEN0029B_SBSA_5.0.pdf
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci-msi.txt
> 
