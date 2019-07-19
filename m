Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66271C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361312173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sI6liOEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGSGcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:32:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfGSGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WybkyjUrQ9N6AtNgh2oW7UCNiPMoPSi8Rfxq1jvS6sI=; b=sI6liOEo5b8ADps8vl/o0Syy8
        IRtsJigw1mZ3TGwzhV3Mo4+PobAMJn7BFG4kNw8ZR/Utn9hfCbsnA0jjZJK0gmhlE9mUveuN38czV
        lr+4yt3vvdA1F4U5Q8ExE+56LsR7ZwbWE4yJZ7lmUqNWMpKSdwUYeKdrmNRZlLmTRPmqhMO5HX+Hy
        7HEW6dqLsqsULcNg9vxrXf9Kw5cNVY+cD0PJiExlMmthL+QB8S1UcWZj05QjHp9PVYdNv/6uoSYF9
        w+LL9eBor/WycwceVOUeOu75klzOTzDwYMlDHW5gSVExKmz2b8UiUsal6AhCJDZwT8zrhKtZDt5ZG
        g9tnU/6nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoMRm-0002gn-Ql; Fri, 19 Jul 2019 06:32:50 +0000
Date:   Thu, 18 Jul 2019 23:32:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Clement Leger <cleger@kalray.eu>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Message-ID: <20190719063250.GA9545@infradead.org>
References: <20190612095521.4703-1-cleger@kalray.eu>
 <20190701070245.32083-1-cleger@kalray.eu>
 <20190702132229.GA8100@infradead.org>
 <58c8b8bd30a949678c027eb42a1b1bbb@SFHDAG7NODE2.st.com>
 <20190708184546.GA20670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708184546.GA20670@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:45:46AM -0700, Christoph Hellwig wrote:
> > But that's breaking legacy as all platforms will have to add a virtio device node in
> > their DT file...
> > 
> > Is it aligned with your view ?
> 
> Yes, that is how I'd assume it works.  But given that until recently
> you did now have these subdevices for dma coherent purposes we can't
> really break anything older than that, so I might still be missing
> something.

Any chance we could expedite this?  remoteproc is the only driver
inheriting dma ops to subdevices, and the only one using
dma_declare_coherent_memory.  I'd really like to clean this mess up
rather sooner than later.
