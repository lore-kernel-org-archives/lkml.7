Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14ACC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC99206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e6kKMZwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfHPOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:38:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38311 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHPOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:38:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so6316477qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MS7ajLYKprAI3MhxmX/5qsDZrA6uiLpBaWLcIAnB0Lc=;
        b=e6kKMZwV4O+Kvfn4npy8P0jfNJrkRu5lQs/FFTJRnQrl5xmV0X39jhnFU/IsAoxvwH
         P6DR5NGW3aTKbm7N4If5x9JQENieb1V/Lilmuo5rM7sTLS9nLnxEuwjWWeFqSjhUTh4s
         BreQymkmDdDoKKfFSagL9nElLDythD+DNAXerEQl/4Mg0SUlGRuKtHuHN64CgLpRbdh7
         9cEiq+OjxTyuC3ETIUPKtAosvo2RxGNiaf3KJxInDCigqVuPBuu8nnC62J1n2oXSz00z
         CI41znMtbUNGAF8K5oF0XH26emRHSKZBPu5rb9XfdSp91cdspY84BohKD2Qxxec+/k98
         vgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MS7ajLYKprAI3MhxmX/5qsDZrA6uiLpBaWLcIAnB0Lc=;
        b=abkYfhjxBg0mJBrA1EV7dsy7YG/Nr2qvr2CcPfyviUy4vAd88htJt+04Me9Zb6qydg
         K5ToURGHHMRCK+CJKrqSx7Bppt6vgq2CHneiGxQOAs0+Lm4FrzJJAqUxkxXYxokYFJSA
         r7wGIMPDxzr0YWghe5B+QcR8KlUEfJwdTt4vtQM/ezZpV3c6Gkz3fnBfUyJCd8thbDNJ
         mDtNWZ+aylQKveWUYwD6HHAPDhVVHtKC/cgNG0emExN7BKl5++XedTSrhZG5zXZAEks7
         oHwUY2o0QxYENhekeG3r1MVo1diNvWlCXZgw0D3uAv2ogPHT0ZmSeVyFJFhmMuAimdiv
         gzPw==
X-Gm-Message-State: APjAAAXgor9FlnuSiF4tYo4Hl4w0TLhMYRlSJNDvYenieUV1P6Wcv+v9
        GWBynsMy8xrw8kM+bQEYMel34g==
X-Google-Smtp-Source: APXvYqwYNXHDUKQmfXFxyCkbseiiOK3Viv9fJl48UIauzpwNOIbibM0ZWbjQ/KNdDlBkdoYp4JQ5mg==
X-Received: by 2002:ac8:c86:: with SMTP id n6mr8777114qti.345.1565966300391;
        Fri, 16 Aug 2019 07:38:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 125sm3190521qkl.36.2019.08.16.07.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 07:38:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hydMx-0003Hq-9g; Fri, 16 Aug 2019 11:38:19 -0300
Date:   Fri, 16 Aug 2019 11:38:19 -0300
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
Message-ID: <20190816143819.GE5398@ziepe.ca>
References: <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
 <20190815202721.GV21596@ziepe.ca>
 <CAKMK7uER0u1TqeJBXarKakphnyZTHOmedOfXXqLGVDE2mE-mAQ@mail.gmail.com>
 <20190816010036.GA9915@ziepe.ca>
 <CAKMK7uH0oa10LoCiEbj1NqAfWitbdOa-jQm9hM=iNL-=8gH9nw@mail.gmail.com>
 <20190816121243.GB5398@ziepe.ca>
 <CAKMK7uHk03OD+N-anPf-ADPzvQJ_NbQXFh5WsVUo-Ewv9vcOAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHk03OD+N-anPf-ADPzvQJ_NbQXFh5WsVUo-Ewv9vcOAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 04:11:34PM +0200, Daniel Vetter wrote:
> Also, aside from this patch (which is prep for the next) and some
> simple reordering conflicts they're all independent. So if there's no
> way to paint this bikeshed here (technicolor perhaps?) then I'd like
> to get at least the others considered.

Sure, I think for conflict avoidance reasons I'm probably taking
mmu_notifier stuff via hmm.git, so:

- Andrew had a minor remark on #1, I am ambivalent and would take it
  as-is. Your decision if you want to respin.
- #2/#3 is this issue, I would stand by the preempt_disable/etc path
  Our situation matches yours, debug tests run lockdep/etc.
- #4 I like a lot, except the map should enclose range_end too,
  this can be done after the mm_has_notifiers inside the
  __mmu_notifier function
  Can you respin?
  I will propose preloading the map in another patch
- #5 is already applied in -rc

Jason
