Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9109EC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7000C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfFXPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:23:44 -0400
Received: from foss.arm.com ([217.140.110.172]:53322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfFXPXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:23:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C424A2B;
        Mon, 24 Jun 2019 08:23:42 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5250A3F71E;
        Mon, 24 Jun 2019 08:23:41 -0700 (PDT)
Subject: Re: [PATCH v4 08/22] iommu: Introduce attach/detach_pasid_table API
To:     Auger Eric <eric.auger@redhat.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Yi L <yi.l.liu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Liu@mail.linuxfoundation.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190618164128.0000204f@huawei.com>
 <c6e2d65b-8181-3627-f454-d491a738b6ee@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e23414a4-698d-e7ed-d1eb-f680992e7deb@arm.com>
Date:   Mon, 24 Jun 2019 16:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c6e2d65b-8181-3627-f454-d491a738b6ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2019 16:06, Auger Eric wrote:
> Hi,
> 
> On 6/18/19 5:41 PM, Jonathan Cameron wrote:
>> On Sun, 9 Jun 2019 06:44:08 -0700
>> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>>
>>> In virtualization use case, when a guest is assigned
>>> a PCI host device, protected by a virtual IOMMU on the guest,
>>> the physical IOMMU must be programmed to be consistent with
>>> the guest mappings. If the physical IOMMU supports two
>>> translation stages it makes sense to program guest mappings
>>> onto the first stage/level (ARM/Intel terminology) while the host
>>> owns the stage/level 2.
>>>
>>> In that case, it is mandated to trap on guest configuration
>>> settings and pass those to the physical iommu driver.
>>>
>>> This patch adds a new API to the iommu subsystem that allows
>>> to set/unset the pasid table information.
>>>
>>> A generic iommu_pasid_table_config struct is introduced in
>>> a new iommu.h uapi header. This is going to be used by the VFIO
>>> user API.
>>
>> Another case where strictly speaking stuff is introduced that this series
>> doesn't use.  I don't know what the plans are to merge the various
>> related series though so this might make sense in general. Right now
>> it just bloats this series a bit..
> 
> I am now the only user of this API in
> [PATCH v8 00/29] SMMUv3 Nested Stage Setup
> (https://patchwork.kernel.org/cover/10961733/).
> 
> This can live in this series or Jean-Philippe do you intend to keep on
> maintaining it in your api branch?

No, I think it makes sense to keep it within your series

Thanks,
Jean
