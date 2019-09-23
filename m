Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5C2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D7F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569265333;
	bh=TwRyUii69N90MumbsrW37YfCOAv9Nkll5ZHs9TZGqi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vsLNpTDN0b2DlwNriLIWukwurjQVuO+g+/WNngbDLb3RyiPXp9W+8T6CF3nE+R6Rq
	 iWKFjB6WE6gFvkShlsYv+DtI7eE0kQ1MFe4ET5MR4io8cFKZ2Dw5zJBhYvSYTaKlob
	 gRmlpJsyGniHzkxh+iAbKXFolY0gCatGgrOEBuRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfIWTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:02:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43954 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfIWTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:02:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so9759618ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfMT6FFABs8+WVOQ4a5gNHPABOSr1e233skwsQrCiw8=;
        b=IpzY4nqJc66P16YRm5ZfJwieV6oydkv4tIN11aSpzafuJZq6yNKAstSXQChu2guroN
         J2IQDMziYaomuguf6h05Q9XzLki4nCDmgldzB9zsmDlMzx8nZoSIAweGHXXeWyeukUhJ
         DFCCvN44yT+LeYV5J6NQE7cdJtFiUpgev6CS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfMT6FFABs8+WVOQ4a5gNHPABOSr1e233skwsQrCiw8=;
        b=hfLPt2l21CP6AP/YaHcBChbgVLOK9MugZxAhp9PUraD06+BEH7/kvXHtERg/3r47cM
         9+1keyEHSKiip7iCKdJquJ9o9oMgYi6pt90bAsy8M/I9CwDPxPAVRAWF/slmbeZPwM1q
         jPZtZbRyrQKYaf+ordrI7mOLdpYDqjPpSdOHlHuFI1OQKXztpiI208FAZxHz8d+sOI9m
         6gB/ZUWTHwR3NRKLqxITYpgCWsVjMgipGOwIpKVFA8XbQF/bxsWusm35W43XwTRr2dIl
         XjNTYZV2uggWCz5EccbOY9jKjBIv7x8mJECzbqi0yOMff7rShgcA33zNsYssanHX5Pm9
         tgnQ==
X-Gm-Message-State: APjAAAXMWkqPGkBuXJVCJ769QLSSGxUfP2ao4RnXskI9kKkmJpviDSj/
        lQ6quisubyLuRZojpwdUyePdNj32W0s=
X-Google-Smtp-Source: APXvYqzb1t5QkXsdU0Vzgx30avh+JcGzEIzrXQuBI0f4cfuwONN3ls9QB40rH9fSucaz8KottYJQiQ==
X-Received: by 2002:a2e:98ce:: with SMTP id s14mr544196ljj.108.1569265328697;
        Mon, 23 Sep 2019 12:02:08 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x25sm1272768ljb.60.2019.09.23.12.02.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:02:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d17so10985662lfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:02:05 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr624411lfh.29.1569265324930;
 Mon, 23 Sep 2019 12:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
In-Reply-To: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 12:01:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
Message-ID: <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:41 AM Micah Morton <mortonm@chromium.org> wrote:
>
> Fix for SafeSetID bug that was introduced in 5.3

So this seems to be a good fix, but the bug itself came from the fact that

    rcu_swap_protected(..)

is so hard to read, and I don't see *why* it's so pointlessly hard to read.

Yes, we have some macros that change their arguments, but they have a
_reason_ to do so (ie they return two different values) and they tend
to be very special in other ways too.

But rcu_swap_protected() has no reason for it's odd semantics.

Looking at that 'handle_policy_update()' function, it's entirely
reasonable to think "pol cannot possibly be NULL". When I looked at
the fix patch, that was my initial reaction too, and it's probably the
reason Jann's commit 03638e62f55f ("LSM: SafeSetID: rewrite userspace
API to atomic updates") had that bug to begin with.

I don't see the original discussion at all, it's not on
Linux-Security-Module for some reason, so I can't tell when/if the
NULL pointer test got deleted.

Anyway, this bug would likely had been avoided if rcu_swap_protected()
just returned the old pointer instead of changing the argument.

There are only a handful or users of that macro, maybe this could be fixed?

Adding some of the RCU parties to the participants..

Also, the commit message for this fix was a mess, I feel. It says
"SafeSetID: Stop releasing uninitialized ruleset", but the ruleset it
releases is perfectly initialized. It just might be NULL because it
doesn't _exist_.

           Linus
