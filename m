Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E90EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BD02190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfCVQ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:57:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45753 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfCVQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:57:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so3224930qtv.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 09:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV/VlmiWT5ICHGENGi1uLztsqw5jkI8SLkdbegt9HLs=;
        b=eo8oglaBa7sE50Tqz2dDMFVuGHshg1z8dLe/sA13xA8kDP6FIWFDV9VVjU1YsoFBC8
         xYYbsIdxGSGa+8ZeFta/nB1/3XNyI3iLI4ur5DrzqUSKcKL7HkFrA2osEX0vvGSb7Fkr
         GuACPo++D7inT/8aaW4EzF5Tq+0zBRfaYXY6DVyTotEPtuLWIx3OLBR50dGtG5RF19/w
         QylUXtntmx9X7pyYlRA3vi6OWOX/kkXaevbvH5iFCXNjxIrJzsnfl84XuqR6FhpCrEcp
         l+Hy8Ut/hmirQsRWdoqQWMPGq6/80/AhUTSA0wM4iKrD3vZfjAKdUN0UpnkIwkAtMCO6
         gTwA==
X-Gm-Message-State: APjAAAUAvGogyME5W0uKHgELiRibrBsGmu/g5FApgJYtH7RJkHZ+mgK8
        IO6TN+XhIq9NSyAS63CcoLu2fVHYFL/H9tZgckA=
X-Google-Smtp-Source: APXvYqzByAOanotG+eNryBmdjsucTuAcIlh39uv0w/vRR9jdRsG2QIsy2R67Fx5Vwvp8T70vfK75pE+dCcMDG/ccwRI=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr8998796qth.319.1553273847171;
 Fri, 22 Mar 2019 09:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-2-andi@firstfloor.org>
 <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com> <20190322163954.GG7905@worktop.programming.kicks-ass.net>
In-Reply-To: <20190322163954.GG7905@worktop.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 17:57:09 +0100
Message-ID: <CAK8P3a3Zpkz+TNYE_PtY0dS=jxi1G1VtXWAmiABAS7nRMUkGgA@mail.gmail.com>
Subject: Re: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc 9
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 5:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 22, 2019 at 02:58:51PM +0100, Arnd Bergmann wrote:
> > On Thu, Mar 21, 2019 at 11:00 PM Andi Kleen <andi@firstfloor.org> wrote:
> > >
> > > From: Andi Kleen <ak@linux.intel.com>
> > >
> > > This warning is very noisy in a default build with gcc 9.
> > > Move it into W=2 only.
> > >
> > > Cc: arnd@arndb.de
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >
> > I think W=2 is too aggressive. On many architectures, this finds
> > real bugs and the false positives tend to be trivial to fix
> > (by removing the bogus __packed annotation), which improves
> > the generated code in the process.
> >
> > Moving it to W=1 for the moment is probably fine, but ideally
> > I think we should fix the kernel to behave according to the
> > C standard.
>
> Lol... we're actively moving away from the C standard on many places.
>
> Why does the silly compiler think it is a problem to take the address of
> a member of a packed structure? That sounds like something that's
> perfectly fine and useful.

The problem is casting a pointer of an unaligned variable to one
of higher alignment and passing that to a function that does not
expect unaligned data.

On CPUs that don't have unaligned load/store instructions, this
causes an alignment fault, which will have to be fixed up in
software by doing a bytewise access or crash the system.

        Arnd
