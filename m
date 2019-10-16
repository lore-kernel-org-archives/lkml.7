Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3BECE58E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B4F217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571202527;
	bh=jKNLfVYIQbE7clkP9PEh2yGL1A1P2qJTYScbWHJpYCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMvEkT1qzdTBavVyImj8R7Eo1MpADG6J20a6IHlA0Bsq6g0bN13xsBdRwG9qvtleH
	 c0mfXgkIIRC0bSuZc/uOrrC8L5GB1piTMMNvbNIfMbYw2KNenOhnOsu9jd4veT9+57
	 YArn3WlNvxlgyV5t5HEpgg5GC70Vu3ijB7c4DZmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfJPFIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfJPFIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:08:47 -0400
Received: from localhost (unknown [171.76.123.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9302168B;
        Wed, 16 Oct 2019 05:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571202526;
        bh=jKNLfVYIQbE7clkP9PEh2yGL1A1P2qJTYScbWHJpYCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+szEqQtxgSq/xFMmw3WjWUUGhCRS1GAhjSZlRHiooWMM0YTeXWsHKKQ0DR1JidN0
         Rf+WxzVc28RTDuygqyJliSUu3sSvukvp/NlfYh1M6XMKtnjqRcTf/SGNKasvZ7Bx2m
         ha9Hc9zObkvKPrbM54gfLQKGuSl2Z6lYRBnk2nM8=
Date:   Wed, 16 Oct 2019 10:38:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alencar.fmce@imbel.gov.br" <alencar.fmce@imbel.gov.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Message-ID: <20191016050841.GA2654@vkoul-mobl>
References: <20190913145404.28715-1-alexandru.ardelean@analog.com>
 <20191014070142.GB2654@vkoul-mobl>
 <4384347cc94a54e3fa22790aaa91375afda54e1b.camel@analog.com>
 <20191015104342.GW2654@vkoul-mobl>
 <4428e1fa-1a2a-5a5f-ada8-806078c8da94@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4428e1fa-1a2a-5a5f-ada8-806078c8da94@metafoo.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-19, 23:06, Lars-Peter Clausen wrote:

> >> This DMA controller is a bit special.
> >> It gets synthesized in FPGA, so the configuration is fixed and cannot be
> >> changed at runtime. Maybe later we would allow/implement this
> >> functionality, but this is a question for my HDL colleagues.
> >>
> >> Two things are done (in this order):
> >> 1. For some paramters, axi_dmac_parse_chan_dt() is used to determine things
> >> from device-tree; as it's an FPGA core, things are synthesized once and
> >> cannot change (yet)
> >> 2. For other parameters, the axi_dmac_detect_caps() is used to guess some
> >> of them at probe time, by doing some reg reads/writes
> > 
> > So the question for you hw folks is how would a controller work with
> > multiple slave devices, do they need to synthesize it everytime?
> > 
> > Rather than that why cant they make the peripheral addresses
> > programmable so that you dont need updating fpga everytime!
> 
> The DMA has a direct connection to the peripheral and the peripheral
> data port is not connected to the general purpose memory interconnect.
> So you can't write to it by an MMIO address and	 there is no address
> that needs to be configured. For an FPGA based design this is quite a
> good solution in terms of resource usage, performance and simplicity. A
> direct connection requires less resources than connection it to the
> central memory interconnect, while at the same time having lower latency
> and not eating up any additional bandwidth on the central memory connect.

thanks for explanation!

> So slave config in this case is a noop and all it can do is verify that
> the requested configuration matches the available configuration.

okay so noop it is!

-- 
~Vinod
