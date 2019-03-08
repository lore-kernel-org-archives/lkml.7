Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D522C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F170920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGR4/N+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfCHOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:01:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfCHOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CQNOn7VRqNPMAB2dx+aofnzJJUlSNmuQ0diFqFsNhJU=; b=rGR4/N+Vd6xxc6KFkER24mL1I
        Btf7M+xK04ci5qfbVtNR77Y8YOfofZfAqomckriBqnMDnUG57ZZJpwadgwJ+TF8RGhfaPmVluggMJ
        H6kntA77+jq2iSdir+A0H2+jLqB/dK9vX2rzMPaARGUa81HzO5ZgRMZvRhQccP7/wxMX9q4EcHkzz
        Reu6LMd5KOl1lubLpZazi3pOJB+tYhrw0obM8UmybNRmWaodIrrdkrsni8KW/S3Rmp9tfbrS2ADX9
        zm99OLxQsZKW4BRjqz0UIifAO5GvD96WI5v/GV6E5NG6JOoQqB0Q7C8k/0YXFIXH3jWLxEO9vPoVu
        OlhjfGV1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2G4E-0003Ma-UF; Fri, 08 Mar 2019 14:01:42 +0000
Date:   Fri, 8 Mar 2019 06:01:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: use KERNEL_DS instead of get_ds()
Message-ID: <20190308140142.GA1971@infradead.org>
References: <20190301200835.18286-1-jannh@google.com>
 <20190302034017.GM2217@ZenIV.linux.org.uk>
 <CAHk-=wjJ1vY9Gte01+YhEOuKHbd=u4zwPxRCOfuiHw-kMvE26Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJ1vY9Gte01+YhEOuKHbd=u4zwPxRCOfuiHw-kMvE26Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 04:23:06PM -0800, Linus Torvalds wrote:
> Your script is disgusting, and I will not quote it for posterity for
> that reason. I will just say that git has a "path exclusion" thing
> that you can use to make it much more streamlined.
> 
> And I ended up going a bit further, and just got rid of it all in
> commit 736706bee329 ("get rid of legacy 'get_ds()' function")

Any chance we could just retire the legacy FS/DS names that are
horribly misleading these days?  E.g. turn the whole thing into:

	uaccess_kernel_enable();

	...

	uaccess_kernel_disable();

which for now turn into the existing calls with a nesting counter
in task_struct, with the hopes of cleaning all that mess up
eventually.
