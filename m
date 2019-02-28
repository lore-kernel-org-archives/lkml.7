Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1974E20842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfB1BK7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:10:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:59930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfB1BK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:10:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 17:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,421,1544515200"; 
   d="scan'208";a="129933788"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 17:10:58 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 27 Feb 2019 17:10:57 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.57]) with mapi id 14.03.0415.000;
 Thu, 28 Feb 2019 09:10:56 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 1/1] iommu: Bind process address spaces to devices
Thread-Topic: [PATCH 1/1] iommu: Bind process address spaces to devices
Thread-Index: AQHUySjix3qJPDMggEGYL4Jk5mdK/aXxcVqAgAJAnICAAL9y4A==
Date:   Thu, 28 Feb 2019 01:10:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C9687D8@SHSMSX104.ccr.corp.intel.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org> <20190227134129.51ad42ac@jacob-builder>
In-Reply-To: <20190227134129.51ad42ac@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzMwNzQ3ZGEtYTA1Mi00ODkzLThkMDUtNWM2ZGQ1OGFiNzM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRUZHa1drNGZKQXVBWkJDTDZyKzVPRHNWemNTc2x0dko4M0xMNU1aQ1lqOTNjS283WkZiSUNcL1wvY2JDM2FkU2doIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Thursday, February 28, 2019 5:41 AM
> 
> On Tue, 26 Feb 2019 12:17:43 +0100
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> >
> > How about a 'struct iommu_sva' with an iommu-private definition that
> > is returned by this function:
> >
> > 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> > 						struct mm_struct *mm);
> >
> Just trying to understand how to use this API.
> So if we bind the same mm to two different devices, we should get two
> different iommu_sva handle, right?
> I think intel-svm still needs a flag argument for supervisor pasid etc.
> Other than that, I think both interface should work for vt-d.
> 
> Another question is that for nested SVA, we will need to bind guest mm.
> Do you think we should try to reuse this or have it separate? I am
> working on a separate API for now.
> 

It has to be different. Host doesn't know guest mm.

Also note that from virtualization p.o.v we just focus on 'nested
translation' in host side. The 1st level may point to guest CPU
page table (SVA), or IOVA page table. In that manner, the API
(as currently defined in your series) is purely about setting up
nested translation on VFIO assigned device. 

Thanks
Kevin
