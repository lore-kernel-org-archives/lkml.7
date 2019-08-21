Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA8FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7571D22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VKHzMGGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfHUCRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:17:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUCRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x0KsQxDJ6UzbBe97a0jSJDgAMBuv/qkUKnrZnnyaHkk=; b=VKHzMGGz4ESmSfpJnl8OA8mFc
        a1QmyFZ6npDIF7i3DJx2ZoZHrOMl93Pxn6aTTpZdyTXjUrK9LBzjuTfHPcDSyfQQmCGO1Edvh1y/n
        cQ7QmZv+RavMPkwmqz2UX+5FXsixpThM3u7GhHm3cToF0xyjFesuAEgnXrkWLj87seYgpuabQZF0W
        p3pal6vpIjVv3NOwYbjWEcd+klxulnR0QVpxo0Al6xGCOgzUs0aB+uPbXYNAXama48B2YI1tLIkf6
        1hGcxEwrEjOGLaQrI2HdYJgPRl/rdpX1Ht+EVhK0sX61l9WPhxTUGU/RMyZEF3ynaegkpdwqrObAi
        kw0h0Exxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0GBx-0003dA-VB; Wed, 21 Aug 2019 02:17:41 +0000
Date:   Tue, 20 Aug 2019 19:17:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 3/3] csky: Support kernel non-aligned access
Message-ID: <20190821021741.GB32710@infradead.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
 <1566304469-5601-3-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566304469-5601-3-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:34:29PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> We prohibit non-aligned access in kernel mode, but some special NIC
> driver needs to support kernel-state unaligned access. For example,
> when the bus does not support unaligned access, IP header parsing
> will cause non-aligned access and driver does not recopy the skb
> buffer to dma for performance reasons.
> 
> Added kernel_enable & user_enable to control unaligned access and
> added kernel_count  & user_count for statistical unaligned access.

If the NIC drivers requires this it is buggy.  Kernel code must
use the get_unaligned* / put_unaligned* helpers for that.
