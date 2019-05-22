Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E87BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594D121019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nGL4dc1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfEVUOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:14:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39223 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfEVUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:14:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so4012676qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xsp8wzvGVbNyUe9Y5OAaWlxua6wT+LKUIASWlKSGVbI=;
        b=nGL4dc1gVEC3tmIK+yHRAhrBNXmGUN9c3aOPHc9szqf95uzBCtvDBaYoPT9DBMafvK
         PprSmcHkd7F9eFzrN+f1/owIH2BJGh6IIooib2Ab+m+259oNwpXdCWZk67JmedP5T+uC
         4oAmsaH+4xLqYOR8hKF67vABQSz+aj6O2Hoy3hMS9hO8E1b1MS6DSjLPwBKcb+PfSI41
         pnWaV8IX6e5Z/q5Bk54zwqaTTIn+Dg975b8BTK90FfyFdCB3xIAyOjfaxcXQY4OjIzfN
         6bcdt0Z2Cfmt0RvPfHBEnqbuu4b/ALAIwivunpmu2YHF/33rC9HwtfDslceSaNKB2XOc
         4SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xsp8wzvGVbNyUe9Y5OAaWlxua6wT+LKUIASWlKSGVbI=;
        b=IyiPjx0QgXOxGfckdJkdwH3N/mPr5a39iEElkz75tSY2jf6d/qHgaDoe5j2ukSuhyG
         Zbc9IxVYVis//Iyo2yyrQY2fgsVvShdX2ToXQ3vGGh16VUJamDJAU0nfrnY9Ld9QZ4s8
         9W3kbw7JFRskXNZzoZy4ZSMseiM0JMbrREVjF3ae4Wo5T8gzZ2sM+AfXx+G0U80iuO8W
         rv4hd8c/2gvRJLWQ1xMLu/xjqEUYn1MmFJ1AlGaqHbweXG2Q00do1gWlPYvs/uqNmpmw
         SiDOIj0Cw7R1fjI8tKpEg4l6fRxDY0TerYM4rrkvmWeYXF1+91Cb5DqfQ/NcposeG3/6
         ksqA==
X-Gm-Message-State: APjAAAUUgifwOzueszLNmaNATwn8I9j7EEgH8XhFr5T5sDyNt3PSYhn5
        ppVJ0EIu2/ZMAnL466c/pxXQDQ==
X-Google-Smtp-Source: APXvYqxWhyzs4ob0UF21jPfFhWf5ElsU5d4RN1JvTMTbU7miTScFJzApdnBQYv4A4NvxunsO7QzY9A==
X-Received: by 2002:a0c:9679:: with SMTP id 54mr62791182qvy.168.1558556053003;
        Wed, 22 May 2019 13:14:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o64sm12917602qke.61.2019.05.22.13.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 13:14:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTXcq-0003Pl-2D; Wed, 22 May 2019 17:14:12 -0300
Date:   Wed, 22 May 2019 17:14:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit to
 build
Message-ID: <20190522201412.GI6054@ziepe.ca>
References: <20190522145450.25ff483d@gandalf.local.home>
 <20190522192821.GG6054@ziepe.ca>
 <20190522154305.615d1d76@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522154305.615d1d76@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 03:43:05PM -0400, Steven Rostedt wrote:
> On Wed, 22 May 2019 16:28:21 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Wed, May 22, 2019 at 02:54:50PM -0400, Steven Rostedt wrote:
> > > 
> > > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > 
> > > When testing 32 bit x86, my build failed with:
> > > 
> > >   ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > > 
> > > It appears that a few non-ULL roundup() calls were made, which uses a
> > > normal division against a 64 bit number. This is fine for x86_64, but
> > > on 32 bit x86, it causes the compiler to look for a helper function
> > > __udivdi3, which we do not have in the kernel, and thus fails to build.
> > > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Do you like this version better?
> > 
> > https://patchwork.kernel.org/patch/10950913/
> > 
> 
> Honestly, I don't care ;-)
> 
> As long as it is correct and doesn't break my builds. I really prefer
> if these kinds of things don't make it into Linus's tree to begin with.
> I'm surprised the zero-day bot didn't catch this. Because this is
> something that it normally does.

Yes, I was also surprised and I asked them.. They said they needed to
update ARM compilers to see this..

Jason
