Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96174C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEB12086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565877936;
	bh=1kLslZhODIOulMF95Mp3GaT4eL4PAbLGzgh4kOzOGWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sHX5rnvkKArOswusOSYesxKo/pS9izQggO4heDkxyK87E0zzXe4QyWV3WMrN7phXg
	 4cfKLIibjVQ6K4Q6ieeWl+6O3DJLu1vhAj+s0sl4nuI+AWCDPN0YL1ZDi46jS76YS7
	 JD3bs9ubK8nXsBsvO3ZGR41BpM6cH8b0UHFeaRyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfHOOFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732211AbfHOOFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:05:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9C020644;
        Thu, 15 Aug 2019 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565877933;
        bh=1kLslZhODIOulMF95Mp3GaT4eL4PAbLGzgh4kOzOGWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=au9iTmh4J8UTOc/8JXy+/eWQAjp7807F+MVsQsyk2FspuCs3ijzAs+yYvR79zYMXc
         z6XJ68TrNJvxhcbMetWA6k4e8L6wIipTDZxHLgzSqAEJT8wJEPhU68Kr+olj41dMuN
         +vDfTSqYffB6Z5lL4uyC4aStHyB4Elgi4sBLqCGw=
Date:   Thu, 15 Aug 2019 16:05:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geoff Levand <geoff@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olav Kongas <ok@artecdesign.ee>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: next take at setting up a dma mask by default for platform
 devices
Message-ID: <20190815140531.GC7174@kroah.com>
References: <20190811080520.21712-1-hch@lst.de>
 <20190815132318.GA27208@kroah.com>
 <20190815132531.GA12036@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815132531.GA12036@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:25:31PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 03:23:18PM +0200, Greg Kroah-Hartman wrote:
> > I've taken the first 2 patches for 5.3-final.  Given that patch 3 needs
> > to be fixed, I'll wait for a respin of these before considering them.
> 
> I have a respun version ready, but I'd really like to hear some
> comments from usb developers about the approach before spamming
> everyone again..

Spam away, we can take it :)
