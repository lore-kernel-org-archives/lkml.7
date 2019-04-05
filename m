Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94065C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6993F21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfDEQPQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:15:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52239 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731454AbfDEQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:15:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-192-z6o3oXjaMHOKV3P61-wwvw-1; Fri, 05 Apr 2019 17:15:06 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 17:16:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Apr 2019 17:16:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Luis Ressel' <aranea@aixah.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] objtool: Don't use -Werror
Thread-Topic: [PATCH] objtool: Don't use -Werror
Thread-Index: AQHU68meTsW4XthB40qs85GeKW+DmKYtvJfg
Date:   Fri, 5 Apr 2019 16:16:14 +0000
Message-ID: <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
In-Reply-To: <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: z6o3oXjaMHOKV3P61-wwvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Ressel
> Sent: 05 April 2019 17:06
> On Fri, Apr 05, 2019 at 09:39:26AM -0500, Josh Poimboeuf wrote:
> 
> > Hm, I would actually argue the reverse.  Warnings are generally bad and
> > -Werror is useful for ensuring that we don't have any.  For warnings
> > that don't provide value, we just disable those individual warnings.
> 
> Sure, during development it's an excellent idea to investigate compiler
> warnings, and -Werror can be useful for that. But the Linux kernel is
> built by countless users in wildly varying environments, and it's almost
> a given that someone will use a compiler that'll complain about a valid
> part of your code whose style it considers bad.
> 
> As an example, the warning that's breaking the build for me is -Wundef
> complaining about several "#if UNDEFINED_IDENTIFIER" constructs in the
> libelf headers. (I agree with gcc in considering this bad style, but
> it's perfectly valid C, and there probably wasn't a warning about it
> back when this header was written.)

In which case you should be looking at a way of removing -Wundef
not removing -Werror.

FWIW I had to update libelf.so from version 0.153 to 0.165 in
order for the amd64 orc unwinder code in objtool to not generate
corrupt output files.
That is an Ubuntu 13.04 system - nothing like 10 years old.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

