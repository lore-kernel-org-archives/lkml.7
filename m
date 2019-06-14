Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F7C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7BE208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560479459;
	bh=gME1O9+RvWA/tYTnG9DRWZo8JxD0NaeYDRgUxG+BNKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uOeI9aeE6QyjIV2GTUOuT1WcSLa0kNDuB2QhS9QD9HQOkFvEKIykbO66FrcjVeg/g
	 9ojZ5ThXE9TvdRcl8GBrIU7UCiRZ47m0f3GPPwazWvcaxvYAoH5pAyglBZjDxKTaJh
	 eqB2HXQZOSHZsmFx2FESFPmFpm7yUXJa8pPWcjCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFNCa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:30:58 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:44322 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNCa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:30:57 -0400
Received: by mail-lf1-f49.google.com with SMTP id r15so581436lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54SzfXIM0CUZELnkDPId2LFnAOP2eMm66mZYeVaiMIc=;
        b=b6wus35DaLhs8FFeq7PNRZ3hYyz4oMdypJnhTcMZaFiSx3caRk6yJHOkFLmXfc68gQ
         FYnDbGsYmvinxpLwPoM2+Xa2pga+BkCWG8bI9aaj+MagRJ3SZ/YT13ZFs5CQZvlGQwk+
         z315q1qxQWAhXJ4qm5Fc+0jzeL3t3lDjn2XKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54SzfXIM0CUZELnkDPId2LFnAOP2eMm66mZYeVaiMIc=;
        b=DVbB1StfOZ+gDgVL71hEp/Z529VV6Z37WC3TnxxoG0lA/4+g36Y0wCRnnt7bYlCvOM
         oX/68M8FV8I9AqMDnuU10zNJpgCrhyQGwY7o5AoYFlR751q3CqT8a07ZA8tK9DtRZyY+
         nrV67i2QXIeAqP2IcQPQ/FILP7o/DC3bFrJoK7IIf/R707SegTW+pT/FlMxDK+zir0io
         y2Td7eJCbd6n1o7EI5SPF6obYUq90xacE37GbzMtyEI/cw2dAryIDo4twVw3dVjeAk8U
         mY2s7yoF+lrf60nF/zp3WNfWjoH7c6dSLgS1aw0kdqzsbPefe5PmQ/bPtuBPTknU1l+t
         aBfA==
X-Gm-Message-State: APjAAAUxhk9B2WL4Y3l5FLvoeT28ZOyJ60lMh/0dSNEd73IzKUaZQor4
        UcogK7cdzFjrFOR1aBL7h/yneceXcbg=
X-Google-Smtp-Source: APXvYqwM1Z04Al5ApsQTY3oW68puVl4ygevmZNOXJy6eWLxzeAlc2MwyTNp/LY11QofUFVGKEaKF9w==
X-Received: by 2002:ac2:54a6:: with SMTP id w6mr6820947lfk.108.1560479455192;
        Thu, 13 Jun 2019 19:30:55 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i23sm306683ljb.7.2019.06.13.19.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 19:30:53 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id k18so704892ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:30:53 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr11450885ljk.90.1560479452914;
 Thu, 13 Jun 2019 19:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
In-Reply-To: <20190613235524.GK14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jun 2019 16:30:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com>
Message-ID: <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:56 PM Dave Chinner <david@fromorbit.com> wrote:
>
> That said, the page cache is still far, far slower than direct IO,

Bullshit, Dave.

You've made that claim before, and it's been complete bullshit before
too, and I've called you out on it then too.

Why do you continue to make this obviously garbage argument?

The key word in the "page cache" name is "cache".

Caches work, Dave. Anybody who thinks caches don't work is
incompetent. 99% of all filesystem accesses are cached, and they never
do any IO at all, and the page cache handles them beautifully.

When you say that the page cache is slower than direct IO, it's
because you don't even see or care about the *fast* case. You only get
involved once there is actual IO to be done.

So you're making that statement without taking into account all the
cases that you don't see, and that you don't care about, because the
page cache has already handled them for you, and done so much better
than DIO can do or ever _will_ do.

Is direct IO faster when you *know* it's not cached, and shouldn't be
cached? Sure. But that/s actually quite rare.

How often do you use non-temporal stores when you do non-IO
programming? Approximately never, perhaps? Because caches work.

And no, SSD's haven't made caches irrelevant. Not doing IO at all is
still orders of magnitude faster than doing IO. And it's not clear
nvdimms will either.

So stop with the stupid and dishonest argument already, where you
ignore the effects of caching.

                Linus
