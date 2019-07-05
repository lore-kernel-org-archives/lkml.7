Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DDC4649A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FB021721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562304337;
	bh=mtXsvHvLDkWbJ9xgmQLic9CLP84bbrhMy2js7vuIlmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wRO9WK++JlVcKRdqndyZHYDeLmOyUYox8ykgEIl/nKTVERhqViCJutCtoxqXgj4tb
	 e5keTlx/WSrk+zZ0xMprUKWvBxv5yXpWfNcNF+ckSKvFb0BFQklToPA69TPWaXwbUF
	 I8F5D7ZDCUKzKaxA20ONLskQLJ8H/7ODWgS5X1VE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGEFZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfGEFZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:25:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95CA21721;
        Fri,  5 Jul 2019 05:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562304334;
        bh=mtXsvHvLDkWbJ9xgmQLic9CLP84bbrhMy2js7vuIlmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThThFvL+Z4Ju45y7D8IlcJ857mOE01Tjyomvi+D6wjtVHOmyvvaA5eCULOVTG8aEB
         e6lelSwMxMeeUwN0SdwnJ3fd8r0+Jf2ht/9VeUqgeGcXbbUfn5sDMbNx++nV5gRIFv
         wOxSVjo/8T291lzMf9OIWmA3xxK8WPb+1KEb/8Z0=
Date:   Fri, 5 Jul 2019 07:24:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-iommu: no need to check return value of
 debugfs_create functions
Message-ID: <20190705052425.GA8544@kroah.com>
References: <20190704143649.GA11697@kroah.com>
 <20190704153551.GG3310@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704153551.GG3310@8bytes.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 05:35:52PM +0200, Joerg Roedel wrote:
> On Thu, Jul 04, 2019 at 04:36:49PM +0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Warning, not even test-built, but "should" work :)
> 
> It almost did :)
> 
> > +	debugfs_create_file("regs", 0400, d, obj, &attrregs_fops);
> > +	debugfs_create_file("tlb", 0400, d, obj, &attrtlb_fops);
> > +	debugfs_create_file("pagetable", 0400, d, obj, &attrpagetable_fops);
> 
> The _fops were named without the 'attr' prefix, changed that and it
> compiled. Patch is now applied.

Ah, so close :)

Thanks for fixing it up and applying it!

greg k-h
