Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B1C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E9020833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfEQJGb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:06:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:46103 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727338AbfEQJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:06:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-y_73BxfGMMizl2DShogLcw-1; Fri, 17 May 2019 10:06:27 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 17 May 2019 10:06:26 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 17 May 2019 10:06:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kara' <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Smits <jeff.smits@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Thread-Topic: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Thread-Index: AQHVDI00Hs6UetBw5UmdJ+47dYtmSqZvBeSA
Date:   Fri, 17 May 2019 09:06:26 +0000
Message-ID: <2d8b1ba7890940bf8a512d4eef0d99b3@AcuMS.aculab.com>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
In-Reply-To: <20190517084739.GB20550@quack2.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: y_73BxfGMMizl2DShogLcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara
> Sent: 17 May 2019 09:48
...
> So this last paragraph is not obvious to me as check_copy_size() does a lot
> of various checks in CONFIG_HARDENED_USERCOPY case. I agree that some of
> those checks don't make sense for PMEM pages but I'd rather handle that by
> refining check_copy_size() and check_object_size() functions to detect and
> appropriately handle pmem pages rather that generally skip all the checks
> in pmem_copy_from/to_iter(). And yes, every check in such hot path is going
> to cost performance but that's what user asked for with
> CONFIG_HARDENED_USERCOPY... Kees?

Except that all the distros enable it by default.
So you get the performance cost whether you (as a user) want it or not.

I've changed some of our code to use __get_user() to avoid
these stupid overheads.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

