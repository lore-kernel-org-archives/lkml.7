Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9577BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD1A206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568610148;
	bh=ovwJLk+WxYx5zjsslP/MEW3hwVBjJzNTICGHqj3UqY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SgII7535xN9p40cyTClEbINqoDD52shOmISukoUEGWoC0F/PRJQW7UBI/il7Nemdh
	 fAn9z3RvzAp5KqneJPm1PuiD6/5Or/Y0HcOfxdjNCmDxTtFWtTvBz4MKrmyjXw62pd
	 BqGNRne6v/p45hFTQbsgkoloSbplxjGwfunnZXaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfIPFC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 01:02:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37348 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfIPFC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:02:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so26334416lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 22:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+77oKblgW1oj6FjBllVFfQm2XV8GTAz0jQsoKS4xdc=;
        b=bW2PJuAaZzpeBG5JdcrThGYexKY4t+waHJVh5kr2Qo1YC1+VtAFPsCi28FJ19gU/rH
         PTGWJ4+8rpiLCWaU4mDtgGFu5YreF0dHPosQIaObW57Di/8f4ch5usXEydRlgaWOCzD7
         zsN38UFAxuPASKzpthvDx8t/rXJBJu/58gXJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+77oKblgW1oj6FjBllVFfQm2XV8GTAz0jQsoKS4xdc=;
        b=Ytrf3LUjHEZVlv+i1G4Vz5bZuDEzyLceuZavCyajpsHyIC12Hh7U99yYwOrAM0C8qO
         7FhGjVqMxvXoGMIhKH8xKVgnWw7nGE9I3gsMKaagBlp6zTmuII3JzwwyWfdsnomK3Eto
         JTKqFsoWamlS9kunO8X6ot+W6bnqYvvSBJgBkEoUXWMzBwjbQc7fmwduk7gRjGgeCeBl
         5NXkUl7U1rKuI020LM06N/zg5iXaw+P59uq8oR7sLGd0J+R4Y5cALpWgRbC7WuQWJhoI
         0u+xEfJj+T6iisvyLPaQEUhpksKKtVcR20Q0CEkcqeRUrFZWTy6KcEkS6nUXv+PV9Cj+
         hEaw==
X-Gm-Message-State: APjAAAUOHc6lJhKa8zM0bbnMEOFMePKQG5e/BZPDb7i1YIP81y2eJ13q
        vbpE0UWUlIrhltCgQ2ITlK8EO3S7n4I=
X-Google-Smtp-Source: APXvYqxs7z+2iW2MWlLKyZY3unuedFj96uPNrHPbh3K8sss82ZnL636LK86oiD+99GKLd/dVAyKfxw==
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr5021475lfl.74.1568610142353;
        Sun, 15 Sep 2019 22:02:22 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g21sm6531935lje.67.2019.09.15.22.02.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 22:02:19 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y23so32386568lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 22:02:18 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr3508817lji.52.1568610138468;
 Sun, 15 Sep 2019 22:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login> <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc> <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
In-Reply-To: <20190916042952.GB23719@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 22:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
Message-ID: <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 9:30 PM Willy Tarreau <w@1wt.eu> wrote:
>
> I'd be in favor of adding in the man page something like "this
> random source is only suitable for applications which will not be
> harmed by getting a predictable value on output, and as such it is
> not suitable for generation of system keys or passwords, please
> use GRND_RANDOM for this".

The problem with GRND_RANDOM is that it also ends up extracting
entropy, and has absolutely horrendous performance behavior. It's why
hardly anybody uses /dev/random.

Which nobody should really ever do. I don't understand why people want
that thing, considering that the second law of thermodynamics really
pretty much applies. If you can crack the cryptographic hashes well
enough to break them despite reseeding etc, people will have much more
serious issues than the entropy accounting.

So the problem with getrandom() is that it only offered two flags, and
to make things worse they were the wrong ones.

Nobody should basically _ever_ use the silly "entropy can go away"
model, yet that is exactly what GRND_RANDOM does.

End result: GRND_RANDOM is almost entirely useless, and is actively
dangerous, because it can actually block not just during boot, it can
block (and cause others to block) during random running of the system
because it does that entropy accounting().

Nobody can use GRND_RANDOM if they have _any_ performance requirements
what-so-ever. It's possibly useful for one-time ssh host keys etc.

So GRND_RANDOM is just bad - with or without GRND_NONBLOCK, because
even in the nonblocking form it will account for entropy in the
blocking pool (until it's all gone, and it will return -EAGAIN).

And the non-GRND_RANDOM case avoids that problem, but requires the
initial entropy with no way to opt out of it. Yes, GRND_NONBLOCK makes
it work.

So we have four flag combinations:

 - 0 - don't use if it could possibly run at boot

   Possibly useful for the systemd-random-seed case, and if you *know*
you're way past boot, but clearly overused.

   This is the one that bit us this time.

 - GRND_NONBLOCK - fine, but you now don't get even untrusted random
numbers, and you have to come up with a way to fill the entropy pool

   This one is most useful as a quick "get me urandom", but needs a
fallback to _actual_ /dev/urandom when it fails.

   This is the best choice by far, and has no inherent downsides apart
from needing that fallback code.

 - GRND_RANDOM - don't use

   This will block and it will decrease the blocking pool entropy so
that others will block too, and has horrible performance.

   Just don't use it outside of very occasional non-serious work.

   Yes, it will give you secure numbers, but because of performance
issues it's not viable for any serious code, and obviously not for
bootup.

    It can be useful as a seed for future serious use that just does
all random handling in user space. Just not during boot.

 - GRND_RANDOM | GRND_NONBLOCK - don't use

   This won't block, but it will decrease the blocking pool entropy.

   It might be an acceptable "get me a truly secure ring with reliable
performance", but when it fails, you're going to be unhappy, and there
is no obvious fallback.

So three out of four flag combinations end up being mostly "don't
use", and the fourth one isn't what you'd normally want (which is just
plain /dev/urandom semantics).

                     Linus
