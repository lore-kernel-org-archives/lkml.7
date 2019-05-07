Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502FEC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212A920656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557264497;
	bh=juqCTQTiRc/o2ZeLV/ddvPoaGMauAWgfkKUfr/DZx6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EP6qi+MO1pkcld+fpppGYNyiJEUv7u60WU0e1zeG8UPpTorPRfjzzh+jDs6q4phMm
	 2LgNbzByQHgf9XWdsvN1iVhPcSL6To1p1KEwEsjgZTs6GvrRvQJraKN98/xYMQtU19
	 s4SJSSPkjPPnX1FC+zWqzTD6bXhfeKKlwh5kZK1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfEGV2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:28:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:52636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfEGV2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:28:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 14:28:15 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2019 14:28:14 -0700
Date:   Tue, 7 May 2019 15:22:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/7] nvme-pci: add device coredump support
Message-ID: <20190507212241.GA7113@localhost.localdomain>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
 <a4ec2c1a-1ff7-52fe-07bd-179613411536@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ec2c1a-1ff7-52fe-07bd-179613411536@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 02:31:41PM -0600, Heitke, Kenneth wrote:
> On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > +
> > +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *buf,
> > +					 size_t bytes, loff_t offset)
> > +{
> > +	const size_t chunk_size = ctrl->max_hw_sectors * ctrl->page_size;
> 
> Just curious if chunk_size is correct since page size and block size can
> be different.

They're always different. ctrl->page_size is hard-coded to 4k, while
sectors are always 512b.
