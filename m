Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD35AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A907217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqa/5AWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfFZPic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:38:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+/or7RUo8RlGi5/xsF/irgqT3ptx8jRXk2ETY+C794o=; b=iqa/5AWMRhPrM653o+fAvvzP/
        3Lu11i5qtEA4ol0XFXBypacKt3hMduvti/cE2K/yNgiQ4JRON9meWX+Po+pL5yBo6NP8FgwZSYEFc
        Mdj4WQn2vH6kw8etGhdrkBZHybPguu7XHlfgj+JQix/X/BYr1OfCIztMkG8B2KcHQ05PMK0WbemnH
        v50nvf7jL5fZ2lPZYTnNbtdWlaY7trB2NndBDzJ9Nf+Dm5tLjPQUoHrmoaAT8wTKYmzbFSOO+uUbZ
        F2Bz/idD0WyKulTxAegisbOggsq6y/MYuNqTHpvvgnVktWlVD18xTtxTQlhbkT6gRspskDQF9ZtLw
        6G1KTOdiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgA0D-0006Qo-QY; Wed, 26 Jun 2019 15:38:29 +0000
Date:   Wed, 26 Jun 2019 08:38:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-ID: <20190626153829.GA22138@infradead.org>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626123139.GB20635@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:31:40PM +0100, Mark Rutland wrote:
> On Wed, Jun 26, 2019 at 12:35:33AM -0700, Christoph Hellwig wrote:
> > Robin, Andrew:
> 
> As a heads-up, Robin is currently on holiday, so this is all down to
> Andrew's preference.
> 
> > I have a series for the hmm tree, which touches the section size
> > bits, and remove device public memory support.
> > 
> > It might be best if we include this series in the hmm tree as well
> > to avoid conflicts.  Is it ok to include the rebase version of at least
> > the cleanup part (which looks like it is not required for the actual
> > arm64 support) in the hmm tree to avoid conflicts?
> 
> Per the cover letter, the arm64 patch has a build dependency on the
> others, so that might require a stable brnach for the common prefix.

I guess we'll just have to live with the merge errors then, as the
mm tree is a patch series and thus can't easily use a stable base
tree.  That is unlike Andrew wants to pull in the hmm tree as a prep
patch for the series.
