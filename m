Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1CC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC8920684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfCFUcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:32:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47012 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfCFUcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:32:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id i5so7638198qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zdlXK/K9DrmgdShzIBPYnOPsskIKfhagYRirY+udO1c=;
        b=SbK9yK2pioPTU8Q6hMqWvvHZoQWgdBqXFoIIqZoGwaZ6DaNcqIIVHbJ46pLV2QatJN
         mQSBtXK19AXyWl3noxhSs22FyvN0dKlGo6PQ4/W5bMwsDTmFxHv2xDI+brK+u8SQXrKh
         3D1IyOxL/gltY+M/blkKnub/5RyqFCMLRsUHERg5988gp5p46EdE4F2NRT7AnAD0AX1l
         Q94/3VUUNPdxlw/hC3wlyJfms6Y7+ISSLMhi55O9Pka1q3IGlxt6ZdPht0u+0MQ4xAEz
         BoRNIfChspXH2YxsDSYwT4CyjFBy6++dpHJDJGFn7Kaxk4lAU5AfIeTJtDpE97daQ/At
         uVEQ==
X-Gm-Message-State: APjAAAWX3da3uYKObYYhRKDGD4+gRu9oKoys2oUNUuXpcveGqRuiNi5r
        IGzpvwRK8zEEMjUokzigbzFL++CWbYU=
X-Google-Smtp-Source: APXvYqxms3WUU7IeqX32+lnwJ/uUR/49fW9yRJm447yiqeryyZJ3BJoAMav/eWIlJ6fELpmiv5iJ0g==
X-Received: by 2002:a05:620a:124c:: with SMTP id a12mr7158890qkl.103.1551904332106;
        Wed, 06 Mar 2019 12:32:12 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v25sm1108008qtp.92.2019.03.06.12.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 12:32:10 -0800 (PST)
Date:   Wed, 6 Mar 2019 15:32:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190306140917-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
 <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
 <20190306133826-mutt-send-email-mst@kernel.org>
 <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 07:59:57PM +0100, David Hildenbrand wrote:
> On 06.03.19 19:43, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> >>>> Here are the results:
> >>>>
> >>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> >>>> total memory of 15GB and no swap. In each of the guest, memhog is run
> >>>> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> >>>> using Free command.
> >>>>
> >>>> Without Hinting:
> >>>>                  Time of execution    Host used memory
> >>>> Guest 1:        45 seconds            5.4 GB
> >>>> Guest 2:        45 seconds            10 GB
> >>>> Guest 3:        1  minute               15 GB
> >>>>
> >>>> With Hinting:
> >>>>                 Time of execution     Host used memory
> >>>> Guest 1:        49 seconds            2.4 GB
> >>>> Guest 2:        40 seconds            4.3 GB
> >>>> Guest 3:        50 seconds            6.3 GB
> >>> OK so no improvement.
> >> If we are looking in terms of memory we are getting back from the guest,
> >> then there is an improvement. However, if we are looking at the
> >> improvement in terms of time of execution of memhog then yes there is none.
> > 
> > Yes but the way I see it you can't overcommit this unused memory
> > since guests can start using it at any time.  You timed it carefully
> > such that this does not happen, but what will cause this timing on real
> > guests?
> 
> Whenever you overcommit you will need backup swap.

Right and the point of hinting is that pages can just be
discarded and not end up in swap.


Point is you should be able to see the gain.

Hinting patches cost some CPU so we need to know whether
they cost too much. How much is too much? When the cost
is bigger than benefit. But we can't compare CPU cycles
to bytes. So we need to benchmark everything in terms of
cycles.

> There is no way
> around it. It just makes the probability of you having to go to disk
> less likely.


Right and let's quantify this. Does this result in net gain or loss?


> If you assume that all of your guests will be using all of their memory
> all the time, you don't have to think about overcommiting memory in the
> first place. But this is not what we usually have.

Right and swap is there to support overcommit. However it
was felt that hinting can be faster since it avoids IO
involved in swap.

> > 
> > So the real reason to want this is to avoid need for writeback on free
> > pages.
> > 
> > Right?
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
