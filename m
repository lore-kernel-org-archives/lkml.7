Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EB1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3322D6D
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfHaPaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:30:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:2873 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfHaPaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:30:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 08:30:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; 
   d="scan'208";a="265606221"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2019 08:30:50 -0700
Date:   Sat, 31 Aug 2019 09:29:11 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190831152910.GA29439@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831000139.7662-1-logang@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 06:01:39PM -0600, Logan Gunthorpe wrote:
> To fix this, assign the subsystem's instance based on the instance
> number of the controller's instance that first created it. There should
> always be fewer subsystems than controllers so the should not be a need
> to create extra subsystems that overlap existing controllers.

The subsystem's lifetime is not tied to the controller's. When the
controller is removed and releases its instance, the next controller
to take that available instance will create naming collisions with the
subsystem still using it.
