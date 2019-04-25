Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84901C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB62067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfDYOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:32:53 -0400
Received: from verein.lst.de ([213.95.11.211]:34931 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYOcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:32:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0BCB568B20; Thu, 25 Apr 2019 16:32:36 +0200 (CEST)
Date:   Thu, 25 Apr 2019 16:32:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Slaby <jslaby@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        "kernel-janitors@vger.kernel.org H Hartley Sweeten" 
        <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Message-ID: <20190425143235.GD16790@lst.de>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de> <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk> <20190425141832.GA16643@lst.de> <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:31:01PM +0100, Ian Abbott wrote:
> On 25/04/2019 15:18, Christoph Hellwig wrote:
>> On Thu, Apr 25, 2019 at 03:13:49PM +0100, Ian Abbott wrote:
>>> So for comedi_isadma, we can just replace the NULL with a pointer to a
>>> static dummy device with a 24-bit coherent mask?
>>
>> It should be converted to a proper isa_driver, so that it gets a real
>> struct device.
>
> But it will work as a short term solution?  comedi_isadma isn't a driver, 
> but is used by a few comedi drivers for ISA cards.

Then convert the drivers properly and pass on the device from them.
