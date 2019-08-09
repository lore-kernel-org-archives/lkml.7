Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ACEC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD192166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR17JX/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfHIT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:59:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33381 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHIT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:59:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so32651480edq.0;
        Fri, 09 Aug 2019 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHqEsgDgb5JzggXVfgJe1D/a5UW3aJXppbSuLP37XBs=;
        b=UR17JX/NbilG4ikKVy/oXcFAzOhqmweKVz+dGvxNjAxtqUl5SWhFuFYzVE+TP8BMzr
         /3wWPC+QBgk+BfTQpJ8Kbq3+RM0V2Zagx7vEC1in0XQJHg+ZWo9WXEc/f1njls5jOOFi
         Ma0xpWbqLMFuX3HFTu+Y3+kjmNsk2aQZrnDkKRo/Wa5oLEhhXba5gPFMIt5nPx8T5kpC
         hlpgIYXYoWwsUey8+XKE2f9rv8IY+i8+s/1Ce60eQ+jCRjqsE4LD/h9OBMuaaZrVj8ev
         yVay6t75Kik1BCr8A4MjxdCRAdQcAbXVXv48wR4oFL425IvfbU5JgliosnozC0h1loYA
         FmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHqEsgDgb5JzggXVfgJe1D/a5UW3aJXppbSuLP37XBs=;
        b=mA5YsM/mHwE9E++s6b+jEBn+KFKvOLhrqg723fjW72k8m5ZzrdNDUXKXdQ06o76vr8
         qRkm/YhB7V+0a6Fe+D1SCpNmGM+6ZNBkAYSlb+iUktY+POZff+y5HgduLQq5qP6nsDrt
         M+eZAyZsfngmc5QDOPoeq1ZWAuWXFaWpTp0fni9YTp19pCbIYLbfEVkCoJ5kRwktStFE
         d8urR7idT2PwKaAHHq+7yUnEtKwLrmUnYM/WGB/xjVrUSqMhOatPIe9psKKQps3sJ5n0
         FTm44SR06aT0OjmQ/Ozey8Nek6ly6qj+WCbIVBAEG051K2qgR149jP8Wp8nE56Ge8y7G
         /jXg==
X-Gm-Message-State: APjAAAVXBou9fpyg6z1Wp4lTTU+UUJGlSTOm+n2kDHs6JNU3qej79EIk
        PC/KkqRH3exISp9ERZK9FIlXXBE53iW5JPmzKVw=
X-Google-Smtp-Source: APXvYqz5a7RO0N9V2+pKGw7IFaG7VrGw1vD109CfGojs8XjLLN259Sjyaymy//2dM1gWI+9NNSyMdh4I+fVa9Rkxjzc=
X-Received: by 2002:a17:906:318e:: with SMTP id 14mr20172779ejy.85.1565380772979;
 Fri, 09 Aug 2019 12:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org>
In-Reply-To: <20190717215956.GA30369@altlinux.org>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 9 Aug 2019 22:59:23 +0300
Message-ID: <CADxRZqy61-JOYSv3xtdeW_wTDqKovqDg2G+a-=LH3w=mrf2zUQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:59 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Tue, Jun 25, 2019 at 04:37:08PM +0200, Christoph Hellwig wrote:
> > The sparc64 code is mostly equivalent to the generic one, minus various
> > bugfixes and two arch overrides that this patch adds to pgtable.h.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > ---
> >  arch/sparc/Kconfig                  |   1 +
> >  arch/sparc/include/asm/pgtable_64.h |  18 ++
> >  arch/sparc/mm/Makefile              |   2 +-
> >  arch/sparc/mm/gup.c                 | 340 ----------------------------
> >  4 files changed, 20 insertions(+), 341 deletions(-)
> >  delete mode 100644 arch/sparc/mm/gup.c
>
> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505

I've tried to revert this commit on a current master branch , but i'm getting :

linux-2.6$ git show 7b9afb86b632 > /tmp/gup.patch
linux-2.6$ patch -p1 -R < /tmp/gup.patch
...
linux-2.6$ make -j && make -j modules
...
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CHK     include/generated/autoksyms.h
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
ld: mm/gup.o: in function `__get_user_pages_fast':
gup.c:(.text+0x1bc0): multiple definition of `__get_user_pages_fast';
arch/sparc/mm/gup.o:gup.c:(.text+0x620): first defined here
ld: mm/gup.o: in function `get_user_pages_fast':
gup.c:(.text+0x1be0): multiple definition of `get_user_pages_fast';
arch/sparc/mm/gup.o:gup.c:(.text+0x740): first defined here
make: *** [Makefile:1060: vmlinux] Error 1

Can someone help me to revert this commit? Is it even possible? Since
it's not only futex strace calls getting killed and producing OOPS,
even util-linux.git 'make check' hangs machine/LDOM with multiple OOPS
in logs, while previous (before this commit) kernel passes tests ok
(and without kernel OOPS). I've already tried to compile current
master with gcc-6, gcc-7, gcc-8 debian versions, but all produce same
OOPS.

Thanks.
