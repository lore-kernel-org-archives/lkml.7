Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5ADC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEF120896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391892AbfFLLzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:55:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387878AbfFLLzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:55:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E6C128;
        Wed, 12 Jun 2019 04:55:19 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E30603F246;
        Wed, 12 Jun 2019 04:57:00 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
 <20190612081944.GB17505@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <0f21e1b2-837f-87ba-6cf3-f6490d9e2a57@arm.com>
Date:   Wed, 12 Jun 2019 12:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612081944.GB17505@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2019 09:19, Joerg Roedel wrote:
> On Mon, Jun 03, 2019 at 03:57:45PM +0100, Jean-Philippe Brucker wrote:
>> Jacob Pan (3):
>>   driver core: Add per device iommu param
>>   iommu: Introduce device fault data
>>   iommu: Introduce device fault report API
>>
>> Jean-Philippe Brucker (1):
>>   iommu: Add recoverable fault reporting
>>
>>  drivers/iommu/iommu.c      | 236 ++++++++++++++++++++++++++++++++++++-
>>  include/linux/device.h     |   3 +
>>  include/linux/iommu.h      |  87 ++++++++++++++
>>  include/uapi/linux/iommu.h | 153 ++++++++++++++++++++++++
>>  4 files changed, 476 insertions(+), 3 deletions(-)
>>  create mode 100644 include/uapi/linux/iommu.h
> 
> Applied, thanks.

Thanks! As discussed I think we need to add padding into the iommu_fault
structure before this reaches mainline, to make the UAPI easier to
extend in the future. It's already possible to extend but requires
introducing a new ABI version number and support two structures. Adding
some padding would only require introducing new flags. If there is no
objection I'll send a one-line patch bumping the structure size to 64
bytes (currently 48)

Thanks,
Jean
