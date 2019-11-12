Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE9C2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="g5FCw/Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKLA4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:56:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45721 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLA4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:56:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so10611769pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G+W/WgXFQW+lt7IfFRrFaHlfa6KYsGjbDHKvVT4OS68=;
        b=g5FCw/IrcyCS1t94m4uHwMuV4Q3V5h7wkcZG9mdWN/i4/r74kHXoFxRopB1hP4HYNT
         Rhoi+JpodhCjU4z0t5yxD8TCE0oGNH9l3mtzZgtTyqlmi/2Ljg9eR8fZ6areT3FHNMlr
         r03QRqPz9c4fvkCM9ISoeNY5EZ01cyxNKr2mLZhYt3uuA1yD6sgpRN5CWro+j6gfUxEO
         KkUygH0E0yiK9/Uyfx76DxUJQCVplN5l8caDT5g5QzoqGNU3jzDytjWqGut9jEKw8bK5
         aYkIhntlaimGrJkGOKh0k6ZKz10+Cq9LjdKyiZs96ik3WI6w++0q+vnhKfAV7KPAhTTk
         y6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+W/WgXFQW+lt7IfFRrFaHlfa6KYsGjbDHKvVT4OS68=;
        b=CKPHxh1eK0MmaRQNouZ+wS5NmiS8TGMlHObM8Tqmrq0Rn0nu2XfaHewpuCkXTfU01s
         CnvkanWi3pjU1B+uhnx4p2tIoQY8YeOS7VX1zxjWCpGp5Pv+DyzVjquAdLI3LHTBtWOO
         JkbS8r4TmtYI2t3pUBCkcEwLOhdR068IMFnw316m/JYzHvXTv5tSK3umJyWiQC/ta0nI
         WZoslFJLzyy4AJqQJPDQE0Yu9tOVxvfwfUfDLM1HyoBRDA7DoQtbf83extY/HGBWyg7g
         AoyWYXXxlmzyfslOzajTfZzHSSQbhoObaQ61tF0iNfDhccYe0W5Rs+rGwLPhAE/oOOHD
         M7PQ==
X-Gm-Message-State: APjAAAWVi5aq2InKS2NB+rk8YT3VZgfoqu1fbRyMK3+T+iNGPt1k7kHh
        uT55JF88TLjjomIZu3IhhWi3Fw==
X-Google-Smtp-Source: APXvYqw9wZ8KS9Kjzz+u+JmppGkycaLQwPal5QAlHhwTBI9UAlrxZzGzLRvP1TWhZaqpf0BzWA2MdQ==
X-Received: by 2002:a63:950c:: with SMTP id p12mr33368602pgd.238.1573520170966;
        Mon, 11 Nov 2019 16:56:10 -0800 (PST)
Received: from localhost ([2401:fa00:d:2:4dd6:fffa:d6aa:9572])
        by smtp.gmail.com with ESMTPSA id k103sm627402pje.16.2019.11.11.16.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:56:10 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:56:07 +0900
From:   Sandeep Patil <sspatil@android.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
Message-ID: <20191112005607.GB17144@google.com>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local>
 <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
 <20191105094259.GX10326@phenom.ffwll.local>
 <CALAqxLWvNOL=Exybb25GgYQujyJcPNTsFuaBnjLQPKTkVAi6Xw@mail.gmail.com>
 <CAKMK7uFSBNqVWy0N-GH7CzH-R7c9CVb97LgCffdMzGCgvVan4Q@mail.gmail.com>
 <CALAqxLV+MfESanq+PenRUNR_w6KZT1KQ7suPjmiT-bdAFx83EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLV+MfESanq+PenRUNR_w6KZT1KQ7suPjmiT-bdAFx83EA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:47:53AM -0800, John Stultz wrote:
> On Tue, Nov 5, 2019 at 11:19 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Tue, Nov 5, 2019 at 6:41 PM John Stultz <john.stultz@linaro.org> wrote:
> > > On Tue, Nov 5, 2019 at 1:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
> > > > > On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > > On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> > > > > So even if the heaps are configured via DT (which at the moment there
> > > > > is no such binding, so that's not really a valid method yet), there's
> > > > > still the question of if the heap is necessary/makes sense on the
> > > > > device. And the DT would only control the availability of the heap
> > > > > interface, not if the heap driver is loaded or not.
> > > >
> > > > Hm I thought the cma regions are configured in DT? How does that work if
> > > > it's not using DT?
> > >
> > > So yea, CMA regions are either configured by DT or setup at build time
> > > (I think there's a cmdline option to set it up as well).
> > >
> > > But the CMA regions and the dmabuf cma heap driver are separate
> > > things. The latter uses the former.
> >
> > Huh, I assumed the plan is that whenever there's a cma region, we want
> > to instantiate a dma-buf heap for it? Why/when would we not want to do
> > that?
> 
> Not quite. Andrew noted that we may not want to expose all CMA regions
> via dmabuf heaps, so right now we only expose the default region. I
> have follow on patches that I sent out earlier (which requires a
> to-be-finalized DT binding) which allows us to specify which other CMA
> regions to expose.
> 
> > > > > On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
> > > > > for the display framebuffer. So gralloc uses ION to allocate from the
> > > > > CMA heap. However on the db845c, it has no such restrictions, so the
> > > > > CMA heap isn't necessary.
> > > >
> > > > Why do you have a CMA region for the 2nd board if you don't need it?
> > > > _That_ sounds like some serious memory waster, not a few lines of code
> > > > loaded for nothing :-)
> > >
> > > ??? That's not what I said above.  If the db845c doesn't need CMA it
> > > won't have a CMA region.
> > >
> > > The issue at hand is that we may want to avoid loading the dmabuf CMA
> > > heap driver on a board that doesn't use CMA.
> >
> > So the CMA core code is also a module, or how does that work? Not
> 
> No.  CMA core isn't available as a module.
> 
> > loading the cma dma-buf heap, but keeping all the other cma code
> > around feels slightly silly. Do we have numbers that justify this
> > silliness?
> 
> I agree that is maybe not the most critical item on the list, but its
> one of many that do add up over time.
> 
> Again, I'll defer to Sandeep or other folks on the Google side to help
> with the importance here. Mostly I'm trying to ensure there is
> functional parity to ION so we don't give folks any reason they could
> object to deprecating it.

Parity with ION will definitely be nice. For now, however, even if we achieve
that parity with UAPI and think about the cma-heap-as-module bit later, I
guess that's ok.

The real problem is the need for these heaps to be a module in the first
place.  I'd much rather have an upstream user to show the need for cache
maintenance operations that have been talked about so many times, so we can
make them happen for dma-buf-heaps in upstream. None of this has to be
a module if that happens :(.

The reason for the "modularization"  for ion heaps is also the CMOs for
Android use cases. Unfortunately we haven't had any luck with proving the
need for. John, CMIIW.


- ssp
