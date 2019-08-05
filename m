Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3ABC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A91B21743
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfHESl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:41:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:9687 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfHESlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:41:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 11:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="349187188"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2019 11:38:29 -0700
Date:   Mon, 5 Aug 2019 12:35:58 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>,
        Jens Axboe <axboe@fb.com>, Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Message-ID: <20190805183557.GA22859@localhost.localdomain>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
 <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
 <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
 <20190805134907.GC18647@localhost.localdomain>
 <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:27:54AM -0700, Sagi Grimberg wrote:
> 
> > > Ping ? I had another look today and I don't feel like mucking around
> > > with all the AQ size logic, AEN magic tag etc... just for that sake of
> > > that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
> > > to make much of a difference in practice anyway.
> > > 
> > > But if you feel strongly about it, then I'll implement the "proper" way
> > > sometimes this week, adding a way to shrink the AQ down to something
> > > like 3 (one admin request, one async event (AEN), and the empty slot)
> > > by making a bunch of the constants involved variables instead.
> > 
> > I don't feel too strongly about it. I think your patch is fine, so
> > 
> > Acked-by: Keith Busch <keith.busch@intel.com>
> 
> Should we pick this up for 5.3-rc?

Probably not. While I don't think this is a risky patch set, it's not
a bug fix for anything we introduced during the merge window. Christoph
also stated he wanted this to go in the 5.4 merge window.
