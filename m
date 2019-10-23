Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99587CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600CE2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bP5gy/Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbfJWJUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:20:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389998AbfJWJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=52Jm32jrrusywh/3nqAsIZ0YYBHKi0vZ9VhuEV0cCIA=; b=bP5gy/FfoLW6d56GYc4h+bRVX
        L9MAtKkYul7Ui6vwj8Kpd+3HhjRrHBExFOQM/94qxKspB8OVXc9yZU9DmokRw2ZiBFxB1iVKkvTwH
        Pbqu8XVBnl7RzDKPla608gGz0w7EBm0FXoRFR0eehg25Ry4/eUxjdXZyb4i+zg1bG3ROl037p7myL
        RJe+ACljRKSQ9TQahbGmVkMGq787/xdXrCokB5IHxbBYlBx/pNP9pRKO9OMLpeMAx/I8K8BUc9M6K
        FddMUH5sCvKo2133j+6u5firXeKrcTDAy9Jf6p1j3e/dmJN1QA/6ZwYxcUvxajqOdwLRovfEMoxtM
        tblwX+Vuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNCol-0004T6-FG; Wed, 23 Oct 2019 09:20:35 +0000
Date:   Wed, 23 Oct 2019 02:20:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Message-ID: <20191023092035.GA12222@infradead.org>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022063028.9030-1-oshpigelman@habana.ai>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 06:30:35AM +0000, Omer Shpigelman wrote:
> Changes in v2:
>  - use a boolean parameter to indicate for kernel address rather than
>    calling is_vmalloc_addr, as kernel and user addresses can overlap on
>    some architectures.

That is still broken.  Please use an actual kernel pointer instead of
losing all type safety by casting it an integer type.
