Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45550C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D02B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KcW7SJTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfHPBAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:00:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35967 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHPBAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:00:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id d23so3481387qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ae7oLtYinKvgCP13tnVSH7l6maTQr55HBH5L3FO3DiI=;
        b=KcW7SJTCvYMKEBr6ZA7ZBCVrwhTBhrxBAzKDZCEQfgTQ1UAU1/yBqq/rXTp4rQSuMJ
         IO3knBqpn2AdA04HAixLj3yCozsg1UAo/yGd5mtobT9P7ox1cF3Az+gzxvSHjtS74RUp
         WvaqkLapT2Ubt9ToChKBB0qe0ngW33kWeP+H8aeA2AYYZE14PPhIZ/S3lqmaw6o7OQOc
         +NqXbwj2Kf5YIU09s9BqFI5Fx6K9MIW9Pox2mvr2sLTsxwPMikvBFCp/EFlqT78uepMz
         rSFX7X+6jzzyCjzCiQ0A93GLozvhXSdE0CeSM6/pkHRgn74yKYamKJEUnwca6vz4+PPL
         iGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ae7oLtYinKvgCP13tnVSH7l6maTQr55HBH5L3FO3DiI=;
        b=I50SEBaJp2EEudvPlh+gklwJRLjxGm4n1q+CkIlkiFYjWj7hZqKYA5pkD6q3s8uYgi
         5Hz6sTYEB8dAB7Bz5jYBo3KqkDToY4YWft7nPA91EqOBaPz5XCPwESh3xmCTmY/lsjVp
         bGDh+02iPyJnT4XirYWLPweM8rjXCSk92BFDfh0ODbGRhJClnNyc1eMRbKuhQAv2vjiO
         hlXyZw8Mqk7jScIViYUNbC3Rbkya60T7nbSRG0CgtVyLTTGPOBDGPZ4XpsilXUyIotfu
         DfZ5Um4IO38XA1//dvCx1xngifNhJ0O6QPqDfEVrQWUajbx+8UL2mbh8qVexS/B4I3Pd
         1t9g==
X-Gm-Message-State: APjAAAUdxRhTN/+CKFFruvU2K4I3Tkz3OsCJ1E/2nqr6QXnnSPG4GekD
        XlWMuULDMyuf2fD6z2mwsfqmRQ==
X-Google-Smtp-Source: APXvYqyxI9OS6AUw/7wEeJomE7hGeWSroP0/H9Q9E+ZoJynGDvtwyvcA9yHhjJMm3q3CVcLQLGNODw==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr6562963qke.34.1565917237376;
        Thu, 15 Aug 2019 18:00:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t15sm2084806qtr.88.2019.08.15.18.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 18:00:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyQbc-0002v2-3C; Thu, 15 Aug 2019 22:00:36 -0300
Date:   Thu, 15 Aug 2019 22:00:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Wei Wang <wvw@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190816010036.GA9915@ziepe.ca>
References: <20190815155950.GN9477@dhcp22.suse.cz>
 <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
 <20190815202721.GV21596@ziepe.ca>
 <CAKMK7uER0u1TqeJBXarKakphnyZTHOmedOfXXqLGVDE2mE-mAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uER0u1TqeJBXarKakphnyZTHOmedOfXXqLGVDE2mE-mAQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:49:31PM +0200, Daniel Vetter wrote:
> On Thu, Aug 15, 2019 at 10:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Thu, Aug 15, 2019 at 10:16:43PM +0200, Daniel Vetter wrote:
> > > So if someone can explain to me how that works with lockdep I can of
> > > course implement it. But afaics that doesn't exist (I tried to explain
> > > that somewhere else already), and I'm no really looking forward to
> > > hacking also on lockdep for this little series.
> >
> > Hmm, kind of looks like it is done by calling preempt_disable()
> 
> Yup. That was v1, then came the suggestion that disabling preemption
> is maybe not the best thing (the oom reaper could still run for a long
> time comparatively, if it's cleaning out gigabytes of process memory
> or what not, hence this dedicated debug infrastructure).

Oh, I'm coming in late, sorry

Anyhow, I was thinking since we agreed this can trigger on some
CONFIG_DEBUG flag, something like

    /* This is a sleepable region, but use preempt_disable to get debugging
     * for calls that are not allowed to block for OOM [.. insert
     * Michal's explanation.. ] */
    if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !mmu_notifier_range_blockable(range))
	preempt_disable();
    ops->invalidate_range_start();

And I have also been idly mulling doing something like

   if (IS_ENABLED(CONFIG_DEBUG_NOTIFIERS) && 
       rand &&
       mmu_notifier_range_blockable(range)) {
     range->flags = 0
     if (!ops->invalidate_range_start(range))
	continue

     // Failed, try again as blockable
     range->flags = MMU_NOTIFIER_RANGE_BLOCKABLE
   }
   ops->invalidate_range_start(range);

Which would give coverage for this corner case without forcing OOM.

Jason
