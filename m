Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5733DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F121707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfD3KwV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:52:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:41503 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbfD3KwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-o3Z4AmsVPhKcl9wCrASykQ-1; Tue, 30 Apr 2019 11:52:14 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 30 Apr 2019 11:52:13 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 30 Apr 2019 11:52:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Phong Tran' <tranmanphong@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>
CC:     "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] of: replace be32_to_cpu to be32_to_cpup
Thread-Topic: [PATCH] of: replace be32_to_cpu to be32_to_cpup
Thread-Index: AQHU/zOHQCFPeP9s40qeT2QsFKHyGqZUhhqA
Date:   Tue, 30 Apr 2019 10:52:13 +0000
Message-ID: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com>
References: <20190430090044.16345-1-tranmanphong@gmail.com>
In-Reply-To: <20190430090044.16345-1-tranmanphong@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: o3Z4AmsVPhKcl9wCrASykQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran
> Sent: 30 April 2019 10:01
> The cell is a pointer to __be32.
> with the be32_to_cpu a lot of clang warning show that:
> 
> ./include/linux/of.h:238:37: warning: multiple unsequenced modifications
> to 'cell' [-Wunsequenced]
>                 r = (r << 32) | be32_to_cpu(*(cell++));
>                                                   ^~
> ./include/linux/byteorder/generic.h:95:21: note: expanded from macro
> 'be32_to_cpu'
>                     ^
> ./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
> from macro '__be32_to_cpu'
>                                                           ^
> ./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
>         ___constant_swab32(x) :                 \
>                            ^
> ./include/uapi/linux/swab.h:18:12: note: expanded from macro
> '___constant_swab32'
>         (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
>                   ^
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  include/linux/of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e240992e5cb6..1c35fc8f19b0 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -235,7 +235,7 @@ static inline u64 of_read_number(const __be32 *cell, int size)
>  {
>  	u64 r = 0;
>  	while (size--)
> -		r = (r << 32) | be32_to_cpu(*(cell++));
> +		r = (r << 32) | be32_to_cpup(cell++);
>  	return r;

That is a very strange loop.
It is probably equivalent to:
	r = be32_to_cpu(*cell);
	if (size)
		r = r << 32 | be32_to_cpu(cell[1]);
	return r;

In any case replacing the while with (say):
	for (; size--; cell++)
		r = (r << 32) | be32_to_cpu(*cell);
would remove the ambiguity.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

