Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6769C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C992216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566301500;
	bh=GKU0MqwQ9Eq5z11rsh56hpHg91nSDePZNnrM6N3PfEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=juUZTwWNOVPxSmVb7tG0VTxB0ZWvS8rZ86rs/W5jy4dXL9hEEwjxcVXbx1Q0AH7S2
	 Y8JZxfbt3PccunekFvWfwXfEjQApezIomkKAnyOhgtEVlQKLQdF1DYI/CBCmY6p0z2
	 6btfwElc/gX5uCzwTV2b+Fxz6X8Gr3+3jHtxv2Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfHTLpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfHTLo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:44:59 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B30214DA;
        Tue, 20 Aug 2019 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301498;
        bh=GKU0MqwQ9Eq5z11rsh56hpHg91nSDePZNnrM6N3PfEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQ8+vsWVr97/c7XjDPDGts5rbdcrIM18/Iv9B+D3c6US6KDG8XJUVnV2EAj4JvAKS
         auCfxGnkrfKrRpUM/MRZk7+LwR4XGn9unVB8nc1AYoOzv2VUDR+YLCuAqjgK/a56fH
         xZzIJPWoXBCIzbgl+FTm1RBB8K5Y8Yl+fUYzzh7s=
Date:   Tue, 20 Aug 2019 17:13:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: ti: dma-crossbar: Fix a memory leak bug
Message-ID: <20190820114346.GX12733@vkoul-mobl.Dlink>
References: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-19, 01:48, Wenwen Wang wrote:
> In ti_dra7_xbar_probe(), 'rsv_events' is allocated through kcalloc(). Then
> of_property_read_u32_array() is invoked to search for the property.
> However, if this process fails, 'rsv_events' is not deallocated, leading to
> a memory leak bug. To fix this issue, free 'rsv_events' before returning
> the error.

Applied, thanks

-- 
~Vinod
