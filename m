Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DC724C38
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfFCONK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:13:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33563 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfFCONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:13:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so12301534wrx.0;
        Mon, 03 Jun 2019 07:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2DuwGRXCzN1db5gv+o4JjQrckmHVPeHDhxTCJpaz8A=;
        b=slnWtIzOLzetY2YSYSkDTXcQq/0vDclrroenZ2+Ub32bJnhMud0BdePZ4juHVaiR46
         6nb3rNDaEL+lsDjtL91BThlz5sudGoYmb8kyfo/GgV8ywDIsVxOYRUxQXjZC6Y1Pc35h
         Ec6OxBNy5dARePNXpbR/BQe8/Tkkgz2WfisowptFayoJazNRQTS5YXY/n8IgPeR+GpgS
         21zmVPQStbMYM+Z7W8dn1UjSjW94bOJ+M4D727yzafXRSq0DsyHgDMsziwnQ0qhkUhZF
         39Ptun2FQfKNzsEk3IY+FtkIX86wx5iu4IpK0XyRgGVS18l1eLTqMxhYlZlOohOT7ovF
         UF4A==
X-Gm-Message-State: APjAAAVmSn4B5RynxGNzw+u13uIH4I55DDlIE2gWqHrztqB7HBfOowKM
        I8o9HS1CEAduPf6Jbu88dW3bkDdCVEA640Ltrug=
X-Google-Smtp-Source: APXvYqwSiyj9I4TnvWT5Kk/YYC8ZZsvfzpe4pBWbLs2uh4221Wy+kvVBqdEEPMlCNuHKUYB1/KqrHRsoTcDqqS6+yKA=
X-Received: by 2002:adf:e691:: with SMTP id r17mr2873207wrm.67.1559571187782;
 Mon, 03 Jun 2019 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
 <20190603135939.e2mb7vkxp64qairr@pc636>
In-Reply-To: <20190603135939.e2mb7vkxp64qairr@pc636>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Mon, 3 Jun 2019 15:12:55 +0100
Message-ID: <CAPKp9uauCeYi-ArurSHytpBR4_XXJX6jfG2RqoMo0dpNGyTb5w@mail.gmail.com>
Subject: Re: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 3, 2019 at 3:02 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Krzysztof.
>
> On Mon, Jun 03, 2019 at 11:07:46AM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > On recent next I see bugs during boot (after bringing up user-space or
> > during reboot):
> > kernel BUG at ../mm/vmalloc.c:470!

I was about to report the same and saw this thread.

> > On all my boards. On QEMU I see something similar, although the
> > message is "Internal error: Oops - undefined instruction: 0 [#1] ARM",
> >
> > The calltrace is:
> > [   34.565126] [<c0275c9c>] (__free_vmap_area) from [<c0276044>]
> > (__purge_vmap_area_lazy+0xd0/0x170)
> > [   34.573963] [<c0276044>] (__purge_vmap_area_lazy) from [<c0276d50>]
> > (_vm_unmap_aliases+0x1fc/0x244)
> > [   34.582974] [<c0276d50>] (_vm_unmap_aliases) from [<c0279500>]
> > (__vunmap+0x170/0x200)
> > [   34.590770] [<c0279500>] (__vunmap) from [<c01d5a70>]
> > (do_free_init+0x40/0x5c)
> > [   34.597955] [<c01d5a70>] (do_free_init) from [<c01478f4>]
> > (process_one_work+0x228/0x810)
> > [   34.606018] [<c01478f4>] (process_one_work) from [<c0147f0c>]
> > (worker_thread+0x30/0x570)
> > [   34.614077] [<c0147f0c>] (worker_thread) from [<c014e8b4>]
> > (kthread+0x134/0x164)
> > [   34.621438] [<c014e8b4>] (kthread) from [<c01010b4>]
> > (ret_from_fork+0x14/0x20)
> >
> > Full log here:
> > https://krzk.eu/#/builders/1/builds/3356/steps/14/logs/serial0
> > https://krzk.eu/#/builders/22/builds/1118/steps/35/logs/serial0
> >
> > Bisect pointed to:
> > 728e0fbf263e3ed359c10cb13623390564102881 is the first bad commit
> > commit 728e0fbf263e3ed359c10cb13623390564102881
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Sat Jun 1 12:20:19 2019 +1000
> >     mm/vmalloc.c: get rid of one single unlink_va() when merge
> >
> I have checked the linux-next. I can confirm it happens because of:
>  mm/vmalloc.c: get rid of one single unlink_va() when merge
>
> The problem is that, it has been applied wrongly into linux-next tree
> for some reason, i do not why. Probably due to the fact that i based
> my work on 5.1/2-rcX, whereas linux-next is a bit ahead of it. If so,
> sorry for that.
>
> See below the clean patch for remotes/linux-next/master:
>

This patch fixes the issue and resumes booting on my platform.

--
Regards,
Sudeep
