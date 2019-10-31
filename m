Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F1CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC84320862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OewjRBc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfJaNip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:38:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfJaNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QkB42TZaY19p2tUWLkDIEWFmICndZjJCiuu8c7FQUq4=; b=OewjRBc9r9Xp8/PXv2ckSWK7N
        WX5KxNtEnxuD88ukmOO+8iDivb6it9c5njv2xdlRHDV3ilOSkq+TQL1eZ8py0NxbpFJIK4xgwK6ux
        7D5//CzzfbuOt0waXy9tZOoZuyaFaj6keBpC0pEGDXq0l0ZpuzSYhyoXX9IBE403iJ2khy33zpTr9
        sJDM3/z9b9fFXeAnO2iZzJx16eN0zkdRxNCAyRmFcOIfHAWM7iod8Jv07lYmHFMQ2Rm4qWOBeNu/q
        QKBxAgivmnYe77smiwpxolIuesXJq2NVe/USj+FRAOM5XgZaMqbOpfLsKJvOXgwLXdGuNFg0qOkS+
        TMOLequjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQAel-0005dF-3D; Thu, 31 Oct 2019 13:38:31 +0000
Date:   Thu, 31 Oct 2019 06:38:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>, mbrugger@suse.com,
        f.fainelli@gmail.com, wahrenst@gmx.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] dma/direct: turn ARCH_ZONE_DMA_BITS into a
 variable
Message-ID: <20191031133831.GA21509@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
 <20191014183108.24804-2-nsaenzjulienne@suse.de>
 <20191030214914.GA15939@infradead.org>
 <8c525f66c1c0d9f07e0cff4948d1ec3229756220.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c525f66c1c0d9f07e0cff4948d1ec3229756220.camel@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:30:36AM +0100, Nicolas Saenz Julienne wrote:
> On Wed, 2019-10-30 at 14:49 -0700, Christoph Hellwig wrote:
> > On Mon, Oct 14, 2019 at 08:31:03PM +0200, Nicolas Saenz Julienne wrote:
> > > Some architectures, notably ARM, are interested in tweaking this
> > > depending on their runtime DMA addressing limitations.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > Do you want me to pick this up for the 5.5 dma-mapping tree, or do you
> > want me to wait for the rest to settle?
> 
> I'd say take it, this will be ultimately needed once we push forward with ARM.

Can you resend a version that applies against 5.4-rc?  The current one
has conflicts in the arm64 code.
