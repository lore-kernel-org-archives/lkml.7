Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E4C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7767421670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqfURX+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfIDRGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:06:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44546 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbfIDRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:06:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so3940410oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akOkLHg6n29QqKNPN0D/UrC0AAWyYG9BrPMgu+TzegI=;
        b=PqfURX+k6u7bgIDBNBhTj8IbdbvV8WLcJzdw7ODpyMdVIygpsWK/jkT5ZCnguxSFGd
         8VlYEI6lXwZN1QZXLQuutmnRlGIPY1On9/VfVAU4gDU8ryDHS2LfS1Z8KVuq0VPP0YB2
         Kg2IUgtcglo4YMwW3lvKeUdZY2DNA0m8T+rBqZYF1iGBFnrLH/gB2P30mjhenbTsIECo
         GACV4S8GD3SMKQ/wbeDTA4DoUx47PyYGSRKpJU9oSfXIyAVGnbd06gule5Y0U23AVDl0
         GUgA6RnDAslLlsw87sbyMMsWHrpqPks/fCgc35YCVyjhgmIyi9zBONaQrsk+jurKmPia
         QrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akOkLHg6n29QqKNPN0D/UrC0AAWyYG9BrPMgu+TzegI=;
        b=dpa4VKc1E0gy5U5xBaIeU2EUxLqoIVajcqcvzfGNO5SyMWLvw7SOY/wln5MimQRYmL
         iOUO0R0T2m52BGKk41P0Y2hfJP+eAUvlvKUMUhZwi3Mv/ZrlyngUeelaBZ1uAhEncq0K
         G38xYVDrTXkOhBPGWppvroWshtdNNfEhATxvNIDIvIWDIs0CAX6fCrnx2MRsCkxUh3uU
         dpHtQCXV+bHkY66itPUPPZiU9pVKQBfrziLtDaNXqHlufqm2h73/gNEZypfI1rMgHxZP
         RLbJ+kRfz7p1Q5poNmV7iADZcq6CLyyNmVBCpu9msl8m5FxeljDHtdQ6QJeiDSPGVuFM
         Er9g==
X-Gm-Message-State: APjAAAXtFdIkTb7Sc4nd2EZNM04l27LGHwlHJuSzC9aLVnVTWAbmZPAc
        sQTLasAX9pMqEVqdfiOPBc+AXiIfbPflpF2L33hW9pQn4H2AtQ==
X-Google-Smtp-Source: APXvYqy1jl394J1dtoIqVg0tF3CLuM+SURQYJEtv6V/Z5qYxE+OHahZ2oLbi0N3f+Wd2lBeFo8hvyOT9gvPDap6hCi8=
X-Received: by 2002:aca:aa56:: with SMTP id t83mr4150370oie.178.1567616791972;
 Wed, 04 Sep 2019 10:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com> <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
 <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
In-Reply-To: <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 4 Sep 2019 10:05:55 -0700
Message-ID: <CA+wgaPP_RE8xcEH8LZc_XSV-yTd0A14k0oFb3Ohfvs8v=ixTbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 7:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On September 4, 2019 7:19:35 AM EDT, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
> >> Currently, the only way to access binder state and
> >> statistics is through debugfs. We need a way to
> >> access the same even when debugfs is not mounted.
> >> These patches add a mount option to make this
> >> information available in binderfs without affecting
> >> its presence in debugfs. The following debugfs nodes
> >> will be made available in a binderfs instance when
> >> mounted with the mount option 'stats=global' or 'stats=local'.
> >>
> >>  /sys/kernel/debug/binder/failed_transaction_log
> >>  /sys/kernel/debug/binder/proc
> >>  /sys/kernel/debug/binder/state
> >>  /sys/kernel/debug/binder/stats
> >>  /sys/kernel/debug/binder/transaction_log
> >>  /sys/kernel/debug/binder/transactions
> >
> >Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> >Btw, I think your counting is off-by-one. :) We usually count the
> >initial send of a series as 0 and the first rework of that series as
> >v1.
> >I think you counted your initial send as v1 and the first rework as v2.
>
> Which is fine. I have done it both ways. Is this a rule written somewhere?
>
> >:)
> >
>
> If I am not mistaken, this is Hridya's first set of kernel patches.
> Congrats on landing it upstream and to everyone for reviews! (assuming
> nothing falls apart on the way to Linus tree).

I really hope so! Thank you Joel and everyone else for the reviews !


>
> thanks,
>
> - Joel
>
> [TLDR]
> My first kernel patch was 10 years ago to a WiFi driver when I was an
> intern at University. I was thrilled to have fixed a bug in network
> bridging code in the 802.11s stack. This is always a special moment so
> congrats again! ;-)
>
>
>
>
>
> >Christian
> >
> >>
> >> Hridya Valsaraju (4):
> >>   binder: add a mount option to show global stats
> >>   binder: Add stats, state and transactions files
> >>   binder: Make transaction_log available in binderfs
> >>   binder: Add binder_proc logging to binderfs
> >>
> >>  drivers/android/binder.c          |  95 ++++++-----
> >>  drivers/android/binder_internal.h |  84 ++++++++++
> >>  drivers/android/binderfs.c        | 255
> >++++++++++++++++++++++++++----
> >>  3 files changed, 362 insertions(+), 72 deletions(-)
> >>
> >> --
> >> 2.23.0.187.g17f5b7556c-goog
> >>
