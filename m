Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D65C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA89222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfIZI67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfIZI66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:58:58 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9ED665859E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:58:58 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id z13so1281298pfr.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L9VfLVOKM8R9jc1z9s5TsnK21zyB5Qwdz7pgoArH7ZU=;
        b=FRw1iMBhwxI9rXPjyC0mckE0jlJIUdjPrjhKe8yBg1kXYTEUwfibaHMUmjgVFYIxiW
         5iiXnHUg7imxbaL0RIDXjs8js5Dg8LRtWdCB6MSyViz18Iqh6t9bEqY2FofSlov3QeKi
         67YyjWsLb5sZ+ChfZ62WVYaDcIuf11n8HxByHk9xf1y27Wr5k5nGi0t8/XR8U2G5rfmY
         2fjJzi+NMitaDUPtz2TGNtqz9uJikODpToBmMNH3UDy+BSefukIFsB3I32qKQ6Ibi4u2
         g4AOduUHWe1mZKmsts3GLfWD4BOErhPJ6XuDxVJyq/xBgFtzGsaDWDt6o/IG4B4C+9GG
         4Jaw==
X-Gm-Message-State: APjAAAU3iK/T/7IcKA5eSUB5ZPW+GwL+3FwSNLfEI8ImCT06ehIijEAB
        5a7EGQxHm4bWgXZIijGQSKA913zCIzgZdNt7a46V2xcPKQ/SEXUtAOoDLcLEfm/IWCkY3VfvZGm
        MoG3avvgfAqrV8nvmYi7tu5hj
X-Received: by 2002:a17:90a:1090:: with SMTP id c16mr2409837pja.132.1569488338077;
        Thu, 26 Sep 2019 01:58:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhaZZThluUL2F/LQPkfZtnZIdTa4Wg7MLC8P+1p0q6ib/uQgwy0h20Y+B1DooAZuLsy2ZgwA==
X-Received: by 2002:a17:90a:1090:: with SMTP id c16mr2409814pja.132.1569488337664;
        Thu, 26 Sep 2019 01:58:57 -0700 (PDT)
Received: from xz-x1 ([114.250.102.230])
        by smtp.gmail.com with ESMTPSA id b24sm1341257pgs.15.2019.09.26.01.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 01:58:56 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:58:49 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 05/10] mm: Return faster for non-fatal signals in user
 mode faults
Message-ID: <20190926085849.GA3077@xz-x1>
References: <20190923042523.10027-1-peterx@redhat.com>
 <20190923042523.10027-6-peterx@redhat.com>
 <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
 <20190924024721.GD28074@xz-x1>
 <20190924025447.GE1855@bombadil.infradead.org>
 <20190924031908.GF28074@xz-x1>
 <20190924154518.GG1855@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924154518.GG1855@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:45:18AM -0700, Matthew Wilcox wrote:

[...]

> Oh, and while you're looking at the callers of handle_mm_fault(), a
> lot of them don't check conditions in the right order.  x86, at least,
> handles FAULT_RETRY before handling FAULT_ERROR, which is clearly wrong.
> 
> Kirill and I recently discussed it here:
> https://lore.kernel.org/linux-mm/20190911152338.gqqgxrmqycodfocb@box/T/

Is there any existing path in master that we can get VM_FAULT_RETRY
returned with any existing VM_FAULT_ERROR bit?  It seems to me that
above link is the first one that is going to introduce such case?

If so, I'm uncertain now on whether I should have one patch to handle
the ERROR case first as you suggested with this series, because
otherwise that patch won't explain itself without a real benefit...

Thanks,

-- 
Peter Xu
