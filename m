Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E92C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C2C2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfGOKBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:01:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:50397 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfGOKBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:01:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6FA15xe030672;
        Mon, 15 Jul 2019 05:01:06 -0500
Message-ID: <c82b6aa094f1681272ec1e2a55e47758c435f784.camel@kernel.crashing.org>
Subject: Re: [PATCH] nvme: Add support for Apple 2018+ models
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Paul Pawlowski <paul@mrarm.io>
Date:   Mon, 15 Jul 2019 20:01:05 +1000
In-Reply-To: <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
         <20190715081041.GB31791@lst.de>
         <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
         <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
         <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 12:28 +0300, Maxim Levitsky wrote:
> 
> To be honest, the spec explicitly states that minimum submission queue entry size is 64 
> and minimum completion entry size should be is 16 bytes for NVM command set:
> 
> "Bits 3:0 define the required (i.e., minimum) Submission Queue Entry size when
> using the NVM Command Set. This is the minimum entry size that may be used.
> The value is in bytes and is reported as a power of two (2^n). The required value
> shall be 6, corresponding to 64."

Yes, I saw that :-) Apple seems to ignore this and CC:IOSQES and
effectively hard wire a size of 7 (128 bytes) for the IO queue.

> "Bits 3:0 define the required (i.e., minimum) Completion Queue entry size when using
> the NVM Command Set. This is the minimum entry size that may be used. The value
> is in bytes and is reported as a power of two (2^n). The required value shall be 4,
> corresponding to 16."
> 
> Pages 136/137, NVME 1.3d.
> 
> In theory the spec allows for non NVM IO command set, and for which the sq/cq entry sizes can be of any size,
> as indicated in SQES/CQES and set in CC.IOCQES/CC.IOSQES, but than most of the spec won't apply to it.
> 
> 
> Also FYI, values in CC (IOCQES/IOSQES) are for I/O queues, which kind of implies that admin queue,
> should always use the 64/16 bytes entries, although I haven't found any explicit mention of that.

Right, and it does on the Apple HW as well.

Cheers,
Ben.


