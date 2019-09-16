Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D046C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A6B21670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568675174;
	bh=PHmty0GQrEZ+Ez6un3VvfbDaEMxIHt2bxp5lC9FcPF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F82ebiqz+to5qx+2/Q68n4PQ9nzQHIYhW7HP7/A4mGAyh2+kt+ZQKWU9rngUG1bfp
	 W7RXOvLhAzDrd/nz8T5RUC20kEVoNbwdavp6dBleu9oxrXvIqgr0eVmSaioCfxl0De
	 lc5URzc5rmTlNU4mbeWVSNhF7NjWZ/Wuuf0ALux4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbfIPXGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:06:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34752 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389813AbfIPXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:06:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id h2so1563975ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGY772lMZRO+RxPe3yiKJ2HFEo5jrkt8czVBRCefa98=;
        b=Q7JCqBOjFHRpAm3IIWECi7V0+z1iWHaDOFZaCm6UHZvTzYhkaHhwj14043bgrTO5+M
         irDuUsnCTLlLSkR5eaTGatxvVbFnXqaZCYAJkoMxi8+1pB0mDlKmdUInEOq+UcizHb9i
         e+qtbtq9xxZIz3FByFamlLpdLYhAncsgzI69k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGY772lMZRO+RxPe3yiKJ2HFEo5jrkt8czVBRCefa98=;
        b=S1/agzqMYnUQK6OshWkRZ6dGHyz2pm5vtJxHebaIgKnJalzee3ynPAb68Bkn7kgnSS
         eTVJWN4v8Mm5MKoZ1Fn2J7NSmty3UBoD59SCSdbEhGDAiH+LAWFjtis4zDh4Z0Uk2N61
         PIa6tKTTAELgovdqr6WWpT4XM5SF2Q2xtoS/BTLL1Kh+bZgfcPHzKC4m1ZZIkm597wWc
         t6D5LMvi2Nb4eCzixiplcL/cOyWyGuYwbp6SrMtatxtEiY+/Hp7UZPQLHhrYcio18N6B
         cT/OMA4yE5fSHoJ7TPbF5RYG9pWiCq1TvimX7IxUOk6Qs2Go+g51OoEc9i3i+8O28cLr
         3Ryw==
X-Gm-Message-State: APjAAAXp9GprdImoLzUKOvb/MnBy22/Xp7ImKWdyQwBYVTnV9RxjFRD2
        0nx+cBckKbWG99wGdskN6+agbPjbWI8=
X-Google-Smtp-Source: APXvYqxjTmOVN9ArAmFxcTezTF2EsgLAMn9zzvhdtrQdWi7MmK8k2VmMg6PvhIIezjoPLnsFNKQGoA==
X-Received: by 2002:a2e:9981:: with SMTP id w1mr136915lji.155.1568675166125;
        Mon, 16 Sep 2019 16:06:06 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r27sm55656ljn.60.2019.09.16.16.06.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r134so1234523lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr319536lfp.61.1568675164042;
 Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc> <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
In-Reply-To: <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 16:05:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
Message-ID: <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
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

On Mon, Sep 16, 2019 at 4:02 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> The semantics many people want for secure key generation is urandom, but
> with a guarantee that it's seeded.

And that is exactly what I'd suggest GRND_SECURE should do.

The problem with:

> getrandom()'s default behaviour at present provides that

is that exactly because it's the "default" (ie when you don't pass any
flags at all), that behavior is what all the random people get who do
*not* really intentionally want it, they just don't think about it.

> Changing the default (even with kernel warnings) seems like
> it risks people generating keys from an unseeded prng, and that seems
> like a bad thing?

I agree that it's a horrible thing, but the fact that the default 0
behavior had that "wait for entropy" is what now causes boot problems
for people.

             Linus
