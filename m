Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B34C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEBD214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cLoTJVoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfFSUNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:13:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40698 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfFSUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:13:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so386340qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgcngtEs9uVcYhtJPpPurWF53FUixqD8oD/gTijpCZs=;
        b=cLoTJVojiiY28gDdbS4BiMud3Q2ttCA35wRWS9+enmEKV/fFhoK5HMbRgWCMRNjzCQ
         b5ZrG1xcUBu7h6XelJpG4UMUjYJIzXdXfvpPiSyGYKdOweQ8twH8VntPLrq71j/TsSLy
         jpJZxemlj6uSAxjIlpkxEfVLL6t4SnPV1Na+7aRJWlC/JUKSKlZ2Kb2Z4WwTJsvlN637
         Cevv50iZDvZBGXCN6Gv70gfCH3gmRKeT9j0XQcvmKxIGDNpJ19N3X2W+pEIfCgtmESSX
         foHoQot+LMBKmcpM4/NBKgRFPmN0qLPKRN6ubqbiqKhMYESz50hc7k0uZOGPL7CFxZJG
         aZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgcngtEs9uVcYhtJPpPurWF53FUixqD8oD/gTijpCZs=;
        b=m2T+SdeHtxfs54neGJ9fEneuBOeDh5CRuthaypgCCTgn9lIdplM0ZUnJOMlOWlrwRh
         tc81ukvkmKtNwZZ7wZJ2zPEn5XPdd9AJnZNhH+YlIz5zBtd7jtKc3o8i+pORVHpMK32b
         hyJlSvWcNCwVb9LBdOKhPGW4YOz8zBfP8L6PiSxNyMjICa2vNJvphyK7Rm3AMw7r7w7D
         AaC+DT10kB3sB24fcOKlMetwEl+SNTQeKFeJtGKixphlvFLO0n2LvEgTr/UA8OwP3B8m
         Zbpno2+0dxsgdG6PB1tBLvVplaq9EgrzhuVNdlb1EwBb+3JUDg8bAhDUbOl+XgmVzqsD
         0pog==
X-Gm-Message-State: APjAAAVNvKsATJJ+Fnw0PUlvULzoxiz5pL3YrZtEoI32pv6tEv8aWoib
        6KBVDVhG3zzgkYIMTMOISTZcsQ==
X-Google-Smtp-Source: APXvYqx89CcDrXNyjbTWXMmP5tm+atmaNtgywjB10MJ+6xvDJdWKl3S7Qx9ZNBRu4t92EqyHMT9VzA==
X-Received: by 2002:a37:4cd2:: with SMTP id z201mr54688926qka.284.1560975221161;
        Wed, 19 Jun 2019 13:13:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 34sm12796326qtq.59.2019.06.19.13.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 13:13:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdgxg-0002nE-42; Wed, 19 Jun 2019 17:13:40 -0300
Date:   Wed, 19 Jun 2019 17:13:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20190619201340.GL9360@ziepe.ca>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190521154411.GD3836@redhat.com>
 <20190618152215.GG12905@phenom.ffwll.local>
 <20190619165055.GI9360@ziepe.ca>
 <CAKMK7uGpupxF8MdyX3_HmOfc+OkGxVM_b9WbF+S-2fHe0F5SQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGpupxF8MdyX3_HmOfc+OkGxVM_b9WbF+S-2fHe0F5SQA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 09:57:15PM +0200, Daniel Vetter wrote:
> On Wed, Jun 19, 2019 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Tue, Jun 18, 2019 at 05:22:15PM +0200, Daniel Vetter wrote:
> > > On Tue, May 21, 2019 at 11:44:11AM -0400, Jerome Glisse wrote:
> > > > On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> > > > > Just a bit of paranoia, since if we start pushing this deep into
> > > > > callchains it's hard to spot all places where an mmu notifier
> > > > > implementation might fail when it's not allowed to.
> > > > >
> > > > > Inspired by some confusion we had discussing i915 mmu notifiers and
> > > > > whether we could use the newly-introduced return value to handle some
> > > > > corner cases. Until we realized that these are only for when a task
> > > > > has been killed by the oom reaper.
> > > > >
> > > > > An alternative approach would be to split the callback into two
> > > > > versions, one with the int return value, and the other with void
> > > > > return value like in older kernels. But that's a lot more churn for
> > > > > fairly little gain I think.
> > > > >
> > > > > Summary from the m-l discussion on why we want something at warning
> > > > > level: This allows automated tooling in CI to catch bugs without
> > > > > humans having to look at everything. If we just upgrade the existing
> > > > > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > > > > one will ever spot the problem since it's lost in the massive amounts
> > > > > of overall dmesg noise.
> > > > >
> > > > > v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> > > > > the problematic case (Michal Hocko).
> >
> > I disagree with this v2 note, the WARN_ON/WARN will trigger checkers
> > like syzkaller to report a bug, while a random pr_warn probably will
> > not.
> >
> > I do agree the backtrace is not useful here, but we don't have a
> > warn-no-backtrace version..
> >
> > IMHO, kernel/driver bugs should always be reported by WARN &
> > friends. We never expect to see the print, so why do we care how big
> > it is?
> >
> > Also note that WARN integrates an unlikely() into it so the codegen is
> > automatically a bit more optimal that the if & pr_warn combination.
> 
> Where do you make a difference between a WARN without backtrace and a
> pr_warn? They're both dumped at the same log-level ...

WARN panics the kernel when you set 

/proc/sys/kernel/panic_on_warn

So auto testing tools can set that and get a clean detection that the
kernel has failed the test in some way.

Otherwise you are left with frail/ugly grepping of dmesg.

Jason
