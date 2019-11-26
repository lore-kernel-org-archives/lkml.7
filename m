Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D34C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C457D206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKZKNo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:13:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20539 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbfKZKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:13:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-quipjFAFM3icMji5ZqiO4A-1; Tue, 26 Nov 2019 10:13:38 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 26 Nov 2019 10:13:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 26 Nov 2019 10:13:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Fenghua Yu' <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v2 0/4] Fix some 4-byte vs. 8-byte alignment issues in
 atomic bit operations
Thread-Topic: [PATCH v2 0/4] Fix some 4-byte vs. 8-byte alignment issues in
 atomic bit operations
Thread-Index: AQHVo8bnUSfQXTuB6k6xiK+0nu6MoaedOrpg
Date:   Tue, 26 Nov 2019 10:13:37 +0000
Message-ID: <965b5dcf35b54f8b96008a82e6d581c1@AcuMS.aculab.com>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: quipjFAFM3icMji5ZqiO4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu
> Sent: 25 November 2019 19:43
...
> Change Log:
> v2:
> - Remove patch 1 and 3 in v1 because they are in the tip tree already.
> - Add new patches 2-4 per David Laight's comments:
> https://lore.kernel.org/lkml/e7c75de9191847ed98c573f9ad871518@AcuMS.aculab.com/
> Running "grep -r --include '*.[ch]' '_bit([^(]*, *([^)]*\*)' ."
> returns about 200 results. Most of them don't have split lock issues.

Except that any code that has to cast the long[] array argument to any of
the bitops functions is almost certainly broken in some way or other.
At best it is relying on accidental alignment of whatever address it is passing
to avoid alignment faults (for general misaligned accesses).

In other cases attempting to run the code on a BE system will update the
wrong bits - potentially in some other member of the structure.

Now, you might say that 'this code is LE only', but at some point it might
get used on a BE system.

So all of those 200 results need fixing to remove the casts.
Just using the unblocked __bit_xxx() functions doesn't fix
all the problems.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

