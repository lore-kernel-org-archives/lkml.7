Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7CEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9BD206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VQdtk6+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLAtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:49:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLAtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:49:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so11985221pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHfnAOauvxH+QL+M+wn9JpGV7bZ6YLTyV5/QqLFO508=;
        b=VQdtk6+sVfprM7qZTXqIDkWhg0OjK2FDZJUwAwjlfjciFxsVW+EzV+nHkeNI5IboAn
         +7tK8kfxQrDg62LsReAYo1ywxA9lg8h7VJ2i9mQhAIqVBYC+0oaWQSpAyrOGdgs3kHVh
         d9EyKMqI8wbgrgWR33rBI3gRvJLFYBOAwbkVyHVEBZaT0hn5i8RMxAdujwy9ZcvG/btj
         DEMS11YGsJpX0kbqGW7XXU97zYz6mSATFbrKqVYK0mzeLnuKhygSLZVwurS7uUjHl2p/
         BwFp7y1o70WNvp8LlfOb7K2yuD05pKgpvpRXjsA5RdGnUyhaX+PEFMjQup4tfkeAgGlK
         +nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHfnAOauvxH+QL+M+wn9JpGV7bZ6YLTyV5/QqLFO508=;
        b=p7YGNIyBFhu8bNISXg1jhjueCgjGv18pqF0k03asZuu/O44RHzi/Fjxn0gfcSN+uYS
         RmVRDMF6OjqC75YAfRW8stI+zFDpjDtEFRNF9theesdCL8h4XaA8Xq8wZg57pTabQAzP
         bM9UrJhcEhUAELYSpMFscLiuWjSSzV7xTvJd0s54rLeLi/TI7ZpFh8ivqXbwBDay3L5T
         ZCHTENijWIs88+5sK4s+VxWSzlUPepsIiqwfILgwNv7NYrljZ4op63MMB2kjzCIyCdDv
         wMFRfImcEyBNi+7rOynJLyAEGioE31iz9OOpXA5VlxjNRebcmkFq4MPElB7G7JDZSjJk
         T1Sw==
X-Gm-Message-State: APjAAAVDIL1vrkb6Ya5Y6oG64UJVQVKi8ZSn5iqHZfM/JQ+/mZQwE2Bf
        KzQte3SOSetzmgBE9to1fMTs8g==
X-Google-Smtp-Source: APXvYqz5TX5mwtEo3ZJSHgMs9ccFOENBQqOOu8UqyWeIhtwLLZ/ZiqWEfYRhTOQY8AW5U9Fi7nROJA==
X-Received: by 2002:a62:1c91:: with SMTP id c139mr23723641pfc.175.1573519746088;
        Mon, 11 Nov 2019 16:49:06 -0800 (PST)
Received: from localhost ([2401:fa00:d:2:4dd6:fffa:d6aa:9572])
        by smtp.gmail.com with ESMTPSA id q41sm596688pja.20.2019.11.11.16.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:49:05 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:49:02 +0900
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
Message-ID: <20191111062807.GA17144@google.com>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local>
 <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
 <20191105094259.GX10326@phenom.ffwll.local>
 <CALAqxLWvNOL=Exybb25GgYQujyJcPNTsFuaBnjLQPKTkVAi6Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWvNOL=Exybb25GgYQujyJcPNTsFuaBnjLQPKTkVAi6Xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:41:44AM -0800, John Stultz wrote:
> On Tue, Nov 5, 2019 at 1:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
> > > On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> > > So even if the heaps are configured via DT (which at the moment there
> > > is no such binding, so that's not really a valid method yet), there's
> > > still the question of if the heap is necessary/makes sense on the
> > > device. And the DT would only control the availability of the heap
> > > interface, not if the heap driver is loaded or not.
> >
> > Hm I thought the cma regions are configured in DT? How does that work if
> > it's not using DT?
> 
> So yea, CMA regions are either configured by DT or setup at build time
> (I think there's a cmdline option to set it up as well).
> 
> But the CMA regions and the dmabuf cma heap driver are separate
> things. The latter uses the former.
> 
> > > On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
> > > for the display framebuffer. So gralloc uses ION to allocate from the
> > > CMA heap. However on the db845c, it has no such restrictions, so the
> > > CMA heap isn't necessary.
> >
> > Why do you have a CMA region for the 2nd board if you don't need it?
> > _That_ sounds like some serious memory waster, not a few lines of code
> > loaded for nothing :-)
> 
> ??? That's not what I said above.  If the db845c doesn't need CMA it
> won't have a CMA region.
> 
> The issue at hand is that we may want to avoid loading the dmabuf CMA
> heap driver on a board that doesn't use CMA.
> 
> 
> > > With Android's GKI effort, there needs to be one kernel that works on
> > > all the devices, and they are using modules to try to minimize the
> > > amount of memory spent on functionality that isn't universally needed.
> > > So on devices that don't need the CMA heap, they'd probably prefer not
> > > to load the CMA dmabuf heap driver, so it would be best if it could be
> > > built as a module.  If we want to build the CMA heap as a module, the
> > > symbols it uses need to be exported.
> >
> > Yeah, I guess I'm disagreeing on whether dma-buf heaps are core or not.
> 
> That's fine to dispute. I'm not really in a place to assert one way or
> not, but the Android folks have made their ION system and CMA heaps
> loadable via a module, so it would seem like having the dmabuf system
> and CMA heaps be modular would be useful to properly replace that
> usage.
> 
> For instance, the system heap as a module probably doesn't make much
> sense, as most boards that want to use the dmabuf heaps interface are
> likely to use that as well.  CMA is more optional as not all boards
> will use that one, so it might make sense to avoid loading it.
> 
> Sandeep: Can you chime in here as to how critical having the system
> and cma heaps be modules are?

With ion, we are making sure there are *standard* heaps that Android should
be able to rely on to exist in all kernels [1]. That list is based on what
default heaps ion had out-of-tree.

As of today, even from those that ion had, Android vendor independent code only
relies on 'system heap' and 'cma/dma heaps' so, can safely ignore the carveout
and other ion heaps.

system heap is really the one that is realistically 'hardware independent',
so that can be in kernel. The cma heaps and their existence is optional, so
it will be nice to be able to load them as modules.


<snip>

- ssp

1. https://android.googlesource.com/platform/system/core/+/refs/heads/master/libion/kernel-headers/linux/ion_4.19.h#28
