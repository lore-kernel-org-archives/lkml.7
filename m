Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07AA217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569600354;
	bh=BZ4tzcEF172VnXn+8Hq4/MZNbwYlf6x08IqcF1hJuSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IZsTq0s3/Ewjq91h3pMa+FRkFoTgy3leH72jAn7KywiMaprSmUv1ZbIowtl+HHsix
	 U0740KhIPtxforBeScG0isKM8bW9kc8hYSCB3wzbqEuORsGTXopID1+IX0bAVkbimh
	 JST7eaBPpciicwzVQGHjnDJza8baesFVKtMkHs3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfI0QFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:05:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34222 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0QFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:05:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so3058625lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUAOKj8TZSrA0yEWe2HFVFAP8tkdAoUvA0qRc/X2cQw=;
        b=gmZVemT3kiPxJ+8cpxAZPOWUM+OCNclOcXI3vW7HbQXKL0sh5OTlcNAkP0CWnCKa5a
         zT+iiF8vVo3r2RkNGaqPNZVYv2LYMJwzYsEqIEB9TZQQ94W4xVcmnk0DtC8URs/ZpX/O
         1DnVrVlH+y95Mqvpe3nzWUmYoU64c/+Qyc6lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUAOKj8TZSrA0yEWe2HFVFAP8tkdAoUvA0qRc/X2cQw=;
        b=nwoecjHyW+QfHFC6ubIx66JB9p2+pj4+EAhlZh6N5aAXSSiSlEBnqVxl+Ca8HkTczj
         TMSWqmSwFSyKivhTRsYHzPYNotHsM5T7Ax+C/+cvfbp6eCB/GXyde2eTRuX5ON5rbBwf
         I6RGvIvGl6M0KeK7yzJdvzOJuu8lhM1FXhytezvKy48vocx5UnA1utIcTxsrmzPL+9/p
         xy5evGsgwBvJcMa4NrPFzYeXEydwIN7bYJNWWMb8wFTNaOTWZL9nSVWpDbICl1FWHJrL
         iH9OlvUjdbI5JpgrHNR/dsiuicdMsMKtJt6KaO49l2QK1z5KmNWwa6bnbfbUNnwLrDcs
         SwXw==
X-Gm-Message-State: APjAAAWMaDue0DLd4pAmQhi/fZgV5WZsuE3COdDfnCzJ8bnvCJPxh7b0
        ddvbF1sYbevJls87oUvSdX+kKFIVyx0=
X-Google-Smtp-Source: APXvYqxdVVy8n5Ww23XCbbnFmJECxQwZlF+kh7UU+/VH2WeosV3y/4sXJK2e3YNjFFXf/xDbFxmlEA==
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr3596044ljk.166.1569600350287;
        Fri, 27 Sep 2019 09:05:50 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m10sm557337lfo.69.2019.09.27.09.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:05:50 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id d1so2995515ljl.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:05:49 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr3440165lja.180.1569599952421;
 Fri, 27 Sep 2019 08:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu> <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <87zhj15qgf.fsf@x220.int.ebiederm.org>
 <84824f79-2d12-0fd5-5b32-b0360eb075ac@gmail.com> <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
 <20190927135708.GD11791@gardel-login>
In-Reply-To: <20190927135708.GD11791@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 08:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=widBVsz+JZYnkV8xvCt+XMzkO6Gz3KZQ_gULXpMpUZfMA@mail.gmail.com>
Message-ID: <CAHk-=widBVsz+JZYnkV8xvCt+XMzkO6Gz3KZQ_gULXpMpUZfMA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 6:57 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> Doing the random seed in the boot loader is nice for two reasons:
>
> 1. It runs very very early, so that the OS can come up with fully
>    initialized entropy right from the beginning.

Oh, that part I love.

But I don't believe in your second case:

> 2. The boot loader generally has found some disk to read the kernel from,
>    i.e. has a place where stuff can be stored and which can be updated
>    (most modern boot loaders can write to disk these days, and so can
>    EFI). Thus, it can derive a new random seed from a stored seed on disk
>    and pass it to the OS *AND* update it right away on disk ensuring that
>    it is never reused again.

No. This is absolutely no different at all from user space doing it
early with a file.

All the same "golden image" issues exist, and in general the less the
boot loader writes to disk, the better.

Plus it doesn't actually work anyway in the one situation where people
_really_ want it - embedded devices, where the kernel image is quite
possibly in read-only flash that needs major setup for updates.

PLUS.

Your "it can update it right away on disk" is just crazy talk. With
WHAT? It has no randomness to play with, and it doesn't have time to
do jitter entropy stuff.

So all it can do is a really bad job at taking the previous random
seed, doing some transformation on it, and add a little bit of
whatever system randomness it can find. None of which is any better
than what the kernel can do.

End result: you'd need to have the kernel update whatever bootloader
data later on, and I'm not seeing that happening. Afaik the current
bootloader interface has no way to specify how to update it when you
actually have better randomness.

> NVRAM backing EFI vars sucks. Nothing you want to update on every
> cycle. It's OK to update during OS installation, but during every
> single boot? I'd rather not.

I do agree that EFI nvram isn't wonderful, but hopefully nonvolatile
storage is improving, and it's conceptually the right thing.

                  Linus
