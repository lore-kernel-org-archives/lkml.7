Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A813C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E149214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbfDRJgv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:36:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37139 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388044AbfDRJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:36:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-194-3nn_-yBIN6-W_ON_FwyD_A-1; Thu, 18 Apr 2019 10:36:48 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 18 Apr 2019 10:37:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 18 Apr 2019 10:37:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jerome Glisse' <jglisse@redhat.com>,
        Patrick Brunner <brunner@stettbacher.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: IOMMU Page faults when running DMA transfers from PCIe device
Thread-Topic: IOMMU Page faults when running DMA transfers from PCIe device
Thread-Index: AQHU9Gne0Qp5IRR58EG3maRPM8o18aZBqidw
Date:   Thu, 18 Apr 2019 09:37:58 +0000
Message-ID: <7bcd438c9e85449e97554d5248d580ca@AcuMS.aculab.com>
References: <2987837.CvKyUSae8N@jona> <20190416153307.GB3254@redhat.com>
In-Reply-To: <20190416153307.GB3254@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 3nn_-yBIN6-W_ON_FwyD_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Glisse
> Sent: 16 April 2019 16:33
...
> I am no expert but i am guessing your FPGA set the request field in the
> PCIE TLP write packet to 00:00.0 and this might work when IOMMU is off but
> might not work when IOMMU is on ie when IOMMU is on your device should set
> the request field to the FPGA PCIE id so that the IOMMU knows for which
> device the PCIE write or read packet is and thus against which IOMMU page
> table.

Interesting.
Does that mean that a malicious PCIe device can send write TLP
that contain the 'wrong' id (IIRC that is bus:dev:fn) and so
write to areas that it shouldn't access?

For any degree of security the PCIe bridge nearest the target
needs to verify the id as well.
Actually all bridges need to verify the 'bus' part.
Then boards with 'dodgy' bridges can only write to locations
that other dev:fn on the same board can access.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

