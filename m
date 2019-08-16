Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9374C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A354320644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BByaPnWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfHPObs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:31:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37459 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfHPObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:31:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so4920822qkm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZuTpFWe2nt7y+/QS811q/nmqipRVURrHatiPCF7ae4=;
        b=BByaPnWhPiJu1NxST08KD8o3VHHoiXCwSeRF5WRkI/A6iSsJdYieYRZABO+ij0Wygo
         Lo/VJnPn76360uFCIIy+stRki3L1XZCSg1jPNkH82SaVmeEYzi7frVKaZzL2sstBoAE5
         YuTpZ9a+sHGLMn7wSAkZ4xaZH5NHgu5+lQiwjltkkU4Xchb+3WFO1/OT/SsMyB5YTCKq
         vGn4XXff29JRy16xTaGRBisMX9dVxL0S14uarJH8M7adfNiA41rbssBJ5gJ3x/l6WkfM
         cVG0i4r+p0/g8qVkqC3D4MPpQ0JFBX01PwrhMyxSAIovASAQQbfTTtwsyQ5rzvsif2+g
         mo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZuTpFWe2nt7y+/QS811q/nmqipRVURrHatiPCF7ae4=;
        b=ZuGEzUvtk4R3StZjfHJMnKZW9JKC8y881NcpSYg9mJ0ci1R3i5WyD91Yf6HZdoVOYy
         Ww0EzFZX5V6E4wFUJZAqPagaBJVjCkiJ3pb3bthkVPcJzwTtvY9pwkniaRyiuYUCBCMU
         KK2u2YwZCXFiI3qacy8jRA4iQ0sXylpETB7I51ksNOr+XT4de4ffj42MnAHvOF2lif6B
         GGz2v0XzG3gpw38U67RBa5J9l176xprNf5GP/LroBmUiO8qefHm+SLd8hOp/irplmDeH
         oJcSL9RlLIyqZ0QDD9aDlJiQxOoSFvdFueWAtQhUg2EJOyjy0lf9ALYOQLzYCNGStqZF
         0jdw==
X-Gm-Message-State: APjAAAWNYK6f53XtE2ONbA7O2LdTvtRXEXSQJdOitdmd+HhLp+xRctKD
        J4iUQdIocPO32+TNSmmuyd6xdQ==
X-Google-Smtp-Source: APXvYqyHeNGMSajC8LayRoc9yXnyTbryp7gzBAKte1EONsNRmPFxAu/9i1w4lJZvzvM2peXVF4NhrA==
X-Received: by 2002:a37:8ac7:: with SMTP id m190mr8450373qkd.385.1565965906561;
        Fri, 16 Aug 2019 07:31:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 6sm3412555qtu.15.2019.08.16.07.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 07:31:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hydGb-0003DR-B1; Fri, 16 Aug 2019 11:31:45 -0300
Date:   Fri, 16 Aug 2019 11:31:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org DRI Development" 
        <dri-devel@lists.freedesktop.org>,
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
Message-ID: <20190816143145.GD5398@ziepe.ca>
References: <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <20190815201323.GU21596@ziepe.ca>
 <20190816081029.GA27790@dhcp22.suse.cz>
 <20190816121906.GC5398@ziepe.ca>
 <20190816122625.GA10499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816122625.GA10499@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 02:26:25PM +0200, Michal Hocko wrote:
> On Fri 16-08-19 09:19:06, Jason Gunthorpe wrote:
> > On Fri, Aug 16, 2019 at 10:10:29AM +0200, Michal Hocko wrote:
> > > On Thu 15-08-19 17:13:23, Jason Gunthorpe wrote:
> > > > On Thu, Aug 15, 2019 at 09:35:26PM +0200, Michal Hocko wrote:
> > > > 
> > > > > > The last detail is I'm still unclear what a GFP flags a blockable
> > > > > > invalidate_range_start() should use. Is GFP_KERNEL OK?
> > > > > 
> > > > > I hope I will not make this muddy again ;)
> > > > > invalidate_range_start in the blockable mode can use/depend on any sleepable
> > > > > allocation allowed in the context it is called from. 
> > > > 
> > > > 'in the context is is called from' is the magic phrase, as
> > > > invalidate_range_start is called while holding several different mm
> > > > related locks. I know at least write mmap_sem and i_mmap_rwsem
> > > > (write?)
> > > > 
> > > > Can GFP_KERNEL be called while holding those locks?
> > > 
> > > i_mmap_rwsem would be problematic because it is taken during the
> > > reclaim.
> > 
> > Okay.. So the fs_reclaim debugging does catch errors.
> 
> I do not think fs_reclaim is the udnerlying mechanism to catch this
> deadlock. 

Indeed lockdep would catch it directly as an AA deadlock, but only if
we happen to take the reclaim path under the kmalloc in the notifier
and lucked into it also choosing to lock the same lock we are holding.

The trouble is this is very difficult to hit.

lockdep allows making this less difficult. For instance with a
'might_reclaim()' annotation in the allocator we could check that the
various reclaim related locks are obtainable. Testing doesn't need to
get lucky and go down the very unlikely path.

It turns out this is already happening, it is actually a side effect
of the way fs_reclaim works now.

> > Do you have any
> > reference for what a false positive looks like? 
> 
> I believe I have given some examples when introducing __GFP_NOLOCKDEP.

Okay, I think that is 7e7844226f10 ("lockdep: allow to disable reclaim
lockup detection") Hmm, sadly the lkml link in the commit is broken.

Hum. There are no users of __GFP_NOLOCKDEP today?? Could all the false
positives have been fixed??

Keep in mind that this fs_reclaim was reworked away from the hacky
interrupt context flag to a fairly elegant real lock map.

Based on my read of the commit message, my first reaction would be to
suggest lockdep_set_class() to solve the problem described, ie
different classes for 'inside transaction' and 'outside transaction'
on xfs_refcountbt_init_cursor()

I understood that generally that is the way to handle lockdep false
positives.

Anyhow, if you are willing to consider that lockdep isn't broken, I
have some ideas on how to make this clearer and increase
coverage. Would you be willing to look at patches on this topic? (not
soon, I have to finish my mmu notifier stuff)

> > I would like to inject it into the notifier path as this is very
> > difficult for driver authors to discover and know about, but I'm
> > worried about your false positive remark.
> > 
> > I think I understand we can use only GFP_ATOMIC in the notifiers, but
> > we need a strategy to handle OOM to guarentee forward progress.
> 
> Your example is from the notifier registration IIUC. 

Yes, that is where this commit hit it.. Triggering this under an
actual notifier to get a lockdep report is hard.

> Can you pre-allocate before taking locks? Could you point me to some
> examples when the allocation is necessary in the range notifier
> callback?

Hmm. I took a careful look, I only found mlx5 as obviously allocating
memory:

 mlx5_ib_invalidate_range()
  mlx5_ib_update_xlt()
   __get_free_pages(gfp, get_order(size));

However, I think this could be changed to fall back to some small
buffer if allocation fails. The existing scheme looks sketchy

nouveau does:

 nouveau_svmm_invalidate
  nvif_object_mthd
   kmalloc(GFP_KERNEL)

But I think it reliably uses a stack buffer here

i915 I think Daniel said he audited.

amd_mn.. The actual invalidate_range_start does not allocate memory,
but it is entangled with so many locks it would need careful analysis
to be sure.

The others look generally OK, which is good, better than I hoped :)

Jason
