Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C9FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E91620644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfG3JBt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:01:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31686 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730144AbfG3JBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:01:48 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-78-fpdZrzpgOd2IFEr4Y9p-iw-1; Tue, 30 Jul 2019 10:01:43 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 30 Jul 2019 10:01:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 30 Jul 2019 10:01:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qian Cai' <cai@lca.pw>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "vyasevich@gmail.com" <vyasevich@gmail.com>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/socket: fix GCC8+ Wpacked-not-aligned warnings
Thread-Topic: [PATCH] net/socket: fix GCC8+ Wpacked-not-aligned warnings
Thread-Index: AQHVRkudEsn++uUNgEOzf6EyOSA1VKbi3DOA
Date:   Tue, 30 Jul 2019 09:01:43 +0000
Message-ID: <91237fd501de4ab895305c4d5666d822@AcuMS.aculab.com>
References: <1564431838-23051-1-git-send-email-cai@lca.pw>
In-Reply-To: <1564431838-23051-1-git-send-email-cai@lca.pw>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: fpdZrzpgOd2IFEr4Y9p-iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai
> Sent: 29 July 2019 21:24
..
> To fix this, "struct sockaddr_storage" needs to be aligned to 4-byte as
> it is only used in those packed sctp structure which is part of UAPI,
> and "struct __kernel_sockaddr_storage" is used in some other
> places of UAPI that need not to change alignments in order to not
> breaking userspace.
> 
> One option is use typedef between "sockaddr_storage" and
> "__kernel_sockaddr_storage" but it needs to change 35 or 370 lines of
> codes. The other option is to duplicate this simple 2-field structure to
> have a separate "struct sockaddr_storage" so it can use a different
> alignment than "__kernel_sockaddr_storage". Also the structure seems
> stable enough, so it will be low-maintenance to update two structures in
> the future in case of changes.

Does it all work if the 8 byte alignment is implicit, not explicit?
For instance if unnamed union and struct are used eg:

struct sockaddr_storage {
	union {
		void * __ptr;  /* Force alignment */
		struct {
			__kernel_sa_family_t	ss_family;		/* address family */
			/* Following field(s) are implementation specific */
			char	__data[_K_SS_MAXSIZE - sizeof(unsigned short)];
					/* space to achieve desired size, */
					/* _SS_MAXSIZE value minus size of ss_family */
		};
	};
};

I suspect unnamed unions and structs have to be allowed by the compiler.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

