Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2662FC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6A02171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jlEJuZ04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHPMTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:19:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46153 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfHPMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:19:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id j15so5783448qtl.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bEaXAj2iniWEaSuyn0fH/kEDTRkIl1c5/RWuNELkR8k=;
        b=jlEJuZ04r4FfQRnSsDTdZ15gGG887mO3OlgLiS5KOdM/EzBvDtD+FVvFpCf4P/D/DI
         frDzy0JvoZ4ASbRUxBfxq+VBafmy6i1RohHZRDHW1JuD0RUOantYkeDrGj6nJAu3OzhD
         f+/Ek9pkIMkSwoxSy/qgajjsD1TfTK+u5nMYCCwMirwVEjP7Crpcx0vKg0u+issupd6f
         ytBhCE03xW7wOtyBD2RlHnjr3wEofPwarGLZUapHD3sOp9Ep2hSxfXwe0fbAsFdoQ95J
         cIJ4g27qSF4DkzKx3Ql2/UzoVwZ9pTqSajKxBQ+YphcyHXFp5lofa0olwQDzdNLT9q32
         IwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEaXAj2iniWEaSuyn0fH/kEDTRkIl1c5/RWuNELkR8k=;
        b=kHr2e5hzINQqCHMg3a0Pwg/DCZ39B0iHWfpBytvbP5yvaosuEeaYzVoiZo/otnllfQ
         amgyEnYuuqYh9m13r73xPIUHLg0Ruf3D03Hvo6jNgG0DTH7JdZJjb7nYrhM28FYQiyUW
         7Mzuci8hjd/l69/kNiuJxs4j9EX9Liid6hRu2RgWy+ttBzdowPr44xoS2vPUyStGkC4O
         xhKNAkHHxrJaXCdWVdfNDtVf56ijvElGxgGlMYSDZ1eraANN863LIM0CxK97IjOLedrZ
         gqx7WEQmGYfpqIZ/uu2/VHlfmh7wfweP3wp0EoYxX7GeWU2BTPaR6oAnXEXi5D+7ntiF
         3fZA==
X-Gm-Message-State: APjAAAVX17ap9kiWnP31pzMLoz5ECsZS7SKgXg93NXA2QcazSjy45ufO
        9QpktpaHpbiHPBWrzWpr2t8wjg==
X-Google-Smtp-Source: APXvYqwJ0xLOCEoe5le7pO6VtEfZW/wyQ9tx0UXL7Cr/GZtD4aFsgQFkuJBiYfOrdvN1joh+5J6bkg==
X-Received: by 2002:ac8:5503:: with SMTP id j3mr8391055qtq.355.1565957947384;
        Fri, 16 Aug 2019 05:19:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f27sm2963616qkl.25.2019.08.16.05.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 05:19:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hybCE-0001q2-67; Fri, 16 Aug 2019 09:19:06 -0300
Date:   Fri, 16 Aug 2019 09:19:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190816121906.GC5398@ziepe.ca>
References: <20190815141219.GF21596@ziepe.ca>
 <20190815155950.GN9477@dhcp22.suse.cz>
 <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <20190815201323.GU21596@ziepe.ca>
 <20190816081029.GA27790@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816081029.GA27790@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:10:29AM +0200, Michal Hocko wrote:
> On Thu 15-08-19 17:13:23, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2019 at 09:35:26PM +0200, Michal Hocko wrote:
> > 
> > > > The last detail is I'm still unclear what a GFP flags a blockable
> > > > invalidate_range_start() should use. Is GFP_KERNEL OK?
> > > 
> > > I hope I will not make this muddy again ;)
> > > invalidate_range_start in the blockable mode can use/depend on any sleepable
> > > allocation allowed in the context it is called from. 
> > 
> > 'in the context is is called from' is the magic phrase, as
> > invalidate_range_start is called while holding several different mm
> > related locks. I know at least write mmap_sem and i_mmap_rwsem
> > (write?)
> > 
> > Can GFP_KERNEL be called while holding those locks?
> 
> i_mmap_rwsem would be problematic because it is taken during the
> reclaim.

Okay.. So the fs_reclaim debugging does catch errors. Do you have any
reference for what a false positive looks like? 

I would like to inject it into the notifier path as this is very
difficult for driver authors to discover and know about, but I'm
worried about your false positive remark.

I think I understand we can use only GFP_ATOMIC in the notifiers, but
we need a strategy to handle OOM to guarentee forward progress.

This is just more bugs to fix :(

Jason
