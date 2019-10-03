Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFCC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B278A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfJCKNp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:13:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:56391 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbfJCKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:13:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-DH_yUcB-PHeo9Pyr2wfXUg-1; Thu, 03 Oct 2019 11:13:41 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 3 Oct 2019 11:13:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 3 Oct 2019 11:13:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kurt Roeckx' <kurt@roeckx.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
Subject: RE: Stop breaking the CSRNG
Thread-Topic: Stop breaking the CSRNG
Thread-Index: AQHVeUNxp+fni2lQz0uk1fV0/DAY1qdIrV6A
Date:   Thu, 3 Oct 2019 10:13:39 +0000
Message-ID: <b193685d90c0474aa0727555f936528b@AcuMS.aculab.com>
References: <20191002165533.GA18282@roeckx.be>
In-Reply-To: <20191002165533.GA18282@roeckx.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: DH_yUcB-PHeo9Pyr2wfXUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Roeckx
> Sent: 02 October 2019 17:56
> As OpenSSL, we want cryptograhic secure random numbers. Before
> getrandom(), Linux never provided a good API for that, both
> /dev/random and /dev/urandom have problems. getrandom() fixed
> that, so we switched to it were available.

The fundamental problem is that you can't always get ' cryptograhic secure
random numbers'. No API changes are ever going to change that.

The system can either return an error or sleep (possibly indefinitely)
until some 'reasonably random' numbers are available.

A RISC-V system running on an FGPA (I've only used Altera NIOS cpu)
may have absolutely no sources of randomness at boot time.
Saying the architecture must include a random number instruction
doesn't help!
Generating random bits inside the FPGA is somewhere between 'difficult'
and impossible (forcing metastability between clock domains might work).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

