Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D16BC352AB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7BF222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569518344;
	bh=Iemf5tRfr5wOSFqa/aWWGJKPJS18KwjXC9W3m7Fd1pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LauXdBPzm6eS1vUtx/nMFQJ7LhHZ+VPwOOiGiFDCLPXZnl0+F56T8LsPJAWvo1iX2
	 ok/cyVyTtxTDFTnjFd5navrYWTa4xlDhxdom3wSV8nofPU3+/5Onm0pdoGb2yog0ap
	 lSc7I2mfOPVclmsXFHyvz3aIFc3oTBQmy25z2svE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfIZRTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfIZRTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:19:03 -0400
Received: from localhost (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73638222C7;
        Thu, 26 Sep 2019 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569518342;
        bh=Iemf5tRfr5wOSFqa/aWWGJKPJS18KwjXC9W3m7Fd1pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0UMPdSphtNsXSVixlIKQElNjAwFdXB0CIEWwEfcwGvIGlmRhn8/AJd2FEnSVlfDu
         Vlt3oaxizv34tN5YIvB165H2FC50Nbc2i9mR6dBdao0kNZfi0ySeeYa8esbWVtbwu7
         A0DJRLq/6PDEGmFTemYnmPBKXbKIxbR3ECuVWwcs=
Date:   Thu, 26 Sep 2019 10:18:01 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Message-ID: <20190926171801.GM3824@vkoul-mobl>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190925210123.GL3824@vkoul-mobl>
 <CH2PR02MB70008CE8600D98753BE1CC97C7860@CH2PR02MB7000.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB70008CE8600D98753BE1CC97C7860@CH2PR02MB7000.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-09-19, 05:52, Radhey Shyam Pandey wrote:

> > > +	 * VDMA and simple mode do not support residue reporting, so the
> > > +	 * residue field will always be 0.
> > > +	 */
> > > +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_VDMA ||
> > !chan->has_sg)
> > > +		return residue;
> > 
> > why not check this in status callback?
> Assuming we mean to move vdma and non-sg check to xilinx_dma_tx_status.
> Just a thought- Keeping this check in xilinx_dma_get_residue provides
> an abstraction and caller can simply call this func with knowing about
> IP config specific residue calculation. Considering this point does it
> looks ok ? 

well you are checking either way, so calling the lower level function
only when you need it makes more sense!

-- 
~Vinod
