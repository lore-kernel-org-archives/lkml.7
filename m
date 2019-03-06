Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B072206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCFWSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:18:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43462 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCFWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:18:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so7844937qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 14:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2N9aqlQ4HKUDuST4gxVpBphoZcSf8YauDOaIeVrJnFs=;
        b=WQiNUzgtRnVxdDh9gQRq+l944RyldE/d4gFp5SRr8HkA8uovmOXq4sQ18qg1LB4rjp
         v4K0bv2Yn8SiRUw8sSeTMrpDlv68sQhjhzU88V9vX+TZdLRrrDFmzKEwZgt6MOrsjgBC
         mmW65YBp1nPQSl7JLDFms38GmS7rw0UGfH812TWPEZsEfWrS01StOXhgTAWB9YlArMgq
         IB0rxo4yFWB67d5yj52rwHRMOkGtFP6YZQpejskhfdA5Ms+75cNeFWUI6vnRvWvI4tWY
         U9CmXL8NIog6NhOXaq3TI/RJqkK5il4SU6UOFq3aQX3JyZJdRp1iqIFfmwa7cBV9PMoX
         Iqyg==
X-Gm-Message-State: APjAAAUgfPFPXuYt2VvgKFsYlMX0BDqDEihERXvfW39Q5tYLfddSbZ+l
        v3kQDwjXkSJwbdu/2e1ISa2OzA==
X-Google-Smtp-Source: APXvYqwa7usRRktLyp0btTR2809ewmFaZN798RXEPUOi6V3KI7/AZqnpk1HZl4MAQMWfVpUmYM4Rnw==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr7487577qke.248.1551910715164;
        Wed, 06 Mar 2019 14:18:35 -0800 (PST)
Received: from redhat.com ([50.235.185.82])
        by smtp.gmail.com with ESMTPSA id o4sm1712887qke.30.2019.03.06.14.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 14:18:34 -0800 (PST)
Date:   Wed, 6 Mar 2019 17:18:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190306165223-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
 <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
 <20190306133826-mutt-send-email-mst@kernel.org>
 <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com>
 <20190306140917-mutt-send-email-mst@kernel.org>
 <9ead968e-0cc6-0061-de5c-42a3cef46339@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ead968e-0cc6-0061-de5c-42a3cef46339@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:40:57PM +0100, David Hildenbrand wrote:
> On 06.03.19 21:32, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 07:59:57PM +0100, David Hildenbrand wrote:
> >> On 06.03.19 19:43, Michael S. Tsirkin wrote:
> >>> On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> >>>>>> Here are the results:
> >>>>>>
> >>>>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> >>>>>> total memory of 15GB and no swap. In each of the guest, memhog is run
> >>>>>> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> >>>>>> using Free command.
> >>>>>>
> >>>>>> Without Hinting:
> >>>>>>                  Time of execution    Host used memory
> >>>>>> Guest 1:        45 seconds            5.4 GB
> >>>>>> Guest 2:        45 seconds            10 GB
> >>>>>> Guest 3:        1  minute               15 GB
> >>>>>>
> >>>>>> With Hinting:
> >>>>>>                 Time of execution     Host used memory
> >>>>>> Guest 1:        49 seconds            2.4 GB
> >>>>>> Guest 2:        40 seconds            4.3 GB
> >>>>>> Guest 3:        50 seconds            6.3 GB
> >>>>> OK so no improvement.
> >>>> If we are looking in terms of memory we are getting back from the guest,
> >>>> then there is an improvement. However, if we are looking at the
> >>>> improvement in terms of time of execution of memhog then yes there is none.
> >>>
> >>> Yes but the way I see it you can't overcommit this unused memory
> >>> since guests can start using it at any time.  You timed it carefully
> >>> such that this does not happen, but what will cause this timing on real
> >>> guests?
> >>
> >> Whenever you overcommit you will need backup swap.
> > 
> > Right and the point of hinting is that pages can just be
> > discarded and not end up in swap.
> > 
> > 
> > Point is you should be able to see the gain.
> > 
> > Hinting patches cost some CPU so we need to know whether
> > they cost too much. How much is too much? When the cost
> > is bigger than benefit. But we can't compare CPU cycles
> > to bytes. So we need to benchmark everything in terms of
> > cycles.
> > 
> >> There is no way
> >> around it. It just makes the probability of you having to go to disk
> >> less likely.
> > 
> > 
> > Right and let's quantify this. Does this result in net gain or loss?
> 
> Yes, I am totally with you. But if it is a net benefit heavily depends
> on the setup. E.g. what kind of storage used for the swap, how fast, is
> the same disk also used for other I/O ...
> 
> Also, CPU is a totally different resource than I/O. While you might have
> plenty of CPU cycles to spare, your I/O throughput might already be
> limited. Same goes into the other direction.
> 
> So it might not be as easy as comparing two numbers. It really depends
> on the setup. Well, not completely true, with 0% CPU overhead we would
> have a clear winner with hinting ;)

I mean users need to know about this too.

Are these hinting patches a gain:
- on zram
- on ssd
- on a rotating disk
- none of the above
?

If users don't know when would they enable hinting?

Close to one is going to try all possible configurations, test
exhaustively and find an optimal default for their workload.
So it's our job to figure it out and provide guidance.

> 
> > 
> > 
> >> If you assume that all of your guests will be using all of their memory
> >> all the time, you don't have to think about overcommiting memory in the
> >> first place. But this is not what we usually have.
> > 
> > Right and swap is there to support overcommit. However it
> > was felt that hinting can be faster since it avoids IO
> > involved in swap.
> 
> Feels like it, I/O is prone to be slow.
> 
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb

OK so should be measureable.

-- 
MST
