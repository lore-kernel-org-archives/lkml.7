Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC4CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE3F2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJaN7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:59:07 -0400
Received: from verein.lst.de ([213.95.11.211]:51144 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbfJaN7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:59:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5339068BE1; Thu, 31 Oct 2019 14:59:04 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:59:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        marta.rybczynska@kalray.eu, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191031135904.GA5180@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de> <CANSCoS8rN6g7u6iG4SRTcXjdj68cbimvX1n1Ex+FBAkhAAivJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSCoS8rN6g7u6iG4SRTcXjdj68cbimvX1n1Ex+FBAkhAAivJA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 06:55:33AM -0700, Charles Machalow wrote:
> Not quite sure what you mean by check for zero in the ioctl handler. I like
> the idea of being able to use the same struct for either the original or 64
> ioctls from userspace. I don't believe adding the explicit rsvd field
> allows that.

You might like the idea, but it fundamentally is a bad idea.  For example
you completely break architectures that do not support unaligned loads
and stores.
