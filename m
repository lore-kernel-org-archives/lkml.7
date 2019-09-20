Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096ACC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE74208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568997014;
	bh=+PTnT10ZI2ZRJq/fO+rMaNRm4KIdJPYWzc2S039iTj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FKvJYgV+Pqx8IWteLXRmNfAYee8o++Gnh0eM4FTgtI8xFvt3OrUVv+bpEJm811zap
	 2mEdwTwXOMUgwRLEWHlEgXMHBOpJV777/sdSAPqI2oyQbgUFsJ7+JYgUpx1h0whIwW
	 nfug4X342gGmYGHWQFtb2FSKuW+W9a9G4M+QXhco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbfITQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:30:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45317 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388966AbfITQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:30:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so7628387ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qfHDj62HozW8w7YWwj9CkN9/sQfc3fOAZsNubcgArY=;
        b=ZQIGHEoM2VE/RUJCyR8wJqhG4SoL3m5ky7t1mnKhLv11uqJxbD6lRJm5k/4ajS8Sdo
         UMhvXa/MmA5zyCc/ENaP9s79+xZOTrHtnrS7z9ra7Xe2HT/ekZVmC2KO+GbdBvDc35H9
         t5l05A8TLonE+2sI7SlSpw7F1/5/t4r9zscBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qfHDj62HozW8w7YWwj9CkN9/sQfc3fOAZsNubcgArY=;
        b=UJl/abPJZdpzp/buzTtTwnWTh4yrPxqdflmMJ5pn6r4mA7x5LMpJj7ONpAz8ngWF56
         o5aWe97LHhMjFkwnWe19uK6sA9/xalHUPi7TFMvqxmZgJ3/OWmdXnym224jJOQ8eJLkI
         ELI6llcPA4gXGroWqa8r8nh6T/n9PT61WlmFqVEc9KrBfVZOnTzXRQekHABCb1M06Ilp
         K+Tarkx83zcTQK+vTXPc/WdPc13NVQ3D44K7Acr5mptMN+59FNBTVybzW/Hn0w02Gya4
         kanddSG1n6qSBPKYqIWW2ees3F21D3pfTtZER5xXUMg7d3FnTVYBoC8wqrxDq1vad7ZT
         HMLA==
X-Gm-Message-State: APjAAAXockCX8WBNF88/Af5F7OPcK3ThsLxlgQI2ZdlbLDqEjysNZz8I
        F8Pgwqjk0nLqtNgmJAcjPihGxck/GL4=
X-Google-Smtp-Source: APXvYqyuXEBNarP+JG9IoGJ2UZIP6YG0oQQXgktLJYCoQM6oe8ouZojE2j5hfnjO1c7o3WDo5EuiqQ==
X-Received: by 2002:a2e:58a:: with SMTP id 132mr9187717ljf.132.1568997010688;
        Fri, 20 Sep 2019 09:30:10 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s26sm582695lfc.60.2019.09.20.09.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:30:08 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y3so6282767ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:30:08 -0700 (PDT)
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr411864ljj.165.1568997007674;
 Fri, 20 Sep 2019 09:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
In-Reply-To: <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 09:29:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
Message-ID: <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 7:34 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> What is this GRND_EXPLICIT thing?

Your own email gives the explanation:

> Linus, I disagree that blocking while waiting for randomness is an
> error.  Sometimes you want to generate a key

That's *exactly* why GRND_EXPLICIT needs to be done regardless.

The keyword there is "Sometimes".

But people currently use "getrandom(0)" when they DO NOT want a key,
they just want some miscellaneous random numbers for some totally
non-security-related reason.

And that will continue. Exactly because the people who do not want a
key by definition aren't thinking about it very hard.

So the interface was very much mis-designed from the get-go. It was
designed purely for key people, even though generating keys is by no
means the most common reason for wanting a block of "random" numbers.

So GRND_EXPLICIT is there very much to make sure people who want true
secure keys will say so, and five years from now we will not have the
confusion between "Oh, I wasn't thinking about bootup". Because at a
minimum, in the near future getrandom(0) will warn about the
ambiguity. Or it will use some questionable jitter entropy that some
real key users will look at sideways and go "I don't want that".

This is an ABI design issue. The old ABI was fundamentally misdesigned
and actively encouraged the current situation of mixing secure and
insecure callers for that getrandom(0).

And it's entirely orthogonal to _any_ actual technical change we will
do (like removing the old GRND_RANDOM behavior entirely, which is
insane for other reasons and nobody ever wanted or likely used).

            Linus
