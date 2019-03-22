Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF90C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8l8n4VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfCVN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:27:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbfCVN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=81yvs8kO6tiD9h8Dy7JbJzun2fOk0TIuC3WMn0e/lv4=; b=Z8l8n4VY0qahgfyLYsFIvnr1x
        gpLVu4bNJq5D1jZICYDm+b0WTDee87qym4G3B63vBu22XFuHFi/GnDObaQqKdTr0CgzxtKl/7M+BQ
        pC0i/HwQzVJuVhJkWC+HcbQtyFIzT+aOpzwapcO9O1jjnMNaNWaFbHvSO3+JZuSsLm7ohqISq/FaB
        Dz/LGKkPg75L7oN/ALehw1on6sB1KDINj9AwP6X+aI+0G7zWTmGoq53wiMlfc3/LWradwvkmKF8PJ
        wycWOAtXt4+RCobrr0D+EudWAHD9eRNOD1+LucMexLc+Uy3Or5GKhMmafmAdJyQtiZD9B78ey8VAD
        M7fzouC8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7KD6-00089C-No; Fri, 22 Mar 2019 13:27:48 +0000
Date:   Fri, 22 Mar 2019 06:27:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip: plic: Fix priority base offset
Message-ID: <20190322132748.GD19263@infradead.org>
References: <20190320223853.1209-1-alistair.francis@wdc.com>
 <20190320234858.GA5304@infradead.org>
 <CAKmqyKPsoi7F_NNLKcm269=VAgdvsUV7HdF3dtkpMBzaKbHhtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKPsoi7F_NNLKcm269=VAgdvsUV7HdF3dtkpMBzaKbHhtA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 05:04:58PM -0700, Alistair Francis wrote:
> > Well, it starts at 0x00, but the first one is reserved.  If you think
> > that is too confusing I'd rather throw in a comment explaining this
> > fact rather than making the calculating more complicated.
> 
> It doesn't mention that it starts at 0 when you look here:
> https://sifive.cdn.prismic.io/sifive%2F834354f0-08e6-423c-bf1f-0cb58ef14061_fu540-c000-v1.0.pdf

It doesn't say that.  But it is completely obvious from the map,
and from how everything else works.  In this case I think the
documentation is simply written in a confusing way, and we need to fix
it once we have an official riscv spec level documentation of this
hardware.
