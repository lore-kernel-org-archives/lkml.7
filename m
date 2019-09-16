Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C69C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469FB214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568653686;
	bh=ZMyAyLAYsoa3qVfWHM7UVHAKR27uDdfrx5GN9gLS/z4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m0k9DlL6aSbtOW9hC4HJWy+gEcTcxU37vepEhBDZGFuuHWKePCmU5iGzJnB/r1J8J
	 H7A+oNzJ9AM0NBeiZY1iopYAFuYveJa5ss0xD3p5q8IdSd3sTWalRNT3j+i7M8Z8kG
	 7tMTqxoZkVu+Mpze3Q1/UuIefZYyuiZb3JZGrfdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbfIPRHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:07:52 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38327 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390277AbfIPRHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:07:51 -0400
Received: by mail-lj1-f175.google.com with SMTP id y23so670912ljn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhXl70av4EvOTbL0RRXS4SdgE4V4WRtYtcKsjJL619g=;
        b=Fs3ihW1d0/7OhSFVjmMcwT0WBaV23WDO7f0r7V2eN5ewaGmCnHtgRxJ+CpdhycMKWW
         rP4+Xi9hy0A30CcOwQKaYl7GEfN4Xr6h3g3ESaYI871rAs2uhfnN/bND0hOZVHWDEA6y
         f3Qrk6EBNA9PfhZV/b9JMfp5fSM0rIwDkmdKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhXl70av4EvOTbL0RRXS4SdgE4V4WRtYtcKsjJL619g=;
        b=kPbD4JvwwiE7Vw34dFvuV0TzgRE0vmZF3WIY+gaY+V1c2Fsg18Q4YWHXNp47RSoQim
         Csedknntietn1YYHmNGPPt3A7o2mhPyLuECGlYdJ+hp+cG3a76jWhuLhwf5lS9/JnIHT
         T0JYLc/jrKKIcdjedKSj8Gm1zUydBXPtEBjtReNKqR6AU2/46oX5f914I6z42mT6LeVx
         1/X9EUHKFu2kJMRB20/wFk0SHwL5IxpP2eTSiY+yc5KA28yQBo0tFyXYs3/NjoITLW14
         e3x25fH7+UReXo4p0jssHkn3kb62yEeztQhxPBj+qwR8AeG4WM8WDVjTQMa0U+xY1wp3
         r1pA==
X-Gm-Message-State: APjAAAU17aNqvI1ixZ6HRyomITLk05Wq9U2xDHoMeAddn1w45o72lLy4
        MmCMwy6idZSvoSh2+zmgnRCuF6sOj7g=
X-Google-Smtp-Source: APXvYqx0jq6cec5vfIrpCo20PyJTsyvPKacMKBDoQ8p/V/ZvxEHPsIRtyO9qrJURngEm3y1HPvTFpw==
X-Received: by 2002:a2e:9e8f:: with SMTP id f15mr341126ljk.212.1568653667752;
        Mon, 16 Sep 2019 10:07:47 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m25sm8296842ljg.35.2019.09.16.10.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 10:07:44 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c22so678439ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:07:44 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr383093ljs.156.1568653664082;
 Mon, 16 Sep 2019 10:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login> <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu> <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
 <20190916170028.GA15263@mit.edu>
In-Reply-To: <20190916170028.GA15263@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 10:07:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHNtmCAWGWmUn7LYnwGWdNvDavhzBdNdeeTnP4Wkk3gg@mail.gmail.com>
Message-ID: <CAHk-=wiHNtmCAWGWmUn7LYnwGWdNvDavhzBdNdeeTnP4Wkk3gg@mail.gmail.com>
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

On Mon, Sep 16, 2019 at 10:00 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> How /dev/random blocks is very different from how getrandom(2) blocks.
> Getrandom(2) blocks until the CRNG, and then it never blocks again.

Yes and no.

getrandom() very much blocks exactly like /dev/random, when you give
it the GRND_RANDOM flag.

Which is completely broken, and was already known to be broken. So
that flag is just plain stupid.

And getrandom() does *not* block like /dev/urandom does (ie not at
all), which was actually useful, and very widely used.

So you really have the worst of both worlds.

Yes, getrandom(0) does what /dev/random _should_ have done, and what
getrandom(GRND_RANDOM) should be but isn't.

But by making the choice it did, we now have three useless flag
combinations, and we lack one people _want_ and need.

And this design mistake very much caused the particular bug we are now hitting.

                  Linus
