Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8AAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B221743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U5M7r7PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbfHVOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:24:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35403 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHVOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:24:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so5301443qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dc5+B44d/riVZ4BUj5s+q3Lkc18YuwqlI4z9+Sq+DYI=;
        b=U5M7r7PIyUiUocgqIIxQGJhmG0OFdz9U6VAO0wM0x9A3Vm1DHeBBjWMEOm+kGH0+sZ
         DVv7IgnNa8XvXNx76i2JRGXB1VOoVy4HaRSd5Majxg2lBxexhTGf4IqG48SiOLjcbvhE
         Mgx+/6CT1tNcq2BuTPXz8aDbbkhIzpAZObMLT2Axn3xV8AUEPMljgWAa7yQMvm08Ssyj
         Z+5muEGCOJ/m+c/Z3hTPXgauluqi3fD9P9IRfcmxsuTg1tqEb+PCwj8pdWwr8DWOjvtw
         +g//1M+gbQ6xkkIk7Px0hFVwWYVOOI7HP4+k4bs2ecFl2T7g0x/XQiWSQxDtGK4KXiOT
         9sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dc5+B44d/riVZ4BUj5s+q3Lkc18YuwqlI4z9+Sq+DYI=;
        b=VzXTtvynfkWou2kOshh63jRmy7u2olno32hW4h/i57sdu7ra+DQjrhFi7ktBLog7YV
         sy7Vex+eVqyDwWwOr5yD8RTJqoZdqHI3LYMpU4f3yro/XBGGlfeOGMk5vlFUHcTO9T4W
         syBpNGnxvZJkmSblv1L2mow9DiWORhcIRUHUTbVCET53oX3RydnxPjggaXIgtDIgRcpj
         enr9d2Xo1b552ZFof5WePzH3f+JwrFujPza87eD1SEbNYJv9v4SefrYll9Od4jOJFdru
         wfmRtPcmPnXr8J+cZHHwS4q1G5SDx0RAvaZjN/CmPXZkUJ3Hj0+uQdznIOX9gUsWSNvF
         P17g==
X-Gm-Message-State: APjAAAXkgp0YXteFI/n9MZvGarVAzvuBLAwez1yRISw/4iMw0T64A2Qo
        SXMOUjWNglgMGmU2SkiKDwNC70CYPcc=
X-Google-Smtp-Source: APXvYqx1hDXEyXaCf4TQxuW7kB785QqUUNv48fJgwQaA1egBhvm9xoK/w0v99nR0V1KI+G1DH5vz7A==
X-Received: by 2002:a37:47d8:: with SMTP id u207mr20384093qka.255.1566483851626;
        Thu, 22 Aug 2019 07:24:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m3sm7668768qki.10.2019.08.22.07.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 07:24:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0o0Y-000763-37; Thu, 22 Aug 2019 11:24:10 -0300
Date:   Thu, 22 Aug 2019 11:24:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190822142410.GB8339@ziepe.ca>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch>
 <20190820133418.GG29246@ziepe.ca>
 <20190820151810.GG11147@phenom.ffwll.local>
 <20190821154151.GK11147@phenom.ffwll.local>
 <20190821161635.GC8653@ziepe.ca>
 <CAKMK7uERsmgFqDVHMCWs=4s_3fHM0eRr7MV6A8Mdv7xVouyxJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uERsmgFqDVHMCWs=4s_3fHM0eRr7MV6A8Mdv7xVouyxJw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:42:39AM +0200, Daniel Vetter wrote:

> > RDMA has a mutex:
> >
> > ib_umem_notifier_invalidate_range_end
> >   rbt_ib_umem_for_each_in_range
> >    invalidate_range_start_trampoline
> >     ib_umem_notifier_end_account
> >       mutex_lock(&umem_odp->umem_mutex);
> >
> > I'm working to delete this path though!
> >
> > nonblocking or not follows the start, the same flag gets placed into
> > the mmu_notifier_range struct passed to end.
> 
> Ok, makes sense.
> 
> I guess that also means the might_sleep (I started on that) in
> invalidate_range_end also needs to be conditional? Or not bother with
> a might_sleep in invalidate_range_end since you're working on removing
> the last sleep in there?

I might suggest the same pattern as used for locked, the might_sleep
unconditionally on the start, and a 2nd might sleep after the IF in
__mmu_notifier_invalidate_range_end()

Observing that by audit all the callers already have the same locking
context for start/end

Jason
