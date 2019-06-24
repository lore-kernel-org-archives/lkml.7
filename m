Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E48C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4F620645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gJlLLhHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfFXPT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:19:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46194 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfFXPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:19:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so7261106pgr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xk9Y9/4d1P0hhiRulYC6/59GayfnrTydVvyulmj2MA0=;
        b=gJlLLhHaj6Jvm1bCaUN3ZW2zumf00y0LQxCLkUqwaGzxFCYZiFYQ8rTczXQpCRZDpw
         NtK5q/uM6I5V76gghSg5fmbJ43CHbwtS081cohfzOJ6io4WFLGOcoXgaTyWCbMrjkAsj
         xY9qHxrZFwQHzIVemFHx4ljFg0oGqYce6edkh2yeRRpwJiU/trCjsIhFgezWhFJcCgqe
         H4Scl/FXgMov4Q2yD8FeFxw798h6RqiToCrKV5Bs2iobxW0/QAamUc9TkSldXFyswImI
         Apxtk2c/8886Fs7QUpgFAYPFhvHX896Nq/69H5XW37lFOXvRa0xmPRdWgvt7Lc42nHf+
         rPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xk9Y9/4d1P0hhiRulYC6/59GayfnrTydVvyulmj2MA0=;
        b=LrRrB6tpx+26roxvc0Hs7MrZ6/5/mQzzTq0rF7U5BBxlRkJO9f8FMaztH/x0lmmagr
         ZV0YYhUbibjbRn2U4pmkf8H1qyfCvfL2ozX+16GmR9EEOmmz4dSOx3N3M0v+DkWVVp3/
         btws6oGVPgcjaZbRyteJkj5NKETFdnFpBJmwJuUteRCQ6/XJdoX1vxu4yjiVXqHiKDE8
         OUTtk8TQT6vOKfcOKM01mhRrSroPsvekm1mwkxCbQuqis/X5pdWrIxJqC6i6tTzl1dgE
         YJF2aCGhsMlP7aIjxav2QXjOjJo8RpaOtD/p5DpJ2iGcGanKY4yCxYu4rc8tLCz8wccc
         7vSg==
X-Gm-Message-State: APjAAAUxG5iTPOxpcfmneEN2FcOknzqaffND5vhZAz2vHHhO5w8IiSGY
        22nYhSugBFGHkkg0N7OGr0ER6g==
X-Google-Smtp-Source: APXvYqwFHGQOnQnTXhDr9lU4NK1+H6IcL2ndUHa4gASx7rxzeny46s92Ldbi9u0yLFNEg+G6B9aOGg==
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr25538029pjq.36.1561389566146;
        Mon, 24 Jun 2019 08:19:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d3ed])
        by smtp.gmail.com with ESMTPSA id n2sm10152216pgp.27.2019.06.24.08.19.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:19:25 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:19:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix page cache convergence regression
Message-ID: <20190624151923.GA10572@cmpxchg.org>
References: <20190524153148.18481-1-hannes@cmpxchg.org>
 <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org>
 <20190530161548.GA8415@cmpxchg.org>
 <20190530171356.GA19630@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530171356.GA19630@bombadil.infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:13:56AM -0700, Matthew Wilcox wrote:
> On Thu, May 30, 2019 at 12:15:48PM -0400, Johannes Weiner wrote:
> > Are there any objections or feedback on the proposed fix below? This
> > is kind of a serious regression.
> 
> I'll drop it into the xarray tree for merging in a week, if that's ok
> with you?

Hey, it's three weeks later and we're about to miss 5.2.

This sucks, Matthew. You introduced a serious regression to the MM
subsystem, whose process and patch routing you largely bypassed. When
I encountered the problem and provided a reproducer and a fix, you
gave me a hard time on cosmetic grounds. I incorporated all your
feedback, and still you show no urgency to get this patch or a fix of
your own into mainline. It's your bug, please fix it.
