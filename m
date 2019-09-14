Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B4C4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382472081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568488788;
	bh=ouScJnt26pzP69fgyglFbrcV+rBmS6ZulHjP8wEhBGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aje83BlhFtw3lkE4pWeOUF8wP+fL+Opp91DQmJJPUJeEq+QdM/dZWIGks0cDjU+0A
	 aoU5/7dZZpkdUrGdIpc7XZIJaLPFAGzhlBITlk/rYK2O5Pv0rP8u7Ckeqoo0xil1tz
	 vKGX/4E1+XS/jQAF43gXHkMBTvzbcAp0WiHS9PP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfINTTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:19:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45284 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfINTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:19:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so24464081lff.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPQUiN+MJCiURQJKXosBWd3fof3PGiz/eGjFjKhHooQ=;
        b=WnL0j3pyjxPnM4hyGPIMKPvliWuoPrHkG3hgdyb3sUJcufozYIh7VZ+bBUf44lWAB4
         pcl0tDtzPQqDxymM/g3YLvtkLjejtwFbg4lioNHR9dtkICNJTYZ6/F3XTY/AgKJG9z1d
         EuP51x7okTZmjwEK/BHlvdQaggkLC8U+lNfw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPQUiN+MJCiURQJKXosBWd3fof3PGiz/eGjFjKhHooQ=;
        b=frCIzyPqASPPuEm46yT1q8ZA08oyaLQPzXcbtu35Ex7C0nLr3AobKlF1WEEEBlMGxg
         NiraQ7Nd4IilW+C0DZ5fVK2GutkY8swoJBh8NV6vrv7VlOBPxB6sJ4B/bWRxJRUzFoRi
         Poybd8KpFJ4PKKgK7WCCTTgMIWqzo+LLQ6m7Nj2jRpZYUzN/fTpotE4uWKYhCIkxKvbP
         1swNyzjM9o1Y0Xlmq1tQ7p0yrSRSFi81dvtQ0jMyiyKEh+0FtNANVplHP7SQ3yQevuPM
         0MkdEjCoH1xebCsVmAG3QW+xIhjSD09899BAZ/gh0upby1ddSFjgwH70wyoCWo2hllAb
         WA4g==
X-Gm-Message-State: APjAAAU0HmQI8GDmI2hoq+1hwtm/xgBKSNqfbU0Zl8Td+BGuQXclSWvU
        nQf/VNq4wrz90oa1Y5ogDdeqDp5jWAE=
X-Google-Smtp-Source: APXvYqwyT029cVI3rOrNtCnl6xU+8i9CHVDkJkE6mAw9kmT6RRqW1yJPjhIuy89nkhVJ97CIx4wRAA==
X-Received: by 2002:a19:6549:: with SMTP id c9mr32040639lfj.99.1568488781346;
        Sat, 14 Sep 2019 12:19:41 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m25sm7108110ljg.35.2019.09.14.12.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 12:19:40 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a4so30092000ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 12:19:39 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr34140740ljg.72.1568488779341;
 Sat, 14 Sep 2019 12:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <8c2a47cc-a519-ad94-5d9a-18bb03ba2fd7@gmail.com>
In-Reply-To: <8c2a47cc-a519-ad94-5d9a-18bb03ba2fd7@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 12:19:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSbo=dBiqozLoa6TFmMgbeB8d9krXXvXBKtpRWkG0rMQ@mail.gmail.com>
Message-ID: <CAHk-=whSbo=dBiqozLoa6TFmMgbeB8d9krXXvXBKtpRWkG0rMQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 10:09 AM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> > Which means that we're all kinds of screwed. The whole "we guarantee
> > entropy" model is broken.
>
> I agree here. Given that you suggested "to just fill the buffer and
> return 0" in the previous mail (well, I think you really meant "return
> buflen", otherwise ENOENTROPY == 0 and your previous objection applies),

Right.

The question remains when we should WARN_ON(), though.

For example, if somebody did save entropy between boots, we probably
should accept that - at least in the sense of not warning when they
then ask for randomness data back.

And if the hardware does have a functioning rdrand, we probably should
accept that too - simply because not accepting it and warning sounds a
bit too annoying.

But we definitely *should* have a warning for people who build
embedded devices that we can't see any reasonable amount of possible
entropy. Those have definitely happened, and it's a serious and real
security issue.

> let's do just that. As a bonus, it saves applications from the complex
> dance with retrying via /dev/urandom and finally brings a reliable API
> (modulo old and broken kernels) to get random numbers (well, as random
> as possible right now) without needing a file descriptor.

Yeah, well, the question in the end always is "what is reliable".

Waiting has definitely not been reliable, and has only ever caused problems.

Returning an error (or some status while still doing a best effort)
would be reasonable, but I really do think that people will mis-use
that. We just have too much of a history of people having the mindset
that they can just fall back to something better - like waiting - and
they are always wrong.

Just returning random data is the right thing, but we do need to make
sure that system developers see a warning if they do something
obviously wrong (so that the embedded people without even a real-time
clock to initialize any bits of entropy AT ALL won't think that they
can generate a system key on their router).

               Linus
