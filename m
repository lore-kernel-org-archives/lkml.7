Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F19C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF3E20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCJV1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:27:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46567 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCJV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:27:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id j10so2097601oij.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4u1OcIKNyiAZm/99ALlppfHz2fZU/SI9CMTqcRRtHzs=;
        b=fQXtmXUdAWaoLdmmAh5/S5SNEMyH5XLtMZturn3E/4PFk/L1T1Ub+xBxFMVT5KL6Rh
         LjQP4UEUr7MCZR0UmZCe0TNBaAM19gY20YvPkqXXCYumvqsGGIt7iORw7xiQrZF1o1EI
         7iwcwszyJ4yXd0KFRkB8YO52HEXsgVee18e0fN777xLMyu2NtOo7PB7m/mFsrBka7jMJ
         9a99kns82GBAQ5gWUCXztaMy6kp977eYkEX6FRSkhsYvc+Fqr8zqUzq4Q4bYAgAJ6PeF
         LCgbjzUPBSmRsh3xgVfJY9rPRQuAO2ITweGnmpkaBTho79gawhIiitjlagUwh3NTHls+
         CCvA==
X-Gm-Message-State: APjAAAU5G+NKfMCvteKNMXe/CqeGk6ePHSQx+SF/SHNExEHcOZgEWxV4
        X/HwDS38brDta2UqYjt4M6Y=
X-Google-Smtp-Source: APXvYqxjcCjnFU3RfO/1hwx3pHB+Yb48/5V7ITu0oaflmB41chl6Xwpbn9jCqKcryoCjKc9W4RYkzQ==
X-Received: by 2002:aca:51cb:: with SMTP id f194mr14997826oib.6.1552253220128;
        Sun, 10 Mar 2019 14:27:00 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id j21sm1626192otr.28.2019.03.10.14.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 14:26:59 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:26:55 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190310212655.GA30695@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190310210335.GA5504@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310210335.GA5504@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 10:03:35PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 10, 2019 at 01:34:03PM -0700, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > 
> > This is a complete low memory killer solution for Android that is small
> > and simple. It kills the largest, least-important processes it can find
> > whenever a page allocation has completely failed (right after direct
> > reclaim). Processes are killed according to the priorities that Android
> > gives them, so that the least important processes are always killed
> > first. Killing larger processes is preferred in order to free the most
> > memory possible in one go.
> > 
> > Simple LMK is integrated deeply into the page allocator in order to
> > catch exactly when a page allocation fails and exactly when a page is
> > freed. Failed page allocations that have invoked Simple LMK are placed
> > on a queue and wait for Simple LMK to satisfy them. When a page is about
> > to be freed, the failed page allocations are given priority over normal
> > page allocations by Simple LMK to see if they can immediately use the
> > freed page.
> > 
> > Additionally, processes are continuously killed by failed small-order
> > page allocations until they are satisfied.
> > 
> > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> Wait, why?  We just removed the in-kernel android memory killer, we
> don't want to add another one back again, right?  Android Go devices
> work just fine with the userspace memory killer code, and those are "low
> memory" by design.
> 
> Why do we need kernel code here at all?
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thanks for replying. It has not been my experience and the experience of many
others that Android's userspace low memory memory killer works "just fine." On
my Pixel 3 XL with a meager 4GB of memory, the userspace killer has had issues
with killing too many processes, which has resulted in a noticeably poor user
experience for all Pixel owners. From the looks of lmkd on the master branch,
there still isn't really any definitive solution for this, aside from a 100ms
delay in between process kills.

I think that the userspace low memory killer is more complex than necessary,
especially since in the kernel we can detect exactly when we run out of memory
and react far more quickly than any userspace daemon.

The original reasoning behind why the old kernel low memory killer was removed
is also a bit vague to me. It just seemed to be abandonware, and all of a sudden
a userspace daemon was touted as the solution.

This driver is like an Android-flavored version of the kernel's oom killer, and
has proven quite effective for me on my Pixel. Processes are killed exactly when
a page allocation fails, so memory use is maximized. There is no complexity to
try and estimate how full memory is either.

Thanks,
Sultan
