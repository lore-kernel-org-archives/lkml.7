Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CBDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FED233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567119369;
	bh=0kUMYx7gzVlJowquO77IfOfcqdoB3q98qT54dRfDbCg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=2RwiRO1rW5yYp1kZbbKsa5RxJxt5l8KkNIzLgbk3qLpAQbFTP9WjrcpTbhdNQtByG
	 4ERdwLRPutVPIQ5xQrmuJ1mo5Hpfi1mcmEF0B40SmOzIsd6Nryp6YtUk2Jk9RaEDNa
	 H4fFhChLPgb/Dftm2In8yc3N6jXBED2GwuPViW44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfH2W4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfH2W4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:56:07 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A082189D;
        Thu, 29 Aug 2019 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567119366;
        bh=0kUMYx7gzVlJowquO77IfOfcqdoB3q98qT54dRfDbCg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=EqimipHf7BH6EosF+GwoK6BM8E2syjcI0kMZftzMiYm6rAZSnLaWOt686dkvfGR/T
         9IkxHwg9ivTMCQi2vw/hoW7Ups6jtlB+W006m6+Xm+1RpSUCK4StjNRtFJvRRfnwIg
         in2Z0zXILN00ru92/mCbUQrfTw7f3x/nZElUXS60=
Date:   Thu, 29 Aug 2019 15:55:59 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: swiotlb-xen cleanups v2
In-Reply-To: <20190826121944.515-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908291554270.4927@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> Hi Xen maintainers and friends,
> 
> please take a look at this series that cleans up the parts of swiotlb-xen
> that deal with non-coherent caches.
> 
> Changes since v1:
>  - rewrite dma_cache_maint to be much simpler
>  - improve various comments and commit logs
>  - remove page-coherent.h entirely

Thanks for your work on this, it really makes the code better. I tested
it on ARM64 with a non-coherent network device and verified it works as
intended (Cadence GEM on ZynqMP).
