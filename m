Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80316ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625EF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfJONoe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:44:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52636 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728880AbfJONod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:44:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-191-VZdTs2gWNsGAxBzQDtU9Qw-1; Tue, 15 Oct 2019 14:44:30 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Oct 2019 14:44:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Oct 2019 14:44:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/1] printf: add support for printing symbolic error
 names
Thread-Topic: [PATCH v4 1/1] printf: add support for printing symbolic error
 names
Thread-Index: AQHVgo+xcgMsYRXixUil6/wftqCdMKdbtuyw
Date:   Tue, 15 Oct 2019 13:44:30 +0000
Message-ID: <904b85b3c32d448abc6b4e58b6c4dc35@AcuMS.aculab.com>
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-2-linux@rasmusvillemoes.dk>
 <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
In-Reply-To: <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VZdTs2gWNsGAxBzQDtU9Qw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek
> Sent: 14 October 2019 14:03
> On Fri 2019-10-11 15:36:17, Rasmus Villemoes wrote:
> > It has been suggested several times to extend vsnprintf() to be able
> > to convert the numeric value of ENOSPC to print "ENOSPC". This
> > implements that as a %p extension: With %pe, one can do
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I like the patch. There are only two rather cosmetic things.
> 
> > diff --git a/lib/errname.c b/lib/errname.c
> > new file mode 100644
> > index 000000000000..30d3bab99477
> > --- /dev/null
> > +++ b/lib/errname.c
> > +const char *errname(int err)
> > +{
> > +	bool pos = err > 0;
> > +	const char *name = __errname(err > 0 ? err : -err);
> > +
> > +	return name ? name + pos : NULL;
> 
> This made me to check C standard. It seems that "true" really has
> to be "1".

What is thus "true" symbol you are talking about?
Actually you could get rid of the "bool" as well.
	unsigned int pos = err > 0;
	const char *name = __errname(pos ? err : -err);
	return name ? &pos[name] : NULL;
then it is all well defined.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

