Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96D220851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKetQsyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfCADT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:19:27 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37483 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCADT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:19:27 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so19283958itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHca5tTZi2E0JqjIPlb4MJ/8nRUQ1/7scXPzMTiSAV0=;
        b=GKetQsyDzRqUNPmAt822eTLcyXYX27MKkPexbmAQ5fJClK9RpoYLW2zOCSVLvxPg5R
         aFZmO+kHK2P19fN7WaDZV9xZGxJ3BMkLXV8IVWwpuDGSqu2bnabcF2Ua4g3dPN71P+gi
         0m1J9jfauPiZFrX9LGXUf/xy+++ENlzGB8oIH925IG2FSILvkVT/jrPxD6vQvmlrxvFz
         SIopVF4KCzdmN16Yme0fzjZdJ4K2xpwmnwS4hOvr21VkaZhQmQyo6+My4JzYz822i3yu
         1Nt52v+POpcQfTvlGprmRaR109C7NMIBhTbRt/TbxHXUzilcZJ7D/puypKSnRU7+5/+T
         zU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHca5tTZi2E0JqjIPlb4MJ/8nRUQ1/7scXPzMTiSAV0=;
        b=BvCgO97741iYG/DBNOwrE/OMgbSjlnB2IdKNpY2+6sKnqArIZ5+NJwulqQWx9NHUhe
         FYXHORVHh5VGZvajvmQq+GXgRD77MukhoX/b5WzlUCt/qDT8Zpw3ImOGwM6FVzi8UAFI
         2PVnZVFVpkgLTDEPynS2R9Ny758D4nC4BXQgeQHI8UfLqYOJoOMUg07XofXUgeX/fu5A
         k3fQqVrFYAJRjoHEn9aSwQDtkSE28HOanbp7vHPIc2urwaXWfBx/uY9br6OQmKqi/cPf
         7OQEab5DMlPlL1ydJib9p0fhCAdv1ds8zrsBledRbq/ZoLzW3lSHCwXVAthJ9Qm68NHX
         o3Yw==
X-Gm-Message-State: APjAAAUVgcdJGa5FPkGNnUjM807ASbr4WYRhjNt6jzBIOMqMMVX1xBsv
        5OVsTUMZjz56lDZZwvKQwHoBanW18XtEn9Qv6g==
X-Google-Smtp-Source: APXvYqyutcQDnkPEmjHHeJoRjoR4dKY5s94fOsaWwEQuowlp0qFWvOnA05OlIBeHKLYjOP8LvWEvKQbMbCAHGghGLhk=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr2007311itk.173.1551410366254;
 Thu, 28 Feb 2019 19:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20190215102458.GD10433@zn.tnic> <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic> <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic> <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de> <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
 <20190225113003.GE26145@zn.tnic> <CAFgQCTvP-YDUEcHTgupr+ar+qeoj5rw1y8k+6kzrzHPzTqBkaw@mail.gmail.com>
In-Reply-To: <CAFgQCTvP-YDUEcHTgupr+ar+qeoj5rw1y8k+6kzrzHPzTqBkaw@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 1 Mar 2019 11:19:15 +0800
Message-ID: <CAFgQCTs9pJ=3Jt1YLv6RmBWeViH8cmuMcKG+2Aj-Vo2Kh-Wcog@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 11:04 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Hi Borislav,
>
> Do you think the following patch is good at present?
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 81f9d23..9213073 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -460,7 +460,7 @@ static void __init
> memblock_x86_reserve_range_setup_data(void)
>  # define CRASH_ADDR_LOW_MAX    (512 << 20)
>  # define CRASH_ADDR_HIGH_MAX   (512 << 20)
>  #else
> -# define CRASH_ADDR_LOW_MAX    (896UL << 20)
> +# define CRASH_ADDR_LOW_MAX    (1 << 32)
>  # define CRASH_ADDR_HIGH_MAX   MAXMEM
>  #endif
>
Or patch lools like:
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..ed0def5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -459,7 +459,7 @@ static void __init
memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_LOW_MAX    (512 << 20)
 # define CRASH_ADDR_HIGH_MAX   (512 << 20)
 #else
-# define CRASH_ADDR_LOW_MAX    (896UL << 20)
+# define CRASH_ADDR_LOW_MAX    (1 << 32)
 # define CRASH_ADDR_HIGH_MAX   MAXMEM
 #endif

@@ -551,6 +551,15 @@ static void __init reserve_crashkernel(void)
                                                    high ? CRASH_ADDR_HIGH_MAX
                                                         : CRASH_ADDR_LOW_MAX,
                                                    crash_size, CRASH_ALIGN);
+#ifdef CONFIG_X86_64
+               /*
+                * crashkernel=X reserve below 4G fails? Try MAXMEM
+                */
+               if (!high && !crash_base)
+                       crash_base = memblock_find_in_range(CRASH_ALIGN,
+                                               CRASH_ADDR_HIGH_MAX,
+                                               crash_size, CRASH_ALIGN);
+#endif

which tries 0-4G, the fall back to 4G above

> For documentation, I will send another patch to improve the description.
>
> Thanks,
> Pingfan
>
> On Mon, Feb 25, 2019 at 7:30 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Feb 25, 2019 at 07:12:16PM +0800, Dave Young wrote:
> > > If we move to high as default, it will allocate 160M high + 256M low. It
> >
> > We won't move to high by default - we will *fall* back to high if the
> > default allocation fails.
> >
> > > To make the process less fragile maybe we can remove the 896M limitation
> > > and only try <4G then go to high.
> >
> > Sure, the more robust for the user, the better.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > Good mailing practices for 400: avoid top-posting and trim the reply.
