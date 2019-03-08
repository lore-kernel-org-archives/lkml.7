Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE82C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C8B2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ztSEzU/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCHUIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:08:47 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37557 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCHUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:08:46 -0500
Received: by mail-yw1-f66.google.com with SMTP id k14so17254130ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lsDKYgY/vW+4PZgtpL6UxmadwcQMmmAKs9/Wm6oIc60=;
        b=ztSEzU/6vBGBf9DrjQO0t5ZpIaSdOqZQyNVmCAsJmoAIkaaqfilKrcCTlQuxeJZbqE
         6Zardof+knqLJhbUghmNHG8oo+rpaByG1Z6DYq/6tVKVWpEtnySkX9np1nLchgYBXCfk
         bZeIJqhjnHWCSOv+tcoBYYaGO14uYTUykOH9M3QakiiJ8nq5aE+IWEgUHFriGvmMIPr4
         u7H+u6GUCvI4GLPfLWckLtm8EK/Y/8fr7JdfVIAQNaZ1T1SDbLTiOyytxe+IBxqr/NUz
         GIIIv/ggIVWjQc45wKQllONXB8b+oImRROVROuXY4lXNMLfuV+z7UcEgz3TP/rhHZk2g
         dgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsDKYgY/vW+4PZgtpL6UxmadwcQMmmAKs9/Wm6oIc60=;
        b=QDFht8D7GthlVLxDhaHa9YEYRGM65aU5n0lukU8NYW5YdAmky+qdZWUOMAaKPsXk7w
         Wtw5fAU7Ngi4iHvUEEOqQsM4Dd+jFGnYJK/kfeEfdfJPM1lxP5PH6eq2G8qO4WVxOuWE
         4t+GlfL4d6m6W28wAAEoK8n8l54+5jIlEgqlkTtjPucHH1fBj9DKfefOcnzWP7KyHQyx
         8Kv/ZbAQvtPqNfqodQ7Fh4HIXBpFtotO7w/filoj6ppPMhNWqf8z12BIBHhovLmajPcw
         AAXPtARM8EJRODhRWo3Y69kL0fFSda9IEvDP+c0TA7AdeC50hyrcYhA/wPxuQE6RnrTj
         K2Sg==
X-Gm-Message-State: APjAAAW290SyR+NyXCbSNgq4dg+VqZQ4/pr289fGeer8dWDg6RYwjJvQ
        pNYQq2OaqDTmNYwmbfRHvlzWTA==
X-Google-Smtp-Source: APXvYqxq6tlH3XmO+b/yYa/g/R5gxvHmySxARKfdam4+aP/F+bTd15GfgEDVQRkid+zicODj41s4rw==
X-Received: by 2002:a25:9002:: with SMTP id s2mr415ybl.375.1552075725718;
        Fri, 08 Mar 2019 12:08:45 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id y67sm3073646ywf.89.2019.03.08.12.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 12:08:44 -0800 (PST)
Date:   Fri, 8 Mar 2019 13:08:42 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/15] slub: Add isolate() and migrate() methods
Message-ID: <20190308200842.GF373@cisco>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-3-tobin@kernel.org>
 <20190308152820.GB373@cisco>
 <010001695e16cdef-9831bf56-3075-4f0e-8c25-5d60103cb95f-000000@email.amazonses.com>
 <20190308162237.GD373@cisco>
 <20190308195322.GA25102@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308195322.GA25102@eros.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 06:53:22AM +1100, Tobin C. Harding wrote:
> On Fri, Mar 08, 2019 at 09:22:37AM -0700, Tycho Andersen wrote:
> > On Fri, Mar 08, 2019 at 04:15:46PM +0000, Christopher Lameter wrote:
> > > On Fri, 8 Mar 2019, Tycho Andersen wrote:
> > > 
> > > > On Fri, Mar 08, 2019 at 03:14:13PM +1100, Tobin C. Harding wrote:
> > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > index f9d89c1b5977..754acdb292e4 100644
> > > > > --- a/mm/slab_common.c
> > > > > +++ b/mm/slab_common.c
> > > > > @@ -298,6 +298,10 @@ int slab_unmergeable(struct kmem_cache *s)
> > > > >  	if (!is_root_cache(s))
> > > > >  		return 1;
> > > > >
> > > > > +	/*
> > > > > +	 * s->isolate and s->migrate imply s->ctor so no need to
> > > > > +	 * check them explicitly.
> > > > > +	 */
> > > >
> > > > Shouldn't this implication go the other way, i.e.
> > > >     s->ctor => s->isolate & s->migrate
> > > 
> > > A cache can have a constructor but the object may not be movable (I.e.
> > > currently dentries and inodes).
> > 
> > Yep, thanks. Somehow I got confused by the comment.
> 
> I removed code here from the original RFC-v2, if this comment is
> confusing perhaps we are better off without it.

I'd say leave it, unless others have objections. I got lost in the
"no need" and return true for unmergable too-many-nots goop, but it's
definitely worth noting that one implies the other. An alternative
might be to move it to a comment on the struct member instead.

Tycho
