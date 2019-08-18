Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A6C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6720851
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 07:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4os+5u3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfHRHrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 03:47:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45138 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 03:47:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so8522580eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i8dYHRhjyQq56TtntndePfnzxoMqtxxO44HUTYu3/I=;
        b=A4os+5u3AY9vy+3QQo6CEH4KDIVd4rEY00yVYB+1nr3SPCydBTHH0NOAOGDCZTwXoP
         dWGdwe5366Lr2S9fz2ZmeWNVYUC2YwIKV2bgX+BRfY+phiLBKAvPs/H/h45jDmL4CdGQ
         CteNzyH9QlemetYkgT9DeRfjDBH5U2LOUQIFhYjilIYw90x6pb1Rsu/2kRF9ZijBoo5B
         8PWMwAOCDouoYs5TJHkVyJ0UqCQclg/bmcNadOReHzElgAnejEfXBij+QydXCVlKryu6
         YTh8+9xgFIsSJTVT0rDxOec55sC5eyTtbR2z+YXabdtEdV4QEioEZNioH3vCjWqmfRKO
         dNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i8dYHRhjyQq56TtntndePfnzxoMqtxxO44HUTYu3/I=;
        b=R8xSWUmtCF8v4+t7iTGGITmxqCNfCYPIg6nAsE9cqCorqUBPeUtjfNESCdVmH2Eb/6
         a5FMxzW7rf1O1TPfe25/jQZ8YrggqaqdW8Xp2ke90acYB65F6QXJw81+mbzltcPLLnpY
         A7EKg3Ittp+gspVrYA4p6kmk8ZfCeHF2H89vhA7P+vw1f9v2FUpH+R44eHIHeytug3nO
         /2aZEmEjxhNy2zBxRKW2Ia/WA/5UO2SVmjbjOG3VcUnqOVyCZtVWPwnMXjPHDdxkGPGf
         T7cuY+6VbeKxE+gQnR6sIAAAQdISymZylc4+FmwXKRqK2DKcdgImbvA+57EC48S7btEA
         pCcA==
X-Gm-Message-State: APjAAAW5ExfzTeonkOsldk3z7bO31aFCqjnllE3df+MVASTcz4Sd90mE
        t5pYocyEShAzgzeOAq1R2WYQUAnNeISZ5sDiP6E=
X-Google-Smtp-Source: APXvYqz1mUZECTJrsCX8TbM4B5MfF4HYsBDtV4p4ZNqdgilx7DGF6UwwN+cffa9ljLeQJ/iS6MkNUUMRvRqMIdwbhx4=
X-Received: by 2002:aa7:d94f:: with SMTP id l15mr19034091eds.299.1566114422571;
 Sun, 18 Aug 2019 00:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <1566010813-27219-1-git-send-email-huangzhaoyang@gmail.com> <20190817183240.GM13294@shell.armlinux.org.uk>
In-Reply-To: <20190817183240.GM13294@shell.armlinux.org.uk>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 18 Aug 2019 15:46:51 +0800
Message-ID: <CAGWkznEvHE6B+eLnCn=s8Hgm3FFbbXcEdj_OxCM4NOj0u61FGA@mail.gmail.com>
Subject: Re: [PATCH] arch : arm : add a criteria for pfn_valid
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 2:32 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, Aug 17, 2019 at 11:00:13AM +0800, Zhaoyang Huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > pfn_valid can be wrong while the MSB of physical address be trimed as pfn
> > larger than the max_pfn.
>
> What scenario are you addressing here?  At a guess, you're addressing
> the non-LPAE case with PFNs that correspond with >= 4GiB of memory?
Please find bellowing for the callstack caused by this defect. The
original reason is a invalid PFN passed from userspace which will
introduce a invalid page within stable_page_flags and then kernel
panic.

[46886.723249] c7 [<c031ff98>] (stable_page_flags) from [<c03203f8>]
(kpageflags_read+0x90/0x11c)
[46886.723256] c7  r9:c101ce04 r8:c2d0bf70 r7:c2d0bf70 r6:1fbb10fb
r5:a8686f08 r4:a8686f08
[46886.723264] c7 [<c0320368>] (kpageflags_read) from [<c0312030>]
(proc_reg_read+0x80/0x94)
[46886.723270] c7  r10:000000b4 r9:00000008 r8:c2d0bf70 r7:00000000
r6:00000001 r5:ed8e7240
[46886.723272] c7  r4:00000000
[46886.723280] c7 [<c0311fb0>] (proc_reg_read) from [<c02a6e6c>]
(__vfs_read+0x48/0x150)
[46886.723284] c7  r7:c2d0bf70 r6:c0f09208 r5:c0a4f940 r4:c40326c0
[46886.723290] c7 [<c02a6e24>] (__vfs_read) from [<c02a7018>]
(vfs_read+0xa4/0x158)
[46886.723296] c7  r9:a8686f08 r8:00000008 r7:c2d0bf70 r6:a8686f08
r5:c40326c0 r4:00000008
[46886.723301] c7 [<c02a6f74>] (vfs_read) from [<c02a778c>]
(SyS_pread64+0x80/0xb8)
[46886.723306] c7  r8:00000008 r7:c0f09208 r6:c40326c0 r5:c40326c0 r4:fdd887d8
[46886.723315] c7 [<c02a770c>] (SyS_pread64) from [<c0108620>]
(ret_fast_syscall+0x0/0x28)

>
> >
> > Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
> > ---
> >  arch/arm/mm/init.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index c2daabb..9c4d938 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -177,7 +177,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
> >  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> >  int pfn_valid(unsigned long pfn)
> >  {
> > -     return memblock_is_map_memory(__pfn_to_phys(pfn));
> > +     return (pfn > max_pfn) ?
> > +             false : memblock_is_map_memory(__pfn_to_phys(pfn));
> >  }
> >  EXPORT_SYMBOL(pfn_valid);
> >  #endif
> > --
> > 1.9.1
> >
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
