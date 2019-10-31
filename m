Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC822086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfJaOvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:51:31 -0400
Received: from verein.lst.de ([213.95.11.211]:51457 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfJaOva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:51:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B76EF68C4E; Thu, 31 Oct 2019 15:51:27 +0100 (CET)
Date:   Thu, 31 Oct 2019 15:51:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
Message-ID: <20191031145127.GC6024@lst.de>
References: <20191030152418.23753-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030152418.23753-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:24:18PM +0100, Daniel Wagner wrote:
> All async events are enqueued via nvmet_add_async_event() which
> updates the ctrl->async_event_cmds[] array and additionally an struct
> nvmet_async_event is added to the ctrl->async_events list.
> 
> Under normal operations the nvmet_async_event_work() updates again the
> ctrl->async_event_cmds and removes the corresponding struct
> nvmet_async_event from the list again. Though nvmet_sq_destroy() could
> be called which calles nvmet_async_events_free() which only updates
> the ctrl->async_event_cmds[] array.
> 
> Add a new function nvmet_async_events_process() which processes the
> async events and updates both array and the list. With this we avoid
> having two places where the array and list are modified.

I don't think this patch is correct.  We can have AEN commands pending
that aren't used - that is the host sent the command, but the target
did not have even event yet.  That means the command sits in
async_event_cmds, but there is no entry in >async_events for it yet.

That being said I think what we want is to do the loop in your new
nvmet_async_events_free first, but after that still call the loop in
the existing nvmet_async_events_free after that.  That ensures we first
flush out everything in ->async_events, and then also return any
potential remaining entry.
