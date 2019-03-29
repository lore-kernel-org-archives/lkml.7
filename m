Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27643C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D36218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExtgvdXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfC2QtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:49:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37768 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbfC2QtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:49:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so2185710oif.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaOWiwaKjM/I8d+hQLjfmNO8tEmcYpcTncowB6z1DDU=;
        b=ExtgvdXsHJcSeieqJ7N5ScpYmu8tDtRSUQml9XKuZm8rsSnCFaeaoxQUt1flK8oCDU
         G62NJC6NGcgJr/TDkTiZyyKdDQhEpuI4QL9qd+NfZ3pzO6pCMO3/HF2Bm40dgZ2il7eD
         TEHVOjuw1v9iAYYds61GShDszbSD+CAvXmnXB/lOmRDCssvZeXD2+Sa2+SmdP21XCulv
         REWN1qGykUpTgDUfKbO+mCjyEZ0ZyPOyBdK0WfEuVbnOVSuCtOmVwOYiEK+Z9/xfMD79
         BNrn1p80jCSiqd5PlOuP2gLNcS7f159p2V8vx19RQ2G4SLuAG2zM3VhLADaly414MEbQ
         ZrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaOWiwaKjM/I8d+hQLjfmNO8tEmcYpcTncowB6z1DDU=;
        b=M+lnyLLpmp77dT3hx3xy7/Jh5xUHZ0Md2PSfqMHl13pKFZUH69/Z51sNn20naahwI9
         5IEdQ1DYnwJoQ3beyqly1f01QoREqVhBEibQ8+mmOX4wLgKEjDqKD19OtkP4krqb0K2I
         ED0Cv9Uwpi7TZpG1+4hams9gYP4ogTK3vRlJEE7Npb2vAY68adgPh7Suivnd8/WQOEbV
         NSn7YZTPIqukDncctZw3hLQUVvZe5qZ49myYajK/7/adzPnU1ic3FP11AxYy9mu25Zf0
         XL+Wr614Oy54imddUKSDPQewza4Du+F81XlbSZGl3xqCUroZ3XRAnLbmPZAhIoPhJwYJ
         papw==
X-Gm-Message-State: APjAAAVG9O3LqcaheuU6105RPdFj7wkxrdsE/cHV5Au4lo7Zjl4F06Yn
        9zXMyE2jI82S7+dKcfW75kkcGnVAKrEsvSdo0ZmGsQ==
X-Google-Smtp-Source: APXvYqxU7bcOjv9ajNYbpHtV3ISnmlb8/RTSuZVjTrExqHMDLoknIqr0iGfvnMI57lfwdiKnvSc07XwsIlN7n/alsJg=
X-Received: by 2002:aca:eb44:: with SMTP id j65mr1440087oih.0.1553878144628;
 Fri, 29 Mar 2019 09:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190328225925.241998-1-jannh@google.com> <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
In-Reply-To: <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 17:48:38 +0100
Message-ID: <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:19 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
> On 3/29/2019 4:29 AM, Jann Horn wrote:
> > The sparse checker attempts to ensure that all conversions between
> > fixed-endianness numbers and numbers with native endianness are explicit.
> > However, the calgary code reads and writes big-endian numbers from/to IO
> > memory using {read,write}{l,q}(), which return native-endian numbers.
> >
> > This could be addressed by putting __force casts all over the place, but
> > that would kind of defeat the point of the warning. Instead, create new
> > helpers {read,write}{l,q}_be() for big-endian IO that convert from/to
> > native endianness.
> >
> > Most of this patch is a straightforward conversion; the following parts
> > aren't just mechanical replacement:
> >
> >   - ->tar_val is now a native-endian number instead of big-endian
> >   - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when it
> >     intended to do `be32_to_cpu(readl(target))` (but that has no actual
> >     effects outside of type warnings)
> >
> > This gets rid of 108 lines of sparse warnings.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > compile-tested only
> >
> >   arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++-------------
> >   1 file changed, 64 insertions(+), 44 deletions(-)
> >
> > diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
> > index c70720f61a34..36cd66d940fb 100644
> > --- a/arch/x86/kernel/pci-calgary_64.c
> > +++ b/arch/x86/kernel/pci-calgary_64.c
> > @@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned short device)
> >       return (is_calgary(device) || is_calioc2(device));
> >   }
>
>
> Can the existing api's not be used here like iowrite64be/ioread64be/ or
> similar variant in "include/asm-generic/io.h"

Oooh! I didn't realize that those exist. I'll change that and send a v2.
