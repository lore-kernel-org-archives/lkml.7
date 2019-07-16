Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB2C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673AC21743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfGPWFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:05:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35262 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfGPWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:05:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so21289577qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65KRGEYO/3Bgs7IZ+YWXNcAEzJ5dZdwUKcf3VZBRcoA=;
        b=rTv0GhtXOIB+3BRheAHs82d9NFTB4NlUzoYxon36Sgou+ul0BZIPbT6jfAGc7+2xgT
         r/e2SeEveYiE4dGm1QHqE2wNtX/QabH9H9RPMGkJtH3da0anUp7aAXPYrppz6rGKB1wr
         JKCgodK1KcUTCqCHad4E6DVA/CpGDETims0BOIOPzEVIfcZktN7iGxpc+z/2zcLGVmIb
         g350O65h03qANJyuABcnLxdPOvy/q4G5IxJMlTSnQhHqJ5S7y8vHyW8eUNnxA/A0hEQi
         IafcWNcNW9tcrZTbtzd1o2bTHv8W3IpVls1CgJT4IPJpQo5RljmnrwIlRUarj97qXGAA
         qoJw==
X-Gm-Message-State: APjAAAWVxpH9sgTchleCpC79EJokF56OLUPMu2Mf8apJlXI2U0lvBzKh
        bfaMB0LxeoFCqvbFtHx52ah9kivi/E5NbV/b8YulGHff
X-Google-Smtp-Source: APXvYqzwbgDm9inbH8OpIY+1upwViCc70PZ50KKd0E9QoKNRpkuQqHxhq+WtoyakCcbduG/A2i4pKYZSLdOB1KQ6Wyo=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr24046384qtn.304.1563314730760;
 Tue, 16 Jul 2019 15:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble> <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
 <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
 <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com>
 <20190712135755.7qa4wxw3bfmwn5rp@treble> <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
 <20190712142928.gmt6gibikdjmkppm@treble> <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
 <CAK8P3a0AGpvAOzSfER7iiaz=aLVMbxiVorTsh__yT4xxBOHSyw@mail.gmail.com> <CAKwvOd=o16rtGOVm9DWhhqxed0OEW5NKt4Vt3y_6KCcbdU-dhQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=o16rtGOVm9DWhhqxed0OEW5NKt4Vt3y_6KCcbdU-dhQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Jul 2019 00:05:14 +0200
Message-ID: <CAK8P3a2Vq+ojOZSefwziMhzU2SG+Bq6HDz2Ssjz7_BpVnMUu=A@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:24 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, Jul 12, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Jul 12, 2019 at 6:59 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > > > The issue still needs to get fixed in clang regardless.  There are other
> > > > noreturn functions in the kernel and this problem could easily pop back
> > > > up.
> > >
> > > Sure, thanks for the report.  Arnd, can you help us get a more minimal
> > > test case to understand the issue better?
> >
> > I reduced it to this testcase:
> >
> > int a, b;
> > void __reiserfs_panic(int, ...) __attribute__((noreturn));
> > void balance_internal() {
> >   if (a)
> >     __reiserfs_panic(0, "", __func__, "", 2, __func__, a);
> >   if (b)
> >     __reiserfs_panic(0, "", __func__, "", 5, __func__, a, 0);
> > }
> >
> > https://godbolt.org/z/Byfvmx
>
> Is this the same issue as Josh pointed out?  IIUC, Josh pointed to a
> jump destination that was past a `push %rbp`, and I don't see it in
> your link.  (Or, did I miss it?)

I think it can be any push. The point is that the stack is different
between the two branches leading up to the noreturn call.

      Arnd
