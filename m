Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B43C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC12054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfGOInm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:43:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:60195 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbfGOInl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:43:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6F8hQwi025286;
        Mon, 15 Jul 2019 03:43:27 -0500
Message-ID: <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
Subject: Re: [PATCH] nvme: Add support for Apple 2018+ models
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Mon, 15 Jul 2019 18:43:25 +1000
In-Reply-To: <20190715081041.GB31791@lst.de>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
         <20190715081041.GB31791@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 10:10 +0200, Christoph Hellwig wrote:
> > +	/*
> > +	 * Apple 2018 and latter variant has a few issues
> > +	 */
> > +	NVME_QUIRK_APPLE_2018			= (1 << 10),
> 
> We try to have quirks for the actual issue, so this should be one quirk
> for the irq vectors issues, and another for the sq entry size.  Note that
> NVMe actually has the concept of an I/O queue entry size (IOSQES in the
> Cc register based on values reported in the SQES field in Identify
> Controller.  Do these controllers report anything interesting there?

Ah good to know, I'll dig.

> At the very least I'd make all the terminology based on that and then
> just treat the Apple controllers as a buggy implementation of that model.

Yup, sounds good. I'll poke around tomorrow.

> Btw, are there open source darwin NVMe driver that could explain this
> mess a little better?

You wish...

> > @@ -504,8 +505,11 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
> >  static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
> >  			    bool write_sq)
> >  {
> > +	u16 sq_actual_pos;
> > +
> >  	spin_lock(&nvmeq->sq_lock);
> > -	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
> > +	sq_actual_pos = nvmeq->sq_tail << nvmeq->sq_extra_shift;
> > +	memcpy(&nvmeq->sq_cmds[sq_actual_pos], cmd, sizeof(*cmd));
> 
> This is a little too magic.  I think we'd better off making sq_cmds
> a void array and use manual indexing, at least that makes it very
> obvious what is going on.

Ok. That's plan B as I described in the message. There's an advantage
to do that, it merges the indexing shift and the quirk shift into one.

I'll look into it & respin

> > -				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
> > +				nvmeq->sq_cmds, SQ_SIZE(nvmeq));
> 
> Btw, chaning SQ_SIZE to take the queue seems like something that should
> be split into a prep patch, making the main change a lot smaller.

Sure. Will do.

> > -	if (!polled)
> > +	if (!polled) {
> > +
> > +		/*
> > +		 * On Apple 2018 or later implementations, only vector 0 is accepted
> 
> Please fix the > 80 char line.

Ok.

Thanks for the review.

Cheers,
Ben.


