Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32719C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0576B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfG2KYa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:24:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:49549 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728150AbfG2KYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:24:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-VJwiHrKHPaOBTCMo7rm5ew-1; Mon, 29 Jul 2019 11:24:28 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 29 Jul 2019 11:24:27 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 29 Jul 2019 11:24:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Moore, Robert'" <robert.moore@intel.com>, Qian Cai <cai@lca.pw>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@FreeBSD.org" <jkim@FreeBSD.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Topic: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Index: AQHVPaHylXmfzBauvEybJLDaugeeCqbdV0WAgAQb46A=
Date:   Mon, 29 Jul 2019 10:24:27 +0000
Message-ID: <c98fa373a004472b979255a93b414fe1@AcuMS.aculab.com>
References: <20190718194846.1880-1-cai@lca.pw>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VJwiHrKHPaOBTCMo7rm5ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moore, Robert
> Sent: 26 July 2019 20:36
...
> This is because pointer arithmetic
> on a pointer not pointing to an array is an undefined behavior (C11 6.5.6, constraint 8).
...

The standards committee as smoking dope again :-)
If that is enforced as a compiler warning/error a lot of code 'breaks'.
Anything that does:
	struct foo *foo = ...;
      struct bar *bar = (void *)(foo + 1);
suddenly becomes 'invalid'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

