Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0340C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A186E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3LmHnwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDLE77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:59:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfDLE76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:59:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id g6so3198723edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=91XWN/M4/HGvUyhbEma1qFooI+deqFFHVesGDBmP478=;
        b=Z3LmHnwNw/o/6uYLHK6KjPxkc1GNosBxI2jwFDs6ZIJfSJrsYzC300lLQGYZ90Nq+X
         +JyQLeQMQ80TpqZNB52znc5XgTDYOQRbgaB8+t3+GJK5I6PmIah8BMWHqZMieLInt32s
         390ugyiQ40mUji9D2VYCnEqX9tLSA5HdS3avxvWoCJv6QQv0RPDj8QhTnDmvm3SigEqL
         Hm6Ehn4tSH8BveKWfZfKhJ88s+mHbmwZJffOUgm1J8DZDaLQoBIhpELoOgFo+w6Jg3ht
         jCBq0rTieq/mjE1qlPs0qu/Q9cScFbC/f4lSkSvlQx1Ng2u2sYcOFNTsEpQiRAfu79ey
         925Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=91XWN/M4/HGvUyhbEma1qFooI+deqFFHVesGDBmP478=;
        b=hMmQ5NwIHJPMFvi/bGXhEmR5wVtyulOllMJfP1FssvYfqpqqmr9HNSA/LM4kohrDyo
         esG2+Zz/09ZnRwg8Y7SCk2qDXN7FT/oS9XuVptw00Ky2JdfzHhNeeX/YzhcqpdUKBb6u
         XhNEKw8g0fLmxTYeDdZlm2i5vgbVWq/KvN9SOvnLzMG6Od2wDtjI5kc+qYNmjvMzCStx
         dnvWYrLF5q2DNOgQX2QM6NjHRjjvevBgzIjnbb81fOVF7zn9Y1pOcsM+ghL44wPpkq5I
         0WQcKaE7WYd4DrGQzMtncgu64pdUn4PdXeOaImU9K+T3+hpFf3Il8lHYxPJoJiJEndBM
         Q1nA==
X-Gm-Message-State: APjAAAX5TVayVwgmXQyB6W1kdybhfjTaiXGFwI1DNrdCOtE9KyrSiAx1
        J9KcSPBxxYbdfQ4P59EfJZkg4eE9B98=
X-Google-Smtp-Source: APXvYqy1v7pPlaTcp8Ysx0fTkBgoouWDYMdsXu2pwJ6c0DsXPro2lKhmqRPmil9nO9wVRfT42WNkFg==
X-Received: by 2002:a50:f7c8:: with SMTP id i8mr4597658edn.223.1555045197059;
        Thu, 11 Apr 2019 21:59:57 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id t52sm12160596edd.54.2019.04.11.21.59.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Apr 2019 21:59:56 -0700 (PDT)
Date:   Thu, 11 Apr 2019 21:59:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
Message-ID: <20190412045954.GA30291@archlinux-i9>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch>
 <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
 <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
 <20190411205657.GT2839@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411205657.GT2839@atomide.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 01:56:57PM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Daniel Lezcano <daniel.lezcano@linaro.org> [190411 19:21]:
> > On 10/04/2019 22:07, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Daniel Lezcano <daniel.lezcano@linaro.org> [190410 17:02]:
> > >> can you ask for an acked-by before pulling a patch in your tree?
> > > 
> > > I certainly do ask and wait for acks where possible :)
> > 
> > Ok, I may have missed them.
> > 
> > > Note that I have not applied this patch. I just added
> > > Keerthy to Cc on this thread so maybe you misread the
> > > message earlier. My comment "seems like no other
> > > takers" was for Ladislav regarding somebody picking up
> > > his earlier work, not for picking up this patch :)
> > 
> > Actually I was referring to the commit 592ea6bd1fad. Anyway as stated
> > above I could have miss your call.
> 
> Hmm so commit 592ea6bd1fad was part of the PWM timer series
> that was posted several times from late 2017 to end of
> February 2018. I did not get any timer related acks or
> comments so I applied it together with the PWM timer
> changes.
> 
> I'm guessing you may have accidentally checked out some
> older deja-vu branch from about a year ago? Commit
> 592ea6bd1fad is not related to this fix.. :)
> 

Just for the record, I said this patch fixes 592ea6bd1fad because
592ea6bd1fad should have been marked this function as static, which
would have exposed that this function was unused and it could have
been removed at that time. I know it is a bit of a stretch for this
commit (would be more appropriate for 008258d995a6 to have it) but
that was my logic behind it. Not opposed to having it removed before
committing.

Thanks,
Nathan

> Regards,
> 
> Tony
> 
> 
> 
