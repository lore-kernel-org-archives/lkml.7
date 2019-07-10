Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246FC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9AC20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXmGPoxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfGJULh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:11:37 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45614 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:11:36 -0400
Received: by mail-oi1-f170.google.com with SMTP id m206so2630360oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4Oo5mdvetUmxDbSUBL29GZ+Vehe4xWNg6RgKG4Gwt4=;
        b=mXmGPoxjwHpfp3CLLd+9LSOoCKadt5E0qlN+U8wdZNRzV7JdqZ9Q0VhlT1bvP7tkY6
         +ub4J7BiIjLznFj6KqyIAhb6lIAEbHmU/UDdqQhn5KMJhN1SZtNdThiVHk0MjoOplHmD
         +gBCmRmU2/PxHPN55nPCadpD4MKnsVW8UOmYTQuDtq0OhnF4qI8As8VBoXuXzavOoLQa
         F2YJNJCRVr5xuHbe6YtvMRz/N/TS5mfd5JaDOVCuAkqx4Xk1zJWklfNxXTzLsS9pQuQp
         tlJ1SNp81XlS3Py7w3AVzbr/Wjr45MOYDkiXIaBqZ+gOdQJqf6w94mAzB5RRmCsBXaNn
         wPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=C4Oo5mdvetUmxDbSUBL29GZ+Vehe4xWNg6RgKG4Gwt4=;
        b=f4Wo7pj/tWY8grWoUF6z+O4AHXHFQKNHvJ3ap67wVrBCCeUFxhvum/Vp6ukLUPXD3h
         DuybqtxYWUT1NMsouDurhEU8g+Uw2FWOHotXWhsCNGh8bIw4yk6djeDJqWBOFeM84eDv
         uTVwcqWFQeaqa4V9c12T2fMO6XbPgVOFuil6mJfXms9aHPjHU6cDzp9T26IJLHhHrsGz
         2pFo+EpI9IIz4RNt2VuWYJ8F9JJneo/6FX9aL/1Vy2GKh3+SAtidsKWqbCjocInxVl1y
         MArvORhFbzoB7NbEW+LF6ZGwA1UbUmM/T+WB6piToIRn2fdPUf4rxwJD1aNje2Zb1Jaj
         XM8g==
X-Gm-Message-State: APjAAAXqU/MIcjXvtQAmwBxHx5j214pEVxNX5Wg3HVTO/g+1PaWq1xkQ
        XjmVzn8apSTnnImnX6zsFA==
X-Google-Smtp-Source: APXvYqwluDUCiSXTRKCeP9btcWwoCO5Q93q4Z5o1gMibop9R2/B/lPFbj1yts8R/BE/ln2w4Cw4kMQ==
X-Received: by 2002:aca:be88:: with SMTP id o130mr116980oif.122.1562789495255;
        Wed, 10 Jul 2019 13:11:35 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id k10sm1080434otn.58.2019.07.10.13.11.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 13:11:34 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8d86:5827:9904:bfb])
        by serve.minyard.net (Postfix) with ESMTPSA id 12F961800D1;
        Wed, 10 Jul 2019 20:11:34 +0000 (UTC)
Date:   Wed, 10 Jul 2019 15:11:32 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190710201132.GB3066@minyard.net>
Reply-To: minyard@acm.org
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
 <20190709230144.GE19430@minyard.net>
 <20190710142221.GO657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710142221.GO657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 07:22:21AM -0700, Tejun Heo wrote:
> Hello,
> 
> > > We can go for shorter timeouts for sure but I don't think this sort of
> > > busy looping is acceptable.  Is your position that this must be a busy
> > > loop?
> > 
> > Well, no.  I want something that provides as high a throughput as
> > possible and doesn't cause scheduling issues.  But that may not be
> > possible.  Screwing up the scheduler is a lot worse than slow IPMI
> > firmware updates.
> > 
> > How short can the timeouts be and avoid issues?
> 
> We first tried msleep(1) and that was too slow even for sensor reading
> making it take longer than 50s.  With the 100us-200us sleep, it got
> down to ~5s which was good enough for our use case and the cpu /
> scheduler impact was still mostly negligible.  I can't tell for sure
> without testing but going significantly below 100us is likely to
> become visible pretty quickly.

What was the time to read the sensors before you did the change?
It depends a lot on the system, so I can't really guess.

> 
> We can also take a hybrid approach where we busy poll w/ 1us udelay
> upto, say, fifty times and then switch to sleeping poll.

I'm pretty sure we didn't try that in the original work, but I'm
not sure that would work.  Most of the initial spinning would be
pointless.

I would guess that you would decrease the delay and the performance
would improve linearly until you hit a certain point, and then
decreasing the delay wouldn't make a big difference.  That's the
point you want to use, I think.

What might actually be best would be for the driver to measure the
time it takes the BMC to respond and try to set the timeout based
on that information.  BMCs vary a lot, a constant probably won't
work.

And I was just saying that I wasn't expecting any big changes in
the IPMI driver any more...

> 
> Are there some tests which can be used to verify the cases which may
> get impacted by these changes?

Unfortunately not.  The original people at Dell that did the work
don't work there any more, I don't think.

I mostly use qemu now for testing, but this is not something you can
really simulate on qemu very well.  Can you do an IPMI firmware
update on your system?  That would be the easiest way to measure.

Thanks,

-corey

> 
> Thanks.
> 
> -- 
> tejun
