Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5250FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6DD2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICEJvWUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbfCAQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:55:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43241 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388913AbfCAQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:55:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so21522242ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxcKvZL5ghYbv9/JBuVNlbvsywHZ626xaw5ZwKJgT48=;
        b=ICEJvWUOIuzsnmu4GsdRg9f2ipxS0zBGatNaGIyWsWMTK0pxo33rPn4lWv6YWogJVz
         rcHXKGrI28LTVvJtY24756nDSSsVXbS/1HajuzkXCtG9udqJFkpp8SZvlX9bxkqOdzow
         UTWqiYWVdWlczkurpzp0msoRP7xFLYoxoxdPR8MHnD9CDsKvuoeHW/OtvJ8EK+72V5X3
         LBDGRzbXhUB5oB+ScPc0gn6cqFvCExNegz4tQWaSW0XczFPAmhmLtOpWjhYD3QO5FOp/
         lzy54L+lgjtmLFrCA4Y61bytiwt1w42bDZXqynz5vzuuMBNEZJWyeyFsMSsdDiuMOnp9
         3jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxcKvZL5ghYbv9/JBuVNlbvsywHZ626xaw5ZwKJgT48=;
        b=jYZda7IF5d1L/l26lkdyPHTuo+ZhjkhKUIzXeLFfxEMK/sFzbxxwsQFsDky1Sv5r90
         KpzRfMApPwWX+UoLH2Nx3EhAlh7WPn5BOEBQOt8TvyXGoiVbjdjDwiCSexGq/28Ja4JA
         N2XGTW5uthBNsfD62OK2TudefoOoCQ0BxQ1d9U1XvTziV8jbG6LV3+vtLxRpMQgPIbRh
         HE9PEX5KdDGh47HhuHYml+BU6bJl/GGA1ZrJx/C2q2PoGfZIaL1FNqMwohsxs3uhZEKs
         WZR7JiQaHE1cvEsfZtqO4jEv6i55eWXo3ILaQCHlhl7GUKIpxUNPqyPHpoNVRKVDxUjX
         L0rQ==
X-Gm-Message-State: APjAAAWRhhDSBvBDeI/KP5qOtfF//T/Schj6qTgVt65Xdbhh7Pkgx1/6
        IDRDrUDQ6rpGHsFDaL14tKy3/6hl2iO+jC1CSCRzRA==
X-Google-Smtp-Source: APXvYqwVyAkHp1x9bZAhXurrP7XIOyT2VHko8N6A/dkO7GHTfsm5Z4saOOA4/yIGBQOboCm7lDzmZHkSL77BTfElnSw=
X-Received: by 2002:a9d:7091:: with SMTP id l17mr4124045otj.198.1551459329397;
 Fri, 01 Mar 2019 08:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20190301031201.7416-1-jannh@google.com> <20190301031201.7416-2-jannh@google.com>
 <20190301162418.sbhth5tycd6znxin@treble> <20190301162911.ucd6diddioqnthc2@treble>
In-Reply-To: <20190301162911.ucd6diddioqnthc2@treble>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Mar 2019 17:55:03 +0100
Message-ID: <CAG48ez0dkHyoTzxro_nCdhExygbxWVHn4LWnTmc7sAb43RureA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/unwind: add hardcoded ORC entry for NULL
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 5:29 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Mar 01, 2019 at 10:24:18AM -0600, Josh Poimboeuf wrote:
> > > Is there a reason why the top-level Makefile only sets
> > > -fno-optimize-sibling-calls if CONFIG_FRAME_POINTER is set?
> > > I suspect that this is just a historical thing, because reliable
> > > unwinding didn't work without frame pointers until ORC came along.
> > > I'm not quite sure how best to express "don't do tail optimization if
> > > either frame pointers are used or ORC is used" in a Makefile, and
> > > whether we want an indirection through Kconfig for that, so I'm not
> > > doing anything about it in this series.
> > > Can someone send a patch to deal with it properly?
> >
> > Why would sibling calls be a problem for ORC?  Once a function does a
> > sibling call, it has effectively returned and shouldn't show up on the
> > stack trace anyway.
>
> Answering my own question, I guess some people might find it confusing
> to have a caller skipped in the stack trace.  But nobody has ever
> complained about it.
>
> It's not a problem for livepatch since we only care about the return
> path.

Yeah, that's my concern. I understand that it's irrelevant for tooling
that wants to understand what context a function is running in, but it
might matter to a human trying to understand how a function was
reached. In a theoretical worst case, a stack trace might skip
directly from do_syscall_64() into some random helper function that
received a bad pointer, and that might make debugging harder.
