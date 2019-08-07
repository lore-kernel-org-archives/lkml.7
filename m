Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F4C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8922173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnqJY1As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbfHGUxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:53:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39743 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfHGUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:53:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so86708300ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzPEva7t//48vc2Upo4H9X391yFFOid7B+wS/3JQJVo=;
        b=VnqJY1AsT+sm3+z69qrT9NZeAT+aS6eJb3SDNkLFeDTLM6FjWxFiFLEwuO9awuj8a5
         5HeaBC5hNw+sby1pHOi2HteduKaZ+3KmdicEPlZWm/da7AxCs8RrSUwDYniOFV+GK5BK
         HcfpjeKFwxurGTB/8qYd1jZZ6JbKmlV7oDrCRnI3P7CkD7BFvLhqOUssMaF+n4BKNYv0
         1grfE/4+ZfqcobeoZ4YDMvqxoeQAJCi256P1WRwGnM0tyu6YXXwCSfJGGg+KyixNW8oe
         7HHDyoDIl4q6Cx7iMLIvHzbKiiZpvtNpvFEaeE3DJjptA0Qyoq5QBCJ6Xwl10SX9juoR
         6BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzPEva7t//48vc2Upo4H9X391yFFOid7B+wS/3JQJVo=;
        b=rF6ZH/77P7VJhI8sm+57rYxxgKoi/a9d+mdP/nVJh2KWk2MXv2xoJM1cSLifBnBxN/
         9cV7rMGxXnlVW2T62fI/WpH605WmTl/x1QHAEL5egG67rw+GsJUSaVeUoW+nBRiQgoP5
         WcP3Xxn5HqNa7tzef22wW1k3Q7nDTRITGbX6Zy0pMBjczJePIsfYDByXHA3RMvwvRj8N
         i4j06anwd6skV+JMHIsc8oAkXG6QgssSkvsnYeLZDdjhtEx9pqfMp8my2oOMjcrlAYk4
         RiMgjRWRRwJ5hmEz3r2yIoc46FmWS/YRC5gm9igUPGkJRp9CsuzlKa6UxUSL62X8uwSD
         sN3g==
X-Gm-Message-State: APjAAAV9GoBVdfvyZtJt1gic08yWCXJLkCeibfvf91PF8j0H5RH4P4lA
        ZXWUnRGafr94K1egRyTKAWY=
X-Google-Smtp-Source: APXvYqyvRwgwcbxhdq/miU/5qXUQY5aYJ1nN6DX4yon7bQqFB5Vcn+UGr2ofzuj1QzFJPjGSXtyh+Q==
X-Received: by 2002:a2e:9cd1:: with SMTP id g17mr6178151ljj.234.1565211186666;
        Wed, 07 Aug 2019 13:53:06 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id f28sm659942lfk.1.2019.08.07.13.53.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 13:53:06 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Wed, 7 Aug 2019 22:53:02 +0200
To:     Joe Perches <joe@perches.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190807205302.GB14779@rikard>
References: <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard>
 <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
 <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
 <20190803183637.GA831@rikard>
 <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
 <20190805195526.GA869@rikard>
 <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
 <20190806192727.GA11773@rikard>
 <a687a6d29d4cc928a6aa128bcada5f55b26f41a4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a687a6d29d4cc928a6aa128bcada5f55b26f41a4.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:15:54PM -0700, Joe Perches wrote:
> On Tue, 2019-08-06 at 21:27 +0200, Rikard Falkeborn wrote:
> > On Wed, Aug 07, 2019 at 12:19:36AM +0900, Masahiro Yamada wrote:
> > > How about this?
> > > #define GENMASK_INPUT_CHECK(high, low) \
> > >        BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > >               __builtin_constant_p((low) > (high)), (low) > (high), 0))
> > Thanks for the feedback, your version looks much cleaner than mine. I
> > *think* I had a reason for using __is_constexpr() instead of
> > __builtin_constant_p but I'll try a full rebuild to see if something
> > comes up.
> 
> Perhaps a statement expression so high and low aren't possibly
> evaluated multiple times?
> 
> #define GENMASK_INPUT_CHECK(high, low)				\
> ({								\
> 	typeof(high) _high = high;				\
> 	typeof(low) _low = low;					\
> 	BUILD_BUG_ON_ZERO(__builtin_constant_p(_low > _high,	\
> 					       _low > _high,	\
> 					       0))		\
> })
> 
> 

That doesn't work I think (even after adding __builtin_choose_expr).
Even so, high and low are not evaluated multiple times (they're not
evaluated at all in GENMASK_INPUT_CHECK, if they were, the arguments
would be evaluated twice since they're evaluated in __GENMASK as well.

__builtin_constant_p does not seem to evaluate it's expression (even
though I didn't manage to find that spelled out in the docs, but since
__builtin_constant_p is evaluated at compile time it makes sense that it
doesn't), and __builtin_choose_expr does not evaluate the operand that
is not chosen (this is actually in the docs). Even if it was,
BUIlD_BUG_ON_ZERO uses sizeof its argument, which is evaluated at compile
time (unless the argument is a VLA).

So this should be safe.
