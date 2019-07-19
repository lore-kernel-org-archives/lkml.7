Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C7C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87B2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfGSSb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfGSSb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3141A3EA4;
        Fri, 19 Jul 2019 18:31:28 +0000 (UTC)
Received: from treble (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C052610190A1;
        Fri, 19 Jul 2019 18:31:27 +0000 (UTC)
Date:   Fri, 19 Jul 2019 13:31:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: warning: objtool: fn1 uses BP as a scratch register
Message-ID: <20190719183125.2tuhcch2rtanxvyn@treble>
References: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
 <CAKwvOdmoD1wVFLdWRXTA=c-p4oc6HDxsfhXq5wQpD-8oFUfNNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmoD1wVFLdWRXTA=c-p4oc6HDxsfhXq5wQpD-8oFUfNNQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 19 Jul 2019 18:31:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:23:16AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 19, 2019 at 11:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > A lot of objtool fixes showed up in linux-next, so I looked at some
> > remaining ones.
> > This one comes a lot up in some configurations
> >
> > https://godbolt.org/z/ZZLVD-
> >
> > struct ov7670_win_size {
> >   int width;
> >   int height;
> > };
> > struct ov7670_devtype {
> >   struct ov7670_win_size *win_sizes;
> >   unsigned n_win_sizes;
> > };
> > struct ov7670_info {
> >   int min_width;
> >   int min_height;
> >   struct ov7670_devtype devtype;
> > } a;
> > int b;
> > int fn1() {
> >   struct ov7670_info c = a;
> >   int i = 0;
> >   for (; i < c.devtype.n_win_sizes; i++) {
> >     struct ov7670_win_size d = c.devtype.win_sizes[i];
> >     if (c.min_width && d.width < d.height < c.min_height)
> >       if (b)
> >         return 0;
> >   }
> >   return 2;
> > }
> >
> > $ clang-8 -O2 -fno-omit-frame-pointer -fno-strict-overflow -c ov7670.i
> > $ objtool check  --no-unreachable --uaccess ov7670.o
> > ov7670.o: warning: objtool: fn1 uses BP as a scratch register
> 
> Thanks for the report and reduced test case.  From the godbolt link, I
> don't see %rbp, %ebp, %bp, or %bpl being referenced (other that %rbp
> in the typical epilogue).  Am I missing something? Is objtool maybe
> not reporting the precise function at fault?

I haven't looked, but it could very well be an objtool bug (surprise).

-- 
Josh
