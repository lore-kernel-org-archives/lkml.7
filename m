Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90FECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4616721906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDw821R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfJAL1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:27:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41720 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJAL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:27:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so12933441ljg.8;
        Tue, 01 Oct 2019 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7yl90eDyUNbyXKN1QXnqy8jV6SoXExUZE/lJxIw9j7w=;
        b=XDw821R4xQcFLOZdGzsbw4EpnPvm2B1/X0+rEWnX1z2bZtcmrcjd65hrWtP7jm1coS
         IJip/mZdO5sLBpXRSp8DLf7baNhUmzIKBmQvW5ZLP/xvQcaGnTkxKnE7ixqtaFepq8Om
         eFiViVSZQI52USKnlMtNwIBOsbMZoizkbWBPsXfhjrfbNOZk7UYBDdJujsQqdUcFoLN0
         6CiC81ZsmGEaNT/VurrZowKkmAJG4xHzwbJMoaZw8185lWel800cHFtUzaeR9YX/2eTm
         8BI4LOiHBEpN+gz63cLGCtmUPksYJEWj6nbiEmwcwYomrYIFCcPEE8pycskTXU3prC0I
         Fgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7yl90eDyUNbyXKN1QXnqy8jV6SoXExUZE/lJxIw9j7w=;
        b=ElnMttR4hiAtSb/RZpL/cCyJEvGReCCAg6kHSGA9Yhw9nDgfiNazbhXwPGapkfBI8z
         lm8u8cGUfbqYr9lGvvVlxqvKm/QR03DyKXyxBu7jrY40n620YQrCkigEj/XiOIJ1zbXP
         QwiQiA1TkeZJMx62DmAzT8ufKMgmNewQr1arJ/CKAg9XOobBi2g7zFZyblbYErnxnibJ
         SMeppKAQodDEDu7TB1jf+hAN1YWZlDs0PY9zNRGkl1njq+EUEUkUw9YbfOg47VOOmLBl
         NYXlDnbHraip+6z5M997lP2Zph/6v5uUMisbMnrpvVv8Q+9wEYpP09QrZoPFMxEOlRj/
         Rvpw==
X-Gm-Message-State: APjAAAXOY74I7g/AGhb6czDs/kdZQ81ix1UifhP3tKYiS4zD79yp51cC
        aEGRAus0O7yl1LrhfkS4CEY=
X-Google-Smtp-Source: APXvYqxZjU4YbaPUakVbiX1hi3z8kXoJqj1JEZzF7eSS9/uGIKtlvW/tvZiSX5uDbU91DnMtqnIOzA==
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr15579041ljd.83.1569929232041;
        Tue, 01 Oct 2019 04:27:12 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id n2sm3941606ljj.30.2019.10.01.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:27:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 1 Oct 2019 13:27:02 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kernel-team@lge.com,
        Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20191001112702.GA22112@pc636>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190918095811.GA25821@pc636>
 <20190930201623.GA134859@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930201623.GA134859@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hello, Joel.
> > 
> > First of all thank you for improving it. I also noticed a high pressure
> > on RCU-machinery during performing some vmalloc tests when kfree_rcu()
> > flood occurred. Therefore i got rid of using kfree_rcu() there.
> 
> Replying a bit late due to overseas conference travel and vacation.
> 
> When you say 'high pressure', do you mean memory pressure or just system
> load?
> 
>
> Memory pressure slightly increases with the kfree_rcu() rework with the
> benefit of much fewer grace periods.
> 
I meant a system load, because of high number of cycles in the kfree_rcu()
symbol under stressing. But i do not have numbers next to me, because it
was quite a long time ago. As for memory usage, i understand that.

> > I have just a small question related to workloads and performance evaluation.
> > Are you aware of any specific workloads which benefit from it for example
> > mobile area, etc? I am asking because i think about backporting of it and
> > reuse it on our kernel. 
> 
> I am not aware of a mobile usecase that benefits but there are server
> workloads that make system more stable in the face of a kfree_rcu() flood.
> 
OK, i got it. I wanted to test it finding out how it could effect mobile
workloads.

>
> For the KVA allocator work, I see it is quite similar to the way binder
> allocates blocks. See function: binder_alloc_new_buf_locked(). Is there are
> any chance to reuse any code? For one thing, binder also has an rbtree for
> allocated blocks for fast lookup of allocated blocks. Does the KVA allocator
> not have the need for that?
>
Well, there is a difference. Actually the free blocks are not sorted by
the its size like in binder layer, if understand the code correctly.

Instead, i keep them(free blocks) sorted(by start address) in ascending
order + maintain the augment value(biggest free size in left or right sub-tree)
for each node, that allows to navigate toward the lowest address and the block
that definitely suits. So as a result our allocations become sequential
what is important.

>
> And, nice LPC presentation! I was there ;)
> 
Thanks :)

--
Vlad Rezki
