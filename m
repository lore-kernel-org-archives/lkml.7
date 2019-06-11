Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835ECC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA120679
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560227962;
	bh=mvtj2aHGzX0ilJr5zceP50LOhamFuNUHmgRWOiUlROA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fhbT2/BJvUg7p5aN1VPS7Bzas432HB1drRzolFGyHkDUTHPQqXNNuYxBL7KUboXAj
	 MuXRRNPEBWUMnPJKDMj+Felci22+18Lfs4gTa/CekP71R/QNfdUu7dZN9lw1myc7Ck
	 rnK0RTP8mXnqPKaqXZp44QaMNA/Jqb0LZjvHuAdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbfFKEjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:39:21 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41279 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbfFKEjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:39:20 -0400
Received: by mail-lj1-f169.google.com with SMTP id s21so10144204lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SMEwJWMeHtEyw0+L1caTDzGbNv810UPp3Lqsx3PUF8=;
        b=QoOOR0HYKqsx3JsW6Ew+a3guMYkQ2W/iAmuqxvOFKc2gBdgPpiDUc6GDNZv08ve+UL
         EI1jVlrxftmcd8GkeJ0oFp4Q1bcxwTC2j3DRi7CGlH9xQA0pIgDG9f/n8XTk+FnhBPSf
         5EUYmUYvqmN9yKTc9mv8oUSfj0cMJfJ9bKh/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SMEwJWMeHtEyw0+L1caTDzGbNv810UPp3Lqsx3PUF8=;
        b=PHgeXV0vYtP0LInRJdxJLyPJKop+0n8JYMc4XFCtkXlpVL+3lUk4vWAktb60E+vqhF
         uzlGx4ZaQPcB2k+PgIMC966zCWPq5bH4AvBLOw83LiTlsyDaikgUwHMJzWbnIh7XZrFs
         bCEeXzirh+e2FR2AP+LuT6u4j4Z1NbO65vpo1x6I1ev8ScxkvbyAGz0hO04bWCL5f5PT
         WjTvupNadqpybAQOnFGah4pFGwYqalr0VDgbsmrNxQ+t98cBNrXPTL7XcSEZVgtFV1Fy
         b+tl46HT4v/FyZAsGfjeAsa2p7V88XYlBfjjAAzEx5wI2kI8cBufXydALuBktVssKEM4
         98kA==
X-Gm-Message-State: APjAAAUj0oJVeesqrRboBkxUCu0GX1e42VIBa97pTKo700RsFc9ZXafe
        BF2GykwJP+RHmQEEO7cXj1kXo7kfm2M=
X-Google-Smtp-Source: APXvYqwc9xd/mVAckObVN0+5wRvuLYJjCQsOdGdvgLA7PsLStiRU/OKXufKQCJVEPUvkk+9PrSCa8w==
X-Received: by 2002:a2e:9692:: with SMTP id q18mr40044182lji.89.1560227958303;
        Mon, 10 Jun 2019 21:39:18 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t15sm2317469lff.94.2019.06.10.21.39.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 21:39:17 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id m23so10093716lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:39:16 -0700 (PDT)
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr4973161ljs.44.1560227956599;
 Mon, 10 Jun 2019 21:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com> <20190611041045.GA14363@dread.disaster.area>
In-Reply-To: <20190611041045.GA14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jun 2019 18:39:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=whDmeozRHUO0qM+2OeGw+=dkcjwGdsvms-x5Dz4y7Tzcw@mail.gmail.com>
Message-ID: <CAHk-=whDmeozRHUO0qM+2OeGw+=dkcjwGdsvms-x5Dz4y7Tzcw@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 6:11 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Please, no, let's not make the rwsems even more fragile than they
> already are. I'm tired of the ongoing XFS customer escalations that
> end up being root caused to yet another rwsem memory barrier bug.
>
> > Have you talked to Waiman Long about that?
>
> Unfortunately, Waiman has been unable to find/debug multiple rwsem
> exclusion violations we've seen in XFS bug reports over the past 2-3
> years.

Inside xfs you can do whatever you want.

But in generic code, no, we're not saying "we don't trust the generic
locking, so we cook our own random locking".

If tghere really are exclusion issues, they should be fairly easy to
try to find with a generic test-suite. Have a bunch of readers that
assert that some shared variable has a particular value, and a bund of
writers that then modify the value and set it back. Add some random
timing and "yield" to them all, and show that the serialization is
wrong.

Some kind of "XFS load Y shows problems" is undebuggable, and not
necessarily due to locking.

Because if the locking issues are real (and we did fix one bug
recently in a9e9bcb45b15: "locking/rwsem: Prevent decrement of reader
count before increment") it needs to be fixed. Some kind of "let's do
something else entirely" is simply not acceptable.

                  Linus
