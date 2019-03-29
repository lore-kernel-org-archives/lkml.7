Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BEC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEF32186A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfC2PIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:08:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42729 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2PIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:08:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so2669522qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Op0S9e4x5Kscr7h7eXmRDVk/JsCI4DJblah3z5xAD5s=;
        b=WpydAHWdOVFFh2yvuYq93fBvRcAuEVEYnO5kMT9wKJKKaSJMQfItTzPigH0tK1Obj4
         FdraUH6LP4aVL990TLX+aQKGZLi4+4naT67da7ZDUMpV+aX4BTDCXySONDH2+RQDOMxZ
         RLoN6Klf8jkja1CqsJ7dSC8DXw/L2PW786tj1RVG/FdVp73FRiXa7O71v8DnQJXaR1tt
         GZnb4UlFtdWcPcsGxOlSSKqkswpyfcN7JIKyomv7N2LwcSZNbY76aGG6ZBNLzSE/A5Qs
         eVzCp3xlsL2nMfBUDp5aK/lEdMDIU7YybWL6QKEK0hD4vVtcWuPNoRvKmMPS9cAIoJkP
         OamQ==
X-Gm-Message-State: APjAAAUIH+LG2V2YYvHIxWaNLJoJjfDK3NIhMtrqvnZjyjKe/h3654Ht
        N5grC4WTAOceVxaadf8qaGzDDw==
X-Google-Smtp-Source: APXvYqwSURTkVA80rMos1Y/SrKKWTM65DCM27okuf26x0TIA02J8JpidaqJbyIfkHE4PLF309IdXWA==
X-Received: by 2002:aed:3f49:: with SMTP id q9mr41973253qtf.279.1553872132003;
        Fri, 29 Mar 2019 08:08:52 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id k41sm1846322qtc.89.2019.03.29.08.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 08:08:50 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:08:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190329104311-mutt-send-email-mst@kernel.org>
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:24:24PM +0100, David Hildenbrand wrote:
> 
> We had a very simple idea in mind: As long as a hinting request is
> pending, don't actually trigger any OOM activity, but wait for it to be
> processed. Can be done using simple atomic variable.
> 
> This is a scenario that will only pop up when already pretty low on
> memory. And the main difference to ballooning is that we *know* we will
> get more memory soon.

No we don't.  If we keep polling we are quite possibly keeping the CPU
busy so delaying the hint request processing.  Again the issue it's a
tradeoff. One performance for the other. Very hard to know which path do
you hit in advance, and in the real world no one has the time to profile
and tune things. By comparison trading memory for performance is well
understood.


> "appended to guest memory", "global list of memory", malicious guests
> always using that memory like what about NUMA?

This can be up to the guest. A good approach would be to take
a chunk out of each node and add to the hints buffer.

> What about different page
> granularity?

Seems like an orthogonal issue to me.

> What about malicious guests?

That's an interesting question.  Host can actually enforce that # of
hinted free pages at least matches the hint buffer size.


> What about more hitning
> requests than the buffer is capable to handle?

The idea is that we don't send more hints than in the buffer.
In this way host can actually control the overhead which
is probably a good thing - host knows how much benefit
can be derived from hinting. Guest doesn't.

> Honestly, requiring page hinting to make use of actual ballooning or
> additional memory makes me shiver. I hope I don't get nightmares ;) In
> the long term we might want to get rid of the inflation/deflation side
> of virtio-balloon, not require it.
> 
> Please don't over-engineer an issue we haven't even see yet.

All hinting patches are very lightly tested as it is. OOM especially is
very hard to test properly.  So *I* will sleep better at night if we
don't have corner cases.  Balloon is already involved in MM for
isolation and somehow we live with that.  So wait until you see actual
code before worrying about nightmares.

> Especially
> not using a mechanism that sounds more involved than actual hinting.

That would depend on the implementation.
It's just moving a page between two lists.


> 
> As always, I might be very wrong, but this sounds way too complicated to
> me, both on the guest and the hypervisor side.

On the hypervisor side it can be literally nothing if we don't
want to enforce buffer size.

> -- 
> 
> Thanks,
> 
> David / dhildenb
