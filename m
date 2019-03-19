Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B606C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000D0213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553005509;
	bh=ShJrO75kVwVfj0TZZkY25BHwM7NrVg9eygGGfJtKH2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+NMbGig6V9r+Pnp14s8dsmNYFDXcGbF6VEuukGXE77H/N2DnbmEBHv42T9qrghDS
	 XSLLGDIogWlk/YG7EqrXJZkdk/iZviH1sBqKM9D98vwfqdM1YOLpSku3oF95ORaQsq
	 kpvo2VAQhWS14/Kg/+HE9U7LMvotGO5LhEAK2IZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfCSOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfCSOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:25:07 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3DA2133D;
        Tue, 19 Mar 2019 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553005506;
        bh=ShJrO75kVwVfj0TZZkY25BHwM7NrVg9eygGGfJtKH2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1Vt2pZ4YXOsVZTHEO9lx9M5N1zdr81U6O1zpTLsdZdBkyarkr3kYKibJmudFabr6
         t+8T1hUsJlb72osycB9mvyfjZ6TMb6MKkh+JJEghpaL7i6p2Bt6ZD2DRRZr1STXKY5
         SRo1tUM3ocisdMYcYnWTa/QWJ1ReIrScmrSTE+vM=
Date:   Tue, 19 Mar 2019 15:25:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: idma64: Use actual device for DMA transfers
Message-ID: <20190319142503.GA13758@kroah.com>
References: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 06:39:30PM +0300, Andy Shevchenko wrote:
> Intel IOMMU, when enabled, tries to find the domain of the device,
> assuming it's a PCI one, during DMA operations, such as mapping or
> unmapping. Since we are splitting the actual PCI device to couple of
> children via MFD framework (see drivers/mfd/intel-lpss.c for details),
> the DMA device appears to be a platform one, and thus not an actual one
> that performs DMA. In a such situation IOMMU can't find or allocate
> a proper domain for its operations. As a result, all DMA operations are
> failed.
> 
> In order to fix this, supply parent of the platform device
> to the DMA engine framework and fix filter functions accordingly.
> 
> We may rely on the fact that parent is a real PCI device, because no
> other configuration is present in the wild.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the tty/serial/ portion:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
