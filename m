Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F43C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D821920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfIRRKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:10:02 -0400
Received: from verein.lst.de ([213.95.11.211]:34657 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfIRRKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:10:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB71568B05; Wed, 18 Sep 2019 19:09:56 +0200 (CEST)
Date:   Wed, 18 Sep 2019 19:09:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Baldyga, Robert" <robert.baldyga@intel.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rakowski, Michal" <michal.rakowski@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190918170956.GA19639@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com> <20190913143709.GA8525@lst.de> <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com> <20190916073455.GA25515@lst.de> <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com> <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com> <20190918132611.GA16232@lst.de> <20190918170807.GA50966@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918170807.GA50966@C02WT3WMHTD6>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:08:07AM -0600, Keith Busch wrote:
> And yes, that bouncing is really nasty, but it's really only needed for
> PRP, so maybe let's just not ignore that transfer mode and support
> extended metadata iff the controller supports SGLs. We just need a
> special SGL setup routine to weave the data and metadata.

Well, what is the point?  If people really want to use metadata they
should just buy a drive supporting the separate metadata pointer.  In
fact I haven't had to deal with a drive that only supports interleaved
metadata so far given how awkward that is to deal with.  But based on
the discussions here it seems Intel is stupid enough to ship such a thing.
