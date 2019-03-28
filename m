Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F370420811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oS6gIPZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfC1UBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:01:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43109 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfC1UBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:01:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so24620692qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lz89bnX6MO99fLAlfZaJL/FGVckNukTmUAoaayRHAGc=;
        b=oS6gIPZhG/GUPuZcKNgmBm8Wa8Xile+y95OwY6mEHifFyWDjMVVfqC0VsZQRH2kWMn
         Y6BeDEMI1+CBYsrBYZLtYKmXeLGWPMZMEO4saf4pfp9kxFPn8wKvXcJYKf3MHmRu5n3S
         dNyAFtKj9MRBesD3e5qVjdApwktlfQ5bj6gH31om3wdJBK/etbj5hErRLkOw3rnYuHu5
         UkOlvDnkT9CkPwllTF75NA4zNcHAR/pTo0L31ss2xcy7Jk2GjITlxWjbjlh5URlhSkhu
         I9u7EjwTWJZ+5IYDzH7uSm6Uyl66p2tRS3pkpgsDJIqYSbnz8jaWaJew1NFXfD8DzhOh
         OpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lz89bnX6MO99fLAlfZaJL/FGVckNukTmUAoaayRHAGc=;
        b=fzpF0cjlD3gMLzSuJTvrij0WR0TlQNnc2aSYMrasw68WKPbNCAeDRjjz7yedDnRVtP
         sFmv3AY246TUce/+pZ47Ob6O9HeiYNKxqAvObF+KJ+/wfgSKsx+DvtkuwKgIEvBN7JgQ
         NKmcsKpzIqG1p/AUAQDOwQGE2UfhZFP2Ynn/UfVScFaiPUcqhXM5V5HFMwl2guCMlRNn
         OoIfzdw9K1ZSzaXqZnYaP8k90OXDg/OlISbcsmIDq2SFaWzgcC8JXCuHwF2+LtzgyUts
         9yhwGtpolfKJKzhkx5Dz6G4BU4algdVGtwMiC8SA8KbRP8GpLrhJTInMQTCwFycnoyh7
         chSQ==
X-Gm-Message-State: APjAAAWkMleTEmre6xvAzyk/hMNYhmTGlD7A3Tc6ucVhZWIVOe4X/djD
        k8vh6GLqBpDNqTdky5hQdY7JNBnAekMP+PMzSB0EXQ==
X-Google-Smtp-Source: APXvYqzUpaP7dpc1k2GrxAnqNCIobCZhtuvEnZEX/2Nju1yRa4euQMvgJbNG/1i/W9A7VHcbplSQlJ0belQsZf3cJJc=
X-Received: by 2002:ac8:3202:: with SMTP id x2mr37423871qta.56.1553803277280;
 Thu, 28 Mar 2019 13:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRSSEzdN_PyZNg51PMosxR5w1Q6h8hqb4fg-r7uOWngA-eAZA@mail.gmail.com>
 <000000000000de91f105852c8924@google.com>
In-Reply-To: <000000000000de91f105852c8924@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 28 Mar 2019 13:01:05 -0700
Message-ID: <CAHRSSEzGaZw4y4gKzyJzxmrkL20NpTAtB8mDeDs+JzsTWeDZKA@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
To:     syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs@googlegroups.com, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:27 PM syzbot
<syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but build/boot failed:
>
> patch is already applied
>
>
> Tested on:
>
> commit:         0532a1b0 virt: vbox: Implement passing requestor info to t..
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> char-misc-linus
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1577678b200000
>

Trying again without (redundantly) attaching the patch...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
char-misc-linus
