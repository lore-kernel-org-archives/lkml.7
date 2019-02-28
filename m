Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC548C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/LXIMx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfB1OAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:00:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbfB1OAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YDUWC7wUujpAzTqYlp/PqlL1MRgZJoeqqg0wLYhDrLk=; b=X/LXIMx4HY4qQMsMjFotJlJRb
        2I87RAq5nlSXvqp7qTCMcDj/xmWroVBZWV4o3t/cxwaMJGEfFHdrmRhKAuhT9avyZvNnDJmfmpQ/4
        ssPkeGkvKzvW46u7OOE9K18m/ivtlu0/Y1mMSo/hhOTg5+F+Zn0LrROlD0YohSwMA/r8fEAidqd7y
        rmedK7u+KouxMg7aUole9UUlYED80n5D8/nz4Ee8224e6nEunejGf+guLxH9kBa9kc7iivb29oQG2
        XBuUVE0XtmZCV+zVk4tBKwYMC2KfYiLvc0RM+b7erh7mBHygfxip8Y7+T5Spk9w1o305tWA2+qUSn
        Sqgwk08oQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzMEv-0000Rt-8i; Thu, 28 Feb 2019 14:00:45 +0000
Date:   Thu, 28 Feb 2019 06:00:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 5/8] at12: use pci_zalloc instead of pci_alloc
Message-ID: <20190228140045.GA24819@infradead.org>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
 <485f61fd135d56e6e0c66ec41770ce7e5b8b219e.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485f61fd135d56e6e0c66ec41770ce7e5b8b219e.1551246708.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:09:52PM -0800, Robert Eshleman wrote:
> This patch replaces a pci_alloc and memset(,0) call
> with a single call to pci_zalloc.

Please don't move from one deprecated API to another one.  If you feel
like cleaning up DMA API calls please move to dma_alloc_coherent,
and do that for the whole DMA API usage.
