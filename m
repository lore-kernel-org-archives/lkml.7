Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FCEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956AE20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FNury48j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCS05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:26:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36596 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MpjqHQ2HzGxCVqYxpjy1nZP4w4gLR2IqXxY1B2OAQh0=; b=FNury48jQ7X7qLl/AFXy5qJ4S
        owo8kh1SmkAmaYhT5SKFdEwpRym/t2rWq44jhlw7A71dCyIqKabu5jvK4IFU0Pa23SqZTGbgxnb38
        VD6rK4DEkXhpgxtSbZbNmTTrEPT0rDpbTtgDJHQtnFgQ9EbZH57HnqYVh76K1jhlCakg6kX5+q4lL
        O8WkJ88dfsvQvwaTfrXImGwVh5/aYLuQKUwdo/4+tuygv/fyNhnjAGKru7fYFmnhfq8hFd4IZWJdg
        4rdWBb4DPE7IWJ/0ii5kznUqSrlkcbC0jFv0/KxbHdamqDgMFsXkFh8hCk7HbhLukWI+JXqAgaITV
        iujYs89dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51946)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hBkb3-0004ju-Df; Wed, 03 Apr 2019 19:26:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hBkau-00055z-HH; Wed, 03 Apr 2019 19:26:40 +0100
Date:   Wed, 3 Apr 2019 19:26:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: remove NULL struct device support in the DMA API
Message-ID: <20190403182640.2ca6w2hngjqp35mt@shell.armlinux.org.uk>
References: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:52:28PM -0700, Christoph Hellwig wrote:
> We still have a few drivers which pass a NULL struct device pointer
> to DMA API functions, which generally is a bad idea as the API
> implementations rely on the device not only for ops selection, but
> also the dma mask and various other attributes, and many implementations
> have been broken for NULL device support for a while.

I think I must be missing something, but...

My understanding is that ISA DMA is normally limited to 24 bits of
address - indeed, the x86 version only programs 24 bits of DMA address.
Looking through this series, it appears that the conversions mean that
the DMA mask for ISA becomes the full all-ones DMA mask, which would
of course lead to memory corruption if only 24 bits of the address end
up being programmed into the hardware.

Maybe you could say why you think this series is safe in regard to ISA
DMA?

> 
> This series removes the few remaning users that weren't picked up in
> the last merge window and then removes core support for this "feature".
> 
> A git tree is also available at:
> 
>     git://git.infradead.org/users/hch/misc.git dma-remove-NULL-dev-support
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-remove-NULL-dev-support
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
