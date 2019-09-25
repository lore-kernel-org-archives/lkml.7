Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BECC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356A7214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJpyOQX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfIYJve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:51:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33226 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfIYJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:51:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so5933306wrs.0;
        Wed, 25 Sep 2019 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i70lXkpmjKx3wjz7ASYvHbouIU1eq8KGYClq6A9hzqA=;
        b=VJpyOQX9mBx/yw78cH6FqBy+6LRyXgCG3MK91gQnPCUB8Yak73HP2NkINBFtox3J9q
         5Vm9/ywVnLtaZEBuqfMds0KbBvujnj+O01CqopMP3pEkKMMAdSfHys9A+Ajci2vJ2U8x
         xDao0xLvnnqvlj/MmOY/viBotHTcG2jSV1zc5a6c0FmDRM3FSvDhEMIkHQmXnWAHR3wr
         MvWegmT0v6TFFC+hBmo6ywGB2RfCKFsZDND1fepfuTR8vow3Tr6TJlj9BQmzcGunM2h/
         Vf37sj4fzNT5JVSVa+0/SpTzskgJ4XXGjB3hLkVkJajP9jQgpyzdGJc066iXQvbi8xhD
         svXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i70lXkpmjKx3wjz7ASYvHbouIU1eq8KGYClq6A9hzqA=;
        b=rp6GprkmofMgGgvXGvHgmlJKBTrl5CMnDmKnDba2QyExYSTYCaSwtmTXqqK3HyfRvw
         /Le+U6/fSMBtFo5oR6+Gb0xP7DTz/pf7IGb5on997Fd2sI7gNaiehCmLnIa7c6S9raVS
         0+VqBgQSx3z5GjByTf07TS7eklyNmaXf/DaGZTZ/TkVzOmxxcMk7z6NHC6+4cz0WctSg
         ovko7rDFhbmifVtBAvxUVa2q0andZ1vJ91UXq2b/jTbMaMn2rXFFWA2kLSaoSasvRFKF
         rPQZXoGmZ5Vf508Ojus4E//e3LGu2fZE3fd4F+Ue+OHfQ6tX/DY8r00XEivTcrkakc2r
         wjVA==
X-Gm-Message-State: APjAAAWmzfCVyMQwdIEjpDhyir9usRf7eNHj0+MWCY04Sd5k4PjUPtAN
        ADQ5RSNs24/Crk9v06httT6SF0fBMcz/bCMJ+1Q=
X-Google-Smtp-Source: APXvYqxkeStWm0YPf4CxszEWXS2elUqqB/yKezVaRzDg8A0S0QgreaLilGVynCBZd10sZdZCmpm0BOjZHWLN3g7lAXw=
X-Received: by 2002:a5d:4350:: with SMTP id u16mr8605104wrr.289.1569405090725;
 Wed, 25 Sep 2019 02:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
 <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com> <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com>
In-Reply-To: <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 25 Sep 2019 12:51:19 +0300
Message-ID: <CADxRZqxobQN2mxprSQN3jbE7KpYGOMm50+CmtyCpqEbgcVgPFQ@mail.gmail.com>
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 2:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sun, Sep 22, 2019 at 5:33 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> > On Sun, Sep 22, 2019 at 11:13 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> > >
> > > Hello!
> > >
> > > Latest git kernel does not compile for me:
> > >
> > > ~/linux-2.6$ git desc
> > > v5.3-11506-gf7c3bf8fa7e5
> > >
> > > ~/linux-2.6$ make
> > >   CALL    scripts/checksyscalls.sh
> > > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CHK     include/generated/compile.h
> > >   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> > > unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> > > arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> > > make[2]: *** [scripts/Makefile.build:266:
> > > arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> > > make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> > > make[1]: *** [scripts/Makefile.build:509: arch/sparc/vdso] Error 2
> > > make: *** [Makefile:1667: arch/sparc] Error
> > >
> > > but I was able to compile successfully v5.3-10169-g574cc4539762
>
>
> Thanks for the report, and apology for the breakage.
>
> Please check this patch.
> https://lore.kernel.org/patchwork/patch/1130469/
>
> I hope it will fix the build error.

Masahiro,

fixes kernel compilation for me, thanks!

David,

can we please push it to current git kernel , so later bisect sessions
does not need yet another patch... Thanks.

Tested-by: Anatoly Pugachev <matorola@gmail.com>
