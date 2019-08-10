Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472CC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FF7218A4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZtaR225x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfHJIWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:22:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eSjbW2TykUVvNLJT+WwW0KK/90QAdp/KYaHkJ5L32Sw=; b=ZtaR225x4uz8WxQcy84b810BY
        5V+gDiuwCXnmFGv531/0uJ+JtsxoOyc4WUlx88PAp0kWYV2EJM1WOf2uhGSiJCrApIieirGn/7/1P
        x8KJHXwWoy4jU7Zv40qx/fDwd4WWFfHsrHQ5hHQ7ej/C86hdlUYDnfxU+KWCZdx2574gDHZfT52mc
        T13VqO8BrX8ifrzsx9W08gzc0RvAyva8DNT8eDa+AIalU3S/jsiHBMPv+/i+3q1y8bTG0aaksDvk7
        0LzShH4aAubD1qehsZQS0ANehoF8iOW4P6CU9kkz/WqXq40YZHJB624GVEIzmXBfkKNumHJxrsKjR
        sfp+7+lTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwMdU-0003xB-BC; Sat, 10 Aug 2019 08:22:00 +0000
Date:   Sat, 10 Aug 2019 01:22:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: use virtio_max_dma_size
Message-ID: <20190810082200.GC30426@infradead.org>
References: <20190808153445.27177-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808153445.27177-1-kraxel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 05:34:45PM +0200, Gerd Hoffmann wrote:
> We must make sure our scatterlist segments are not too big, otherwise
> we might see swiotlb failures (happens with sev, also reproducable with
> swiotlb=force).

Btw, any chance I could also draft you to replace the remaining
abuses of swiotlb_max_segment and swiotlb_nr_tbl in drm with proper
dma level interface?
