Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC8C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609AE2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfGIT1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:27:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44489 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGIT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:27:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so18970907qtg.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ut1CYKEdUPaAKuaQJzRmmI/090yVlVYJHVfrpV3nW+k=;
        b=ccwi3lXSkf7HxJgn5IA+weYBloyBR0EabWDPBEFq7iGrwPIHKaaPWh9X2J86rtGeV9
         URTeXzeV42FoydBryZnoDlKAAFGp5RY2ZnCYh2u13H8WSgDfXoPq8oDJuRcF1R7hWzgl
         DxlKVrjn6R9/eRrjJdRiGA+nqCGoZ4wERvsgXa/EZnj/icd4iRCyIjuWd6pVl5v0SbKu
         X9WTBb+ZbaOdR60W9hM/oiflzyhdeHqdpB8pQWn2xgp0ASzXEHLSo6xhTDf5HABiu8rz
         q/2iVXaC3DdVbUrnAWlHZCEG/Q1Xsd/4AjDu2X4OMPrMCxUHY6MCgKKe/X6577abKmGG
         3dfQ==
X-Gm-Message-State: APjAAAVHMf8Iav/ecc6mzKQ7N0fUG2vZdC76u2NYV5+PbjoWVXtsMuIx
        5s5LdR/GzaGFUUr5H4rYvppBrTF5j/i4ENFulcA=
X-Google-Smtp-Source: APXvYqzfGd7Ka9GO7cFWo++Fz82uuQceqJevKSYwYmmRgURi2D0/da8cUUiufL7EbHa7gDrNFtpAr2AC1iG5Sby45rE=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr20206906qtf.204.1562700454881;
 Tue, 09 Jul 2019 12:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190703081119.209976-1-arnd@arndb.de> <20190703175845.GA68011@archlinux-epyc>
In-Reply-To: <20190703175845.GA68011@archlinux-epyc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jul 2019 21:27:17 +0200
Message-ID: <CAK8P3a041S8KFTz4ZjmByDUTM9pDxsWi=hGPeamkFfn4B1dcxQ@mail.gmail.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 7:58 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, Jul 03, 2019 at 10:10:55AM +0200, Arnd Bergmann wrote:
> > When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> > produces an annoying warning from clang, which is particularly annoying
> > for allmodconfig builds:
> >
> > fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
> >         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> >                                         ^~
> > include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
> >         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> >                                ~~~~                                  ^~~~
> > include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
> >         ({ init_waitqueue_head(&name); name; })
> >                                        ^~~~
> >
> > After playing with it for a while, I have found a way to rephrase the
> > macro in a way that should work well with both gcc and clang and not
> > produce this warning. The open-coded __WAIT_QUEUE_HEAD_INIT_ONSTACK
> > is a little more verbose than the original version by Peter Zijlstra,
> > but avoids the gcc-ism that suppresses warnings when assigning a
> > variable to itself.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Who would be the right person to pick this patch up for mainline?

I guess it may have to wait until the end of the merge window now,
but I'd still like this to be part of 4.3 and possibly backported to
the stable kernels as we build those with clang as well.

       Arnd
