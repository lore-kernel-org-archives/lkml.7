Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6651CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404CA2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEOMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:43:12 -0400
Received: from verein.lst.de ([213.95.11.211]:52449 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfEOMnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:43:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5D86867358; Wed, 15 May 2019 14:42:50 +0200 (CEST)
Date:   Wed, 15 May 2019 14:42:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 1/3] USB: use genalloc for USB HCs with local
 memory
Message-ID: <20190515124250.GA13754@lst.de>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com> <20190514143807.7745-2-laurentiu.tudor@nxp.com> <20190514144210.GA14625@lst.de> <f4fc0151-5e49-77fd-7736-37cdfe57c268@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4fc0151-5e49-77fd-7736-37cdfe57c268@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 09:57:12AM +0000, Laurentiu Tudor wrote:
> Glad I could help. On the remoteproc_virtio.c case, I had a cursory look 
> and found out that the dma_declare_coherent_memory() usage was 
> introduced quite recently, by this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=086d08725d34c6b3333db710344ae9c4fdafb2d5

Yes.  I took a look at it to, and while it isn't exactly a clean
usage of the API it at least declares system memory and not a resource.
So it doesn't really affect our plan.
