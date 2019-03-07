Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2970D20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCGSxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:53:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34602 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:53:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id x20so728896qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GtnWDLcWe4XQrcK8Q6Ov6kZxVC6vJzbAaPKjx7ZIdO0=;
        b=jPo2fAonUIYoj/Ws+uncOAjuQfj/KjdT4qTijUeO2TV6GkSwcdoV5MbywMCSdFHfUu
         u2oza3VkDj+dyNTnAz5v0I8w/OW/Ivhy3rOC3kmUbiPk+gnwFfkmfKcB5PacyAD+7TKw
         DzXtlmT8sCNzTAILStyaXGu7aObA3G1L5o6Khv8g5/1UV1Vl9jOFOvKvJWdSIy+YPVmh
         acdeVvjwiM/U1sceZGx18nq6BYw2PNe6TqgTMStW5RbM1Hk4pVrFt/EqwTx8qemW6YRQ
         lNfDhMM+uY5B4TA5EnJ2AJeSJQikZ94z4z4LYDq77pDC0pMO76OfMN9LNiYDGha6L0dS
         950g==
X-Gm-Message-State: APjAAAWqeJJ4kT8t5FtW2oF7qNamezLgG2vtwAscCqlq9nGcJUuGAX5E
        PEU67QKJ50QedhMFCvlknEmq+A==
X-Google-Smtp-Source: APXvYqzW9j0JzJli+Hoik7VfAelOEXtBb2ylO093NKWOvb/pOqqctTtb7pw3S3oGhuiEqQBqRTuWJA==
X-Received: by 2002:a0c:d60d:: with SMTP id c13mr12269763qvj.43.1551984787074;
        Thu, 07 Mar 2019 10:53:07 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id l24sm3674456qtf.27.2019.03.07.10.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 10:53:05 -0800 (PST)
Date:   Thu, 7 Mar 2019 13:53:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190307134744-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <CAKgT0Ud35pmmfAabYJijWo8qpucUWS8-OzBW=gsotfxZFuS9PQ@mail.gmail.com>
 <1d5e27dc-aade-1be7-2076-b7710fa513b6@redhat.com>
 <CAKgT0UdNPADF+8NMxnWuiB_+_M6_0jTt5NfoOvFN9qbPjGWNtw@mail.gmail.com>
 <2269c59c-968c-bbff-34c4-1041a2b1898a@redhat.com>
 <CAKgT0UdHkDB1vFMp7T9_pdoiuDW4qvgxhqsNztPQXrRCAmYNng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdHkDB1vFMp7T9_pdoiuDW4qvgxhqsNztPQXrRCAmYNng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:45:58AM -0800, Alexander Duyck wrote:
> To that end what I think w may want to do is instead just walk the LRU
> list for a given zone/order in reverse order so that we can try to
> identify the pages that are most likely to be cold and unused and
> those are the first ones we want to be hinting on rather than the ones
> that were just freed. If we can look at doing something like adding a
> jiffies value to the page indicating when it was last freed we could
> even have a good point for determining when we should stop processing
> pages in a given zone/order list.
> 
> In reality the approach wouldn't be too different from what you are
> doing now, the only real difference would be that we would just want
> to walk the LRU list for the given zone/order rather then pulling
> hints on what to free from the calls to free_one_page. In addition we
> would need to add a couple bits to indicate if the page has been
> hinted on, is in the middle of getting hinted on, and something such
> as the jiffies value I mentioned which we could use to determine how
> old the page is.

Do we really need bits in the page?
Would it be bad to just have a separate hint list?

If you run out of free memory you can check the hint
list, if you find stuff there you can spin
or kick the hypervisor to hurry up.

Core mm/ changes, so nothing's easy, I know.

-- 
MST
