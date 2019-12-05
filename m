Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B92C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2093122525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b09ztlWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfLEOFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:05:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39009 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLEOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:05:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so2805885oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeq4HgJBk0tt+S9xudVxwhQMEwHOJwN3jhLi9OPFVKY=;
        b=b09ztlWc8v0Um4ctng63ZDT0E7P0RKXrvR927jOraXHcGtJp+Uf2CHIS+MDhda51Bh
         t/U7WR4cLn1riEonp0c2aWFTbS7B4AKZl2EUZHj5NsL5WDWdHrX8BVO6KWzWJvr2InKS
         NcLiCmBKk1g//LRtR7nDPgmouAT6mLYsA1WLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeq4HgJBk0tt+S9xudVxwhQMEwHOJwN3jhLi9OPFVKY=;
        b=jvH6hx+taDig2SoMMVtZWIzNoCWM1tqO7UgUzZ2hvKrIOY9uImjMtCd6mhdrntGZro
         xZjeGOYXSF03Y2ffzwi5qHAA8SUDY7w4HBYhOy3q78aHtrgQUwwEYRPkVAP+U25PRh89
         f7Kybc2RRHFD63FIdVXT5EJmshALvjgLLnWHZKZLb+L5JOs4JDaSCDo5RtuJj14L93un
         onPyVfcJi5oE5fVBPDYgfULezykbJ7ARv+ckDncaEF0W5OHeDldPKdKw8og5r4OkjOFG
         U+YEm40iJX9+TaH5hHk6kiBTsSiFJyFMJzv2guASX79WJhoJzIpmurWIp+1oz1bik/Nb
         64jg==
X-Gm-Message-State: APjAAAWOv2vvBwAY09LlN4P5+rbXtIvWbbwNYFdOwksiWGrA2IedR2h9
        8w2Or5IJjkCgks46w89tQfQ6dwoAi9gHLB/QvUvCMA==
X-Google-Smtp-Source: APXvYqzl2QkRicAy9CfAYCw7et3Bgx9YggGL0O1f0fzAsagnw/nPzczyEThdywCyJBZDVTdqDQAUNlpNTbUK5vhRF90=
X-Received: by 2002:aca:b805:: with SMTP id i5mr7462629oif.110.1575554707452;
 Thu, 05 Dec 2019 06:05:07 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006dff110598d25a9b@google.com> <000000000000bcf3bc0598f5090d@google.com>
In-Reply-To: <000000000000bcf3bc0598f5090d@google.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 5 Dec 2019 15:04:55 +0100
Message-ID: <CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A=xyuh1HjgvfYy7RCBg@mail.gmail.com>
Subject: Re: INFO: task hung in fb_open
To:     syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Ayan Kumar Halder <ayan.halder@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Peter Rosin <peda@axentia.se>, Sam Ravnborg <sam@ravnborg.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Syrjala, Ville" <ville.syrjala@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 2:38 PM syzbot
<syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 979c11ef39cee79d6f556091a357890962be2580
> Author: Ayan Kumar Halder <ayan.halder@arm.com>
> Date:   Tue Jul 17 17:13:46 2018 +0000
>
>      drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_yuv

Pretty sure your GCD machine is not using the sun4i driver. It's also
very far away from the code that's blowing up. bisect gone wrong?
-Daniel

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d2f97ee00000
> start commit:   596cf45c Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d2f97ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
> dashboard link: https://syzkaller.appspot.com/bug?extid=a4ae1442ccc637162dc1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000
>
> Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com
> Fixes: 979c11ef39ce ("drm/sun4i: Substitute sun4i_backend_format_is_yuv()
> with format->is_yuv")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
