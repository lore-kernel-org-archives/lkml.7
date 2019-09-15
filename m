Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1EC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00587214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568574535;
	bh=+zi3aw0q2XV5yrmH2QAF10ImM4ucdBJ/m0iAdgfPmho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nDehIlTgI8YjBRZ5VI3VnaCaMLMzJX83pqQTSMNVGBUKKKrKe/ESIxg+6K/XNq0Sk
	 GsEIoszhSn47sGN+yfCjAJgaK/gcWL2FwDvwZTvYZ3LA8p7O6dVLtJca9Zod34R/+9
	 4e3NajM7oJYAEIPzYlqg03HeKXM2I/zdMzrKIp/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfIOTIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:08:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37705 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfIOTIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:08:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id c22so3904562ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FC6oplaM/uLQVrJ7puxoeIhZgwICvODF/vPEHCG2N4M=;
        b=H8aeNSjUbHEYQw38GMjoyn9XHob6uka2vY7wVgLQDsFuRYIpWKHEOXFjfKOwAOpbRD
         fzQz/sjksOMUjfFHHoJbP1NELmEJRgPUZ9+WAFmXZDAleQmykxS+ss+2fYrhKaZhhX4/
         bT/VS5+fpR8ZyOIIW2ZolBDrjqNHyHlJCVzr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FC6oplaM/uLQVrJ7puxoeIhZgwICvODF/vPEHCG2N4M=;
        b=J+QFigvGIp/OkGcdmOf/b42XIfbSl/arvAhrlcEoJp0zP0Q9aLfXM9dhLW2KGhQqFk
         Q5oPaydXSJ9umYm2MGBDHmVH9ybD37IC7FwZK+jdlSDdGS7Ma51n+eNxkSGajpg5qv5J
         UmB7n8GfPpXPZhmuDOb+xtW8AJN30hkEzid1UfCHAT380AfO54MqIvooprLb9wdTEfEe
         bc3VQJ12oRBfua/KJsYzUJwlaAGEmqIV9UQELdN1F6dOZT+royVMjoYVe3TtEjdR6HKD
         /OYsIBOQPWa2BqKDCu0Bj9h0UPxGxkh8+I2j8nJGzux6n+8xoF5YMdER+ZYp+IQTFute
         D46Q==
X-Gm-Message-State: APjAAAWNmo3f9UGSo3tbYVzQllJVjzUMyDUAS221ldYEmuN3CGhZ+QTf
        HOrzqulhZHpDaYoTUAEjKlr9PZRpMeM=
X-Google-Smtp-Source: APXvYqz1DKXTzv+LhP8Yf6NE+BiW+3FMAQKjKd031vjYbI1rMNiBDaWah5Ez3Rk/C842ImnoKqBISA==
X-Received: by 2002:a2e:9012:: with SMTP id h18mr4435440ljg.45.1568574530514;
        Sun, 15 Sep 2019 12:08:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r8sm8462490lfm.71.2019.09.15.12.08.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 12:08:49 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q11so10802976lfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 12:08:49 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr36322038lfc.106.1568574529013;
 Sun, 15 Sep 2019 12:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu> <20190915183659.GA23179@1wt.eu>
In-Reply-To: <20190915183659.GA23179@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 12:08:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
Message-ID: <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 11:37 AM Willy Tarreau <w@1wt.eu> wrote:
>
> I also wanted to ask, are we going to enforce the same strategy on
> /dev/urandom ?

Right now the strategy for /dev/urandom is "print a one-line warning,
then do the read".

I don't see why we should change that. The whole point of urandom has
been that it doesn't block, and doesn't use up entropy.

It's the _blocking_ behavior that has always been problematic. It's
why almost nobody uses /dev/random in practice.

getrandom() looks like /dev/urandom in not using up entropy, but had
that blocking behavior of /dev/random that was problematic.

And exactly the same way it was problematic for /dev/random users, it
has now shown itself to be problematic for getrandom().

My suggested patch left the /dev/random blocking behavior, because
hopefully people *know* about the problems there.

And hopefully people understand that getrandom(GRND_RANDOM) has all
the same issues.

If you want that behavior, you can still use GRND_RANDOM or
/dev/random, but they are simply not acceptable for boot-time
schenarios. Never have been,

... exactly the way the "block forever" wasn't acceptable for getrandom().

                Linus
