Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E215C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EF72084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfB1WmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:42:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55358 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfB1WmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:42:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B44D8A78;
        Thu, 28 Feb 2019 14:42:13 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 611903F720;
        Thu, 28 Feb 2019 14:42:12 -0800 (PST)
Subject: Re: [PATCH] Revert "of/device: Really only set bus DMA mask when
 appropriate"
To:     Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alistair23@gmail.com" <alistair23@gmail.com>
References: <20190228223257.6189-1-alistair.francis@wdc.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <056edacd-a998-277c-f0de-1aac256165a2@arm.com>
Date:   Thu, 28 Feb 2019 22:42:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228223257.6189-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-28 10:33 pm, Alistair Francis wrote:
> This reverts commit 6778be4e520959659b27a441c06a84c9cb009085.
> 
> Reverting the commit fixes these error messages and an non-functioning
> USB bus when attaching a USB to PCIe card to a RISC-V board:
>      xhci_hcd 0000:03:00.0: Host took too long to start, waited 16000 microseconds.
>      xhci_hcd 0000:03:00.0: startup error -19
>      xhci_hcd 0000:03:00.0: USB bus 2 deregistered
>      xhci_hcd 0000:03:00.0: WARNING: Host System Error
>      xhci_hcd 0000:03:00.0: remove, state 1
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> I'm not sure if this is the correct fix, it's possible something else is
> wrong, but I wanted to get some feedback.

Given that the bug which this revert would reintroduce cripples DMA on 
just about every 64-bit DT system, probably not. Can you clarify what 
your DT looks like, and turn on the debug output for of_dma_get_range() 
to see what it says?

Robin.

> drivers/of/device.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 3717f2a20d0d..8299f8055da7 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -149,11 +149,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>   	 * set by the driver.
>   	 */
>   	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> +	dev->bus_dma_mask = mask;
>   	dev->coherent_dma_mask &= mask;
>   	*dev->dma_mask &= mask;
> -	/* ...but only set bus mask if we found valid dma-ranges earlier */
> -	if (!ret)
> -		dev->bus_dma_mask = mask;
>   
>   	coherent = of_dma_is_coherent(np);
>   	dev_dbg(dev, "device is%sdma coherent\n",
> 
