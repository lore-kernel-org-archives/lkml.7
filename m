Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C37C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E1220643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578484197;
	bh=v7NpeMdXeC10MVaQ3W3VIorUfyExr5UW985+cQ9Zo18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bX+j9Of60ruaLWH1Qwgnc1hq3dg5JX+SEj4yJwlTnjnjf+97K5MUBvAVRjQ355FCY
	 1iaN+N7fAWwoq+5nJbDcke8TaErZu4mMVQX1M4Oi2dM0dw8gs9M1hUILiGJDBEAYpF
	 Qo2YTBImczcwnx6ySYcK7OgeQT/MO2dp9mfwjDtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgAHLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:49:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHLt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:49:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so2980627wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 03:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ds/FcZo5DP8P9uihgmT1DwfKR7s47NWH9iNXqs1JE9k=;
        b=ovGPeBnwssX/aSjEWv/nluc95pVVOC65T45qvqqpwAi6u/jWzVX9M37Z7JNBE9JKWr
         XLtj77kcdPtU5NGayHQe308U/u510ucyNbjAzTESWwCAHQCb+h4bXamxkApTk0eFtaK1
         xcsbZIWgyK0IPi38AdY10wEGk/XyW1UyARjy81YsmATt3ZwO60zWaDE/wcHXJDlWadAP
         u+1FyIF6fkaCIWZQhwNKgX5fZak5M+H+eTCxzZVjcMtJWeVBSGuohxKvTbPr+ZfzhnTu
         NkMi/KmYCxC6G+4/MbFSs2Rfj9jsTZhOEP2+ixVbHRtGPzuoTClLp4BuKBakP2zD6o/d
         Yn9g==
X-Gm-Message-State: APjAAAVdaXbjL+RKZtBWsAGiHJo0QWB5M4G/XjFhTOb81lB/Uwk1ETGf
        uqs5qdLREPpS1WcDIMcPXVnWGeRr
X-Google-Smtp-Source: APXvYqxIORZkbQTA0rB/gO3SCB/Gq3vx3RsK0kqHMhjtIM4AmW6X4ezpsD+PY0gBZbcYeZRa98OGCA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr4273987wru.318.1578484194590;
        Wed, 08 Jan 2020 03:49:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g25sm35916629wmh.3.2020.01.08.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:49:52 -0800 (PST)
Date:   Wed, 8 Jan 2020 12:49:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
Message-ID: <20200108114952.GR32178@dhcp22.suse.cz>
References: <20191226220205.128664-1-semenzato@google.com>
 <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz>
 <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-01-20 11:08:56, Luigi Semenzato wrote:
> On Mon, Jan 6, 2020 at 4:53 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 26-12-19 14:02:04, Luigi Semenzato wrote:
> > [...]
> > > +Limitations of Hibernation
> > > +==========================
> > > +
> > > +When entering hibernation, the kernel tries to allocate a chunk of memory large
> > > +enough to contain a copy of all pages in use, to use it for the system
> > > +snapshot.  If the allocation fails, the system cannot hibernate and the
> > > +operation fails with ENOMEM.  This will happen, for instance, when the total
> > > +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> > > +
> > > +One possible workaround (besides terminating enough processes) is to force
> > > +excess anonymous pages out to swap before hibernating.  This can be achieved
> > > +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> > > +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> > > +operation is not guaranteed to succeed.
> >
> > I am not familiar with the hibernation process much. But what prevents
> > those allocations to reclaim memory and push out the anonymous memory to
> > the swap on demand during the hibernation's allocations?
> 
> Good question, thanks.
> 
> The hibernation image is stored into a swap device (or partition), so
> I suppose one could set up two swap devices, giving a lower priority
> to the hibernation device, so that it remains unused while the kernel
> reclaims pages for the hibernation image.

I do not think hibernation can choose which swap device to use. Having
an additional swap device migh help though because there will be more
space to swap out to.

> If that works, then it may be appropriate to describe this technique
> in Documentation/power/swsusp.rst.  There's a brief mention of this
> situation in the Q/A section, but maybe this deserves more visibility.
> 
> In my experience, the page allocator is prone to giving up in this
> kind of situation.  But my experience is up to 4.X kernels.  Is this
> guaranteed to work now?

OK, I can see it now. I forgot about the ugly hack in the page allocator
that hibernation is using. If there is no way to make a forward progress
for the allocation and we enter the allocator oom path (__alloc_pages_may_oom)
pm_suspended_storage() bails out early and the allocator gives up.

That being said allocator would swap out processes so it doesn't make
much sense to do that pro-actively. It can still fail if the swap is
depleted though and then the hibernation gives up. This makes some sense
because you wouldn't like to have something killed by the oom killer
while hibernating right? Graceful failure should be a preferable action
and let you decide what to do IMHO.
-- 
Michal Hocko
SUSE Labs
