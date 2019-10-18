Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D19CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD5F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571385543;
	bh=r9mIGNyICLZKduhVIr2wJ2+qRiOFioKTV4sTZSUNf3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ncue+h4UmocPCp3Jq4gbqfkFSoITUjDx2q/G2bOxaDG4/7DCY0bNstcwc5Ek+p6T6
	 cGbJeK7uOGbB354phWYVq60zYwREHiWYmr73EWuazrYxP34ytgFM1t89FFYMSnSUtm
	 UxQ9kgPQOkuCm9a5qkUUFCul6J+vpZHSOIDNVMxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405516AbfJRH7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbfJRH7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:59:00 -0400
Received: from localhost (unknown [106.200.243.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DED7D21897;
        Fri, 18 Oct 2019 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571385539;
        bh=r9mIGNyICLZKduhVIr2wJ2+qRiOFioKTV4sTZSUNf3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jruileM5WG9ou5fFTu2c50e/SsvPW9vAVRA2x9RoEOb9Xpg7VC5on6WTuJSFi6umb
         /X4BOrkAB4MfipWflUnbeusBocDcFdDOqwKHMdbsFc65EFdd49YwfygMv/1RpTh/6H
         zB06aBSif9CCW1lX9f4mdX4IMw7fniSfNJh8AEUw=
Date:   Fri, 18 Oct 2019 13:28:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Fix resource leak
Message-ID: <20191018075855.GP2654@vkoul-mobl>
References: <20191017152606.34120-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017152606.34120-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 08:26, Jeffrey Hugo wrote:
> bam_dma_terminate_all() will leak resources if any of the transactions are
> committed to the hardware (present in the desc fifo), and not complete.
> Since bam_dma_terminate_all() does not cause the hardware to be updated,
> the hardware will still operate on any previously committed transactions.
> This can cause memory corruption if the memory for the transaction has been
> reassigned, and will cause a sync issue between the BAM and its client(s).
> 
> Fix this by properly updating the hardware in bam_dma_terminate_all().

Applied and marked stable, thanks

-- 
~Vinod
