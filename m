Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF77C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C99205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SttzBUSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfDDOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:54:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34643 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfDDOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:54:56 -0400
Received: by mail-vs1-f67.google.com with SMTP id t78so1546699vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cn0LVmXIqoX0URP+txBTeThDDXFlJoR0qshlkcSUUNw=;
        b=SttzBUSj1LZYzXGjPUg4o4D4OuUzYx+FuqZ+9NDi7VYMBq1d5mWLcoNf3n4a3Yb3/W
         E0v9J8CqqIdzYStCS3uayf/0U01PLYPc0xJ51V7OpBv+a7NV3+X+fNk+k3fDOBtGEP56
         JZhDNOlgufduxo7Tu0Ot3WloztiegGGX8IHuzr3PF1sSgiawDT6fF8T3US2CYo01UQai
         MnIqx4/ANEi9SXNUyHW8IdBCKCHOWOSsYrXmn3Js9ADvi9oP5ynoLbsSXPJ/DmANySD8
         +4jIxksEgXCeqOfLBaVP4LOD2wHO5B+HDLehsMLfOBm0Xalvu5TxSbgsOq5kxdEqvhJ3
         jOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cn0LVmXIqoX0URP+txBTeThDDXFlJoR0qshlkcSUUNw=;
        b=FVSLcTcq4L7HTyjm2+DTd/0kwkZbCGhJrQscEO4w+trnm95bvlFATdU/+efKlr/1vw
         P82J0Kk8Cor29SOSAROxEE9LUGSsnNXLiexidSQ2Dm8iXJnq2VWTis3rFaF5a4wLl22R
         ReyPUYZHPWwQKHJmMrOQQdD+MH1DdW7INIpVvmrWVgU7auqFypD4+4jSCSQnGD7p8tp6
         de76IprP6RWz85iW4qZr9W0AFPjiSLiEqV9iMgvd8QGfccjLmpcGswbrj83ZanJSgldK
         pcqs3DYGQfDqh8+RCKOWg6hfTN+HPXL/81p0pDO7tC63AO2atPmORH0uBwqhmgfTa35f
         KFig==
X-Gm-Message-State: APjAAAVH23iZiRJlkjnYgAj3+hIl3SDKDQOVQvFTz+00hdwK0JkxDlvo
        GxQYLxOFEBWlLkfHHyq3brpmobIfU2l70xrkoYh2nQ==
X-Google-Smtp-Source: APXvYqyu0f3/fONIRBlO/SpNCFgA1avxg6TXoCqOmxx9nAIJcCSFXb7WSiS/T77boJRI2YpNbQpsswrKFAKPewRZxUE=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr4444189vsn.96.1554389694879;
 Thu, 04 Apr 2019 07:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001c2b95057ad0935b@google.com> <000000000000462a4105848c8e12@google.com>
 <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com> <be750b12-ba3d-ecb4-541a-ca3669bb75d7@xs4all.nl>
In-Reply-To: <be750b12-ba3d-ecb4-541a-ca3669bb75d7@xs4all.nl>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 4 Apr 2019 16:54:43 +0200
Message-ID: <CAG_fn=UGc2_CpLG0c8Ppv7X7ss6-wmXtEX76=yLow=5_DNCH2g@mail.gmail.com>
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        mchehab@kernel.org, mchehab@s-opensource.com, mkl@pengutronix.de,
        Networking <netdev@vger.kernel.org>, socketcan@hartkopp.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 4:51 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/4/19 4:47 PM, Alexander Potapenko wrote:
> > On Wed, Mar 20, 2019 at 9:35 PM syzbot
> > <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com> wrote:
> >>
> >> syzbot has bisected this bug to:
> >>
> >> commit 6d469a202ee73196d0df76025af80bd6a379e658
> >> Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> >> Date:   Sun May 14 17:07:21 2017 +0000
> >>
> >>      Merge tag 'v4.12-rc1' into patchwork
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12639fd=
7200000
> >> start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
> >> git tree:       upstream
> >> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D15639fd=
7200000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11639fd720=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd86f243338=
80b605
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6c0effb5877f=
6b0344e2
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1312062b=
400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D131bd09340=
0000
> >>
> >> Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
> >> Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
> >>
> >> --
> >> You received this message because you are subscribed to the Google Gro=
ups "syzkaller-bugs" group.
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/m=
sgid/syzkaller-bugs/000000000000462a4105848c8e12%40google.com.
> >> For more options, visit https://groups.google.com/d/optout.
> >
> > I believe this bug is caused by vivid_vid_cap_s_selection() calling
> > kfree(dev->bitmap_cap).
> > This makes little sense, as dev->bitmap_cap seems to be allocated
> > using vzalloc().
> >
>
> Yup, that should be vfree. There was a similar problem with bitmap_out th=
at
> I fixed, but it looks I missed this one. Can you make a patch?
Yes, I've almost hit the send button :)
> Thanks,
>
>         Hans



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
