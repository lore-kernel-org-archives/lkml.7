Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CFC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE0520835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfEAJx4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:53:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:57095 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfEAJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:53:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-221-1XAtXxknNhyca-4tma7EeQ-1; Wed, 01 May 2019 10:53:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 1 May 2019 10:53:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 1 May 2019 10:53:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Upper limit for sysctl fs.file-max
Thread-Topic: Upper limit for sysctl fs.file-max
Thread-Index: AdUAA8ivBxEHYWXCQH+fjE5WlM/5oQ==
Date:   Wed, 1 May 2019 09:53:52 +0000
Message-ID: <e980436491d144bfbd1410a02333ebfc@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 1XAtXxknNhyca-4tma7EeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal default for fs.file-max (the maximum number of file structures)
is 1/10240th of the available memory.

However it seems to be possible to set fs.file-max to any value
up to 2^64-1.
While all 'large' values are effectively the same this seems rather
excessive here.

Problems arrive when any shell scripts (or anything else that
only really has signed 64bit numbers) try to process values above
2^63-1 as these cause errors and/or other unexpected actions.

ISTM that the values of a lot of sysctl parameters should be limited
to avoid such problems.

We've hit this because something is awry in the 5.0 kernel in
ubuntu 19.04.
Booting the failing userspace with a 5.1-rcx kernel is ok.
Nothing looks wrong with the object code for the function that
sets the default, and the last thing it does is divide by 10
so it is difficult for it to generate -1.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

