Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C3C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A7E206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="llgvZRim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfJJOJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:09:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJJOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t00CB4B7aneZjcEIb9GdT3xuLgUTlGoBlIV60QwAFAI=; b=llgvZRimzB46/10WFD9fxvxap
        dDeZk5Sp6UYN+9iddtNmluGdwe5rA3gen8HLF6Q+r12BubqTr1YrwSJWLWTMrJgmd5yjGM4joFFRO
        LoRlFB99yoJ17CJ79jdBGFzBsPoyb3bwshXCMS5dIKpspheUCsQPwz7axJ4YZ+c0E4LhhLNuHaved
        Np4KVrjD+ErLODLvpyhaEuRmYiz9X+Ja7M1zMO4eTA0qPVV312K9jmT1QMkzrvcGtDt5oy/E1W68I
        pG79vpNcH9W0c6BaNICbsPxCQw1crQHS3nviMYGycVP/10ZRtlIVW3SVoGCU2XAPFHg1HU/ggKjJ1
        DHSXJoQQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIZ8Y-0007n3-Jn; Thu, 10 Oct 2019 14:09:50 +0000
Date:   Thu, 10 Oct 2019 07:09:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Message-ID: <20191010140950.GA27176@infradead.org>
References: <20191010140615.26460-1-oshpigelman@habana.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010140615.26460-1-oshpigelman@habana.ai>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:06:22PM +0000, Omer Shpigelman wrote:
> This patch adds support in mapping of vmalloc memory.
> In contrary to user memory, vmalloc memory is already pinned and has no
> vm_area structure. Therefore a new capability was needed in order to map
> this memory.

Unless I am missing something you mix user and kernel pointers in
your is_vmalloc_addr checks.  That will break on those architectures
that have separate kernel and user address spaces.

> Mapping vmalloc memory is needed for Gaudi ASIC.

How does that ASIC pass in the vmalloc memory?  I don't fully understand
the code, but it seems like the addresses are fed from ioctl, which
means they only come from userspace.
