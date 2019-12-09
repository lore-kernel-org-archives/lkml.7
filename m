Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2CDC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD9E20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLIRNC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:13:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45154 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfLIRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:13:02 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-gXjcKifKO0SSX7zViVVInA-1; Mon, 09 Dec 2019 17:12:57 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Dec 2019 17:12:57 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Dec 2019 17:12:57 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "x86@kernel.org" <x86@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86: Optimise x86 IP checksum code
Thread-Topic: [PATCH] x86: Optimise x86 IP checksum code
Thread-Index: AdWpzyHtgEC6Bj0rR0OBHDPJtRbpCgCB6QKAALaXyoA=
Date:   Mon, 9 Dec 2019 17:12:57 +0000
Message-ID: <8ae91feb2edc47f08eda5212dbf05183@AcuMS.aculab.com>
References: <c92db041c78e4d81a70aaf4249393901@AcuMS.aculab.com>
 <201912060941.f3Qi9xtV%lkp@intel.com>
In-Reply-To: <201912060941.f3Qi9xtV%lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: gXjcKifKO0SSX7zViVVInA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot
> Sent: 06 December 2019 01:45
> 
> [auto build test WARNING on tip/auto-latest]
> [also build test WARNING on tip/x86/core linus/master v5.4 next-20191202]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/David-Laight/x86-Optimise-x86-IP-checksum-code/20191203-211313
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e445033e58108a9891abfbc0dea90b066a75e4a9
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-91-g817270f-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> arch/x86/lib/csum-partial_64.c:141:23: sparse: sparse: incorrect type in return expression (different base types) @@    expected
> restricted __wsum @@    got icted __wsum @@
> >> arch/x86/lib/csum-partial_64.c:141:23: sparse:    expected restricted __wsum
> >> arch/x86/lib/csum-partial_64.c:141:23: sparse:    got unsigned int
> 
> vim +141 arch/x86/lib/csum-partial_64.c
> 
...
>    138	 */
>    139	__wsum csum_partial(const void *buff, int len, __wsum sum)
>    140	{
>  > 141		return do_csum(buff, len, (__force u32)sum);
>    142	}
>    143	EXPORT_SYMBOL(csum_partial);
>    144

I can regenerate the patch with the (__force __wsum) cast added back in.

Anyone going to review the changes?
I've tested all (I hope) of the corner cases in a user-space test program.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

