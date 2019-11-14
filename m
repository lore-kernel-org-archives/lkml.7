Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628FDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E27620723
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfKNNWN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:22:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28644 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfKNNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:22:12 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-172-PjHJCdYGMqyCEpwqMfyeLA-1; Thu, 14 Nov 2019 13:22:04 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 14 Nov 2019 13:22:03 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 14 Nov 2019 13:22:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Stephen Hemminger" <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, "Juergen Gross" <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
Thread-Topic: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
Thread-Index: AQHVmTnGMlCgX/wyC0irSyeDShf4MaeKgnHAgAAklgCAAAMfoA==
Date:   Thu, 14 Nov 2019 13:22:03 +0000
Message-ID: <2e02321be78d43e9b7d7ead29a10b1d9@AcuMS.aculab.com>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.603030685@linutronix.de>
 <20191112091521.GX4131@hirez.programming.kicks-ass.net>
 <a0146b86073f4b9bb858d80b4a71683e@AcuMS.aculab.com>
 <20191114130926.GP4114@hirez.programming.kicks-ass.net>
In-Reply-To: <20191114130926.GP4114@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: PjHJCdYGMqyCEpwqMfyeLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
> On Thu, Nov 14, 2019 at 11:02:01AM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > Sent: 12 November 2019 09:15
> > ...
> > > > +	/*
> > > > +	 * If the bitmap is not shared, then nothing can take a refcount as
> > > > +	 * current can obviously not fork at the same time. If it's shared
> > > > +	 * duplicate it and drop the refcount on the original one.
> > > > +	 */
> > > > +	if (refcount_read(&iobm->refcnt) > 1) {
> > > > +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> > > > +		if (!iobm)
> > > > +			return -ENOMEM;
> > > > +		io_bitmap_exit();
> > > 		refcount_set(&iobm->refcnd, 1);
> > > >  	}
> >
> > What happens if two threads of the same process enter the above
> > at the same time?
> 
> Suppose there's just the two threads, and both will change it. Then both
> do copy-on-write and the original gets freed.

I was probably forgetting that the linux kernel uses (more or less) full 'process'
structures for threads, rather than separate 'thread' data areas.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

