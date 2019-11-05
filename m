Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F2C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7127A21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txaxdUHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfKEWK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:10:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35849 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:10:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id m6so206564lfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oHNoa42wrptLOIF/3dlMMyJwxrj4Pwhbf1WPBq8o3uM=;
        b=txaxdUHAhhP9SDZaT+2LCWEybyxTXeBjbSvIEpNO3NUlCNP11+juSvK4NTapgDIQsx
         bx4UA6EMOgVRpvfj9Ytg3Dbq2TH/brOOWOMH+2KBx/B/IHrQbQAjLifbp0FSTSQsO2Bd
         NiuZC+eFppZJoQE3ZUPlpHN1pT+rO6Z14hJeshOd2hCFXwk4GR///Yx4GRVniJ3VKONO
         Kt+mJci6Da3WvnYbEe8gDOsTV7j/2J9XBqJqDkJ51fvbH5UQdmpyyfw/VvxEU/blzMIM
         MaPDes1kjsPOjqDH4nLH7vZE3u4nXKFUCYPNkeargYEdaXpUvyyeDnNhBld+YwzcgZEF
         lFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oHNoa42wrptLOIF/3dlMMyJwxrj4Pwhbf1WPBq8o3uM=;
        b=sGZEAT4kC8nzWY/xhh2MQ6A6basdqGGOmeMJMNtwecWnG55feLqwG6JDs6VllTju6H
         ZQ0hy2I8e/fHNk4NABrUbByecYEkHiLxkaZx7nuzvvFJRpGq39EP+7FkjeWvHEprm0X6
         KDuAW2Cp71kUPFtffGU/ii9gYgcV8KHXZZ6lTtTIEpGkKB789UCRMItjvpzggGRpjojl
         80c5OZGgi4DPT4JhagnTECzvDQKCNAhdWb1KlqyvEtV8x41fzZf7xPfFmZC4Kg7HKBo3
         Lfhgyq2bSUFodPXAtWWmhQrlVUzPt3PoQvHYQIK8ESW5oLxqc33qVYX0F2LHGL221Goz
         Hb6g==
X-Gm-Message-State: APjAAAV5ifYkYID//pOeklOEgEx/Z0zCrr3mcjOftew7KK2HeZmgBR4l
        lX1JwkxWjVHlSO3mL3tjNOkSWofrP3UNc5sygM0nPg==
X-Google-Smtp-Source: APXvYqzbkj8YH9eITFZzXyrVd6DZFMTF5o/g/z0Eip1PKIKK6ASKx4h4gD3fA7MnFeAp5hmlIjHyjgVN7N9W0POhIHg=
X-Received: by 2002:ac2:5587:: with SMTP id v7mr135624lfg.79.1572991853663;
 Tue, 05 Nov 2019 14:10:53 -0800 (PST)
MIME-Version: 1.0
References: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
 <273986A1-A4BE-4FE5-B547-49CAA44C6FD3@amacapital.net>
In-Reply-To: <273986A1-A4BE-4FE5-B547-49CAA44C6FD3@amacapital.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 14:10:16 -0800
Message-ID: <CAKOZuetCqQa_be_2Ek-zo58TA5nLKVFb4f01ahcACxiQ9Th80A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 2:01 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Nov 5, 2019, at 9:02 AM, Daniel Colascione <dancol@google.com> wrote=
:
> >
> > =EF=BB=BFOn Tue, Nov 5, 2019 at 8:56 AM Andrea Arcangeli <aarcange@redh=
at.com> wrote:
> >>
> >>> On Tue, Nov 05, 2019 at 08:39:26AM -0800, Daniel Colascione wrote:
> >>> I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE=
.
> >>> That would, as you point out, break things. I'm talking about
> >>> recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
> >>> uffd context when we create the thing --- and then, at ioctl time,
> >>> checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
> >>> UFFD_FEATURE_EVENT_FORK should be made available. This way, the
> >>> security check hinges on whether the caller *at create time* was
> >>> privileged.
> >>
> >> Until now it wasn't clear to me you still wanted to do the permission
> >> check in UFFDIO_API time, and you only intended to move the
> >> "measurement" of the capability to the syscall.
> >>
> >> So you're suggesting to add more kernel complexity to code pending for
> >> removal to achieve a theoretically more pure solution in the band-aid
> >> required to defer the removal of the posix-breaking read
> >> implementation of the uffd fork feature?
> >
> > And you're suggesting making a security check work weirdly unlike most
> > other security checks because you hope it'll get removed one day?
> > Temporary solutions aren't, and if something goes into the kernel at
> > all, it's worth getting right. The general rule is that access checks
> > happen at open time. The kernel has already been bitten by UFFD
> > exempting itself from the normal rules (e.g., the
> > read(2)-makes-a-file-descriptor thing) in the name of expediency.
> > There shouldn't be any more exceptions.
>
> I don=E2=80=99t think ioctl() checking permission is particularly unusual=
. In principle, it=E2=80=99s better than open for a retrofit =E2=80=94 open=
 didn=E2=80=99t capture this permission in the past, so adding it makes an =
existing capability stronger than it was, which isn=E2=80=99t fantastic.

All right, let's do it the way the OP's patch does it then.
