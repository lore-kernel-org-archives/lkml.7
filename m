Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74648C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550632173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfIBJH6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:07:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37068 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730663AbfIBJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:07:58 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-pWetoKX2MVuDKeOGTbmj9Q-1; Mon, 02 Sep 2019 10:07:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Sep 2019 10:07:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Sep 2019 10:07:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] printf: add support for printing symbolic error codes
Thread-Topic: [PATCH] printf: add support for printing symbolic error codes
Thread-Index: AQHVX4Vhxwh8/eMOVEunFKpvvE2RyacYHAyQ
Date:   Mon, 2 Sep 2019 09:07:53 +0000
Message-ID: <d5cd47d8f2344ddfa88a34eab5cceb81@AcuMS.aculab.com>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
 <9fecd3a9-e1ae-a1f9-a0c5-f5db3430c81d@rasmusvillemoes.dk>
 <92108c09c37a9355566b579db152a05e19f54ccf.camel@perches.com>
 <516ab378-e79a-4e1c-8099-ccb22dfd5508@rasmusvillemoes.dk>
In-Reply-To: <516ab378-e79a-4e1c-8099-ccb22dfd5508@rasmusvillemoes.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: pWetoKX2MVuDKeOGTbmj9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes
> Sent: 30 August 2019 23:51
...
> > But why not just extend check_pointer_msg?
> 
> Partly because that would rely on all %p<foo> actually eventually
> passing ptr through to that (notably plain %p does not), partly because
> the way check_pointer_msg works means that it has to return a string for
> its caller to print - which is ok when the errcode is found, but breaks
> if it needs to format a decimal. It can't even snprintf() to a stack
> buffer and return that, because, well, you can't do that, and it would
> be a silly recursive snprintf anyway.

Perhaps you could use NULL or "" to mean 'just print the value'.
Then you might manage to use the test for NULL to print the errno strings.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

