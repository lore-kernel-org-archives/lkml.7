Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCDA218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQC9CSec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfB1O0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbfB1O0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HEs5axV892K6nYaUjh28uqou6pnSDGNSj/z37uwPTKQ=; b=dQC9CSec/QOYSlSgrTwmosoQr
        tOdzyAC5iiXdHeU//lb8MEOizsMvJoFDLXlrsxUhyEGHBwRoPUZi5+SMBeKCUJK2XqoPPXmtegMK2
        GjXuVhFM1TlGDMFQndO26y2DbmEthClYQowDnb73cIpNP2V0YaFUcN6b9uM0DXhfV7cJWr2ONxd/f
        +NMhkO3uET0wsRIuazyfFa9LlzJsnfC+N6ODr1U3h/60xyjEyjVgR/vwhxwCsiDHSIe527eTkkkKD
        OYQjVZOz9xM3Mmk14CNDuVYPsX7tGDUlpPLdgOPspdtD5y9kGkNgXDg75VyPu0+RcmtQxotj9NN0J
        EmDkq+7bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzMda-0002Tw-QG; Thu, 28 Feb 2019 14:26:14 +0000
Date:   Thu, 28 Feb 2019 06:26:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "bhole_prashant_q7@lab.ntt.co.jp" <bhole_prashant_q7@lab.ntt.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
Message-ID: <20190228142614.GC18319@infradead.org>
References: <20190227085050.30000-1-alexandru.ardelean@analog.com>
 <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
 <CAHp75VdgwM_ybfymh28iqxu2qOfzZo79VOF+XE+brj70Aji6YQ@mail.gmail.com>
 <26f1c0d1a7d98a6a41301d58e53bd9abc1d2f5c9.camel@analog.com>
 <CAHp75Vcup+UUYmqo7stwC4FOmG3GWqOOuewmmG_dSiDoeBms7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcup+UUYmqo7stwC4FOmG3GWqOOuewmmG_dSiDoeBms7w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 04:15:37PM +0200, Andy Shevchenko wrote:
> > https://patchwork.kernel.org/patch/10814527/
> >
> > But, I can rework this patch to work without the helper.
> 
> Ah, okay, worth to mention this in comments (in addition to what you
> put about the patch below).

Just include the patch adding the helper in the series.
