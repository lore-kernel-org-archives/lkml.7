Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7692C208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCHNYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:24:01 -0500
Received: from verein.lst.de ([213.95.11.211]:53812 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfCHNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:24:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 01E4668C4E; Fri,  8 Mar 2019 14:23:55 +0100 (CET)
Date:   Fri, 8 Mar 2019 14:23:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-core: Share code between nvme_wait_ready() and
 nvme_shutdown_ctrl()
Message-ID: <20190308132355.GA18218@lst.de>
References: <20190207001312.13672-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207001312.13672-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:13:12PM -0800, Andrey Smirnov wrote:
> Code polling NVME_CSTS_SHST_CMPLT in nvme_shutdown_ctrl() is very
> similar to polling loop in nvme_wait_ready(). Move shared polling loop
> code into __nvme_wait_ready() and re-implement both
> nvme_shutdown_ctrl() and nvme_wait_ready() on top of it to avoid code
> repetition.

Is there any deeper reason why we would want this?  It only saves
6 lines of code, but makes the functions much harder to read.
