Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A33D20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568737445;
	bh=UaBVixOkiEqS2WlwmdEDVJGxaHgzN4Srf/NhaD1TxzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L5ttG6Icvw7Rbm7voYeSJkjckn0yIdNZ8ddsON/SjVrvrd5CFr7Bdf1wDzo+8WrkA
	 2d2VUu+ciCIN3xOe6+wNPOXrmLHKe0hUf40DEf13s4jnOukw/rUJtoV/2votP7sBvO
	 PQCgoZBhuLXQ6sNw5B404grkKFhdvmzALViNFhwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfIQQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:24:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44155 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfIQQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:24:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id q11so3353828lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxsyW6nLofhV8viqZYmUtikq7MzcUQ0DLONnisNNMgg=;
        b=TqK580QEDxVQPMUfHjJ7kx8CJ6swQ66oeXEZhXBI33FU+q9pAhpktcTOSJh9FjQuYB
         g/amoJaPGMr0tVs+0KonicAn6CEpIb0jSqvDt3HwUdn6xXa6sACcDsgEA68nfpRcpykU
         M3sf6qYdD8L0B4HAx6NYPW9aAgS0IclpQKu/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxsyW6nLofhV8viqZYmUtikq7MzcUQ0DLONnisNNMgg=;
        b=Lai9RfCHTnDmy4+vqTlHii9fFHT/Bo6Z6OOxYWH8F7FcIgMYngb0E3t7Ki6YuvOzvi
         jfUGnbTftX2ffKeVJJTsc4WKeY/IJyGuwmRSELQp69ZJy4UPe+mXj0TMRGRFDKk3/Y6C
         vuma1uPYLyWcvd4f8hoz3BlYbpvjesPJWMrPNdDyvVmb2BZeqls6QvO3rdm5MyAmGVV8
         u2ZhQw0DrEFtBjb15iih7JkJ0encF55mXn/ccROuAn2lGd5gbxPS3jpHxJozXEoScVVv
         kp433EBQPIawchZFzz4LX+Y6gQzh0Ic5A0cdVZ4VhXwN0v7FWb5k/Erm+/nqstfY9HCd
         9UNA==
X-Gm-Message-State: APjAAAUS0zgshq5EhwvUN2Cci7niPY01Rb4n42bnFP7wN4MFctVrvh5X
        pobQnpXLnvoaPkfdZwE5H3J0bW4PqMU=
X-Google-Smtp-Source: APXvYqy128C0o2rIn/0uhDO6OcvHSjHrqOsbyW4LJjShMtF1EusAjQ2JtW1ZpWi5AiBhqVZJP2WSmg==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr2547375lfq.2.1568737441145;
        Tue, 17 Sep 2019 09:24:01 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w27sm512905ljd.55.2019.09.17.09.23.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:24:00 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 7so4170827ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:23:59 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr2491562ljs.156.1568737439299;
 Tue, 17 Sep 2019 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de> <20190917160844.GC31567@gardel-login>
In-Reply-To: <20190917160844.GC31567@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 09:23:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
Message-ID: <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
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

On Tue, Sep 17, 2019 at 9:08 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> Here's what I'd propose:

So I think this is ok, but I have another proposal. Before I post that
one, though, I just wanted to point out:

> 1) Add GRND_INSECURE to get those users of getrandom() who do not need
>    high quality entropy off its use (systemd has uses for this, for
>    seeding hash tables for example), thus reducing the places where
>    things might block.

I really think that trhe logic should be the other way around.

The getrandom() users that don't need high quality entropy are the
ones that don't really think about this, and so _they_ shouldn't be
the ones that have to explicitly state anything. To those users,
"random is random". By definition they don't much care, and quite
possibly they don't even know what "entropy" really means in that
context.

The ones that *do* want high security randomness should be the ones
that know that "random" means different things to different people,
and that randomness is hard.

So the onus should be on them to say that "yes, I'm one of those
people willing to wait".

That's why I'd like to see GRND_SECURE instead. That's kind of what
GRND_RANDOM is right now, but it went overboard and it's not useful
even to the people who do want secure random numners.

Besides, the GRND_RANDOM naming doesn't really help the people who
don't know anyway, so it's just bad in so many ways. We should
probably just get rid of that flag entirely and make it imply
GRND_SECURE without the overdone entropy accounting, but that's a
separate issue.

When we do add GRND_SECURE, we should also add the GRND_INSECURE just
to allow people to mark their use, and to avoid the whole existing
confusion about "0".

> 2) Add a kernel log message if a getrandom(0) client hung for 15s or
>    more, explaining the situation briefly, but not otherwise changing
>    behaviour.

The problem is that when you have some graphical boot, you'll not even
see the kernel messages ;(

I do agree that a message is a good idea regardless, but I don't think
it necessarily solves the problems except for developers.

> 3) Change systemd-random-seed.service to log to console in the same
>    case, blocking boot cleanly and discoverably.

So I think systemd-random-seed might as well just use a new
GRND_SECURE, and then not even have to worry about it.

That said, I think I have a suggestion that everybody can live with -
even if they might not be _happy_ about it. See next email.

> I am not a fan of randomly killing userspace processes that just
> happened to be the unlucky ones, to call this first... I see no
> benefit in killing stuff over letting boot hang in a discoverable way.

Absolutely agreed. The point was to not break things.

              Linus
