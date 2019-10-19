Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E4ECA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD7021744
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HZLUJBhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJSOhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:37:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35330 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:37:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id c8so179339pgb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+8hUva3NZJHnq52kCyvGxECaNBhCY1V4brwN0aPxNyY=;
        b=HZLUJBhrxw3l1UnTyNRKK3Yj/kaRAPc2IGYArD7PILyO4efUDxXrE7HhPw70SGxkeC
         CGquJUbYGgodEbgAvXvdLhHT23Zq5FT+knor+WS0+2X2W0iCSKyZj9T9+c+S9KyR7OR+
         hBXBIO8T8G98+ZhJqNOPEIv8Yz704+/AuZ1oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+8hUva3NZJHnq52kCyvGxECaNBhCY1V4brwN0aPxNyY=;
        b=trnNyCuJJrOzD0JlclDu/OT9v0Kfn2OdwvfpVdEuSpZMMYeZFRVkrIkl9gLs39rR5v
         0dey+KFOsHg8q8r9uFej5PWWd8wMc3wbUUh8iFBAFMt6XgnU03JI3uPKm1Hl+DXKyof5
         4mBerIRafNWMbrtIhCuSwFfyCpDTjY2szFfDl/Hm2AIXR49HDEmpUj0QHWpUG0BfGBcz
         YNX3Nwo3xp0+NiS5UIaEA7VtT26p/3f4MwrFiKw7huRWs6VWUSRVH1pHZlu/PAxTboCH
         UNyY5Cs4RgdnOhLRfs/p9wcGZpDwBIhB0TTvlG98YslRSqKmiZVrwtl9OZo6soZIjZ/S
         sgVg==
X-Gm-Message-State: APjAAAWx/h4YmpqAQGxmqW9r8VdDIsWvL/v3ihG3mkqFZnH2tNBLUAse
        cM9mGqmAO4+D2bu49/ICFm1MBQ==
X-Google-Smtp-Source: APXvYqysHSphhJJCiJ9SuBFqK0eWTCHHyIx94BaAizUD/c9dv5ZJsLUkmzAB76iXbT4tCdUX/e7O1g==
X-Received: by 2002:a65:640e:: with SMTP id a14mr15397797pgv.392.1571495853967;
        Sat, 19 Oct 2019 07:37:33 -0700 (PDT)
Received: from cork (c-67-180-85-52.hsd1.ca.comcast.net. [67.180.85.52])
        by smtp.gmail.com with ESMTPSA id 6sm9019735pgl.40.2019.10.19.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 07:37:32 -0700 (PDT)
Date:   Sat, 19 Oct 2019 07:37:30 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
Message-ID: <20191019143501.GF31027@cork>
References: <20191018203704.GC31027@cork>
 <20191018204220.GD31027@cork>
 <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
 <alpine.DEB.2.21.1910191214490.2098@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1910191214490.2098@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 12:49:52PM +0200, Thomas Gleixner wrote:
> 
> One slightly related thing I was looking into is that the mixing of
> interrupt entropy is always done from hard interrupt context. That has a
> few issues:
> 
>     1) It's pretty visible in profiles for high frequency interrupt
>        scenarios.
> 
>     2) The regs content can be pretty boring non-deterministic when the
>        interrupt hits idle.
> 
>        Not an issue in the try_to_generate_entropy() case probably, but
>        that still needs some careful investigation.
> 
> For #1 I was looking into a trivial storage model with a per cpu ring
> buffer, where each entry contains the entropy data of one interrupt and let
> some thread or whatever handle the mixing later.

Or you can sum up all regs.

unsigned long regsum(struct pt_regs *regs)
{
	unsigned long *r = (void *)regs;
	unsigned long sum = r[0];
	int i;

	for (i = 1; i < sizeof(*regs) / sizeof(*r); i++) {
		sum += r[i];
	}
	return sum;
}

Takes 1 cycle per register in the current form, half as much if the
compiler can be convinced to unroll the loop.  That's cheaper than
rdtsc() on most/all CPUs.

If interrupt volume is high, the regsum should be good enough.  The
final mixing can be amortized as well.  Once the pool is initialized,
you can mix new entropy once per jiffy or so and otherwise just add to a
percpu counter or something like that.

> That would allow to filter out 'constant' data (#) but it would also give
> Joerns approach a way to get to some 'random' register content independent
> of the context in which the timer softirq is running in.

Jörn

--
Given two functions foo_safe() and foo_fast(), the shorthand foo()
should be an alias for foo_safe(), never foo_fast().
-- me
