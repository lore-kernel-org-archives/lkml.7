Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB8620843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l89PZLe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfHNFtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:49:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfHNFtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yLBvjgIz0/4kJcpvkkBD2mhvRhrr916GyFhs+M2+Ar0=; b=l89PZLe3h8ePNmyh0C6eM6wvl
        fuUGOalLN8UJhfga5/x6cM+wfPZjKyP5Rya55baqZOzsQaDLp7ZtDMIikFLTGJo/jvDrqoaEEJso8
        4bSX88LZau5MGKh18xEunO8WFA4fU3P+9LXlt7chI7aR+md32QQUHCsE61yupuvbCWyVZnzzDRmwR
        toolzrEcnVxrJi9pBe/2uCpjXcOzUyZMnSlov9ZZKHDGRhPv60trWYFwKnuLXr+eNoG7iATOE8tjX
        v1TrZew0KtMKapyRN+nODjjWFxz23lJr7W2y5Q7+JksSuUOURqm/FAzzBa/MdsQM8Jxc9jVpz76rT
        DVAssgY+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxmAH-0001Q6-5w; Wed, 14 Aug 2019 05:49:41 +0000
Date:   Tue, 13 Aug 2019 22:49:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/10] powerpc/mm: refactor ioremap_range() and use
 ioremap_page_range()
Message-ID: <20190814054941.GC27497@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow this series is missing a cover letter.

While you are touching all this "fun" can you also look into killing
__ioremap?  It seems to be a weird non-standard version of ioremap_prot
(probably predating ioremap_prot) that is missing a few lines of code
setting attributes that might not even be applicable for the two drivers
calling it.
