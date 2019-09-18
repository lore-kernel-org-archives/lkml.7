Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF323C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7388E21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568826490;
	bh=G32la0/Uj46Si9JMGEgwbmCiq3XWbFpIxwtdy37oWGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLBWzKB35ibEP/KNH8zM9CRhsff9EsbGJ9zJnHbmgeZHSpqCLdjN57q0n7L2vFjYk
	 6H5mu4um8BahEvXjd6U8ACmnp/C+gn39RXdiFPDSpBscQKwBSnpLRzbrOr0FWZDZKH
	 wL01QEJroVQoeYEIuRcgQ0hK+Ca+4oX1SCGTlJrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfIRRIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfIRRIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:08:09 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE93520665;
        Wed, 18 Sep 2019 17:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568826489;
        bh=G32la0/Uj46Si9JMGEgwbmCiq3XWbFpIxwtdy37oWGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YP2Yqo7A+koYz2c0hxGZWLyAtwlLvVGPuowlGAe8Oxuzos29a5n15XvP2WSACUtF4
         pM3ZQ7G/mmiXf5s9lQ1w+w+KmvZvV997vH2ORoIeMMda7cK13y0zwAoDXs5WviUnX5
         /4C893hbfXv6atKsV30Y0YVVUZ6x1CmhNQNnC2RA=
Date:   Wed, 18 Sep 2019 11:08:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Baldyga, Robert" <robert.baldyga@intel.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rakowski, Michal" <michal.rakowski@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190918170807.GA50966@C02WT3WMHTD6>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
 <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
 <20190918132611.GA16232@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918132611.GA16232@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:26:11PM +0200, Christoph Hellwig wrote:
> Even if we had a use case for that the bounce buffer is just too ugly
> to live.  And I'm really sick and tired of Intel wasting our time for
> their out of tree monster given that they haven't even tried helping
> to improve the in-kernel write caching layers.

Right, I don't have any stake in that out-of-tree caching either. I am
more just interested in trying to get Linux to generically reach as many
NVMe spec features as possible, and extended formats have been in-spec
since the beginning of nvme.

And yes, that bouncing is really nasty, but it's really only needed for
PRP, so maybe let's just not ignore that transfer mode and support
extended metadata iff the controller supports SGLs. We just need a
special SGL setup routine to weave the data and metadata.
