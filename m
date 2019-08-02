Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98111C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679DA206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395051AbfHBViB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:38:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56230 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfHBViA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:38:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE1CD68AFE; Fri,  2 Aug 2019 23:37:56 +0200 (CEST)
Date:   Fri, 2 Aug 2019 23:37:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: please revert "drm/msm: Use the correct dma_sync calls in msm_gem"
Message-ID: <20190802213756.GA20033@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I just saw your above commit in Linus' tree, which is completely
bogus and misunderstand the DMA API. Next time you have any issues
please Cc the relevant maintainers and mailing lists.  But even
more importantly get_dma_ops is an completely internal API, and
whatevet your helpers are trying to do is bad - if the dma wasn't
mapped at the time you call the new sync_for_device helper, this
is broken because you can't call dma_sync_sg_for_device on unmapped
address.  If it was mapped it is bogus as well as you can't double
map it.  Please describe what you're actually trying to fix and we're
going to work on a proper solution, but this shot from the hip is just
going to make things worse.
