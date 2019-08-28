Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4572C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7F42339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfH1POR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:14:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41108 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1POR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:14:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id g17so44596qkk.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQzVgkGastCCZFbFZ7g9sQmtqjgZSo1pYtQrF34ax5w=;
        b=eyaRKuChPKUi+LBTUrprs6OthuFSyH44lX507bHnP3bS6LkI7bElz3L2jSYUnP/wdz
         2UAg+c+r3vW/ZJGDXy8adcAubQp1/KPzNoluZRFXVflJUqd7nk8mJpKrLmITAeW20f1F
         EGdDlAl2chxu7xEOyhZLu+6P8rAVF4ZCs+pvjPMe3z3FKseBl+CPLeyXdaJ3LtMCSwDc
         0kvGFodXGLUSa/80XhyrHhWYssoluZ8yEZrBS/KUjKpReB7Aos9d7Ph6DUytCIGZ1iBo
         31IUXTczBhpafaYSmm/KWBseIHDPC0RKNwaZPtDTt/tv+Cwtyc6pZCCAWE2/vcs+b3xD
         cl8g==
X-Gm-Message-State: APjAAAVCJnOWz+ZoKUqh4Y7qjsuiqEoJeRn/XZfeMxtRKr826kdud8D1
        kFuUKPrx1Ns0+AF2lvucgtvtGi+LJp6r8SFk7kE=
X-Google-Smtp-Source: APXvYqxq6dUQwoGZKS2NIPsvwPigFzVtSoqu+iRQ6eqrGgn5DZd+LVhTJIUy6Ir7QVrBMtq4t0rU/tb49Q0lPh6tNHM=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr4454519qkb.394.1567005255266;
 Wed, 28 Aug 2019 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com> <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 17:13:59 +0200
Message-ID: <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:00 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Aug 27, 2019 at 11:22 PM 'Nick Desaulniers' via Clang Built Linux <clang-built-linux@googlegroups.com> wrote:
I figured this one out as well:

> http://paste.ubuntu.com/p/XjdDsypRxX/
> 0x5BA1B7A1:arch/x86/ia32/ia32_signal.o: warning: objtool:
> ia32_setup_rt_frame()+0x238: call to memset() with UACCESS enabled
> 0x5BA1B7A1:arch/x86/kernel/signal.o: warning: objtool:
> __setup_rt_frame()+0x5b8: call to memset() with UACCESS enabled

When CONFIG_KASAN is set, clang decides to use memset() to set
the first two struct members in this function:

 static inline void sas_ss_reset(struct task_struct *p)
 {
        p->sas_ss_sp = 0;
        p->sas_ss_size = 0;
        p->sas_ss_flags = SS_DISABLE;
 }

and that is called from save_altstack_ex(). Adding a barrier() after
the sas_ss_sp() works around the issue, but is certainly not the
best solution. Any other ideas?

       Arnd
