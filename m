Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF9DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26AC2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfKDP3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:29:20 -0500
Received: from verein.lst.de ([213.95.11.211]:39585 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDP3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:29:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 396F668BFE; Mon,  4 Nov 2019 16:29:17 +0100 (CET)
Date:   Mon, 4 Nov 2019 16:29:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Charles Machalow <csm10495@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191104152916.GB17050@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de> <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu> <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com> <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu> <20191104150151.GA26808@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104150151.GA26808@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 12:01:51AM +0900, Keith Busch wrote:
> On Mon, Nov 04, 2019 at 03:56:57PM +0100, Marta Rybczynska wrote:
> > ----- On 4 Nov, 2019, at 15:51, Charles Machalow csm10495@gmail.com wrote:
> > 
> > > For this one yes, UAPI size changes. Though I believe this IOCTL
> > > hasn't been in a released Kernel yet (just RC). Technically it may be
> > > changeable as a fix until the next Kernel is released. I do think its
> > > a useful enough
> > > change to warrant a late fix.
> > 
> > The old one is in UAPI for years. The new one is not yet, right. I'm OK
> > to change the new structure. To have compatibility you would have to use
> > the new structure (at least its size) in the user space code. This is
> > what you'd liek to do?
> 
> Charles is proposing only to modify the recently introduced 64-bit ioctl
> struct without touching the existing 32 bit version. He just wanted the
> lower 32-bits of the 64-bit result to occupy the same space as the 32-bit
> ioctl's result. That space in the 64-bit version is currently occupied
> by an implicit struct padding.

Except on 32-bit x86, which does not have the padding.  Which is why
the current layout is so bad, as it breaks 32-it x86 compat.
