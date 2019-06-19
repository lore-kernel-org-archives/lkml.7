Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C18C46477
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF5A206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KMoNMAk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfFSQu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:50:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33746 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:50:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id x2so20767601qtr.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qZ7DILVFzp78tcp4G5VOohWGeQIPrvQGvihKnIg9H7E=;
        b=KMoNMAk8Ui9/LtKeNa7HIyVKWhexKtOyUwM0YsZQI+1McUXlVPzPHPca+hUWtgwo/6
         03T2AvAUYyMxuNukN8dIy79whNPI9nkupfg9cH6LdySpEzUgauwhQFADzdyRe4Hvu1pY
         fDPLXTlCjygXw/QMhggf2P4CsbK4+s0v1QuBXUz4vFWJeGTQZFX/hUl7EC5MO9D/u2Xs
         NbXmeZUZ9Rt9lNVx3eXE/mU35xwWdDiw3jHn52j89OeRFlTDfy6CEZ1RraQEIP19d7mm
         VyWkyW+DGheaUcNRMXcsg92KDqLEdhfiLfFXP/kmU/pLCATJWbXUUz0VDhB0JqXgdvW1
         UIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZ7DILVFzp78tcp4G5VOohWGeQIPrvQGvihKnIg9H7E=;
        b=d78jfzMJdDjoNpM/eKgaLX6tHo6B+g0vwwpAMPCvM9gf21y4T+b6I/jR77GNCJAHmo
         LcvupxS1RdOiI+D4di9/XDsHwT5lB7mN8zHLIAijiqlYFN/Ho/loKheQHFdA/r13SYaa
         4UWK752WqsLQY0sORGN02cRnUtet1ceWvI01QimcNh14mmjxZrJCGcOwX0sllD0Fd8lA
         yx/e1kTDi6bfMcv8yi5sHjDf9dvSnJq2/ASswudce3LTC0vSaFyyjoaUgeqFogMA99vw
         r7y7yYX+V2il4xgfPXeWjgLv7FN7nYZoc1zbZDRQ2/FNB4dDPQK1XqGYxtlmoOCr+DZB
         vM+g==
X-Gm-Message-State: APjAAAV/wmVKSsW05gyjBsrFSCwM0NZRkksCt5UBsN1LeaX5RD4t6Qj3
        PoiOTBDiFHNG1IOQWgjfkjV0+w==
X-Google-Smtp-Source: APXvYqwORT7n/pvkyNBXMNfOBu1GA78NLHvBz3GZoS2rYJCKw8+BpnU4WCUnG74vXzc78GqCKrZy8g==
X-Received: by 2002:a0c:e6a2:: with SMTP id j2mr32663508qvn.190.1560963056606;
        Wed, 19 Jun 2019 09:50:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m44sm14096849qtm.54.2019.06.19.09.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 09:50:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hddnT-00022a-N7; Wed, 19 Jun 2019 13:50:55 -0300
Date:   Wed, 19 Jun 2019 13:50:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20190619165055.GI9360@ziepe.ca>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190521154411.GD3836@redhat.com>
 <20190618152215.GG12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618152215.GG12905@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 05:22:15PM +0200, Daniel Vetter wrote:
> On Tue, May 21, 2019 at 11:44:11AM -0400, Jerome Glisse wrote:
> > On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> > > Just a bit of paranoia, since if we start pushing this deep into
> > > callchains it's hard to spot all places where an mmu notifier
> > > implementation might fail when it's not allowed to.
> > > 
> > > Inspired by some confusion we had discussing i915 mmu notifiers and
> > > whether we could use the newly-introduced return value to handle some
> > > corner cases. Until we realized that these are only for when a task
> > > has been killed by the oom reaper.
> > > 
> > > An alternative approach would be to split the callback into two
> > > versions, one with the int return value, and the other with void
> > > return value like in older kernels. But that's a lot more churn for
> > > fairly little gain I think.
> > > 
> > > Summary from the m-l discussion on why we want something at warning
> > > level: This allows automated tooling in CI to catch bugs without
> > > humans having to look at everything. If we just upgrade the existing
> > > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > > one will ever spot the problem since it's lost in the massive amounts
> > > of overall dmesg noise.
> > > 
> > > v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> > > the problematic case (Michal Hocko).

I disagree with this v2 note, the WARN_ON/WARN will trigger checkers
like syzkaller to report a bug, while a random pr_warn probably will
not.

I do agree the backtrace is not useful here, but we don't have a
warn-no-backtrace version..

IMHO, kernel/driver bugs should always be reported by WARN &
friends. We never expect to see the print, so why do we care how big
it is?

Also note that WARN integrates an unlikely() into it so the codegen is
automatically a bit more optimal that the if & pr_warn combination.

Jason
