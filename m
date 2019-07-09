Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4DC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF8F2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGISlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:41:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40444 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbfGISlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:41:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so22643850qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnD9hig+YDiQUOjEh5f12Pw4vUpoB+PptfAofP6OBZM=;
        b=o+EEKVkbF1ZCkKaw4qREXrIbph/M6+EqA3Z2iEN0zL+7ofYACKP/mCS2Npea8ae0Dq
         IBIeHNNw0rGnoZj6KhhMWvb5+jyoQ6QazO0Imcnl5HG+PgudRoER0YcK4g98mjCqWyWH
         0pzYbZjHux74E5K8Xl8PcB5M4eY7UmkU1kpa8PyWPXrdLHxytAP3ydwucIUPo7bVpoB1
         BY8tdbnITewyd2ra2AdO3BFS2MaCLfu0QU5xPHuTfzUN8vg129BQf03OVzZppK2jg7Qk
         05gBTQiyfegwAuTks0ewAC86pe6EMp6HoudS7LHX8IxXkUqFVkfadENh+NxJOl2RAhfZ
         A1sg==
X-Gm-Message-State: APjAAAXbO4czU6DRoytx/vGLSo5TY6rDHIkvMyREHtkkNR2uzN1+p/nW
        0XYCNeo3PZtFywWbbxuBDejiecB7JSC3EHD9tT8z2Ye2
X-Google-Smtp-Source: APXvYqxcwL5fgnA8xgT1zFYzj8t5e8uj2UEeYX5+R3isFLDPp9S69KVXmBT+Gtg1wIb5IXLc6Pllc5FughrwCH+y1iI=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr19607025qtn.304.1562697670085;
 Tue, 09 Jul 2019 11:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de> <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
 <CAKwvOdnm6rd4pOJvRbAghLxfd2QL5VJ+ODiMyRh1ri3pmmz0yg@mail.gmail.com>
In-Reply-To: <CAKwvOdnm6rd4pOJvRbAghLxfd2QL5VJ+ODiMyRh1ri3pmmz0yg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jul 2019 20:40:51 +0200
Message-ID: <CAK8P3a2anB0hD5J0JfPpJ_Gjc=NjoNC4k9nJ=t9H5AOBbdnfqg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 8:08 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Tue, Jul 9, 2019 at 1:41 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > I guess this brings up the old question whether the compiler should
> > be worked around or just considered immature, but as it happens this
>
> Definitely a balancing act; we prioritize work based on what's
> feasible to work around vs must be implemented.  A lot of my time is
> going into validation of asm goto right now, but others are ramping up
> on the integrated assembler (clang itself can be invoked as a
> substitute for GNU AS; but there's not enough support to do `make
> AS=clang` for the kernel just yet).

Note that this bug is the same with both gas and AS=clang, which also
indicates that clang implemented the undocumented .rep directive
for compatibility.

Overall I think we are at the point where building the kernel with clang-8
is mature enough that we should work around bugs like this where it is
easy enough rather than waiting for clang-9.

      Arnd
