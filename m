Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B40C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C646F21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfIRIyQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:54:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51187 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfIRIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:54:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-jKdvC4LqNxePvj2_PXioBg-1;
 Wed, 18 Sep 2019 09:54:12 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 18 Sep 2019 09:54:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Sep 2019 09:54:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Luck, Tony'" <tony.luck@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH 3/3] x86/split_lock: Align the x86_capability array to
 size of unsigned long
Thread-Topic: [PATCH 3/3] x86/split_lock: Align the x86_capability array to
 size of unsigned long
Thread-Index: AQHVbN+vZQX1JbkM+kyyTtwnTlEXh6cviXfwgACkJoCAAPSz0A==
Date:   Wed, 18 Sep 2019 08:54:12 +0000
Message-ID: <e7c75de9191847ed98c573f9ad871518@AcuMS.aculab.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <20190916223958.27048-1-tony.luck@intel.com>
 <20190916223958.27048-4-tony.luck@intel.com>
 <d75c94cf2ca345018ef60880ce6c4aeb@AcuMS.aculab.com>
 <20190917191401.GA4721@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20190917191401.GA4721@agluck-desk2.amr.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: jKdvC4LqNxePvj2_PXioBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Luck, Tony
> Sent: 17 September 2019 20:14
> On Tue, Sep 17, 2019 at 08:29:28AM +0000, David Laight wrote:
> > From: Tony Luck
> > > Sent: 16 September 2019 23:40
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > >
> > > The x86_capability array in cpuinfo_x86 is defined as u32 and thus is
> > > naturally aligned to 4 bytes. But, set_bit() and clear_bit() require
> > > the array to be aligned to size of unsigned long (i.e. 8 bytes in
> > > 64-bit).
> > >
> > > To fix the alignment issue, align the x86_capability array to size of
> > > unsigned long by using unnamed union and 'unsigned long array_align'
> > > to force the alignment.
> > >
> > > Changing the x86_capability array's type to unsigned long may also fix
> > > the issue because the x86_capability array will be naturally aligned
> > > to size of unsigned long. But this needs additional code changes.
> > > So choose the simpler solution by setting the array's alignment to size
> > > of unsigned long.
> > >
> > > Suggested-by: David Laight <David.Laight@aculab.com>
> >
> > While this is probably the only play where this 'capabilities' array
> > has been detected as misaligned, ISTR there are several other places
> > where the identical array is defined and used.
> > These all need fixing as well.
> 
> Agree 100%  These three patches cover the places *detected* so
> far. For bisectability reasons they need to be upstream before
> the patches that add WARN_ON, or the one that turns on alignment
> traps.  As we find other places, we can fix alignments in other
> structures too.
> 
> If you remember what those other places are, please let us know
> so we can push patches to fix those.
> 
> If you have a better strategy to find them ... that also would
> be very interesting.

ISTR doing the following:
1) Looking at the other places where the x86 capabilities got stored.
2) Searching for casts of the bit functions.
Try:
grep -r --include '*.[ch]' '_bit([^(]*, *([^)]*\*)' .

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

