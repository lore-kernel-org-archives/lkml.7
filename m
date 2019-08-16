Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C06C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82A32171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565989587;
	bh=CHOCkpoQQkDJgyYKnks0B20Xd0kj+K9F6iwN9Qysbcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hfuX9pAukZJVxY+XgdEE8+0JMpYShSQybuIOQiiCCUSmyRtZpAEYAVbQvLvzp8EVn
	 bYXY8McKvRqQFYLFHBNHnXNe1rCicHp44Yg3nxHr+pJlDFUGjp37Np3ejkwI/xClRN
	 RTNllIhBgHYPSPAMSC121VrTEnHj9WsZrHs+VNf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfHPVGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfHPVGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:06:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639F62133F;
        Fri, 16 Aug 2019 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565989584;
        bh=CHOCkpoQQkDJgyYKnks0B20Xd0kj+K9F6iwN9Qysbcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byMATH9E7U3uZhBNkjUuH7ji+mKtuC/eBtUARcnFSh1beVLZNlgA2k8RtYysflVLx
         GyCP/N3mTKDYKfG0MFuRJIlgvN0hQc6H/IWyeUCY5rwvz5FYqBysanA4OTSZ6K/fgi
         ZJM1MT6M4g0UUjWn3rqLkqdp75HzrqtHPPObUNcs=
Date:   Fri, 16 Aug 2019 14:06:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-Id: <20190816140623.4e3a5f04ea1c08925ac4581f@linux-foundation.org>
In-Reply-To: <20190816123258.GA22140@lst.de>
References: <20190808154240.9384-1-hch@lst.de>
        <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
        <20190816062751.GA16169@infradead.org>
        <20190816115735.GB5412@mellanox.com>
        <20190816123258.GA22140@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 14:32:58 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Aug 16, 2019 at 11:57:40AM +0000, Jason Gunthorpe wrote:
> > Are there conflicts with trees other than hmm?
> > 
> > We can put it on a topic branch and merge to hmm to resolve. If hmm
> > has problems then send the topic on its own?
> 
> I see two new walk_page_range user in linux-next related to MADV_COLD
> support (which probably really should use walk_range_vma), and then
> there is the series from Steven, which hasn't been merged yet.

Would it be practical to create a brand new interface with different
functions names all in new source files?  Once all callers are migrated
over and tested, remove the old code?
