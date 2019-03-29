Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16186C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E048920811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfC2Jov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:44:51 -0400
Received: from verein.lst.de ([213.95.11.211]:51321 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbfC2Jov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:44:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1CEB268CEC; Fri, 29 Mar 2019 10:44:41 +0100 (CET)
Date:   Fri, 29 Mar 2019 10:44:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: add per-device io and admin timeouts
Message-ID: <20190329094440.GA27315@lst.de>
References: <20190329093921.95710-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329093921.95710-1-mheyne@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:39:20AM +0000, Maximilian Heyne wrote:
> Some NVMe devices require specific io and admin timeouts that are
> different from the default, for instance local vs. remote storage.
> 
> This patch adds per-device admin and io timeouts to the nvme_ctrl
> structure and replaces all usages of the module parameters in the PCI
> NVMe driver with the per-device timeouts.

I'm not all against a per-controller override, but if you controllers
really _require_ a different timeout this is not the way to go.

Please talk to the nvme technical working group about exposing a
default timeout in the controller as that is the only way to make
these things work out of box.
