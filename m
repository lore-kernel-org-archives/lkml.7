Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7484C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F3221E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfHGPTE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:19:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26904 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387543AbfHGPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:19:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-58-vbBGLUz5N52_YU_A_1ip9w-1; Wed, 07 Aug 2019 16:19:00 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 7 Aug 2019 16:18:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 7 Aug 2019 16:18:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sudeep Holla' <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Subject: RE: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32
 accessors
Thread-Topic: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32
 accessors
Thread-Index: AQHVTSAtyuEmH657y0Gt9ART6WUBkKbvzBcw
Date:   Wed, 7 Aug 2019 15:18:59 +0000
Message-ID: <4102ce79ef7a4f5ba819663d072bccc8@AcuMS.aculab.com>
References: <20190807130038.26878-1-sudeep.holla@arm.com>
In-Reply-To: <20190807130038.26878-1-sudeep.holla@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vbBGLUz5N52_YU_A_1ip9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla
> Sent: 07 August 2019 14:01
> 
> Instead of type-casting the {tx,rx}.buf all over the place while
> accessing them to read/write __le32 from/to the firmware, let's use
> the nice existing {get,put}_unaligned_le32 accessors to hide all the
> type cast ugliness.

Why the 'unaligned' accessors?

> -	*(__le32 *)t->tx.buf = cpu_to_le32(id);
> +	put_unaligned_le32(id, t->tx.buf);

These will be expensive if the cpu doesn't support them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

