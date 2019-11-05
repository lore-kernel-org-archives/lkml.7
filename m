Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A347C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D3D217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kTl+haPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfKEJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:43:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbfKEJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:43:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id w18so20526815wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/VJ6M2+7hwOEEdLHqHiPh0eW3cGFy3lItJn6scbrkU=;
        b=kTl+haPDx5U6Fx1XlOyiFqVx0h+M0wDWGpkPmdSzIZx09oMjctwEGNnt327IEBPAu3
         Ih1Z4srBFKmE/cWxitDHZaMhrhUpZ2RvSWB+041gOx1qNYaNb3w684F1JJFCZlzrW3Gd
         /6PnBpS0F3UISGPTN6qcGSzBJ9c9z6SzqlIL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4/VJ6M2+7hwOEEdLHqHiPh0eW3cGFy3lItJn6scbrkU=;
        b=QrvLwl7aKKg9NapsSRQudRlZzrA9dH4eFsyMP9uitx6eIzERZdT/tFYvS8PtiuWURW
         B8QrWYSPTNeQXD+GpqstCnBaFBRYuP7jBDYLcZ9JRdGMilbePEpIHjymv3Ih61ovhZqX
         SdfiM+z0zGdWgp5jsCc0ULKsxwfxoBfRr4NokOtkcrVXxb+qoNUi++E7q4jPU9onT4OU
         x9J0OjLf7hSwKqLLXnjQycodQZxjUB4rhAhKH2rvaUUB+Jt03wK8lMFKBFTdz2OuLfCL
         6wPIQ2th0GsFWGI1OliDfXyl82WSw8vk85GoJiqxd1C6gDZgFMSCfahaglH9ih1Q9nPU
         7j3w==
X-Gm-Message-State: APjAAAU3gwoCn52ufvD8x8j78ba4mqBZyhKIBqU+F0LSSy32Wr/wYomx
        6CnfzKRjo+aTPsK+CRs73sX76Q==
X-Google-Smtp-Source: APXvYqzjhUTNVruYhgZfTmLkZ34XimMiuypNBa3cC7z8/2/Ifk+JRdi+Kaed6KOmzy91cnLXEvZNOg==
X-Received: by 2002:adf:e682:: with SMTP id r2mr12546257wrm.358.1572946982169;
        Tue, 05 Nov 2019 01:43:02 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id q6sm20672730wrx.30.2019.11.05.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 01:43:01 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:42:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
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
Message-ID: <20191105094259.GX10326@phenom.ffwll.local>
Mail-Followup-To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local>
 <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
> On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> > > Now that the DMA BUF heaps core code has been queued, I wanted
> > > to send out some of the pending changes that I've been working
> > > on.
> > >
> > > For use with Android and their GKI effort, it is desired that
> > > DMA BUF heaps are able to be loaded as modules. This is required
> > > for migrating vendors off of ION which was also recently changed
> > > to support modules.
> > >
> > > So this patch series simply provides the necessary exported
> > > symbols and allows the system and CMA drivers to be built
> > > as modules.
> > >
> > > Due to the fact that dmabuf's allocated from a heap may
> > > be in use for quite some time, there isn't a way to safely
> > > unload the driver once it has been loaded. Thus these
> > > drivers do no implement module_exit() functions and will
> > > show up in lsmod as "[permanent]"
> > >
> > > Feedback and thoughts on this would be greatly appreciated!
> >
> > Do we actually want this?
> 
> I guess that always depends on the definition of "we" :)
> 
> > I figured if we just state that vendors should set up all the right
> > dma-buf heaps in dt, is that not enough?
> 
> So even if the heaps are configured via DT (which at the moment there
> is no such binding, so that's not really a valid method yet), there's
> still the question of if the heap is necessary/makes sense on the
> device. And the DT would only control the availability of the heap
> interface, not if the heap driver is loaded or not.

Hm I thought the cma regions are configured in DT? How does that work if
it's not using DT?

> On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
> for the display framebuffer. So gralloc uses ION to allocate from the
> CMA heap. However on the db845c, it has no such restrictions, so the
> CMA heap isn't necessary.

Why do you have a CMA region for the 2nd board if you don't need it?
_That_ sounds like some serious memory waster, not a few lines of code
loaded for nothing :-)

> With Android's GKI effort, there needs to be one kernel that works on
> all the devices, and they are using modules to try to minimize the
> amount of memory spent on functionality that isn't universally needed.
> So on devices that don't need the CMA heap, they'd probably prefer not
> to load the CMA dmabuf heap driver, so it would be best if it could be
> built as a module.  If we want to build the CMA heap as a module, the
> symbols it uses need to be exported.

Yeah, I guess I'm disagreeing on whether dma-buf heaps are core or not.

> > Exporting symbols for no real in-tree users feels fishy.
> 
> I'm submitting an in-tree user here. So I'm not sure what you mean?  I
> suspect you're thinking there is some hidden/nefarious plan here, but
> really there isn't.

I was working under the assumption that you're only exporting the symbols
for other heaps, and keep the current ones in-tree. Are there even any
out-of-tree dma-buf heaps still? out-of-tree and legit different use-case
I mean ofc, not just out-of-tree because inertia :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
