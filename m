Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A88C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7EE2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfDAP1n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:27:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:55859 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbfDAP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:27:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-FIAlWESBMeai6qXJUmKCAg-1; Mon, 01 Apr 2019 16:27:30 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 1 Apr 2019 16:28:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Apr 2019 16:28:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alan Stern' <stern@rowland.harvard.edu>,
        Oleg Nesterov <oleg@redhat.com>
CC:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH] Convert struct pid count to refcount_t
Thread-Topic: [PATCH] Convert struct pid count to refcount_t
Thread-Index: AQHU5mgbEUS1Lz7T4USOARfdCVSWPqYncFxg
Date:   Mon, 1 Apr 2019 15:28:35 +0000
Message-ID: <76f3b894980d4a79a2c0ae815425d6a0@AcuMS.aculab.com>
References: <20190329173209.GA23683@redhat.com>
 <Pine.LNX.4.44L0.1903291519060.1497-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1903291519060.1497-100000@iolanthe.rowland.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: FIAlWESBMeai6qXJUmKCAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern
> Sent: 29 March 2019 19:45
...
> There is a big difference between WRITE_ONCE() and plain assignment.
> Given "WRITE_ONCE(X, 2)", the compiler will emit a simple store
> instruction.  But given "X = 2", the compiler is allowed to emit
> instructions equivalent to:
> 
> 	if (X != 2)
> 		X = 2;

Worse for you, it can also emit:
	X = 0;
	X = 2;

Many years ago I fell foul of a compiler (not C) that implemented
a write to a 2 bit wide bitfield as:
	X &= ~3
	X |= value
even when 'value' was a compile time constant of 3.
Took a while to find out why the linked list got f*cked.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

