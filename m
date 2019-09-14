Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F5D20640
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568479992;
	bh=t87KT3FrQOwxew77SL6wtiB9p0BVgS0Y/MCULnkNzgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HMslt47VlRsQfGhFd+TSXjhWhD8ngmdbf9EiER6d/15Rerg+ccRWnQehBPWMALWrQ
	 rL4uuh8a9iqeQ/6a9Xilzuev1PXlauWHzU5YPEwwmz9tJCU1W4X4WDdPQkDlGQnJGk
	 WSEemN3RkF/ubTvqVOFzBkwQPIomhlbVKQ0TejD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfINQxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 12:53:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39023 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfINQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 12:53:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id j16so29961732ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLIo6vFI0bpmCXFO87whfx1RKUoffbAynCeevQqzVaY=;
        b=ELbD4LRyFSnkAfSPCSVXoyh3un74MVZCrn++kf+mNF8nH8v/FPyJ3yuLu+pNYRJ9Jm
         zd5rpNwKA1AWkc4nMxoDraDB/EG2Z8O2lJDEPT2dz4ZuWB+7c9jdPlZGfkKpysD4rZN0
         mM0oEqg+F6vSDXePBv81AnnhmKfV64W/yfUZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLIo6vFI0bpmCXFO87whfx1RKUoffbAynCeevQqzVaY=;
        b=ZjJHah6ETG2IVZ4PzloaaIEzJh+wzpd+m8o4l+n+QjhedIZsbofRBqK/PKgqmvVE8c
         aWZpF7oi8eZ73olpzaqDbmRlzqwZO1LBTMm3uHvgTozqyKVsX7nOMsbAPOx1BIpcznWb
         V872+QGK2mPiCsXUFKl/MthxxrjvEIyfHRwAj9s9jSlwjJp9pisjWPGtGtqj258FJ7y0
         3pwbFdJJZxz09EzQP1P8f+vg3j1o8EC9lX+k7a/cD8AZBHS6bylcNcLGDvyyBucEIPUA
         J8v8TnPP8vOhLEcYLJ9CvOZjVtfnD/jP4VdoBrAiebzia1zu0BakxDGESMvEg1+pKnGm
         6ZKQ==
X-Gm-Message-State: APjAAAVZ3n8kmFLgwHB3Ob0clso0GQ7ncv/uu21x/1uy/95Rvc2uwF7H
        7YKLTmW4M23q99413kpeXtVjHtt6Dww=
X-Google-Smtp-Source: APXvYqyxX7R+LOtP21rt6kDZYIalfffWGCKzeYeNDVDHloJm7qktuVkIqmgk9o+Uqso1vSYYGEEn3A==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr31731258ljj.62.1568479986118;
        Sat, 14 Sep 2019 09:53:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p10sm7113930lji.71.2019.09.14.09.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 09:53:05 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id v24so2315756ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 09:53:05 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr33898456ljg.72.1568479984957;
 Sat, 14 Sep 2019 09:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
In-Reply-To: <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 09:52:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
Message-ID: <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
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

On Sat, Sep 14, 2019 at 9:35 AM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> Let me repeat: not -EINVAL, please. Please find some other error code,
> so that the application could sensibly distinguish between this case
> (low quality entropy is in the buffer) and the "kernel is too dumb" case
> (and no entropy is in the buffer).

I'm not convinced we want applications to see that difference.

The fact is, every time an application thinks it cares, it has caused
problems. I can just see systemd saying "ok, the kernel didn't block,
so I'll just do

   while (getrandom(x) == -ENOENTROPY)
       sleep(1);

instead. Which is still completely buggy garbage.

The fact is, we can't guarantee entropy in general. It's probably
there is practice, particularly with user space saving randomness from
last boot etc, but that kind of data may be real entropy, but the
kernel cannot *guarantee* that it is.

And people don't like us guaranteeing that rdrand/rdseed is "real
entropy" either, since they don't trust the CPU hw either.

Which means that we're all kinds of screwed. The whole "we guarantee
entropy" model is broken.

               Linus
