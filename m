Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A992175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N342nwjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCTN7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:59:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50212 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTN7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:59:31 -0400
Received: by mail-it1-f193.google.com with SMTP id m137so16020966ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmyQwrFyANnSrcI13I0okPnI4JkfyNY2bxu3oBrzm78=;
        b=N342nwjKC9kyYqwey8dFejLjpIkuXozr0myM+P8RkqmPaV7dCdfBDx2pJgzdacZXYh
         sdRgK9YZNmvOf0NM8s5KID3i1mF06uQS/AZ/mijuKM0nDEc39KKyK2nHX7eo0QhLu20N
         N0LtP3Ph+8fa3PcMZ+s3o8yZnOf03A0ZHVSy1XkYyvnsQLNhqCE7ue0fbROaiFJ4tEpM
         Zdqwkxs4WvURgbd+NdTmakQwU/g3XSnti2C1Vrz8RL1uoPz0qxBId4DyRRcyokopoAVY
         Lyy+dmy6ZHP7719ZexaUn+i9Lc3QUi+utZIWGGhoEPdPrb2usUFyYbs5oqgq3dFtokXz
         vkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmyQwrFyANnSrcI13I0okPnI4JkfyNY2bxu3oBrzm78=;
        b=ddZ2gdBE67z0oPMrn+7DXTgg4EsOOceCGtfkJkdsosu+r4xHZ3RddPVGq3xzTm7Szf
         zXcpAT5Xt+tL7kLMv4Fs8UhBHyRqxp9SlQsICOdUgVLvoqfAz+4AhCJBeuu/o9JICH4l
         9M9hSEj2Qw1Vvs0MnMjxz+wgthGHpHUe68U2NEQXfDAZcUFFK40uRc8g6DpAd0YFEexy
         /ylHaZlfV3bTkEOvkg4Ncn0KImaUmm285+KOlPnUheie3FGBcEQPyEY4lQ48Rs7RFw+X
         f0k1gKtqKiQndsqwjCgDlB30lWm374cLRvbjxPVRM6S4N+VdKJYX6dTf5D7VwQjHyEeR
         mvDA==
X-Gm-Message-State: APjAAAW0P6DDY5egHH7AcAUQ/ObHt/ujaa8NU0JI5cFhAJ7f5LODCPHp
        x5xvJeMQPVbTSwK9WyowBL2TKnZFSkk87Mb0AdgewQ==
X-Google-Smtp-Source: APXvYqzmn4bsPUjYN021O9lPARoRSqq2hf2Uw0i66O47FvP6bUygASSf2713Fh5nTZ9abgbg96YVy3cVWltNfiB6YZA=
X-Received: by 2002:a24:3281:: with SMTP id j123mr1444952ita.166.1553090370724;
 Wed, 20 Mar 2019 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000db3d130584506672@google.com> <d9e4e36d-1e7a-caaf-f96e-b05592405b5f@virtuozzo.com>
 <CACT4Y+Zj=35t2djhKoq+e1SH3Zu3389Pns7xX6MiMWZ=PFpShA@mail.gmail.com>
 <426293c3-bf63-88ad-06fb-83927ab0d7c0@I-love.SAKURA.ne.jp>
 <CACT4Y+Zh8eA50egLquE4LPffTCmF+30QR0pKTpuz_FpzsXVmZg@mail.gmail.com>
 <CACT4Y+Z2FL=t8cHceXMGvG2QfChKdJYprVvBonu9X+jJaL0HMQ@mail.gmail.com> <a06830e7-e396-6dd5-d9d5-2a7b1df9efc1@i-love.sakura.ne.jp>
In-Reply-To: <a06830e7-e396-6dd5-d9d5-2a7b1df9efc1@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 14:59:19 +0100
Message-ID: <CACT4Y+b-VNeKwgP9-x2YZJ08v0f=2C2SujVkgEmcQ+B-ZmmCLQ@mail.gmail.com>
Subject: Re: kernel panic: corrupted stack end in wb_workfn
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        syzbot <syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, David Miller <davem@davemloft.net>,
        guro@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <jbacik@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-sctp@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:59 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/20 19:42, Dmitry Vyukov wrote:
> >> I mean, yes, I agree, kernel bug bisection won't be perfect. But do
> >> you see anything actionable here?
>
> Allow users to manually tell bisection range when
> automatic bisection found a wrong commit.
>
> Also, allow users to specify reproducer program
> when automatic bisection found a wrong commit.
>
> Yes, this is anti automation. But since automation can't become perfect,
> I'm suggesting manual adjustment. Even if we involve manual adjustment,
> the syzbot's plenty CPU resources for building/testing kernels is highly
> appreciated (compared to doing manual bisection by building/testing kernels
> on personal PC environments).

FTR: provided an extended answer here:
https://groups.google.com/d/msg/syzkaller-bugs/1BSkmb_fawo/DOcDxv_KAgAJ


> > I see the larger long term bisection quality improvement (for syzbot
> > and for everybody else) in doing some actual testing for each kernel
> > commit before it's being merged into any kernel tree, so that we have
> > less of these a single program triggers 3 different bugs, stray
> > unrelated bugs, broken release boots, etc. I don't see how reliable
> > bisection is possible without that.
> >
>
> syzbot currently cannot test kernels with custom patches (unless "#syz test:" requests).
> Are you saying that syzbot will become be able to test kernels with custom patches?

I mean if we start improving kernel quality over time so that we have
less of these a single program triggers 3 different bugs, stray
unrelated bugs, broken release boots, etc, it will improve bisection
quality for everybody (beside being hugely useful in itself).
