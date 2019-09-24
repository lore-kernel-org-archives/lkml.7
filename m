Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235AFC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15FA21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569352108;
	bh=r8Edw1zyVdDYplvJ86gljjeH2dBeo/J+GtEOKKWK9EA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=svdorTWq6ki/SbkH83YOXOkobXYOzTnoGy5LLRF7qVTfE2jGf8PAK/IOupuToMrJe
	 6Hnu6LZv3dij7AvneyxHFWuy5BifkLuG+A8NCGaQDSg26AKEkNYvMUX+62zzt8PYzS
	 2yasleVLu15XO9L1UGYL2SdBzw2MJfwcIYA6X6gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441860AbfIXTI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:08:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42638 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406400AbfIXTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:08:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id c195so2246052lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uj1Y9j5QWqL4P9NRMcUrWkMG7q2mqy5Dd8EdClY1dI=;
        b=KeNNjs2YCmvvqn9Okqghy7piNALz7QVTpDoyirLKb2vv3A9ZuN0VtUsI1Ci+kH11dV
         nPDKfZBN4OO7RvDf0UjlqePtCVjunFycfJIX0aRPfBS1B5KizhKrukK72fkQ+rJiQZx8
         qWou7b+Jp5S+Onyl6WMDXnD9Sw0vZRzIn4dqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uj1Y9j5QWqL4P9NRMcUrWkMG7q2mqy5Dd8EdClY1dI=;
        b=eySorqxsGpVJvK8YkHPbzgpMoy4g7KONcI0JB8ME2XaAy7krtz9iPqiL6fo9XR9IvA
         RX6L4TkNtsUwVbU9lnOugqv5eorhSOf1lz1yg99RCeDpgw2y/XGMTZUCEbmdPtQOwlv8
         ElrVS8weABjRa4CMxSoC/IIwWfsUjUD6nEjkSIelzwUsarAMG1ud4rLfxDVje1eyoHpB
         RR81WEPsRH2iE2uCiXaKc078EgNE5GzhlQd6Z6vOUTkXs02Bv9wseHkTRNqXnAfZ5HMh
         uEFMhC29Eh5u8YZP8I9SU6EjdZy6sfqMQB1UhkbziaJaYSN/LFO2Tlqa2ktZKrPQwKZ1
         RD/Q==
X-Gm-Message-State: APjAAAXyrvBEf9cYes/zulGR/4LM09mLtIbigpKk3Ghagt1Zs5Hi256c
        ZsdtoPax2VbJqmdpPODbo1Hto0nE8M8=
X-Google-Smtp-Source: APXvYqwWi8x8MrXUAJNN+aTSfePBOXR+Nk9pdOows0KxMP3JuAyV6dIjLaIoiEAp9MQXzONrtVvTMg==
X-Received: by 2002:ac2:46f8:: with SMTP id q24mr2909199lfo.51.1569352102503;
        Tue, 24 Sep 2019 12:08:22 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n25sm665750ljc.107.2019.09.24.12.08.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:08:21 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l21so3055293lje.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:08:20 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr2982371lje.90.1569352100677;
 Tue, 24 Sep 2019 12:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru> <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru> <20190924073940.GM6636@dread.disaster.area>
In-Reply-To: <20190924073940.GM6636@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Sep 2019 12:08:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf2BQ8xqVBF8YuxRznByrP-oTgcHSY9DgDnrFTxpsrVA@mail.gmail.com>
Message-ID: <CAHk-=whf2BQ8xqVBF8YuxRznByrP-oTgcHSY9DgDnrFTxpsrVA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:39 AM Dave Chinner <david@fromorbit.com> wrote:
>
> Stupid question: how is this any different to simply winding down
> our dirty writeback and throttling thresholds like so:
>
> # echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes

Our dirty_background stuff is very questionable, but it exists (and
has those insane defaults) because of various legacy reasons.

But it probably _shouldn't_ exist any more (except perhaps as a
last-ditch hard limit), and I don't think it really ends up being the
primary throttling any more in many cases.

It used to make sense to make it a "percentage of memory" back when we
were talking old machines with 8MB of RAM, and having an appreciable
percentage of memory dirty was "normal".

And we've kept that model and not touched it, because some benchmarks
really want enormous amounts of dirty data (particularly various dirty
shared mappings).

But out default really is fairly crazy and questionable. 10% of memory
being dirty may be ok when you have a small amount of memory, but it's
rather less sane if you have gigs and gigs of RAM.

Of course, SSD's made it work slightly better again, but our
"dirty_background" stuff really is legacy and not very good.

The whole dirty limit when seen as percentage of memory (which is our
default) is particularly questionable, but even when seen as total
bytes is bad.

If you have slow filesystems (say, FAT on a USB stick), the limit
should be very different from a fast one (eg XFS on a RAID of proper
SSDs).

So the limit really needs be per-bdi, not some global ratio or bytes.

As a result we've grown various _other_ heuristics over time, and the
simplistic dirty_background stuff is only a very small part of the
picture these days.

To the point of almost being irrelevant in many situations, I suspect.

> to start background writeback when there's 100MB of dirty pages in
> memory, and then:
>
> # echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes

The thing is, that also accounts for dirty shared mmap pages. And it
really will kill some benchmarks that people take very very seriously.

And 200MB is peanuts when you're doing a benchmark on some studly
machine that has a million iops per second, and 200MB of dirty data is
nothing.

Yet it's probably much too big when you're on a workstation that still
has rotational media.

And the whole memcg code obviously makes this even more complicated.

Anyway, the end result of all this is that we have that
balance_dirty_pages() that is pretty darn complex and I suspect very
few people understand everything that goes on in that function.

So I think that the point of any write-behind logic would be to avoid
triggering the global limits as much as humanly possible - not just
getting the simple cases to write things out more quickly, but to
remove the complex global limit questions from (one) common and fairly
simple case.

Now, whether write-behind really _does_ help that, or whether it's
just yet another tweak and complication, I can't actually say. But I
don't think 'dirty_background_bytes' is really an argument against
write-behind, it's just one knob on the very complex dirty handling we
have.

            Linus
