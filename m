Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5252085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8KUZC0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0OSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:18:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37602 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0OSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:18:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so5870729wme.2;
        Thu, 27 Jun 2019 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJFhUv3FFI86NgZfIhT7YM85+S7+brFLKrng6/DKBFY=;
        b=k8KUZC0oV2wZ90NxHf7cJ7xBj6bE/MhH6EPsjYEz/IkPymiX6h2Cm4Dfue3Y9Yfx0S
         iQMtZiPqVdhEiSHCzHV8IDIDKazVSHe+YMBLsKc49HNiZnB031jvBgibbBHSoR7sM8EX
         PDmCjxY4brrvwch9MStB82V8iFo0zjdjs1mjGmxHXhQZvUzVte7vVm6EmxW5t9qdZdlC
         DZNbHR1guHmGFa5AATQcRHG5waDLh4FvMPhPWj9CF44M0A9JMD1CqKobV3uXejWPJW2F
         3NGNwl2QIFO7rLldx0SJSDYVwcYaGw/IA9lT/0SNiBYApQmpguGoeOhdyKJCYNT3HpjC
         Sx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJFhUv3FFI86NgZfIhT7YM85+S7+brFLKrng6/DKBFY=;
        b=h0pV2zgy9vK+cwmiyh0ER+zq38Dbaj/4YXOZkX452w2VPeM0y7ECgIhrE2C3DUru+u
         msUJ/gfx2PJmAFGzRJloHoP+oikfXlJfTDi3hTIXbvRWt5QwFh+ibw6SHGS5RKlt3fPd
         000SlKA+B0clcDJWxN6VvJevLGseOUNWt8x8+JbHpQDAQ0mqXpbdb9G0zCmKKA9MCNrx
         WSrj8FVSUhxL94YRQoLG44UwHVH9kkiGrTGv3ZzLx1g1FSSFT/5gkFQgDF+S9/bi38yL
         kWHM8C4/EEpBNF1as8fpbP1tP4JWgVk+MWNvGzTeh89773vNqXk+dCmWIdgs27fJMfVy
         GkZg==
X-Gm-Message-State: APjAAAXhiwBAERfs3ikPdMGSPPa6kfK9Gxt0xoBglJQN1KcaKG4LgiDR
        YjNZUbfmLFBlUyBO57vsiDtPQ/QKplfiO9ajEmQ=
X-Google-Smtp-Source: APXvYqz0paGYlQXryHjGXxF4De2tWeCa7C6LYTy7KQZzri/FXjtl9NaWYg9TI2kczqGuzlHEh86okL7OHxTPSjNgFEM=
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr3591515wme.67.1561645130899;
 Thu, 27 Jun 2019 07:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190626212212.25b41df4@canb.auug.org.au> <20190627133527.391ed0a1@canb.auug.org.au>
In-Reply-To: <20190627133527.391ed0a1@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Jun 2019 10:18:38 -0400
Message-ID: <CADnq5_MOb2Fg+S4igqUrtFrmd3xVHtaLZGc02nu-m=Jn-TVtBw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dave,
>
> On Wed, 26 Jun 2019 21:22:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Alex,
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > In file included from drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:25:
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: In function 'gfx_v10_0_cp_gfx_resume':
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: error: 'CP_RB1_CNTL__BUF_SWAP_MASK' undeclared (first use in this function); did you mean 'CP_RB_CNTL__BUF_SWAP_MASK'?
> >   tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
> >                            ^~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h:1067:36: note: in definition of macro 'REG_FIELD_MASK'
> >  #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
> >                                     ^~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macro 'REG_SET_FIELD'
> >   tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
> >         ^~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: note: each undeclared identifier is reported only once for each function it appears in
> >   tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
> >                            ^~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h:1067:36: note: in definition of macro 'REG_FIELD_MASK'
> >  #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
> >                                     ^~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macro 'REG_SET_FIELD'
> >   tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
> >         ^~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: error: 'CP_RB1_CNTL__BUF_SWAP__SHIFT' undeclared (first use in this function); did you mean 'CP_RB0_CNTL__BUF_SWAP__SHIFT'?
> >   tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
> >                            ^~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h:1066:37: note: in definition of macro 'REG_FIELD_SHIFT'
> >  #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
> >                                      ^~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macro 'REG_SET_FIELD'
> >   tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
> >         ^~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
> >
> > I have disabled that driver for today.  Please let me know when it is
> > fixed so that I can enable it again.
>
> I assume that this has now been inherited by the drm tree (since there
> has been no fix).  So the AMD_GPU driver will still be disabled in
> linux-next today as of the drm tree merge.

Fixed in this patch:
https://patchwork.freedesktop.org/patch/314527/?series=62866&rev=1

Alex

>
> --
> Cheers,
> Stephen Rothwell
