Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C55C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3922CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ljbpw4fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfICHgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:36:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfICHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:36:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so12899096wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Dv55tyGyqXMrZX83SwrRIU+i9nALQjaNWq68c03GXI=;
        b=Ljbpw4fhx6QxNHXels3qpp2aUOAk8vlbavDiQesD0cWLwVLty3aJba0Mv+G14WwXUY
         J6tOlIq7x99iKlJszy6ygTHrSVdJhXdK4R9c4ECB9cFI7FJHkU28AdmbdsPcfR2wey5T
         2uIj2Q78IAXWGJXaFwa7ksHJsfhMYzZrLIq9OiOBFzhKliEPePgfxIZGvexZhC2kwGKF
         VpZXEbGPaBuzF/kmA5CnRXOJPjaPLFjCeCMyCghU1hffYinkPrhF89gIm5WmpAAaQTiZ
         5SR9ZaIV7l/UyhZjbRsOTLtl+1e1D599Ms4rDFsEtWiyRYSo254B1+YiLiOMYVPmDxGH
         PHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Dv55tyGyqXMrZX83SwrRIU+i9nALQjaNWq68c03GXI=;
        b=j3X2lOu14AOJDkjrbvjIZQ7rt2OFwNQCgCW8tg/PDVTbT1B8y3raA4Is1OaRksPqa8
         ikwsE5S84FfE7svggl/Gj/cnsW4siHUIih6xdmyF1btMbMVlAlHI4qP3CJb7k7y6Enui
         d7XijWqGwvsa6r8WDgq1wJ2SiWt+1sWFhH0a6gjmezPI5V7UTsbARB6ZsxS+uqZrKn6Q
         t0YlYVfa3bHNWm77qRLK0iZ8xSJbXEarKGbX4otxO/TJqNfjaJ3Sb7GTlPZ5I2OVrjU2
         4d+4Hm/ppEYClaOzJr5xCTGdxh/TY9mmf7huqFrbnTk0I0vkspAzjiHGzMkfC4kIcFxH
         qFHg==
X-Gm-Message-State: APjAAAUyZ4ddaC0o2AM5XoGxJ3Mhdz/NLb8yIknwI5pYfWxZhhvA9OT2
        6A8HBmqzr+slj3LWJpZDclBqpA==
X-Google-Smtp-Source: APXvYqyxuGiS8BcsynmmU6sW7DpxWQ4xWRBDdJxslrhLv19Q6kkbrC33NvvCD/8YfCrP44tF4Jl5rA==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr9353932wma.165.1567496205721;
        Tue, 03 Sep 2019 00:36:45 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g26sm14684174wmh.32.2019.09.03.00.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 00:36:45 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i53Mq-00012C-1s; Tue, 03 Sep 2019 04:36:44 -0300
Date:   Tue, 3 Sep 2019 04:36:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/5] kernel.h: Add non_block_start/end()
Message-ID: <20190903073644.GB4500@ziepe.ca>
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
 <20190826201425.17547-4-daniel.vetter@ffwll.ch>
 <20190827225002.GB30700@ziepe.ca>
 <CAKMK7uHKiLwXLHd1xThZVM1dH-oKrtpDZ=FxLBBwtY7XmJKgtA@mail.gmail.com>
 <20190828184330.GD933@ziepe.ca>
 <CAKMK7uFJESH1XHTCqYoDb4iMfThxnib3Uz=RUcd7h=SS-TJWbg@mail.gmail.com>
 <CAKMK7uET7GL-nmRd_wxkxu0KsiYiSZcGTsSstcUpqaT=mKTbmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uET7GL-nmRd_wxkxu0KsiYiSZcGTsSstcUpqaT=mKTbmg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:28:23AM +0200, Daniel Vetter wrote:

> > Cleanest would be a new header I guess, together with might_sleep().
> > But moving that is a bit much I think, there's almost 500 callers of
> > that one from a quick git grep
> >
> > > If dropping do while is the only change then I can edit it in..
> > > I think we have the acks now
> >
> > Yeah sounds simplest, thanks.
> 
> Hi Jason,
> 
> Do you expect me to resend now, or do you plan to do the patchwork
> appeasement when applying? I've seen you merged the other patches
> (thanks!), but not these two here.

Sorry, I didn't get to this before I started travelling, and deferred
it since we were having linux-next related problems with hmm.git. I
hope to do it today.

I will fix it up as promised

Thanks,
Jason
