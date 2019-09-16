Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DFEC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FAA206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568605252;
	bh=UJCsA608lGbG71D95v0GEOucgdCj8+Z7N7tL1hOqIfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dXW+mfiX+oe8ZigyTP47YN9GqNktY4cpwcM69eYjY6lcIn5SCvxGnsV4Y6ObJ8SOC
	 k/vkTKZ6AVIGFV3zA8c5/Xv9djVsEtILt5gfQWBIuYjRIqo0LmIR5LN+gxSaHMpTgl
	 AAWVw6PM2fdW9VIfMjkT+DHzXpayUCHUMAK3FtKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfIPDkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 23:40:51 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34976 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfIPDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:40:50 -0400
Received: by mail-lf1-f45.google.com with SMTP id w6so26274819lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLXQAqPqQDmWrNXiK3wVfq5Z50mijKvlxznDrVOzmgs=;
        b=Z+nV7Ke5BSXKKmQ+Ts4YTT7qlC7TbyV/jm6NLKBU6z03rU7NvAQNji5GioZWgK17s7
         62yKx2FMR6rJFiizi4ZjNRv5njnEY7NFsF2OjfCFTgE2HwxHxhM9PY/0+JsGYd4dJ2fD
         dgKtQX7Ouj0JYOEnIgLAxi0CnKF/POvAmDnps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLXQAqPqQDmWrNXiK3wVfq5Z50mijKvlxznDrVOzmgs=;
        b=C5ggWd0uAHJMhwpggvJrjjKGD+PKQrJVeKjdjMaV1iLZjf35o+PAzi2Md+lZF79RQT
         ohIK0I+p0U9LL0OJvyRgr8mwDbqHNulka2il85qRK7rjN5sg1Am2Vsh7V82jleUS61kT
         Go42oaIQirFwZk3YI9MLQZ7FQd1Ail8yXPIdZAoODNEFYs0Oe+rQoi5N4e6hjaU5ZkPm
         1vdwHJOV33aS5eVb1BHzVwH2NY18jMlNJSyljcxD63DsZmBQA8DOuMROYYWmL2wtDr7F
         9xRmJabXYtQC9bX0XMNn42qtN42P/NyOg5V4R/dXniun9tiu5dvGJJZVRdu38nnzgJPt
         1iag==
X-Gm-Message-State: APjAAAV2Lz888FIREMJ7Sww/3sY+z2BWMcDPMXjxPd9Gz06AjzjD9z8U
        qtcc29rVFP1Owtpkqop8XDZCMZGLVn8=
X-Google-Smtp-Source: APXvYqwnBx3PXIo8gw7xlBiYvsViVpSPKl5hCTdsihn6AEVtlba6skL8k05yncBvr15yn+rtzZYWVQ==
X-Received: by 2002:ac2:5bde:: with SMTP id u30mr35607473lfn.59.1568605248063;
        Sun, 15 Sep 2019 20:40:48 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f22sm8630068lfk.56.2019.09.15.20.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:40:47 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id c22so4482236ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:40:46 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr5130786ljs.156.1568605246706;
 Sun, 15 Sep 2019 20:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login> <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu>
In-Reply-To: <20190916032327.GB22035@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:40:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
Message-ID: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 8:23 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> But not blocking is *precisely* what lead us to weak keys in network
> devices that were sold by the millions to users in their printers,
> wifi routers, etc.

Ted, just admit that you are wrong on this, instead of writing the
above kind of bad fantasy.

We have *always* supported blocking. It's called "/dev/random". And
guess what? Not blocking wasn't what lead to weak keys like you try to
imply.

What led to weak keys is that /dev/random is useless and nobody sane
uses it, exactly because it always blocks.

So you claim that it is lack of blocking that is the problem, but
you're ignoring reality. You are ignoring the very real fact that
blocking is what led to people not using the blocking interface in the
first place, because IT IS THE WRONG MODEL.

It really is fundamentally wrong. Blocking by definition will never
work, because it doesn't add any entropy. So people then don't use the
blocking interface, because it doesn't _work_.

End result: they then use another interface that does work, but isn't secure.

I have told you that in this thread, and HISTORY should have told you
that. You're not listening.

If you want secure keys, you can't rely on a blocking model, because
it ends up not working. Blocking leads to problems.

If you want secure keys, you should do the exact opposite of blocking:
you should encourage people to explicitly use a non-blocking "I want
secure random numbers", and then if that fails, they should do things
that cause entropy.

So getrandom() just repeated a known broken model. And you're
parroting that same old known broken stuff. It didn't work with
/dev/random, why do you think it magically works with getrandom()?

Stop fighting reality.

The fact is, either you have sufficient entropy or you don't.

 - if you have sufficient entropy, blocking is stupid and pointless

 - if you don't have sufficient entropy, blocking is exactly the wrong
thing to do.

Seriously. Don't make excuses for bad interfaces. We should have
learnt this long ago.

             Linus
