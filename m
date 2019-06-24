Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D83C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD61208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfFXNzM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:55:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:27378 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbfFXNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:55:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-154-zyOnqJgCNBeziOcEpui8zg-1; Mon, 24 Jun 2019 14:55:08 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 24 Jun 2019 14:55:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 24 Jun 2019 14:55:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: Prevent possible overrun during bitmap
 operations
Thread-Topic: [PATCH] x86/resctrl: Prevent possible overrun during bitmap
 operations
Thread-Index: AQHVJt2gKCUy1MDNR0eTZZQcuzstIqaq2mhQ
Date:   Mon, 24 Jun 2019 13:55:07 +0000
Message-ID: <2b15f4ce814a425c8278e910289398c1@AcuMS.aculab.com>
References: <58c9b6081fd9bf599af0dfc01a6fdd335768efef.1560975645.git.reinette.chatre@intel.com>
In-Reply-To: <58c9b6081fd9bf599af0dfc01a6fdd335768efef.1560975645.git.reinette.chatre@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: zyOnqJgCNBeziOcEpui8zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre
> Sent: 19 June 2019 21:27
> 
> While the DOC at the beginning of lib/bitmap.c explicitly states that
> "The number of valid bits in a given bitmap does _not_ need to be an
> exact multiple of BITS_PER_LONG.", some of the bitmap operations do
> indeed access BITS_PER_LONG portions of the provided bitmap no matter
> the size of the provided bitmap. For example, if find_first_bit()
> is provided with an 8 bit bitmap the operation will access
> BITS_PER_LONG bits from the provided bitmap. While the operation
> ensures that these extra bits do not affect the result, the memory
> is still accessed.

I suspect that comment also needs correcting.
On BE systems you really do need to have a array of longs.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

