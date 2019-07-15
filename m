Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E021EC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7502205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tV/deThL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfGOS35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:29:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34033 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfGOS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:29:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so4462641lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPvxiQHl/XpK5lt5vP4y2doBBzKLayLNDsJKONRA2Dk=;
        b=tV/deThLDZe31WMO8nTAh9K9TM0jW5+vMT1NfhxHMROxn7FA6/BczTC5ocyHago83Z
         O18gjZTkFK21kgxUnQr8esifjPBhbkr5tlhS1Ddi9aHdScCuFDB634IRJvJbY6G29uMx
         26XTzBnaJfmG7iXifLRBSQEu0pmt8nf3U/HG8Mfejp2USFrtfBbI3zY9od43QvNQ//Aq
         q5G4wgd7DMK8vFYZJrO1GxqFyQ+O8Yarbx0SgwUzHsHcYVkEE3rKX7SW/jHltuQcFcqO
         RIL4MqFHzL9vIiXLjdsC63P2f7v5tyiw3FbxTwQetXrHK6sYughpntfz0MgD4wNm5WdB
         vIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPvxiQHl/XpK5lt5vP4y2doBBzKLayLNDsJKONRA2Dk=;
        b=L8CHatqGrd5qh1ZPY8QKRkkFJQWpJ4M1mFiwSWVZ1w5sAyxSCLP33otffs/FMtSMPe
         rGbUGT9bVrUwY4jsazXu1hSxWgCjqLzJOt/lwAGndZ5pjhI7oWVxbjLTqqFx3DlIo8uB
         pJ+iQI2TDdfT0MMkp3COhDVaKJEujiAcVjcIfMnm68v6sobFmmZp5pzqtRbzmgSoPTv2
         cWJanuyYnMxtPuMNqMs6MDVZPebuBENBVEpEoEHsOWZMlKvyAZPI1f65u5+vzYiC8tdR
         KL5PvCru4uIC5eUaZ+lyvtdqrmp/X7aZXKhqt73NuzJrwcGr62LZjSK63EMN3c8Kt5ab
         cIMA==
X-Gm-Message-State: APjAAAW0MHDFijcGNAn1+Soo6RiBLl7BU+Ge/+T1BV7MMwd1ns9kcXMP
        KuDoxghqX/Sb6QD7c4E8Qw+FH+E4dARfQENxtL4=
X-Google-Smtp-Source: APXvYqxJQm3ccb14HTwtnHx4Exld8ZB4jKosY+0FKtFAlSN7DSp6Z+JsME4XcBlP9PCCczxTN+kvpkGM8EErT8/97CM=
X-Received: by 2002:a19:e006:: with SMTP id x6mr11939257lfg.165.1563215395101;
 Mon, 15 Jul 2019 11:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com> <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
In-Reply-To: <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 16 Jul 2019 04:29:43 +1000
Message-ID: <CAPM=9tx9N=qDnt8sn6dMw4BmfPwh-qNPGXDg5FA5fh5hKmooEA@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 at 04:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 10:37 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'm not pulling this. Why did you merge it into your tree, when
> > apparently you were aware of how questionable it is judging by the drm
> > pull request.
>
> Looking at some of the fallout, I also see that you then added that
> "adjust apply_to_pfn_range interface for dropped token" patch that
> seems to be for easier merging of this all.
>
> But you remove the 'token' entirely in one place, and in another you
> keep it and just say "whatever, it's unused, pass in NULL". WHAA?

Not that I want to defend that code, but the mm patch that conflicts
already shows that removing the token is fine as nobody needs or
requires it. So the fixup patch in my tree was just a bridge to that patch,
which reduces conflicts. Rip the token out of the new API, pass it as NULL
to the old API until the mm patch is merged against it which drops the
token from the old API.

Dave.

>
> As part of looking at this all, I also note that some of this is also
> very non-kernely.
>
> The whole thing with trying to implement a "closure" in C is simply
> not how we do things in the kernel (although I've admittedly seen
> signs of it in some drivers).
>
> If this should be done at all (and that's questionable), at least do
> it in the canonical kernel way: pass in a separate "actor" function
> pointer and an argument block, don't try to mix function pointers and
> argument data and call it a "closure".
>
> We try to keep data and functions separate. It's not even for security
> concerns (although those have caused some splits in the past - avoid
> putting function pointers in structures that you then can't mark
> read-only!), it's a more generic issue of just keeping arguments as
> arguments - even if you then make a structure of them in order to not
> make the calling convention very complicated.
>
> (Yes, we do have the pattern of sometimes mixing function pointers
> with "describing data", ie the "struct file_operations" structure
> isn't _just_ actual function pointers, it also contains the module
> owner, for example. But those aren't about mixing function pointers
> with their arguments, it's about basically "describing" an object
> interface with more than just the operation pointers).
>
> So some of this code is stuff that I would have let go if it was in
> some individual driver ("Closures? C doesn't have closures! But
> whatever - that driver writer came from some place that taught lamda
> calculus before techning C").
>
> But in the core mm code, I want reviews. And I want the code to follow
> normal kernel conventions.
>
>                    Linus
