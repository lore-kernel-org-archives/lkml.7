Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08486FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CBD21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408961AbfJQLZw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:25:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:38098 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405615AbfJQLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:25:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-229-IgOKeQaCO-2JqkfwN87PQg-1; Thu, 17 Oct 2019 12:25:48 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 17 Oct 2019 12:25:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 17 Oct 2019 12:25:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michal Hocko' <mhocko@kernel.org>, Pavel Machek <pavel@denx.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH 4.19 56/81] kernel/sysctl.c: do not override max_threads
 provided by userspace
Thread-Topic: [PATCH 4.19 56/81] kernel/sysctl.c: do not override max_threads
 provided by userspace
Thread-Index: AQHVhNrFkztCyRMcd0qNqS+/WALIZaderzAw
Date:   Thu, 17 Oct 2019 11:25:47 +0000
Message-ID: <b41558c732384c6280f0fe18823aa7e1@AcuMS.aculab.com>
References: <20191016214805.727399379@linuxfoundation.org>
 <20191016214842.621065901@linuxfoundation.org> <20191017105940.GA5966@amd>
 <20191017110516.GG24485@dhcp22.suse.cz>
In-Reply-To: <20191017110516.GG24485@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: IgOKeQaCO-2JqkfwN87PQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko
> Sent: 17 October 2019 12:05
...
> > Plus, I don't see any locking here, should this be WRITE_ONCE() at
> > minimum?
> 
> Why would that matter? Do you expect several root processes race to set
> the value?

One of them wins. No one is going to notice is the value is set an extra time.

WRITE_ONCE() is rarely required.
Probably only if other code is going to update the value after seeing the first write.
(eg if you are unlocking a mutex - although they have to be more complex)

READ_ONCE() is a different matter.
IMHO the compiler shouldn't be allowed to do more reads than the source requests.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

