Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE33C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9741421726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH3Nj4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:39:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25633 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727729AbfH3Nj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:39:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-210-F1QPlVPsMbqytrDM-jSL6w-1; Fri, 30 Aug 2019 14:39:52 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 14:39:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Aug 2019 14:39:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lu Baolu' <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "alan.cox@intel.com" <alan.cox@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "pengfei.xu@intel.com" <pengfei.xu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted
 devices
Thread-Topic: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted
 devices
Thread-Index: AQHVXwNAt0TkSHwjwEWfpppIl7udg6cTsWfA
Date:   Fri, 30 Aug 2019 13:39:51 +0000
Message-ID: <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
 <20190830071718.16613-8-baolu.lu@linux.intel.com>
In-Reply-To: <20190830071718.16613-8-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: F1QPlVPsMbqytrDM-jSL6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu
> Sent: 30 August 2019 08:17

> The Intel VT-d hardware uses paging for DMA remapping.
> The minimum mapped window is a page size. The device
> drivers may map buffers not filling the whole IOMMU
> window. This allows the device to access to possibly
> unrelated memory and a malicious device could exploit
> this to perform DMA attacks. To address this, the
> Intel IOMMU driver will use bounce pages for those
> buffers which don't fill whole IOMMU pages.

Won't this completely kill performance?

I'd expect to see something for dma_alloc_coherent() (etc)
that tries to give the driver page sized buffers.

Either that or the driver could allocate page sized buffers
even though it only passes fragments of these buffers to
the dma functions (to avoid excessive cache invalidates).

Since you have to trust the driver, why not actually trust it?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

