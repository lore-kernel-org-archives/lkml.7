Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB64CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE605218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJZCNu6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfCUKJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:09:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36040 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfCUKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:09:50 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so4746509iop.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJw0AWsREoUidqsPbHFR+gycD5v2DnubcKl2jsLBetg=;
        b=JJZCNu6pvABSVmqz+YlXS0NnzdUB5oxTqSi+8o949MflIQ1/p1eX9BPB7Zro53O05C
         bO55MH/9mOENQVVt4r7inL0j2BWCQUWkvqTCf7GSRnkRZIF/wdOpiP5PYfgA05jXairU
         4qYBDJ6v1fdYroBXzZOA7HHOl5voCutH+eFLL27kFWsN9Li2ZEKyXdotJFNpAJFCf2Qp
         fsdGXSCftoWc1aGY8vaw8rn7zGsFarSAA+SbqOXRm51N5CIhR/aeDOWEOfQMOwU6SC0G
         FGWl59RiriXwZsFp4xgu3aslZkKesk/kCjKWoRWVjO/3YBm/MnoKWmcezCfaNpupTHm9
         uKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJw0AWsREoUidqsPbHFR+gycD5v2DnubcKl2jsLBetg=;
        b=S5y97qw+zEBeXZ93ibOfiPRM/sA8q9mQEU5YHnCny6m1XSrGD+Qs3IoQL63wsUGT/C
         FOqJdS+aOrrB0eGgBDo56EhTuLg49r6ZkVLlPz8njyOVV3ZXyZVKkWXY3ymVqN7cUThh
         fYm8SjYCyZY+0rB9K0Y1SZOuxs4UDEOXceAxAQ7Qzbm36+gxSJ3VkIJaIyEy7DJP4ap8
         4ZES/ZtbGosOoKgvTuZr16esaGDeroxcrnVboBijtfLu69zHaF6e6eqRXUXZ9d06T2dt
         gH3HnGyBUm2At2jkfPYDDKHM2XCHEW3kxDWJ3HVjEB/ObbmhwyDOfpr+BltNFOGZjga8
         63wA==
X-Gm-Message-State: APjAAAVbFIypCoE6JNfJnXiagxoG3/pR2yNC9XblKpnAvc9l1aMceeek
        UcvKUqDvfHe16sDZvEpLX3RcDoqkLfA0JcrP4xWj/A==
X-Google-Smtp-Source: APXvYqwT4xvLIqZbHbB7NQ28BxVZXpAXHqjV7tNZvfZxCDxXaf9/ipxPckDyviW99YE/0v77hqVG8LcXXtu2wnng6xM=
X-Received: by 2002:a5e:8418:: with SMTP id h24mr1974711ioj.170.1553162989412;
 Thu, 21 Mar 2019 03:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190320130502.16667-1-rrichter@marvell.com> <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain> <CAKv+Gu8HKUQPr7TaUm7EwdVFasUitAPBJFotpG43nNAKMBvxdA@mail.gmail.com>
 <20190321093920.beng2d3tbfvydbud@rric.localdomain> <CAKv+Gu899a5FpMqOzF5EVgsHRk37_PBxW8kVicgc8ST3=R_VUA@mail.gmail.com>
 <20190321100819.ok3uuojjvegjjlpg@rric.localdomain>
In-Reply-To: <20190321100819.ok3uuojjvegjjlpg@rric.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 21 Mar 2019 11:09:38 +0100
Message-ID: <CAKv+Gu9WwgYiiGp4sZOndD8znPxtg5g-qrSAvx9=zHm5x5ikSw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
To:     Robert Richter <rrichter@marvell.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 at 11:08, Robert Richter <rrichter@marvell.com> wrote:
>
> On 21.03.19 10:51:34, Ard Biesheuvel wrote:
> > On Thu, 21 Mar 2019 at 10:39, Robert Richter <rrichter@marvell.com> wrote:
> > >
> > > On 20.03.19 23:02:09, Ard Biesheuvel wrote:
> > > > On Wed, 20 Mar 2019 at 16:23, Robert Richter <rrichter@marvell.com> wrote:
> > > > >
> > > > > On 20.03.19 14:16:07, Robert Richter wrote:
> > > > > > On 20.03.19 13:05:37, Robert Richter wrote:
> > > > > > > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> > > > > > >      * itself, depends on dmi_scan_machine() having been called already.
> > > > > > >      */
> > > > > > >     dmi_scan_machine();
> > > > > > > +   dmi_memdev_walk();
> > > > > > >     if (dmi_available)
> > > > > > >             dmi_set_dump_stack_arch_desc();
> > > > > > >     return 0;
> > > > > >
> > > > > > After
> > > > > >
> > > > > >  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
> > > > > >   ghes error logs
> > > > > >
> > > > > > wents in for arm/arm64, we can unify the code. See patch below.
> > > > >
> > > > > V2 with the fix in arm_dmi_init() below.
> > > > >
> > > > > -Robert
> > > > >
> > > > >
> > > > > -- >8 --
> > > > > From: Robert Richter <rrichter@marvell.com>
> > > > > Subject: [PATCH v2] efi: Unify dmi setup code over architectures arm/arm64,
> > > > >  io64 and x86
> > > > >
> > > > > All architectures (arm/arm64, io64 and x86) do the same here, so unify
> > > > > the code.
> > > > >
> > > > > Note: We do not need to call dump_stack_set_arch_desc() in case of
> > > > > !dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
> > > > > desc_str are initialized zero and thus nothing would change.
> > > > >
> > > >
> > > > I don't understand the last sentence - we do not need to call
> > > > dump_stack_set_arch_desc() when !dmi_available, but we do so anyway,
> > > > right? Doesn't that wipe the arch description we set based on the DT
> > > > machine name?
> > >
> > > No, in dmi_setup() we exit early when !dmi_available. So for arm/arm64
> > > nothing changed. But for x86 and ia64 we no longer call dump_stack_
> > > set_arch_desc() in this case. This is ok since both strings,
> > > dmi_ids_string and dump_stack_arch_desc_str, are initialized zero and
> > > copying one to the other does not change anything.
> > >
> >
> > Ah, of course. Apologies for not reading more carefully.
> >
> > I'll take this patch via the EFI tree.
> >
> > It seems to me though that the previous patch makes the memdev_walk()
> > call unconditional for ARM, and this change subsequently makes it
> > dependent on dmi_available. Should we fix that?
>
> The first patch has the check in memdev_walk(). So that is looking
> good. The check is then moved to dmi_setup() in the 2nd patch.
>

OK, that works for me.

> Thanks for handling this.
>

Thanks for the contribution.
