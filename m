Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B60C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD920862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbfEVTnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbfEVTnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:43:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096B720856;
        Wed, 22 May 2019 19:43:06 +0000 (UTC)
Date:   Wed, 22 May 2019 15:43:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit
 to build
Message-ID: <20190522154305.615d1d76@gandalf.local.home>
In-Reply-To: <20190522192821.GG6054@ziepe.ca>
References: <20190522145450.25ff483d@gandalf.local.home>
        <20190522192821.GG6054@ziepe.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 16:28:21 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, May 22, 2019 at 02:54:50PM -0400, Steven Rostedt wrote:
> > 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > When testing 32 bit x86, my build failed with:
> > 
> >   ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > 
> > It appears that a few non-ULL roundup() calls were made, which uses a
> > normal division against a 64 bit number. This is fine for x86_64, but
> > on 32 bit x86, it causes the compiler to look for a helper function
> > __udivdi3, which we do not have in the kernel, and thus fails to build.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---  
> 
> Do you like this version better?
> 
> https://patchwork.kernel.org/patch/10950913/
> 

Honestly, I don't care ;-)

As long as it is correct and doesn't break my builds. I really prefer
if these kinds of things don't make it into Linus's tree to begin with.
I'm surprised the zero-day bot didn't catch this. Because this is
something that it normally does.

-- Steve
