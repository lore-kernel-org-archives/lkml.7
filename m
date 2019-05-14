Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4F5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E282085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfENPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:17:41 -0400
Received: from foss.arm.com ([217.140.101.70]:57540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfENPRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:17:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71362374;
        Tue, 14 May 2019 08:17:39 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDAD3F703;
        Tue, 14 May 2019 08:17:37 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
To:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, noring@nocrew.org, JuergenUrban@gmx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
Date:   Tue, 14 May 2019 16:17:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Fredrik, Juergen

On 14/05/2019 15:38, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> For HCs that have local memory, replace the current DMA API usage
> with a genalloc generic allocator to manage the mappings for these
> devices.
> This is in preparation for dropping the existing "coherent" dma
> mem declaration APIs. Current implementation was relying on a short
> circuit in the DMA API that in the end, was acting as an allocator
> for these type of devices.
> 
> Only compiled tested, so any volunteers willing to test are most welcome.

I recall an out-of-tree PlayStation 2 OHCI driver being another 
HCD_LOCAL_MEM user - if Fredrik and Juergen are still active on that, 
hopefully they might be able to comment on whether this approach can 
work for them too. Patchwork link just in case: 
https://patchwork.kernel.org/project/linux-usb/list/?series=117433

Robin.

> 
> Thank you!
> 
> For context, see thread here: https://lkml.org/lkml/2019/4/22/357
> 
> Changes in v2:
>   - use genalloc also in core usb (based on comment from Robin)
>   - moved genpool decl to usb_hcd to be accesible from core usb
> 
> Laurentiu Tudor (3):
>    USB: use genalloc for USB HCs with local memory
>    usb: host: ohci-sm501: init genalloc for local memory
>    usb: host: ohci-tmio: init genalloc for local memory
> 
>   drivers/usb/core/buffer.c     | 12 ++++++-
>   drivers/usb/host/ohci-hcd.c   | 23 +++++++++++---
>   drivers/usb/host/ohci-sm501.c | 60 +++++++++++++++++++----------------
>   drivers/usb/host/ohci-tmio.c  | 23 +++++++++-----
>   include/linux/usb/hcd.h       |  3 ++
>   5 files changed, 80 insertions(+), 41 deletions(-)
> 
