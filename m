Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06796215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RCqHCdBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfH2NyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:54:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38152 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2NyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:54:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so2103961pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pf/db+szbYm7dJzEjw6KZt3csHMZhr4jO5xT4UCnNZE=;
        b=RCqHCdBfnJpfcZnScGd1muttY38RJgoi9gHDa1Omn5PBRnmwnAT2EHr/oXc5auS4dS
         gxUK6n3qvAeAhkUb7pFLyw3asgmek8WpG0tsknS4dq/VTEJGR3Yl3NqOeXzdxDX2okk/
         fdyoiaYasK1GrF5x8jDqMzGOuiRQfCvnGNndc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pf/db+szbYm7dJzEjw6KZt3csHMZhr4jO5xT4UCnNZE=;
        b=A9iNg/0Ius8KEGJgtRM5YEiwx+w7FnvAwBVWCv5lvQB38YcAtnR+oE1bTCEb1i8toL
         Xy/OIssS2iEFaJgaCIZ1kExhfmBGQQFwnsrfNva5a8iZ4A4cIqQe3hvQmd/mT54GU9qv
         9ZbcndwEJA5tt0AzUTsnzZj2HBwEUhaW9CeGVbsyuH/DA8xMX2w1WZNjqoAJmpf016Dz
         C8rbWUyeoO3QyKX+RZQuc78FmhgSuQgFCW/JiQ8O8wPJJRgJkjINmB+/V1A4TcfaVQWX
         ucNqLssW4MUZtQRyLtL1dw+DnEdhpWtONO/uIDq89V9UTdukBKhjN4qozbZ5+YolphqS
         E1aQ==
X-Gm-Message-State: APjAAAW9F1U+8bpDwKm2gvqF2ty3qcXXsNkVTkeN9Y/SxUvjlj3eeQ/B
        KfZDBPYkV7eJyo4d+nV/h9BQCw==
X-Google-Smtp-Source: APXvYqzszQZHsQVXQ4zEKWNjF5tJmv6Y0LXpwcNWBVVty+o15HXC4XU4E78Fk8gLqUwh+U36WQZ0cw==
X-Received: by 2002:a63:f401:: with SMTP id g1mr8784816pgi.314.1567086840883;
        Thu, 29 Aug 2019 06:54:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 185sm4229503pfd.125.2019.08.29.06.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:54:00 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:53:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peikan Tsai <peikantsai@gmail.com>, arve@android.com,
        tkjos@android.com, maco@android.com, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190829135359.GB63638@google.com>
References: <20190829054953.GA18328@mark-All-Series>
 <20190829064229.GA30423@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829064229.GA30423@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 08:42:29AM +0200, Greg KH wrote:
> On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
[snip] 
> > The allocated size for each binder_thread is 512 bytes by kzalloc.
> > Because the size of binder_thread is fixed and it's only 304 bytes.
> > It will save 208 bytes per binder_thread when use create a kmem_cache
> > for the binder_thread.
> 
> Are you _sure_ it really will save that much memory?  You want to do
> allocations based on a nice alignment for lots of good reasons,
> especially for something that needs quick accesses.

Alignment can be done for slab allocations, kmem_cache_create() takes an
align argument. I am not sure what the default alignment of objects is
though (probably no default alignment). What is an optimal alignment in your
view?

> Did you test your change on a system that relies on binder and find any
> speed improvement or decrease, and any actual memory savings?
> 
> If so, can you post your results?

That's certainly worth it and I thought of asking for the same, but spoke too
soon!

Independent note: In general I find the internal fragmentation with large
kmalloc()s troubling in the kernel :-(. Say you have a 5000 objects of 512
allocation, each 300 bytes. 212 * 5000 is around 1MB. Which is arguably not
neglible on a small memory system, right?

thanks,

 - Joel

