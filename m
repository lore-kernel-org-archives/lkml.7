Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48CAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987022464D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jin1Ceu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfLBRAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:00:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G2ll8x21H3OwfR6X73OWEUXv71XKn2fRqBpOxb8mfV8=; b=jin1Ceu89T016/r57qJ2013T1
        hr1+t0iWlp+orW8JGDLHPv23c8AqgtSjLpocGr/ZnxxnFPEr74z/yAfYrJYh6c097LzAzkhZb+CRW
        iZpTGwMLzjCXcK90KmToPX6phwgXBVCTTpAIDVhcL4kmMwKb23mqiUrL5xWRAoJD3Kkk//jAYfqFH
        zt0ZtF+d8xP5Kp8S2ve+ptn9bOC1kWdkBeaI6set11hILW3ZWuNX8VguaykW67r3nZZrfRPhPvOmJ
        G4M94kGTyCgt81ywBOrEXIo6VSlxxmeRzQi/yhZf+S6Gq6nvcYSVJXMPb148ryREcJHx4jwPvMbOw
        MCiah4RJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibp3T-0000jZ-A1; Mon, 02 Dec 2019 17:00:11 +0000
Date:   Mon, 2 Dec 2019 09:00:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     joro@8bytes.org, Alex Deucher <alexander.deucher@amd.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Message-ID: <20191202170011.GC30032@infradead.org>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129142154.29658-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> 
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> the same here to avoid screen flickering on 4K monitor.

Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
identity map the GPU device?
