Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFEFC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2FC2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbfHFJNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:13:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40517 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:13:31 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1huvX7-00050Y-Ll; Tue, 06 Aug 2019 11:13:29 +0200
Message-ID: <1565082809.2323.24.camel@pengutronix.de>
Subject: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:13:29 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I just found a regression where my NVMe device is no longer able to set
up its HMB.

After subject commit dma_direct_alloc_pages() is no longer initializing
dma_handle properly when DMA_ATTR_NO_KERNEL_MAPPING is set, as the
function is now returning too early.

Now this could easily be fixed by adding the phy_to_dma translation to
the NO_KERNEL_MAPPING code path, but I'm not sure how this stuff
interacts with the memory encryption stuff set up later in the
function, so I guess this should be looked at by someone with more
experience with this code than me.

Regards,
Lucas
