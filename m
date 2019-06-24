Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD57CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A312A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PzI2K5Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfFXG6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:58:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFXG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sTDPzJdQTdSiPCHzqzHaHeH/qwWP4YYe0phj0zN+apc=; b=PzI2K5UzA9qfQuq9sc8Suuwdo
        4c5wpeB76u+bYtLBw0EI2J8CLDXMloPA06LqYxjjHtPEKCu5OfBpopAZvdaj1sbU/2hMLFtPcBjj6
        T8GKgwS5mqzjBCwwB3z7HHprfC84MnjRrM7CXWCciBTps127JL8I/oP1KEvyQA6JkPvWZudDjT97V
        R35mFdnTG/j9boDjC+wzQefnRGDfxH11yIAtEGihKsQfA2xRiyEc3zaH5rHKPjbFGmWMq1tvxkD+R
        HcUklyupmVg7OCOEakDWXHoB/26Dqqi0XcFLQ1p3Pp6NyKBqNK7F1FMhfhEeMFT0KfhxuV4BOxw98
        r5bzm1HnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfIvt-0006Bh-PY; Mon, 24 Jun 2019 06:58:29 +0000
Date:   Sun, 23 Jun 2019 23:58:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190624065829.GA23605@infradead.org>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org>
 <20190611152655.GA3972@kroah.com>
 <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
 <20190616095554.GA5156@infradead.org>
 <CAFCwf11XU1JydbS-wswXBzm4t-fxLjGyXuHCqrNxTsWzLraSZQ@mail.gmail.com>
 <20190617081943.GA11274@infradead.org>
 <CAFCwf11y_K9oKHWkwBGQs1T_S8x+6=tyecpQ-Y7JKs8tQ6oBgA@mail.gmail.com>
 <CAFCwf108WqMPuPqy=QQ72ZVmKNAgWMQ-Nyc=Muea22kkh9E99A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf108WqMPuPqy=QQ72ZVmKNAgWMQ-Nyc=Muea22kkh9E99A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because as a matter of policy the driver has no business knowing the
actual bridge.  Even if we'd agree that a driver workaround would be
the right thing it has to be discoverable by an actual interface and
not a system type or root port PCI ID.
