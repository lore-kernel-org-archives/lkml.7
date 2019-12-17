Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A229C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF1920665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLQRot convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:44:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53537 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726764AbfLQRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:44:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-232-Z7igONalOzWl3qPlo7GPtQ-1; Tue, 17 Dec 2019 17:44:41 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 17 Dec 2019 17:44:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 17 Dec 2019 17:44:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Steven Rostedt'" <rostedt@goodmis.org>
Subject: ftrace trace_raw_pipe format
Thread-Topic: ftrace trace_raw_pipe format
Thread-Index: AdW0/hn3Ss2VXYeUS7iB4GPS8sdlIg==
Date:   Tue, 17 Dec 2019 17:44:40 +0000
Message-ID: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Z7igONalOzWl3qPlo7GPtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to 'grok' the trace_raw_pipe data that ftrace generates.
I've some 3rd party code that post-processes it, but doesn't like wrapped traces
because (I think) the traces from different cpus start at different times.

I can't seem to find any documentation at all...

I can find the format of the trace entries (I only need the length) from the 'format' files.
There seems to be 4 bytes between the entries that looks like a time difference.
I presume this is the interval before the trace item that follows.
(There is a time-delta of 1 before the first entry.)

The overall file seems to be a series of 4k blocks.
All but the first have a 16 byte header (possibly) described by 'header_page'
that has a timestamp and length (and a sign extended flag).

The first 4k page is confusing me.
The first 8 bytes might be the time the actual trace started.
The next 8 contain a length (short for a wrapped trace).
I've no idea what the next 8 are, they look like count of something.

Given that I've stopped tracing before reading the files I'd
expect the last buffer to be the partial one, not the first.
I'm also pretty sure the partial block contains the last trace data
(it seems to refer to the shell script sleep used to time the trace.)

I did find some old mailing list messages about these files being
corrupt - but that was about the time the splice code was
added to read them out - best part of 10 years ago.

If I can sort the headers for the 4k block (and reorder them??),
then delete entries so the start times match I should be able to
make the post-processing code work.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

