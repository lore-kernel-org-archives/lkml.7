Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F403C2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qILK04ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfFRJN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:13:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19235 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfFRJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:13:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08ab560001>; Tue, 18 Jun 2019 02:13:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 02:13:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 02:13:58 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 09:13:56 +0000
Subject: Re: [PATCH V2] i2c: tegra: disable irq in tegra_i2c_xfer_msg
To:     Bitan Biswas <bbiswas@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        <linux-i2c@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Shardar Mohammed <smohammed@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>
References: <1560847368-16069-1-git-send-email-bbiswas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <61c2dbcd-85f2-2094-7596-78ac01f55421@nvidia.com>
Date:   Tue, 18 Jun 2019 10:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560847368-16069-1-git-send-email-bbiswas@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560849238; bh=wILUXSk3M+mIm+w2CtNgTykFq01uFJEP4Obi9FpU5M0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qILK04eeri8qQhFnL8rV1025VphF23Pt0ebqRmRec0O4R8TFSsRfzTy28jnfnvIj9
         zMrBtEMPVNA+T1GMHLGrsKgYU+wm63D2+eF4XttWRnAwXav8R/A5Za1iNEi3k3+1JT
         tn/+l9ahEz/TDk6bqTA5/g2vpV7w0zd4zvXxko0JXrrFl0PDz2OeAzPxUWSy9FVh/q
         oJMaNWcgYHNJP8hsLT/40FEPG+5OFoJA7gRPMvWvAEpHYAGXIX/SADyTkstOlB/nrk
         dLw+7Nx/VbJOnodrxgQ2VPh62IFMvvjEfmjO+feJ8lt9OcYInSyBHYcWvfJRwy4z9e
         U6rw0SXSMoHQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2019 09:42, Bitan Biswas wrote:
> tegra_i2c_xfer_msg initiates the I2C transfer in DMA
> or PIO mode. It involves steps that need FIFO register
> access, DMA API calls like dma_sync_single_for_device, etc.
> Tegra I2C ISR has calls to tegra_i2c_empty_rx_fifo in PIO mode
> and in DMA/PIO mode writes different I2C registers including
> I2C interrupt status. ISR cannot start processing
> before the preparation step at tegra_i2c_xfer_msg is complete.
> Hence, a synchronization between ISR and tegra_i2c_xfer_msg
> is in place today using spinlock.
> 
> Spinlock busy waits and can add avoidable delays.
> 
> In this patch needed synchronization is achieved by disabling
> I2C interrupt during preparation step and enabling interrupt
> once preparation is over and spinlock is no longer needed.
Sorry but I still don't understand the problem you are trying to solve.
Yes spinlocks are busy waits but is this busy wait an actual problem? If
so what is the problem with this?

It appears that the spinlock was added to prevent error interrupts
occurring until the transfer has started. If this is for error cases,
then probably it is not often that the CPU is stuck busy waiting on the
spinlock.

Furthermore, in addition to the spinlock we also have calls to
tegra_i2c_unmask_irq/tegra_i2c_mask_irq. Therefore, if we are going to
change this it would seem like a good idea to consolidate the
masking/unmasking of IRQs and the spinlock, if possible.

Finally, I still see that we have a spinlock in the downstream kernels
we are shipping and so I would prefer to see such a change also be
tested in the downstream kernels we are releasing.

Cheers
Jon

-- 
nvpublic
