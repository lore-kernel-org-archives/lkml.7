Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31211C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F5520722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRRyYpHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLYHUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 02:20:11 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34952 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLYHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 02:20:10 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so18075711ild.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 23:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sri5sfueFO4Exz0ENPN8HCkoPbDYs1U1wIVwtSEFmvg=;
        b=dRRyYpHWkSGOFa9MLwVb0pdRYAR3k1FvZUFxcGseTuMC8B9/7iRRMm+nrs1aTQ/IsI
         tDebN0r/l1He5AXMZSG6SYJGVVlo3YExPGLbuhALmVUm5UpsQ8HhMGuqOE2EOe58GDTS
         f74hSV3iXmNxDWJIu8X3lKcCdVj/UYGsFDOa13C1ILU7hxI617NJBwxGY+c2Obe88mBo
         uL6KvPbj+O7GXD9iwnbQ7G8DJshmJfkmbqEbr8sUQWWF4Ql/C6Hhg2f7TOWHglZlusvk
         tbzXJCFKaUVF3LKZRxfinhArGzkMf4MvaTKZsj8HrGgtDzJTkiADOrPjrwQc80Fg+Wi0
         +7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sri5sfueFO4Exz0ENPN8HCkoPbDYs1U1wIVwtSEFmvg=;
        b=JMQMqkkCzz2b0fV2Ik75qRj8kF1eP9CGvZC7MRvaWngRtP1lVR7S5qFiCNtyA/t3Iq
         8+8/t4FVfrQAmoEKSblKQtc/fnVFDZGAgkh3u1fCLEtaju2bCT9W81ahYQbz7vOnG4/X
         npVUS94Wb8rMLfg7Lf0ok6iWkBuPCAfB+7FsYilbdDtpb5uhj25HpZFRowHem8F4MGx5
         RtybWlJFwDGERJ6aE+EX3y8/M7E9nhkXTpuC4vGHNB2Y6Itj68gLEo8mPVKXt1oOb6OL
         siMN5PadDdPyvsywt1bGAO1U9j79d435O0CP5oLBAwj7I1kU3D0skm7oD5c19rFYRYZM
         iFoQ==
X-Gm-Message-State: APjAAAX7abgrzf0TxIywGUdnONidJ9U008JQueSL4nsOUBbhn0u6TekX
        PZkJLMHG0Xbclg6wSLlK07hDfIsvPM116ZqH8C0=
X-Google-Smtp-Source: APXvYqyzWGbhyiz3+arLsu8FDdvxpCO5Q3CwrYcF6Q1czGLs6PIlzkF8bWasFfcE9Vsl5+R5ju4ih/4agPZW8nCzIbY=
X-Received: by 2002:a92:160a:: with SMTP id r10mr31842328ill.14.1577258409246;
 Tue, 24 Dec 2019 23:20:09 -0800 (PST)
MIME-Version: 1.0
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
 <87pngglmxg.fsf@mpe.ellerman.id.au> <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
 <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
 <CAFAt38FnH376ioDuvyNJW=iOxbcooRRsEeVEfDudRoV4gG98SQ@mail.gmail.com> <a37338283db548c58e6c36e4996a9474b1fe2038.camel@buserror.net>
In-Reply-To: <a37338283db548c58e6c36e4996a9474b1fe2038.camel@buserror.net>
From:   Yingjie Bai <byj.tea@gmail.com>
Date:   Wed, 25 Dec 2019 15:19:58 +0800
Message-ID: <CAFAt38HEUZ1tc-OGw2YF3-YcouG63h1uG8Quot=G5xj+u9pTtA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc85xx: also write addr_h to spin table for
 64bit boot entry
To:     Scott Wood <oss@buserror.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, yingjie_bai@126.com,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Scott, I will test to see if returning phys_addr_t in __pa()
works for my setup.

And another thin I will test is to compile without CONFIG_RELOCATABLE
before resubmitting the patch.

On Wed, Dec 25, 2019 at 2:53 PM Scott Wood <oss@buserror.net> wrote:
>
> On Wed, 2019-12-25 at 11:24 +0800, Yingjie Bai wrote:
> > Hi Scott,
> >
> > __pa() returns 64bit in my setup.
> >
> > in arch/powerpc/include/asm/page.h
> >
> > #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> > #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) +
> > VIRT_PHYS_OFFSET))
> > #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
> > #else
> > #ifdef CONFIG_PPC64
> > ...
> >
> >
> >
> > /* See Description below for VIRT_PHYS_OFFSET */
> > #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> > #ifdef CONFIG_RELOCATABLE
> > #define VIRT_PHYS_OFFSET virt_phys_offset
> > #else
> > #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
> > #endif
> > #endif
>
> OK, so it's the lack of CONFIG_RELOCATABLE causing the build to fail.  Ideally
> we'd make __pa() consistently return phys_addr_t, even if the upper bits are
> known to always be zero in a particular config.
>
> -Scott
>
>
