Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF46BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B388420851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCHLhp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:37:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:60869 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfCHLhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:37:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 03:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="149799698"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2019 03:33:48 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 8 Mar 2019 03:33:48 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 8 Mar 2019 03:33:47 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.134]) with mapi id 14.03.0415.000;
 Fri, 8 Mar 2019 19:33:46 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>
Subject: RE: [RFC v1 0/2] vfio/pci: wrap pci device as mdev with vfio-pci
 driver
Thread-Topic: [RFC v1 0/2] vfio/pci: wrap pci device as mdev with vfio-pci
 driver
Thread-Index: AQHU0owcC77VwoODH0yykPtRbr/Dv6YAIIaAgAF7zGA=
Date:   Fri, 8 Mar 2019 11:33:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E2D7A7@SHSMSX104.ccr.corp.intel.com>
References: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
 <20190307133931.58ce6f4c@w520.home>
In-Reply-To: <20190307133931.58ce6f4c@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTY5YTRhNzktMTI3Ni00MTlkLTgwYTQtM2JmZDVjMWU4MGY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSHduK0dRM2FOMUNTRmJ4XC83TW9Ea2o5Umxpb2xqK2UreWwyc2pkYUFcL3ZRSmR2WTVNaExmZ1h4cTRURElZTVwvOSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, March 8, 2019 4:40 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Cc: kwankhede@nvidia.com; Tian, Kevin <kevin.tian@intel.com>;
> baolu.lu@linux.intel.com; joro@8bytes.org; jean-philippe.brucker@arm.com;
> peterx@redhat.com; linux-kernel@vger.kernel.org; Sun, Yi Y <yi.y.sun@intel.com>
> Subject: Re: [RFC v1 0/2] vfio/pci: wrap pci device as mdev with vfio-pci driver
> 
> On Sun,  3 Mar 2019 20:57:59 +0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > This patchset aims to add a vfio-pci-like meta driver on existing
> > PCI devices, as a demo user of the vfio changes introduced in
> > "vfio/mdev: IOMMU aware mediated device" patchset from Baolu Lu.
> >
> > To build such a meta driver. We have two choices.
> > a) add a vfio-pci alike sample driver under samples directory
> > b) add some extensions in vfio-pci driver to make it wrap pci
> >    device as mdev
> >
> > For choice a), the new sample driver will have quite a few
> > duplicated code with vfio-pci driver since the new sample
> > driver also wants to virtualize the PCI config space. So
> > this choice may bring in extra maintain effort in kernel
> > and also looks strange since there will be a bunch of
> > duplicated code with vfio-pci driver.
> >
> > For choice b), it may reuse the existing vfio-pci driver
> > by adding a new working mode. With this mode, user can wrap
> > a pci device as a mediated device by binding it with the
> > vfio-pci driver which works in the new mode. Thus can be used
> > to verify the ""vfio/mdev: IOMMU aware mediated device"
> > patchset.
> >
> > This patchset is following choice b). However, we are open on
> > the direction of the implementation of this vfio-pci-like meta
> > driver. Pls feel free give your suggestions.
> 
> Thanks for doing this Yi!  Rather than a module option for vfio-pci,
> what about having this build into a separate module (ex.
> vfio-pci-mdev)?  Then we could test "regular" vfio-pci along side mdev
> wrapped devices simply by which driver we bind and it'd probably be more
> friendly to existing users, like libvirt.  This might also make a good
> base driver for experimenting with device specific mdev migration as
> well.  Thanks,

Yeah, much better user experience. Let me do that. Thanks for the suggestion. :-)

Regards,
Yi Liu

