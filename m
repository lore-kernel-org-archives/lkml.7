Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F00C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649421734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQIU7dGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFFjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:39:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39264 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAFFjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:39:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so49688604lja.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlkkInIyCG//aHEm2YZjtVGYBTSoUzhq7aMbB6wqBY8=;
        b=kQIU7dGXyHK5nRWZlaZpGXDAV18PHQE00gTrtC+Up+k9CsDijsoEnEu8ZzFfTlpg+C
         Zw/UDMwrlG4zBb69D4oC36DpQqQdfSJaYKZlnL64l1vDWSm7lhLZQ9hpgnOmAgWap1Hj
         0OVX13ZBTDamKffWGm5dpa0+II6+J0KE/ehkkJ5+32OhPq71yfyg60VVGJBGR/VELdd4
         Wx6KzswF51p8E4M/pe77zZ7IfwF+MZmfbzeEZvGP2VutoShnFsOzEoKQg8uQfNBVyXMV
         fHR7eZZYwjhjFqKMgYQRwle0fSuuWc4pZwWlCqlfgLoXm9stF3UzL0NySBDQusIyfX7R
         UCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlkkInIyCG//aHEm2YZjtVGYBTSoUzhq7aMbB6wqBY8=;
        b=lnHtcMckoHboYlgYGKHP9a3Y/8a3d+Ls8JPMZB/FjewLGIX9U+GLjaCpWAtU96Mf4K
         lUeMJEfjdIYRX6PeW40hartnv2tWQqnnasEnH9tXk+pVrQSIjVT1luevduwMWoIwnEh6
         XIXdixRkzu+5ZpZdYPI85wr9Z5ieDGzocw8ksi3aWZpGZ1IP54Sfi50qqNPW0ONKAJ5x
         pFNCRLOLyGUHFQrk/oDVFsy9Nzg+3rCGRn1Mf+DTFE+xjHFeeLSqmjotXV8HDtbzGVmB
         yQiT/pqBYdM4OiNdjTpYPA7Hi1rrpafoinNHWFCVhEb67Bg5Y2hqrG1KcVOcYAtiwtKZ
         l1fw==
X-Gm-Message-State: APjAAAUQn1HQ6ZVXLElV9JtO/YzCVoaSQbf4sXJDnQiDVMX7GqSIHhpf
        j5DZi+lGDm4sMayrBBmIcLG1tkcOaHPIz3wnfJwVcite
X-Google-Smtp-Source: APXvYqw/Mn7CLRfO8Sa9X3Wkha6pSbBkSmBw4YM1xZXTY1WQvhH1uqWAYfR9xjfMGrxrhQVH7EvsKxg9fnaWjvj70BU=
X-Received: by 2002:a2e:3609:: with SMTP id d9mr58015801lja.188.1578289141455;
 Sun, 05 Jan 2020 21:39:01 -0800 (PST)
MIME-Version: 1.0
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
 <87pngglmxg.fsf@mpe.ellerman.id.au> <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
 <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
 <CAFAt38FnH376ioDuvyNJW=iOxbcooRRsEeVEfDudRoV4gG98SQ@mail.gmail.com>
 <a37338283db548c58e6c36e4996a9474b1fe2038.camel@buserror.net>
 <CAFAt38HEUZ1tc-OGw2YF3-YcouG63h1uG8Quot=G5xj+u9pTtA@mail.gmail.com> <CAFAt38EFEh25Xv_K2GiO2CACW4v17fbtE0YnL0k3x61dERS2fw@mail.gmail.com>
In-Reply-To: <CAFAt38EFEh25Xv_K2GiO2CACW4v17fbtE0YnL0k3x61dERS2fw@mail.gmail.com>
From:   Yingjie Bai <byj.tea@gmail.com>
Date:   Mon, 6 Jan 2020 13:38:50 +0800
Message-ID: <CAFAt38GhDX0OMEz-3AcQRJy6q-cpO-GW_eDFGHmHYw5tZw6EXw@mail.gmail.com>
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

Hi Scott,

Sorry for the late reply, I have checked the compilation error from
kbuild system, and found when CONFIG_PHYS_64BIT is not set,
phys_addr_t is 32bit, there is still "right shift count >= width of
type" error.
So I update the patches accordingly.

https://lore.kernel.org/patchwork/patch/1175560/
https://lore.kernel.org/patchwork/patch/1175559/


On Mon, Dec 30, 2019 at 3:41 PM Yingjie Bai <byj.tea@gmail.com> wrote:
>
> Hi Scott,
>
> Thanks for your time to review this patch
>
> Based on your suggestion, I have verified below new patches that pass
> compilation with and without CONFIG_RELOCATABLE
>
> https://lore.kernel.org/patchwork/patch/1173548
> https://lore.kernel.org/patchwork/patch/1173547
>
> On Wed, Dec 25, 2019 at 3:19 PM Yingjie Bai <byj.tea@gmail.com> wrote:
> >
> > Thanks Scott, I will test to see if returning phys_addr_t in __pa()
> > works for my setup.
> >
> > And another thin I will test is to compile without CONFIG_RELOCATABLE
> > before resubmitting the patch.
> >
> > On Wed, Dec 25, 2019 at 2:53 PM Scott Wood <oss@buserror.net> wrote:
> > >
> > > On Wed, 2019-12-25 at 11:24 +0800, Yingjie Bai wrote:
> > > > Hi Scott,
> > > >
> > > > __pa() returns 64bit in my setup.
> > > >
> > > > in arch/powerpc/include/asm/page.h
> > > >
> > > > #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> > > > #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) +
> > > > VIRT_PHYS_OFFSET))
> > > > #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
> > > > #else
> > > > #ifdef CONFIG_PPC64
> > > > ...
> > > >
> > > >
> > > >
> > > > /* See Description below for VIRT_PHYS_OFFSET */
> > > > #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> > > > #ifdef CONFIG_RELOCATABLE
> > > > #define VIRT_PHYS_OFFSET virt_phys_offset
> > > > #else
> > > > #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
> > > > #endif
> > > > #endif
> > >
> > > OK, so it's the lack of CONFIG_RELOCATABLE causing the build to fail.  Ideally
> > > we'd make __pa() consistently return phys_addr_t, even if the upper bits are
> > > known to always be zero in a particular config.
> > >
> > > -Scott
> > >
> > >
