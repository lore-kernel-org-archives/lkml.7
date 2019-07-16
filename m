Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC415C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F82173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfGPMSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:18:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:56109 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:18:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6GCHu04027160;
        Tue, 16 Jul 2019 07:17:57 -0500
Message-ID: <cca6fd560aa1688ca94fc270310a91ccda9aed06.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Tue, 16 Jul 2019 22:17:56 +1000
In-Reply-To: <20190716120547.GA2388@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
         <20190716004649.17799-2-benh@kernel.crashing.org>
         <20190716060430.GB29414@lst.de>
         <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
         <20190716093301.GA32562@lst.de>
         <bfbc7352951d1adc714f699acb49e298c24fe7e3.camel@kernel.crashing.org>
         <20190716120547.GA2388@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 14:05 +0200, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 08:58:28PM +1000, Benjamin Herrenschmidt wrote:
> > The main risk is if existing controllers return crap in SQES and we try
> > to then use that crap. The rest should essentially be NOPs.
> > 
> > Maybe I should add some kind of printk to warn in case we use/detect a
> > non-standard size. That would help diagnosing issues.
> 
> Given that the spec currently requires bits 0 to 3 of SQES to be 6
> we might as well not check SQES and just hardcode it to 6 or 7 depending
> on the quirk.  That actually was my initial idea, I just suggested using
> the SQES naming and indexing.

If we're going to do that, then I can move it back to pci.c and leave
core.c alone then I suppose. Up to you. I'm just doing that for fun, no
beef in that game :-) let me know how you want it.

Cheers,
Ben.


