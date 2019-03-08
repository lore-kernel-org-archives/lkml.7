Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE831C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B032A20675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCHCYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:24:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41721 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCHCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:24:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so19658740qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 18:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HFB1/hmklm0Jy3Ks9RMvEc3DUyAnT1Dy4tSZTF9cz4o=;
        b=hwOJmiUFNtDJ9dVzLH/7Ioxlho8XXPeGXYaZaxzJJF+ih0qNTM59oUL7H55vrfuMYT
         E1dK9Ed6CJHq6GluSRfahoYTyPJx5EJAGr7qNx7PjWdN2h6VNvJgYN0RUnhaP1cazTRp
         8wh4MLm57ndRSQYc5HwoAw1qO4Ym/gL9w1SbYKpvMuG8RLqBZzp2+Zeznr8IU4eMFdBR
         fI3VjdzRU+MQtfir/MpGzTKDJ6SLmD8VZ/vjoA02dKHPMLLIngS1ujzEv6494YenCR/z
         xxFPLPEtN4eAJFjgM9RZPyA438RnYSEAne2uNefxc8mXGQiiwO6KtxHeC/eh2KUYZJ/8
         nmVg==
X-Gm-Message-State: APjAAAWNRT4tu3GMiP7n7bDCXuAZKVNo9H62VXHm7y0S0ayUGl4jsHE/
        3AV6SMWxvuzsp5ZjCZAvj4AWGQ==
X-Google-Smtp-Source: APXvYqxyR5VSZJ10NMp5R3OZz2CZl0aMWXR/whNO6r58qmBONItF91Ol3Hiusgm23h08v4UTO1SLzA==
X-Received: by 2002:aed:21cc:: with SMTP id m12mr12868000qtc.203.1552011845911;
        Thu, 07 Mar 2019 18:24:05 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id c73sm4923114qka.37.2019.03.07.18.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 18:24:05 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:24:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190307212253-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <CAKgT0Ud35pmmfAabYJijWo8qpucUWS8-OzBW=gsotfxZFuS9PQ@mail.gmail.com>
 <1d5e27dc-aade-1be7-2076-b7710fa513b6@redhat.com>
 <CAKgT0UdNPADF+8NMxnWuiB_+_M6_0jTt5NfoOvFN9qbPjGWNtw@mail.gmail.com>
 <2269c59c-968c-bbff-34c4-1041a2b1898a@redhat.com>
 <CAKgT0UdHkDB1vFMp7T9_pdoiuDW4qvgxhqsNztPQXrRCAmYNng@mail.gmail.com>
 <20190307134744-mutt-send-email-mst@kernel.org>
 <ebca2674-ac15-f1a9-87a4-2ee17a257e4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebca2674-ac15-f1a9-87a4-2ee17a257e4c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:27:32PM +0100, David Hildenbrand wrote:
> On 07.03.19 19:53, Michael S. Tsirkin wrote:
> > On Thu, Mar 07, 2019 at 10:45:58AM -0800, Alexander Duyck wrote:
> >> To that end what I think w may want to do is instead just walk the LRU
> >> list for a given zone/order in reverse order so that we can try to
> >> identify the pages that are most likely to be cold and unused and
> >> those are the first ones we want to be hinting on rather than the ones
> >> that were just freed. If we can look at doing something like adding a
> >> jiffies value to the page indicating when it was last freed we could
> >> even have a good point for determining when we should stop processing
> >> pages in a given zone/order list.
> >>
> >> In reality the approach wouldn't be too different from what you are
> >> doing now, the only real difference would be that we would just want
> >> to walk the LRU list for the given zone/order rather then pulling
> >> hints on what to free from the calls to free_one_page. In addition we
> >> would need to add a couple bits to indicate if the page has been
> >> hinted on, is in the middle of getting hinted on, and something such
> >> as the jiffies value I mentioned which we could use to determine how
> >> old the page is.
> > 
> > Do we really need bits in the page?
> > Would it be bad to just have a separate hint list?
> > 
> > If you run out of free memory you can check the hint
> > list, if you find stuff there you can spin
> > or kick the hypervisor to hurry up.
> > 
> > Core mm/ changes, so nothing's easy, I know.
> 
> We evaluated the idea of busy spinning on some bit/list entry a while
> ago. While it sounds interesting, it is usually not what we want and has
> other negative performance impacts.
> 
> Talking about "marking" pages, what we actually would want is to rework
> the buddy to skip over these "marked" pages and only really spin in case
> there are no other pages left. Allocation paths should only ever be
> blocked if OOM, not if just some hinting activity is going on on another
> VCPU.
> 
> However as you correctly say: "core mm changes". New page flag?
> Basically impossible.

Well not exactly. page bits are at a premium but only for
*allocated* pages. pages in the buddy are free and there are
some unused bits for these.

> Reuse another one? Can easily get horrbily
> confusing and can easily get rejected upstream. What about the buddy
> wanting to merge pages that are marked (assuming we also want something
> < MAX_ORDER - 1)? This smells like possibly heavy core mm changes.
> 
> Lesson learned: Avoid such heavy changes. Especially in the first shot.
> 
> The interesting thing about Nitesh's aproach right now is that we can
> easily rework these details later on. The host->guest interface will
> stay the same. Instead of temporarily taking pages out of the buddy, we
> could e.g. mark them and make the buddy or other users skip over them.
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
