Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE72175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556136790;
	bh=WYh+kk/1twNMT0mmd6W48OSv9HDGzbHgY45yeOjOBqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZZEuqCjpI0FJEtBFHEHk13QovnHzADuCpFvnz2CunUgsEtvJP0ENyfhLQ0kWQGJY
	 9NDyB5rnBcJA625/JSgnp0kfCY/J29RZdXOQaV2xbY592LFNRc8yKjeeT7AcQWVTA9
	 cZ7TthCyeAAnEsFAaF6znuvxZqZrndQB/rFPM7Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfDXUNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:13:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:56592 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDXUNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:13:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 13:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="167600792"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2019 13:13:07 -0700
Date:   Wed, 24 Apr 2019 14:07:06 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Maximilian Heyne <mheyne@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Amit Shah <aams@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Adding per-controller timeout support to nvme
Message-ID: <20190424200706.GB15412@localhost.localdomain>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:55:16AM -0700, Sagi Grimberg wrote:
> 
> > As different nvme controllers are connect via different fabrics, some require
> > different timeout settings than others. This series implements per-controller
> > timeouts in the nvme subsystem which can be set via sysfs.
> 
> How much of a real issue is this?
> 
> block io_timeout defaults to 30 seconds which are considered a universal
> eternity for pretty much any nvme fabric. Moreover, io_timeout is
> mutable already on a per-namespace level.
> 
> This leaves the admin_timeout which goes beyond this to 60 seconds...
> 
> Can you describe what exactly are you trying to solve?

I think they must have an nvme target that is backed by slow media
(i.e. non-SSD). If that's the case, I think it may be a better option
if the target advertises relatively shallow queue depths and/or lower
MDTS that better aligns to the backing storage capabilies.
