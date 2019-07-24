Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69E4C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FE3229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfGXK2f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:28:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52036 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfGXK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:28:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-W7Famm5VOkyvDWkWVnd1yQ-1; Wed, 24 Jul 2019 11:28:31 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 24 Jul 2019 11:28:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 24 Jul 2019 11:28:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Julia Lawall <julia.lawall@lip6.fr>
CC:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms]
Thread-Topic: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
Thread-Index: AQHVQdmROdgsXv6JFEuyvGTo4e2W1qbZkJnA
Date:   Wed, 24 Jul 2019 10:28:31 +0000
Message-ID: <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
          <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
          <alpine.DEB.2.21.1907231546090.2551@hadrien>
          <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
          <alpine.DEB.2.21.1907232252260.2539@hadrien>
         <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
         <alpine.DEB.2.21.1907232326360.2539@hadrien>
 <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
In-Reply-To: <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: W7Famm5VOkyvDWkWVnd1yQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches
> Sent: 24 July 2019 05:38
> On Tue, 2019-07-23 at 23:27 -0500, Julia Lawall wrote:
> >
> > On Tue, 23 Jul 2019, Joe Perches wrote:
> >
> > > On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> > > > A seantic patch and the resulting output for the case where the third
> > > > arugument is a constant is attached.  Likewise the resulting output on a
> > > > recent linux-next.
> > > >
> > > > julia
> > >
> > > Nice.  Thanks Julia
> > >
> > > A couple issues:
> > >
> > > There is a problem with conversions with assignments
> > > of strlcpy() so ideally the cocci script should make sure
> > > any return value was not used before conversion.
> > >
> > > This is not a provably good conversion:
> > >
> > > drivers/s390/char/sclp_ftp.c
> > > @@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
> > >         sccb->evbuf.mdd.ftp.length = ftp->len;
> > >         sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
> > >
> > > -       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
> > > -                     HMCDRV_FTP_FIDENT_MAX);
> > > +       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);
> >
> > Sorry, I don't understand the issue here.  What specifically should I be
> > looking for?
> 
> The return value of strlcpy differs from (strscpy or stracpy).
> 
> strlcpy		returns the length of the src string
> str[sa]cpy	returns the length of the src string if it fits in dest
> 		or -E2BIG if src is truncated by the size of dest
> 		or -E2BIG if dest is 0 length
> 
> Any use of the strlcpy return value should not be converted
> because the logic after an assignment or use of the return value
> can not be assured to have the same behavior.

Most of the code probably expects the length to be that copied
(so is broken if the string is truncated).

OTOH the code almost certainly doesn't expect -E2BIG either
so will go wrong in that case as well.

The return value from str[as]cpy() is its own set of bugs
just waiting to happen.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

