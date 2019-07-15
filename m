Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09387C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC38620C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfGOIKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:10:43 -0400
Received: from verein.lst.de ([213.95.11.211]:58764 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbfGOIKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:10:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6670C68B05; Mon, 15 Jul 2019 10:10:41 +0200 (CEST)
Date:   Mon, 15 Jul 2019 10:10:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH] nvme: Add support for Apple 2018+ models
Message-ID: <20190715081041.GB31791@lst.de>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/*
> +	 * Apple 2018 and latter variant has a few issues
> +	 */
> +	NVME_QUIRK_APPLE_2018			= (1 << 10),

We try to have quirks for the actual issue, so this should be one quirk
for the irq vectors issues, and another for the sq entry size.  Note that
NVMe actually has the concept of an I/O queue entry size (IOSQES in the
Cc register based on values reported in the SQES field in Identify
Controller.  Do these controllers report anything interesting there?

At the very least I'd make all the terminology based on that and then
just treat the Apple controllers as a buggy implementation of that model.

Btw, are there open source darwin NVMe driver that could explain this
mess a little better?

> @@ -504,8 +505,11 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
>  static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
>  			    bool write_sq)
>  {
> +	u16 sq_actual_pos;
> +
>  	spin_lock(&nvmeq->sq_lock);
> -	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
> +	sq_actual_pos = nvmeq->sq_tail << nvmeq->sq_extra_shift;
> +	memcpy(&nvmeq->sq_cmds[sq_actual_pos], cmd, sizeof(*cmd));

This is a little too magic.  I think we'd better off making sq_cmds
a void array and use manual indexing, at least that makes it very
obvious what is going on.

> -				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
> +				nvmeq->sq_cmds, SQ_SIZE(nvmeq));

Btw, chaning SQ_SIZE to take the queue seems like something that should
be split into a prep patch, making the main change a lot smaller.

> -	if (!polled)
> +	if (!polled) {
> +
> +		/*
> +		 * On Apple 2018 or later implementations, only vector 0 is accepted

Please fix the > 80 char line.
