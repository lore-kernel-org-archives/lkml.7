Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B82133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDIODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:03:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41696 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfDIODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:03:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so19840799qta.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n26vjmHJGZ0EQn/mtrk4R3AZxBm3F/1GBg0P+TlV7oI=;
        b=EilNAf8ZMnbfv4W0BM4MEAEJJrIDSqZ+rZH+B+eWza2h21dW1E5ugT1edaj9KeijtL
         phYCfi2ABHMHgJcA/hwWxswj54WhFC0z1seoHaBqN3GgLLKleBqQQWEzfaVzu1nadZt8
         9+XGSxUtGSXVWnGVhj6fZsRhOJiNkHEEoBpXYr4biI7hthGyNGcVDuwyTYWQnXayOJxO
         NuKgFJhO/EFD7w4++8Mn304ChE0iHK8p4cORqL0GoNArETlCu9HDs5eJ08NAp4lTNQjy
         iSAlegxSDmIYwpLraMQmr9tS3sFgQslR4TogOC4XA7mdWhUP9r69VBM0+2NQyvajIrxA
         wI0Q==
X-Gm-Message-State: APjAAAV1LCr0tJM33XfnJ8Eoqnkg7kSSKHy20p/xfiBxENP4m0h4Qu6z
        Lx9SOB353g+mHu52D0s/NGO54w==
X-Google-Smtp-Source: APXvYqzc4JnkNzTNbpoLwYMEr8kUgiCAkWLAYuEbgd/jcCtrBJaBybfVSx4eANHPWt/JSh5F1czjjw==
X-Received: by 2002:ac8:21bc:: with SMTP id 57mr28557365qty.51.1554818614779;
        Tue, 09 Apr 2019 07:03:34 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v129sm18139200qka.77.2019.04.09.07.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 07:03:33 -0700 (PDT)
Date:   Tue, 9 Apr 2019 10:03:29 -0400
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
Subject: Re: Thoughts on simple scanner approach for free page hinting
Message-ID: <20190409100258-mutt-send-email-mst@kernel.org>
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <d2413648-8943-4414-708a-9442ab4b9e65@redhat.com>
 <20190409092625-mutt-send-email-mst@kernel.org>
 <43aa1bd2-4aac-5ac4-3bd4-fe1e4a342c79@redhat.com>
 <20190409093642-mutt-send-email-mst@kernel.org>
 <f25504a0-9763-5184-7b7e-ba618c99f4a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25504a0-9763-5184-7b7e-ba618c99f4a2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 03:43:58PM +0200, David Hildenbrand wrote:
> On 09.04.19 15:37, Michael S. Tsirkin wrote:
> > On Tue, Apr 09, 2019 at 03:36:08PM +0200, David Hildenbrand wrote:
> >> On 09.04.19 15:31, Michael S. Tsirkin wrote:
> >>> On Tue, Apr 09, 2019 at 11:20:36AM +0200, David Hildenbrand wrote:
> >>>> BTW I like the idea of allocating pages that have already been hinted as
> >>>> last "choice", allocating pages that have not been hinted yet first.
> >>>
> >>> OK I guess but note this is just a small window during which
> >>> not all pages have been hinted.
> >>
> >> Yes, good point. It might sound desirable but might be completely
> >> irrelevant in practice.
> >>
> >>>
> >>> So if we actually think this has value then we need
> >>> to design something that will desist and not drop pages
> >>> in steady state too.
> >>
> >> By dropping, you mean dropping hints of e.g. MAX_ORDER - 1 or e.g. not
> >> reporting MAX_ORDER - 3?
> > 
> > I mean the issue is host unmaps the pages from guest right?  That is
> > what makes hinted pages slower than non-hinted ones.  If we do not want
> > that to happen for some pages, then either host can defer acting on the
> > hint, or we can defer hinting.
> 
> Ah right, I think what Alex mentioned is that pages processed in the
> hypervisor via MADVISE_FREE will be set RO, so the kernel can detect if
> they will actually be used again, resulting int
> 
> 1. A pagefault if written and the page(s) have not been reused by the host
> 2. A pagefault if read/written if the page(s) have been reused by the host
> 
> Now, assuming hinting is fast,  most pages will be hinted right away and
> therefore result in pagefaults. I think this is what you meant.
> 
> Deferring processing in the hypervisor cannot be done after a request
> has been marked as processed and handed back to the guest. (otherwise
> pages might already get reused)
> 
> So pages would have to "age" in the guest instead before they might be
> worth hinting. Marking pages as "Offline" alone won't help. Agreed.

Right. I don't see this as a blocker though. We can think about
strategies for addressing this after we have basic hinting
in place.

> -- 
> 
> Thanks,
> 
> David / dhildenb
