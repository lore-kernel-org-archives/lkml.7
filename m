Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C24C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22862171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i+neshkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbfB1OZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:25:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfB1OZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G4X2ZiLU7B33DnhaTnVeog/cj9ygwjHiAP8mCmj9Eqo=; b=i+neshkAh4jIOoiciWGaq1FZsp
        tzpvNaGUkQfb4JemQmRPqftp+jIN68LquJuME3penAkgjd6cNaNa4IYBWcK3adD217r2e8E/lTi76
        rL+sf4yQC3dkEGqypNPHD0g1cjXqEs6aohjgsTf6u6R+Se6tT380Gbg+0yw480yKLFxKXUpT+x+xs
        GaV6k3uHC4+r6wnrJ4CmjvvI0Mcjp5VFg8yXAGfkF/jSdSPZa7wRbZcApw61FIKSdBu9IXqfJvJyi
        t0yZozRqfzDLv58zYSfYu3PIaMUFM/2ejGPNXxj7DRyz/FtSJ6zVSh4VSZngwelN6Zwjw6wrP4Gz6
        pqQXqC2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzMcc-0001Rk-MY; Thu, 28 Feb 2019 14:25:14 +0000
Date:   Thu, 28 Feb 2019 06:25:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] net: ethernet: reduce calls to memset(,0)
Message-ID: <20190228142514.GB18319@infradead.org>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:04:54PM -0800, Robert Eshleman wrote:
> This patch series removes calls to memset(,0) that are
> redundant when used in conjunction with a zalloc call or
> by simple zero-assignment of structs.

NAK.  pci_zalloc_consistent is just as deprecated as
pci_alloc_consistent, and if you look at the implementation you'll
see that we actual zero the memory for both of them.

If you want to do some DMA-related busy work please just bulk convert
drivers from the PCI DMA API to the proper generic DMA API.  Bonus
points for automatіng that using a cocchinelle script.
