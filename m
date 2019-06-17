Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0BAC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E5F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFQQlW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:41:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:32818 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbfFQQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:41:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-13-78eJaLHeN_eregkFsgmmww-1; Mon, 17 Jun 2019 17:41:19 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 17 Jun 2019 17:41:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 17 Jun 2019 17:41:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        "Shawn Landden" <shawn@git.icu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Andy Whitcroft <apw@canonical.com>
Subject: RE: [PATCH] Use fall-through attribute rather than magic comments
Thread-Topic: [PATCH] Use fall-through attribute rather than magic comments
Thread-Index: AQHVJSlclFJUjoUp/0eCUTtyq6dWeaagCssA
Date:   Mon, 17 Jun 2019 16:41:18 +0000
Message-ID: <128384ca2876462b90b9f28db85194fc@AcuMS.aculab.com>
References: <20190316033841.7659-1-shawn@git.icu>
         <20190617155643.GA32544@amd>
 <45e070039e66b1cb1490a78d4805bc73cc09f571.camel@perches.com>
In-Reply-To: <45e070039e66b1cb1490a78d4805bc73cc09f571.camel@perches.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 78eJaLHeN_eregkFsgmmww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches
> Sent: 17 June 2019 17:26
> On Mon, 2019-06-17 at 17:56 +0200, Pavel Machek wrote:
> > Hi!
> >
> > > +/*
> > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-fallthrough
> > > + *   gcc: https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
> > > + */
> > > +#if __has_attribute(__fallthrough__)
> > > +# define __fallthrough                    __attribute__((__fallthrough__))
> > > +#else
> > > +# define __fallthrough
> > > +#endif

Should the trailing ; be added to the above?
I think the above would require:
	case foo:
		bar();
		__fallthrough;
	case baz:

When commented out that leaves a completely empty statement (adjacent ;)
I'm sure some compilers complain about those as well.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

