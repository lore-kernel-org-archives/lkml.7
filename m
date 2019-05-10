Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562EC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3006420881
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfEJPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:53:58 -0400
Received: from verein.lst.de ([213.95.11.211]:53299 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfEJPx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:53:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 785A668C65; Fri, 10 May 2019 17:53:36 +0200 (CEST)
Date:   Fri, 10 May 2019 17:53:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] prerequisites for device reserved local mem
 rework
Message-ID: <20190510155335.GA32010@lst.de>
References: <20190510145646.10078-1-laurentiu.tudor@nxp.com> <e6410453-9ca3-4bdc-3c74-654333f2806f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6410453-9ca3-4bdc-3c74-654333f2806f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 04:03:37PM +0100, Robin Murphy wrote:
> Hi Laurentiu,
>
> On 10/05/2019 15:56,  wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> For HCs that have local memory, replace the current DMA API usage
>> with a genalloc generic allocator to manage the mappings for these
>> devices.
>> This is in preparation for dropping the existing "coherent" dma
>> mem declaration APIs. Current implementation was relying on a short
>> circuit in the DMA API that in the end, was acting as an allocator
>> for these type of devices.
>>
>> Only compiled tested, so any volunteers willing to test are most welcome.
>
> Based on my diggings into this in the past, I would expect that you need to 
> do something about hcd_alloc_coherent() as well.

Yep.  And it might make sense to share the code for that and the
ohci internal allocations with a helper.
