Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B15C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF69A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tC911Ara"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfLPPYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:24:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35347 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfLPPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:24:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so3132823pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ND5vBVspC4LhdAQGe3ggsWBXQWro7jR0iz0KHNGVvLw=;
        b=tC911Ara1oubQlZRmd0EQc8fs74ektdtWTc7jF8D9vLvVG75qV5+RUMNCo6KqjO+//
         y41FWAultQTGUFsRflIG8h/U/2EFoRj7j2xt6yvW+EN83ixHwEnfIAXztV+AGeXK4hWD
         VLsWzyfyiy2ybehEjkb4qJDd2QvJdoptZkkf8BeM851P+InPvABc2+kLumSjskFhyAKt
         IKlwWdx0m/zXi4LtWcWbJbQIuZDRbZPKwGn3wwb53CMAz8QAhTVZ15AqAsfKM04bZy3x
         JmbEunD18YEnu5jwnyQZh2/EnzmOYfeTZKREwY2PeGpwvufl58/kYvJ16+Bb5kMAYEDF
         oTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ND5vBVspC4LhdAQGe3ggsWBXQWro7jR0iz0KHNGVvLw=;
        b=YZtVdOaggtkH3WK8kHt1ZxVzJ5trj2xzXQB1mCOI7w7paA4X9TE35k+m/MA34IvibG
         A7xc4/TpCmbrIE6JwPA/fhxL1lgU9zh0Vjn+Q631qkvUk3rNE7+b1tW26ehTUd7AXbVD
         XO0mOaYhaxwcdOt9IzRR23ii6+1lSNrh+9EKc/vapuM9w8uhwqffohvkp0FS8+phq56G
         5GGLKXbBBiQ9Yznz3BHDJvgyzsw30u8IjM4cah2cyEKR3jc9aznlnvI3NEsQAqM2wzXy
         XbZtzV07yrgu5woYVtHaetW9RLuegqNZjqOdEOBeGGUrNSOJAuaZOLdfpm9IhZl3BE6k
         LO2g==
X-Gm-Message-State: APjAAAWM6JY4GDYQWsXy8DeD/s8O6lJfC4boKNbt5XgAD2H4TO3OTq/H
        1YzipyD5RK3oGtSA972dLG3JY2Olo3xmNLcrBfVxeQ==
X-Google-Smtp-Source: APXvYqxqW5DIvTi6oMsxschKtghuJzELK3hgPNRHB0NKXE9PBJFdVD+IHbjzim6ycnFxvpJonlDPB51dKCXaw7stUpU=
X-Received: by 2002:a17:90a:77c6:: with SMTP id e6mr12111173pjs.129.1576509870817;
 Mon, 16 Dec 2019 07:24:30 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+yz3dtfx0Jfd4sbOcN8tSxp8+qAvW609sP_yJC5q6vq8A@mail.gmail.com>
 <Pine.LNX.4.44L0.1912161002080.1406-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912161002080.1406-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Dec 2019 16:24:19 +0100
Message-ID: <CAAeHK+w3ymXpBeBNCddLPDZuVg8fTgxKVb6U=MSgH_zXxZqxjg@mail.gmail.com>
Subject: Re: Re: general protection fault in usb_set_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, mans@mansr.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 4:05 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 16 Dec 2019, Andrey Konovalov wrote:
>
> > On Fri, Dec 13, 2019 at 8:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, 13 Dec 2019, Andrey Konovalov wrote:
> > >
> > > > > > Let's retry here:
> > > > >
> > > > > > #syz test: https://github.com/google/kasan.git f0df5c1b
> > > > >
> > > > > This bug is already marked as fixed. No point in testing.
> > > > >
> > > >
> > > > Hm, that explains some of the weirdness. It doesn't explain though
> > > > neither why the patch was actually tested when Alan requested it nor
> > > > why syzbot sent no reply.
> > >
> > > In the meantime, is there any way to get syzbot to test the new patch
> > > with the old reproducer?  Perhaps tell it to re-open this bug?
> >
> > No, we can only test this manually now. I can run the reproducer for
> > you. Should I revert the fix for this bug and then apply your patch?
> > What's the expected result?
>
> Please simply run the patch as it is, with no other changes.  The
> expected result is a use-after-free Read in usbvision_v4l2_open, just
> as with c7b0ec009a216143df30.

I've tried to run both the reproducer from this thread and the log
from the other one on 5.5-rc1 with your patch (and other USB fuzzing
patches) applied, but didn't get any crashes.

Thanks!
