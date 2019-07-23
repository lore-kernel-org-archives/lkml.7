Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B476C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC662239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390872AbfGWQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:32:47 -0400
Received: from verein.lst.de ([213.95.11.211]:43200 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbfGWQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:32:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1084268B02; Tue, 23 Jul 2019 18:32:45 +0200 (CEST)
Date:   Tue, 23 Jul 2019 18:32:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
Message-ID: <20190723163244.GE1655@lst.de>
References: <20190722094426.18563-1-hch@lst.de> <20190723152737.GO15331@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723152737.GO15331@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:27:41PM +0000, Jason Gunthorpe wrote:
> Ignoring the STAGING issue I've tried to use the same guideline as for
> -stable for -rc .. 
> 
> So this is a real problem, we definitely hit the locking bugs if we
> retry/etc under stress, so I would be OK to send it to Linus for
> early-rc.
> 
> However, it doesn't look like the 1st patch is fixing a current bug
> though, the only callers uses blocking = true, so just the middle
> three are -rc?

nonblocking isn't used anywher, but it is a major, major API bug.
Your call, but if it was my tree I'd probably send it to Linus.
