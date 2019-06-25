Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572C20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfFYKIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:08:46 -0400
Received: from verein.lst.de ([213.95.11.211]:33408 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYKIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:08:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 45AF768C65; Tue, 25 Jun 2019 12:08:10 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:08:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190625100810.GH1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-12-hch@lst.de> <20190624154601.GK5387@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624154601.GK5387@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 08:46:01AM -0700, Darrick J. Wong wrote:
> This looks like a straight code copy from fs/xfs/ into fs/iomap.c.
> That's fine with me, but seeing as this file is now ~2700 lines long,
> perhaps we should break this up among major functional lines?
> 
> Looking at fs/iomap.c, I see...
> 
>  * Basic iomap iterator functions (~40 lines)
>  * Page cache management (readpage*, write, mkwrite) (~860 lines)
>  * Zeroing (~80 lines)
>  * FIEMAP and seek hole / seek data (~300 lines)
>  * directio (~500 lines)
>  * swapfiles (~170 lines)
>  * and now, page cache writeback (~520 lines)
> 
> If I have spare time this week (ha ha) I'll see if I can break all this
> up (as a separate patch series), so for this:

Meh.  Not sure I'm a fan of too fine grained splits like the one
above.  And ~3k lines is still pretty manageable.  But yes, once it
grows むore it might be worth splitting a bit.
