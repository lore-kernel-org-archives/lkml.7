Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFEF2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryr4eWHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfH2S7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:59:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40055 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfH2S7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:59:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so2070478pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3qNdsy+RA8q5xEKIekaterX1FMMD41w6Pyv+N6rQvM=;
        b=Ryr4eWHNakM79Uz5IF+shdCAGHLvxz+qHwYhVYS5GxwXavW6MOFOTSUealV+NvDYen
         PHrOFCF21p1YXkfFXnXaLBro1auhCw9R6KnpLk9lAdLVu5OJGGVhM03AosfNbuTn/kyz
         v4B5PzKt/ZhHkQR58J6/umPhXhxfih3PctvYD6BO7X18UI/9HFTkxtM94rMcAPyO6vNn
         KBFVnwVlkumWteaX1t17ehT6FWvNuWZVUq6e+to4qTaDHYXOOCFFlUEqNZl9VRKamTvS
         SeD1Il092xMIrn+n6AlCRxVVDx0U/P9w763tTH+vIPBJcIGMlDV7pvEk8AwLxidWvDF0
         lyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3qNdsy+RA8q5xEKIekaterX1FMMD41w6Pyv+N6rQvM=;
        b=i56pE8jDRZ9ib16jkTd/xDITPjtJ3mBmU6SXyoBoFy1Ye9R5DkatbuD72hIrxr8aGa
         jOC/3IlrY9BaL0ncEl8JqTRtbkRbVzGVoPkan+9rcz3tvafdbMwPqlg4Clli7QB1EZau
         QBhkoqoVjZHahGUskVd+AxlTiZkHDQAZQ+IOKpDzkqDDJr6o3uI6SbP9o0wBw+iE1Rlx
         wSCkUfHn0fTqCQkGYUrXty5tK3O2PDsqeyT32nM8jl0tDs6iai5mdfFMCfMqomZyzLqS
         DVmzILtRLCtN7NPGiJj4pK0MrE0gUI79iFjf723mKObXBKFYvtUvV6zn/vS++sdx5Dot
         ismw==
X-Gm-Message-State: APjAAAVw97ofZNJ2QA3hFSzn7PsE/d6Dz0U010LS5qDLHp9tP140nr52
        n/vMdgo1UV+xFmu9rgyeMA==
X-Google-Smtp-Source: APXvYqxAgO1aXnb8LpUxDik+ZPEub6ZSujBoieCX5UO9w0IcvSYwK7FUPYEVitI6Mld6z8OxPlBGRA==
X-Received: by 2002:a63:6146:: with SMTP id v67mr10147635pgb.271.1567105145753;
        Thu, 29 Aug 2019 11:59:05 -0700 (PDT)
Received: from mark-All-Series (114-32-231-59.HINET-IP.hinet.net. [114.32.231.59])
        by smtp.gmail.com with ESMTPSA id b3sm4623185pfp.65.2019.08.29.11.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:59:04 -0700 (PDT)
Date:   Fri, 30 Aug 2019 02:59:01 +0800
From:   Peikan Tsai <peikantsai@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190829185901.GA4680@mark-All-Series>
References: <20190829054953.GA18328@mark-All-Series>
 <20190829064229.GA30423@kroah.com>
 <20190829135359.GB63638@google.com>
 <20190829152721.ttsyfwaeygmwmcu7@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829152721.ttsyfwaeygmwmcu7@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:27:22PM +0200, Christian Brauner wrote:
> On Thu, Aug 29, 2019 at 09:53:59AM -0400, Joel Fernandes wrote:
> > On Thu, Aug 29, 2019 at 08:42:29AM +0200, Greg KH wrote:
> > > On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
> > [snip] 
> > > > The allocated size for each binder_thread is 512 bytes by kzalloc.
> > > > Because the size of binder_thread is fixed and it's only 304 bytes.
> > > > It will save 208 bytes per binder_thread when use create a kmem_cache
> > > > for the binder_thread.
> > > 
> > > Are you _sure_ it really will save that much memory?  You want to do
> > > allocations based on a nice alignment for lots of good reasons,
> > > especially for something that needs quick accesses.
> > 
> > Alignment can be done for slab allocations, kmem_cache_create() takes an
> > align argument. I am not sure what the default alignment of objects is
> > though (probably no default alignment). What is an optimal alignment in your
> > view?
> 
> Probably SLAB_HWCACHE_ALIGN would make most sense.
> 

Agree. Thanks for yours comments and suggestions.
I'll put SLAB_HWCACHE_ALIGN it in patch v2.

> > 
> > > Did you test your change on a system that relies on binder and find any
> > > speed improvement or decrease, and any actual memory savings?
> > > 
> > > If so, can you post your results?
> > 
> > That's certainly worth it and I thought of asking for the same, but spoke too
> > soon!
> 
> Yeah, it'd be interesting to see what difference this actually makes. 
> 
> Christian

I tested this change on an Android device(arm) with AOSP kernel 4.19 and
observed
memory usage of binder_thread. But I didn't do binder benchmark yet.

On my platform the memory usage of binder_thread reduce about 90 KB as
the
following result.
        nr obj          obj size        total
	before: 624             512             319488 bytes
	after:  728             312             227136 bytes

