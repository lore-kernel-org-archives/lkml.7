Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE72AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EB42184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfC2N0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:26:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37517 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbfC2N0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:26:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so2513742qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 06:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6tZ3FsToy/uGhRDMKBuu0T5a7ZQTYi3c4gG8cjj/IR4=;
        b=VULhe8lUlULccBqjLI11Hn8lYzvMLBMKQG20ML66qjqgVpETIIebf6zht+q4bSnTMR
         EpNKlKDhB0D++/EGxCplYbuIVYRyTW3N0WYBP5KYMV8yFvSsEK+dPsY5STC4eRPcvzlV
         u8GvMuzGzXcE+4DTn8uRPSGMfpj4KbAe49x/AodGIbK3PGMWLCdXsgVn1JgV4Iol3zfm
         yxOHJBUd+kOoMoDpYFeFARJVSO5vIHGiUR3C3scNht0ZA1WNygvF0jUxuxqRyxK9Eb7p
         IyZrZpQD+ccb5UMLudX9a1YZAvIoyr0TEK7O3J0uiiOYjHK40LoMUGLcfBjGUBM8qD1d
         AfGw==
X-Gm-Message-State: APjAAAUJ8Mzgmbvc1Y6/YpGBj+nOyvXSqKzOf4dGS2qgmVM9F2eGk041
        gl4wEYZX7IelpRYSB7r0TIfEog==
X-Google-Smtp-Source: APXvYqz9t/fOoWybrlhU5qTUKqQb8Vg0MsizWKV62BSCAnVK0lqtO0/FYFYgcKbqvUoCo7B+Vt0rPg==
X-Received: by 2002:aed:3c0f:: with SMTP id t15mr21216042qte.282.1553865983383;
        Fri, 29 Mar 2019 06:26:23 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id y6sm1102459qka.69.2019.03.29.06.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 06:26:22 -0700 (PDT)
Date:   Fri, 29 Mar 2019 09:26:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        alexander.duyck@gmail.com
Subject: On guest free page hinting and OOM
Message-ID: <20190329084058-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:50:42AM -0500, Nitesh Narayan Lal wrote:
> The following patch-set proposes an efficient mechanism for handing freed memory between the guest and the host. It enables the guests with no page cache to rapidly free and reclaims memory to and from the host respectively.

Sorry about breaking the thread: the original subject was
	KVM: Guest Free Page Hinting
but the following isn't in a response to a specific patch
so I thought it's reasonable to start a new one.

What bothers both me (and others) with both Nitesh's asynchronous approach
to hinting and the hinting that is already supported in the balloon
driver right now is that it seems to have the potential to create a fake OOM situation:
the page that is in the process of being hinted can not be used.  How
likely that is would depend on the workload so is hard to predict.

Alex's patches do not have this problem as they block the
VCPUs from attempting to get new pages during hinting. Solves the fake OOM
issue but adds blocking which most of the time is not necessary.

With both approaches there's a tradeoff: hinting is more efficient if it
hints about large sized chunks of memory at a time, but as that size
increases, chances of being able to hold on to that much memory at a
time decrease. One can claim that this is a regular performance/memory
tradeoff however there is a difference here: normally
guest performance is traded off for host memory (which host
knows how much there is of), this trades guest performance
for guest memory, but the benefit is on the host, not on
the guest. Thus this is harder to manage.

I have an idea: how about allocating extra guest memory on the host?  An
extra hinting buffer would be appended to guest memory, with the
understanding that it is destined specifically to improve page hinting.
Balloon device would get an extra parameter specifying the
hinting buffer size - e.g. in the config space of the driver.
At driver startup, it would get hold of the amount of
memory specified by host as the hinting buffer size, and keep it around in a
buffer list - if no action is taken - forever.  Whenever balloon would
want to get hold of a page of memory and send it to host for hinting, it
would release a page of the same size from the buffer into the free
list: a new page swaps places with a page in the buffer.

In this way the amount of useful free memory stays constant.

Once hinting is done page can be swapped back - or just stay
in the hinting buffer until the next hint.

Clearly this is a memory/performance tradeoff: the more memory host can
allocate for the hinting buffer, the more batching we'll get so hints
become cheaper. One notes that:
- if guest memory isn't pinned, this memory is virtual and can
  be reclaimed by host. In partucular guest can hint about the
  memory within the hinting buffer at startup.
- guest performance/host memory tradeoffs are reasonably well understood, and
  so it's easier to manage: host knows how much memory it can
  sacrifice to gain the benefit of hinting.

Thoughts?

-- 
MST
