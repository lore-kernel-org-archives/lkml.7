Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A56C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86620645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="OfaCB8ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfETMUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:20:19 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34681 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732617AbfETMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:20:15 -0400
Received: by mail-ot1-f44.google.com with SMTP id l17so12775963otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noE5KqZTJm+9I8W88mdzCe6x03a8fEWEy+6jsHjq17U=;
        b=OfaCB8ZDMOk+B9K3K2Fb2f5KnExXVRrqAi78qzu4vYWQMS7bNmngMgcDypOrTCqz6e
         Kui4x0S6U6ouL0mpVQbKn3CNin1JUG8C8nm1RH+oRvIKQ+AScuXoNxE53wp2so+eAW7H
         58sqGesLiEajC7UQpFcMkP3m/ygYe4CR4IQrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noE5KqZTJm+9I8W88mdzCe6x03a8fEWEy+6jsHjq17U=;
        b=QSuHye+xAep3E9kN4AjTmQTUPwa6Zy1men4M2iL4yqAbeH5l8feyGc7JejMVQhJrxM
         QoVHV6dtfIXasEVidL56mTCHejf63/hZaZd6x+quaLndGTCoKrX4n1jLODvuXfHLX6pL
         QYDS1p4ZQnZMvzIApl8F9/NXQCiJzKkUe1Mwa0tZ4WUQP4RApP9ziGAKNjWyYNRAVDFx
         +6vvdoqYXCQZy9P2hv2UhJC66UQNVA3QA02O7DzEouHDKOl/PZyL3PRce3g0HUek3p2K
         q//fBV/mk/r7Umji4TBe+ToxM0mFk3sLhrL65lAKKiPY6vja+KO0HVvYOu/2tVeoXgsz
         IuBA==
X-Gm-Message-State: APjAAAUdmoOGC9wRrHImKJPhdf39hZjtIUE1E4oiVxyfBbMetn3rPhCX
        bUCMHkK2dYotVXJgxvtkceColJHFtxtzdDGLoV0ic//Q+fybRw==
X-Google-Smtp-Source: APXvYqyXtxwUOmQO5vwucLFJvIeTlWu1rXTrqccJbqqpzHHH0p1nOSRvqGd/S3s0xIu8GbEc85stnqZ22H+OTe8EXm0=
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr6660917otp.66.1558354814026;
 Mon, 20 May 2019 05:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
In-Reply-To: <20190520115608.GK18914@techsingularity.net>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Mon, 20 May 2019 08:20:03 -0400
Message-ID: <CAO9zADxf7VdzHWC2C-uCbeqhvN2oTW4KhU=o4GEXfLoVGpEt5w@mail.gmail.com>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at ffffea0002030000
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 7:56 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Sun, May 12, 2019 at 04:27:45AM -0400, Justin Piszcz wrote:
> > Hello,
> >
> > I've turned off zram/zswap and I am still seeing the following during
> > periods of heavy I/O, I am returning to 5.0.xx in the meantime.
> >
> > Kernel: 5.1.1
> > Arch: x86_64
> > Dist: Debian x86_64
> >
> > [29967.019411] BUG: unable to handle kernel paging request at ffffea0002030000
> > [29967.019414] #PF error: [normal kernel read fault]
> > [29967.019415] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
> > [29967.019417] Oops: 0000 [#1] SMP PTI
> > [29967.019419] CPU: 10 PID: 77 Comm: khugepaged Tainted: G
> >    T 5.1.1 #4
> > [29967.019420] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
> > [29967.019424] RIP: 0010:isolate_freepages_block+0xb9/0x310
> > [29967.019425] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
> > 8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
> > 00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
> > 0f 84
>
> If you have debugging symbols installed, can you translate the faulting
> address with the following?
>
> ADDR=`nm /path/to/vmlinux-or-debuginfo-file | grep "t isolate_freepages_block\$" | awk '{print $1}'`
> addr2line -i -e vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))`
>
> I haven't seen this particular error before so I want to see if the
> faulting address could have anything to do with the randomising of
> struct fields. Similarly a full dmesg log would be nice so I can see
> what your memory layout looks like.
>
> Thanks Justin.

Hello,

DMESG output in the interim:
http://installkernel.tripod.com/20190520_dmesg_full.txt

Once the error happens again I will post another dmesg link and get
the addr2line output.

Justin.
