Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61009C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3380420651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfHLPvj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:51:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55860 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfHLPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:51:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-96-FR3q9SRhOcK_sOnXAhoHrg-1; Mon, 12 Aug 2019 16:51:36 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 12 Aug 2019 16:51:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 12 Aug 2019 16:51:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Burmeister' <joe.burmeister@devtank.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
Thread-Topic: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
Thread-Index: AQHVTrGNJIfDRfq0GECP/9557qPIG6b3q6Kw
Date:   Mon, 12 Aug 2019 15:51:35 +0000
Message-ID: <9f1c7d45020d482390737be22c885a9b@AcuMS.aculab.com>
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
In-Reply-To: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: FR3q9SRhOcK_sOnXAhoHrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Burmeister
> Sent: 09 August 2019 13:54
> 
> Many, though not all, AT25s have an instruction for chip erase.
> If there is one in the datasheet, it can be added to device tree.
> Erase can then be done in userspace via the sysfs API with a new
> "erase" device attribute. This matches the eeprom_93xx46 driver's
> "erase".

Is it actually worth doing though?

I'm guessing that device erase can easily take over a minute.

When I looked at 'device erase' on an EEPROM it took just as long
as erasing the sectors one at a time - but without the warm cosy
feeling that progress was being made.

Not only that you can't really interrupt the erase, so either
the application has to sleep uninterruptibly for the duration
or you have to have some kind of 'device busy' response while
it is done asynchronously.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

