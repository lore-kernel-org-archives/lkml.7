Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74397C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC032083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfGOJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:28:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbfGOJ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE24085376;
        Mon, 15 Jul 2019 09:28:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09B10608CD;
        Mon, 15 Jul 2019 09:28:05 +0000 (UTC)
Message-ID: <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
Subject: Re: [PATCH] nvme: Add support for Apple 2018+ models
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Paul Pawlowski <paul@mrarm.io>
Date:   Mon, 15 Jul 2019 12:28:05 +0300
In-Reply-To: <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
         <20190715081041.GB31791@lst.de>
         <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
         <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 09:28:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 19:03 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2019-07-15 at 18:43 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2019-07-15 at 10:10 +0200, Christoph Hellwig wrote:
> > > > +	/*
> > > > +	 * Apple 2018 and latter variant has a few issues
> > > > +	 */
> > > > +	NVME_QUIRK_APPLE_2018			= (1 << 10),
> > > 
> > > We try to have quirks for the actual issue, so this should be one quirk
> > > for the irq vectors issues, and another for the sq entry size.  Note that
> > > NVMe actually has the concept of an I/O queue entry size (IOSQES in the
> > > Cc register based on values reported in the SQES field in Identify
> > > Controller.  Do these controllers report anything interesting there?
> > 
> > Ah good to know, I'll dig.
> 
> Interesting... so SQES is 0x76, indicating that it supports the larger
> entry size but not that it mandates it.
> 
> However, we configure CC:IOSQES with 6 and the HW fails unless we have
> the 128 bytes entry size.
> 
> So the HW is bogus, but we can probably sort that by doing a better job
> at fixing up SQES in the identify on the Apple HW, and then actually
> using it for the SQ.
> 
> I checked and CC is 0x00460001 so it takes our write of "6" fine. I
> think they just ignore the value.
> 
> How do you want to proceed here ? Should I go all the way at attempting
> to honor sqes "mandatory" size field (and quirk *that*) or just I go
> the simpler way and stick to shift 6 unless Apple ?
> 
> If I go the complicated path, should I do the same with cq size
> (knowing that no known HW has a non-4 mandatory size there and we don't
> know of a HW bug... yet).
> 
> Cheers,
> Ben.
> 

To be honest, the spec explicitly states that minimum submission queue entry size is 64 
and minimum completion entry size should be is 16 bytes for NVM command set:

"Bits 3:0 define the required (i.e., minimum) Submission Queue Entry size when
using the NVM Command Set. This is the minimum entry size that may be used.
The value is in bytes and is reported as a power of two (2^n). The required value
shall be 6, corresponding to 64."

"Bits 3:0 define the required (i.e., minimum) Completion Queue entry size when using
the NVM Command Set. This is the minimum entry size that may be used. The value
is in bytes and is reported as a power of two (2^n). The required value shall be 4,
corresponding to 16."

Pages 136/137, NVME 1.3d.

In theory the spec allows for non NVM IO command set, and for which the sq/cq entry sizes can be of any size,
as indicated in SQES/CQES and set in CC.IOCQES/CC.IOSQES, but than most of the spec won't apply to it.


Also FYI, values in CC (IOCQES/IOSQES) are for I/O queues, which kind of implies that admin queue,
should always use the 64/16 bytes entries, although I haven't found any explicit mention of that.

Best regards,
	Maxim Levitsky


