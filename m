Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1009921019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfEVVA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:00:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729937AbfEVVA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:00:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4870AD78;
        Wed, 22 May 2019 21:00:55 +0000 (UTC)
Message-ID: <1558558075.2470.2.camel@suse.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jaewon Kim <jaewon31.kim@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Wed, 22 May 2019 22:47:55 +0200
In-Reply-To: <Pine.LNX.4.44L0.1905221055190.1410-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1905221055190.1410-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2019-05-22 at 10:56 -0400, Alan Stern wrote:
> On Wed, 22 May 2019, Oliver Neukum wrote:
> 
> > I agree with the problem, but I fail to see why this issue would be
> > specific to USB. Shouldn't this be done in the device core layer?
> 
> Only for drivers that are on the block-device writeback path.  The 
> device core doesn't know which drivers these are.

Neither does USB know. It is very hard to predict or even tell which
devices are block device drivers. I think we must assume that
any device may be affected.

	Regards
		Oliver

