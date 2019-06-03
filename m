Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15858C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18E72662E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFCWQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:16:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:19879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfFCWQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:16:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 14:56:47 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2019 14:56:47 -0700
Date:   Mon, 3 Jun 2019 14:59:51 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, eric.auger@redhat.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
Message-ID: <20190603145951.729600e6@jacob-builder>
In-Reply-To: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 15:57:45 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Allow device drivers and VFIO to get notified on IOMMU translation
> fault, and handle recoverable faults (PCI PRI). Several series require
> this API (Intel VT-d and Arm SMMUv3 nested support, as well as the
> generic host SVA implementation).
> 
> Changes since v1 [1]:
> * Allocate iommu_param earlier, in iommu_probe_device().
> * Pass struct iommu_fault to fault handlers, instead of the
>   iommu_fault_event wrapper.
> * Removed unused iommu_fault_event::iommu_private.
> * Removed unnecessary iommu_page_response::addr.
> * Added iommu_page_response::version, which would allow to introduce a
>   new incompatible iommu_page_response structure (as opposed to just
>   adding a flag + field).
> 
> [1] [PATCH 0/4] iommu: Add device fault reporting API
>     https://lore.kernel.org/lkml/20190523180613.55049-1-jean-philippe.brucker@arm.com/
> 
> Jacob Pan (3):
>   driver core: Add per device iommu param
>   iommu: Introduce device fault data
>   iommu: Introduce device fault report API
> 
> Jean-Philippe Brucker (1):
>   iommu: Add recoverable fault reporting
> 
This interface meet the need for vt-d, just one more comment on 2/4. Do
you want to add Co-developed-by you for the three patches from me?

Thanks,

Jacob

>  drivers/iommu/iommu.c      | 236
> ++++++++++++++++++++++++++++++++++++- include/linux/device.h     |
> 3 + include/linux/iommu.h      |  87 ++++++++++++++
>  include/uapi/linux/iommu.h | 153 ++++++++++++++++++++++++
>  4 files changed, 476 insertions(+), 3 deletions(-)
>  create mode 100644 include/uapi/linux/iommu.h
> 

