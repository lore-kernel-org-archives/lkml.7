Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7800AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tq72Hmt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfL3HmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 02:42:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40920 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfL3HmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 02:42:09 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so30725825iop.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANVFGaLAaJoO/Rj+UxPUWyrZLAhcTC/tDRV7tpl7ss8=;
        b=tq72Hmt75sZ3kDa4nG5VGoFZ7vA03qPcuVzy5+JyGG8WMUshaN1dw7JDLkx3Nn1f0T
         nVBTGLt/vz7FaHqEfMkh+p4pb3VtqoGt8AoVrqYZ5ypPxMLGFBU2P223+UMTOPuKFnyy
         MCJWuYZsFIeX+sOo7zC093tchzXoJrEVfsUzBa1a5rfoRaX3XU/l59aud9UJtUDHa23F
         JFXfAOv7GHIJY/P71mI/PcMQfzLl0U1Ym3ebE6dLsXRAQXGR6jPaxWTwuqwgnJgQgKUe
         k97SYPqHGLcA+fYN8gjaDt/ea6MwRjmPw9KocduTukocsFY6qSBzSzWgZVBQGXvLCLKZ
         Ti3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANVFGaLAaJoO/Rj+UxPUWyrZLAhcTC/tDRV7tpl7ss8=;
        b=mmuHLNBcF3HpOyjTLf5l6ROf83isvjq9u7xNgiBNk7phEFQSg67u8P+W9Fm5vZ/5zz
         9SOM5eCqqEtZYv96ojqw0fhdcfSd5PE9wA/EPOZknmKohIoSVfsygamJypUwIyLSNQmU
         Qu7fgGmSBT1t4Q1TY99xsXNC5v7EUNkP3KmiQZXJTEGxfszfO+j8jBE636r/LU37v9NV
         DTGAMC2rA5fiq7BGkKS0Axo5aDHbc2IHo78OP0sOj9/aj+D8bIQnTLJPVz5F9spgm313
         5zraa7oc8Qco7sgPrtCsXiFYaETsg7JB84AxTf9vEJR9bCSDzEN94m/YLMkogHqTZhir
         6Z+g==
X-Gm-Message-State: APjAAAXxZWTRG2oHleApRJu+K7gcvd/mROLNPFTijgZiQoA/h9pXQPeU
        +g67O13LYR1wdijzS3S13/xoGBeBHnLktm1lfWo=
X-Google-Smtp-Source: APXvYqw2BxFkZM5706prgEKWvAiw+qAPwbnpe87gJbOVEGckdmIkgthjmJviD8Fjv8rie3U4gVtz2AADmm/wMrEdB/k=
X-Received: by 2002:a05:6638:723:: with SMTP id j3mr53276068jad.131.1577691728600;
 Sun, 29 Dec 2019 23:42:08 -0800 (PST)
MIME-Version: 1.0
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
 <87pngglmxg.fsf@mpe.ellerman.id.au> <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
 <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
 <CAFAt38FnH376ioDuvyNJW=iOxbcooRRsEeVEfDudRoV4gG98SQ@mail.gmail.com>
 <a37338283db548c58e6c36e4996a9474b1fe2038.camel@buserror.net> <CAFAt38HEUZ1tc-OGw2YF3-YcouG63h1uG8Quot=G5xj+u9pTtA@mail.gmail.com>
In-Reply-To: <CAFAt38HEUZ1tc-OGw2YF3-YcouG63h1uG8Quot=G5xj+u9pTtA@mail.gmail.com>
From:   Yingjie Bai <byj.tea@gmail.com>
Date:   Mon, 30 Dec 2019 15:41:56 +0800
Message-ID: <CAFAt38EFEh25Xv_K2GiO2CACW4v17fbtE0YnL0k3x61dERS2fw@mail.gmail.com>
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

Thanks for your time to review this patch

Based on your suggestion, I have verified below new patches that pass
compilation with and without CONFIG_RELOCATABLE

https://lore.kernel.org/patchwork/patch/1173548
https://lore.kernel.org/patchwork/patch/1173547

On Wed, Dec 25, 2019 at 3:19 PM Yingjie Bai <byj.tea@gmail.com> wrote:
>
> Thanks Scott, I will test to see if returning phys_addr_t in __pa()
> works for my setup.
>
> And another thin I will test is to compile without CONFIG_RELOCATABLE
> before resubmitting the patch.
>
> On Wed, Dec 25, 2019 at 2:53 PM Scott Wood <oss@buserror.net> wrote:
> >
> > On Wed, 2019-12-25 at 11:24 +0800, Yingjie Bai wrote:
> > > Hi Scott,
> > >
> > > __pa() returns 64bit in my setup.
> > >
> > > in arch/powerpc/include/asm/page.h
> > >
> > > #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> > > #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) +
> > > VIRT_PHYS_OFFSET))
> > > #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
> > > #else
> > > #ifdef CONFIG_PPC64
> > > ...
> > >
> > >
> > >
> > > /* See Description below for VIRT_PHYS_OFFSET */
> > > #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> > > #ifdef CONFIG_RELOCATABLE
> > > #define VIRT_PHYS_OFFSET virt_phys_offset
> > > #else
> > > #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
> > > #endif
> > > #endif
> >
> > OK, so it's the lack of CONFIG_RELOCATABLE causing the build to fail.  Ideally
> > we'd make __pa() consistently return phys_addr_t, even if the upper bits are
> > known to always be zero in a particular config.
> >
> > -Scott
> >
> >
