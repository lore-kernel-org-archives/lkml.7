Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF5C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F1A23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ACtDIJSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfH3PqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:46:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3PqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wePmmyRAqzc9E8AvYvRy4CjZhcBEJxH2FmSPiZPoaEw=; b=ACtDIJSRM2EBOX+MHFb+Pg7Gj
        okiQGHIbGoDwFEpUIcFKrJ5P2TzxRrH8kQt1x1ttlmn8Hi6EYwnOS5wxfPX12SyRasM7GrLFcfwGx
        SpmwqgAHfveVdSQRIdU/UNLxWv8nu5nF0S836rOWWjtWiQyyofMPsjTctBlFlFLwk0O+rjXPPnoeG
        0IU3703HDn+vjNLkMF6/eqk5amnwC0IUBIaE9ezBMcoSxbwHmp0lqRizsJo4jiPkejwxITaV14R6V
        VyhLyMS9aa2J98Zbwpo/kX8fZcwV27B+kZWNwBCvhPEgnijY51i27p6dW51LFFz8No1uGrBKNHO6J
        1NLVlItmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3j5z-0005dZ-2P; Fri, 30 Aug 2019 15:45:51 +0000
Date:   Fri, 30 Aug 2019 08:45:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v2 2/7] erofs: some marcos are much more readable as a
 function
Message-ID: <20190830154551.GA11571@infradead.org>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-2-gaoxiang25@huawei.com>
 <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 08:16:27PM -0700, Joe Perches wrote:
> > -		sizeof(__u32) * ((__count) - 1); })
> > +static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
> > +{
> > +	unsigned int icount = le16_to_cpu(d_icount);
> > +
> > +	if (!icount)
> > +		return 0;
> > +
> > +	return sizeof(struct erofs_xattr_ibody_header) +
> > +		sizeof(__u32) * (icount - 1);
> 
> Maybe use struct_size()?

Declaring a variable that is only used for struct_size is rather ugly.
But while we are nitpicking: you don't need to byteswap to check for 0,
so the local variable could be avoided.

Also what is that magic -1 for?  Normally we use that for the
deprecated style where a variable size array is declared using
varname[1], but that doesn't seem to be the case for erofs.
