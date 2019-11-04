Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AB9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D9A20842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfKDPaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:30:30 -0500
Received: from verein.lst.de ([213.95.11.211]:39597 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbfKDPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:30:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA19A68BE1; Mon,  4 Nov 2019 16:30:27 +0100 (CET)
Date:   Mon, 4 Nov 2019 16:30:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191104153027.GC17050@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de> <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu> <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com> <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu> <CANSCoS_MX97_JyLkKrZ7YjTS9L+JsZcPsHpoZ-keA8t3W394Dg@mail.gmail.com> <266047531.90300507.1572880575232.JavaMail.zimbra@kalray.eu> <CANSCoS9A1XY4DzdBwGU4+oT-uKvpohxhyWxdJ1ySJ6QKv6moKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSCoS9A1XY4DzdBwGU4+oT-uKvpohxhyWxdJ1ySJ6QKv6moKw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 07:20:43AM -0800, Charles Machalow wrote:
> The thing with that structure is if you use it with the old IOCTL, the
> result will go into rsvd2 instead of the first 32 bits of result.

But if you use the old ioctls on the new structure you can at least
expect that.  And with the added explicit padding it will at least
do the right thing on 32-bit x86 as well.
