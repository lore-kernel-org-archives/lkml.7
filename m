Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DDC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAE72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNTqUbcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfHNGOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:14:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNGOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=44K07C207hP60aYqx/O6kvlLTyW56Ovhtuazmf91s3M=; b=XNTqUbczBcUcBbsb2phecwHjD
        /lGxXibOWPO99uMOTbuOoALJusaNcHor07dCMalkCClPs3nQt/P8CvClvz2yHRNX4jZwXF3D+om5T
        vB5pbbOJMSjhtIoVYDrnj3tQf+pOhrr8SDPfu4Z96z5i50/E9jiQ2Q+2uLpwgIkwVNH/AOCANk1H7
        CmOBRSMduJImu+WNej5byXvQHT/nhYc7ifGAGEMMtpK6Ob489BB07q5Q9YbJh16eQQseDdqPzRZU+
        nXjkTeROgopU8iLe44RqQC1qHEvtnpXAgFR9q96FXFTjN/yfjSEtQXPjF6XPwsHg1aBHfRiFsfM3I
        51ChTttGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxmY8-0005Tu-P2; Wed, 14 Aug 2019 06:14:21 +0000
Date:   Tue, 13 Aug 2019 23:14:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 05/10] powerpc/mm: Do early ioremaps from top to
 bottom on PPC64 too.
Message-ID: <20190814061420.GA17453@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr>
 <20190814055525.GA12744@infradead.org>
 <1d44ec1d-339d-e22c-2133-175e0aa745f6@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d44ec1d-339d-e22c-2133-175e0aa745f6@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 08:10:59AM +0200, Christophe Leroy wrote:
> > Note that while a few other architectures have a magic hack like powerpc
> > to make ioremap work before vmalloc, the normal practice would be
> > to explicitly use early_ioremap.  I guess your change is fine for now,
> > but it might make sense convert powerpc to the explicit early_ioremap
> > scheme as well.
> > 
> 
> I've been looking into early_ioremap(), but IIUC early_ioremap() is for
> ephemeral mappings only, it expects all early mappings to be gone at the end
> of init.

Yes.

> PPC installs definitive early mappings (for instance for PCI). How does that
> have to be handled ?

Good question, and no good answer.  I've just been looking at a generic
ioremap for simple architectures, and been finding all kinds of crap
and inconsistencies, and this is one of the things I noticed.
