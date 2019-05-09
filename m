Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAECD205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEINrG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:47:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35843 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbfEINrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:47:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-cILVDsqaNZKuy6_7SA1Hbw-1;
 Thu, 09 May 2019 14:47:00 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 9 May 2019 14:46:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 9 May 2019 14:46:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-1?Q?=27Michal_Such=E1nek=27?= <msuchanek@suse.de>,
        Petr Mladek <pmladek@suse.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@ozlabs.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
Thread-Topic: [PATCH] vsprintf: Do not break early boot with probing addresses
Thread-Index: AQHVBmyk/iTC8Q7sI0elwkZY5/gFJaZizfQA
Date:   Thu, 9 May 2019 13:46:59 +0000
Message-ID: <8ad8bb83b7034f7e92df12040fb8c2c2@AcuMS.aculab.com>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190509153829.06319d0c@kitsune.suse.cz>
In-Reply-To: <20190509153829.06319d0c@kitsune.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: cILVDsqaNZKuy6_7SA1Hbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchánek
> Sent: 09 May 2019 14:38
...
> > The problem is the combination of some new code called via printk(),
> > check_pointer() which calls probe_kernel_read(). That then calls
> > allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> > (before we've patched features).
> 
> There is early_mmu_has_feature for this case. mmu_has_feature does not
> work before patching so parts of kernel that can run before patching
> must use the early_ variant which actually runs code reading the
> feature bitmap to determine the answer.

Does the early_ variant get patched so the it is reasonably
efficient after the 'patching' is done?
Or should there be a third version which gets patched across?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

