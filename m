Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB52133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lrv4gijf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDIQoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:44:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43722 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDIQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:44:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so14116865oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ilyq20E19xyV6UbqdWCXc0MKpHCaUfLCj4Un3Tvmso=;
        b=lrv4gijfp8inONCmOta0cZT+rOaqS46kzXxlD7fVm7Dvpf3Yx9BV0vl2saWGilF59Z
         r0JIhV5mKblMk253QdWZYY1tiYj9SMAos6c6FUEEBPBglPmO0bCC/uEl5KDqNr0n9Tgo
         sV9UMZJF9vyRAytOkUGR7XHrfK86Zj5wu6poTg/wItdEzgt2FNAcvZE2xp+WHid1XbKT
         GZYGnWNVNJCvu54jNART4HCe1FWdzhX/+vtUMDqTY12S11FfOjDOjbOc4//48c+iYRmM
         ++Cade6kftVkQ27c80QU3ExuwRPVBr3cVH1UrjunaNBJ56uvCaAxV2ItyXyyVRmRKLXI
         Q9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ilyq20E19xyV6UbqdWCXc0MKpHCaUfLCj4Un3Tvmso=;
        b=DhyCAwhrX6pda6R3eIH3SY7BTTu0XFY0nUUne6JwOlUXN+9WwOVbg9u/kFd2+NkRLa
         1U3IZIU+yYrsZ18emkZHcsHNb7yJyHYKB0HXMXdef12UGZW2LETeFMiiR96Z5s3JytLD
         pr5O11USNg57CTA+14K/E6ZyJWOqKBtZH3miK7+/ZbiRBdspqZxnicWWulg+mn3whgxn
         qPp+DaytDPaxojr4zjyEnSaMO9BtjTJe5S9b/tIAFAsfEZo+TJZN6QZATvWUzzXMFeJv
         tJ8PG7PLeYrLbJkAiowi1uD6ZqR7VTlUC27GUqNeTjDRPJ/85+kfYoDCY/8QSwN4r3mF
         nMPQ==
X-Gm-Message-State: APjAAAXG4rX/vAn1lpDuH2eznSm1dkSioW1oW2MQrWFmuzxJXY3PxT2W
        fB7iyqfgqhV2YFJPrlK3K78lKUxSBxD0SzMgQp8vFg==
X-Google-Smtp-Source: APXvYqxR0l4hgJwOIl2t0dh8FgfnBaGJLiSOysar/muEp50KkXSwWDL6A2Yd+RJSIG/AneDrjksKy2ozyrO6fMV7pNo=
X-Received: by 2002:aca:f581:: with SMTP id t123mr21730459oih.0.1554828242538;
 Tue, 09 Apr 2019 09:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491334.3190322.44013027330479237.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ocQGxTAapfjb5WufhL=Qj54LythHcPHsyy+wUnVBnfA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ocQGxTAapfjb5WufhL=Qj54LythHcPHsyy+wUnVBnfA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Apr 2019 09:43:50 -0700
Message-ID: <CAPcyv4gUL8j+EaAZ556_NKXLgva++HgPBOeeAUNHN+DAWaewaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] efi: Detect UEFI 2.8 Special Purpose Memory
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:21 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Hi Dan,
>
> On Thu, 4 Apr 2019 at 21:21, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > interpretation of the EFI Memory Types as "reserved for a special
> > purpose".
> >
> > The proposed Linux behavior for special purpose memory is that it is
> > reserved for direct-access (device-dax) by default and not available for
> > any kernel usage, not even as an OOM fallback. Later, through udev
> > scripts or another init mechanism, these device-dax claimed ranges can
> > be reconfigured and hot-added to the available System-RAM with a unique
> > node identifier.
> >
> > A follow-on patch integrates parsing of the ACPI HMAT to identify the
> > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > now, arrange for EFI_MEMORY_SP memory to be reserved.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/Kconfig                  |   18 ++++++++++++++++++
> >  arch/x86/boot/compressed/eboot.c  |    5 ++++-
> >  arch/x86/boot/compressed/kaslr.c  |    2 +-
> >  arch/x86/include/asm/e820/types.h |    9 +++++++++
> >  arch/x86/kernel/e820.c            |    9 +++++++--
> >  arch/x86/platform/efi/efi.c       |   10 +++++++++-
> >  include/linux/efi.h               |   14 ++++++++++++++
> >  include/linux/ioport.h            |    1 +
> >  8 files changed, 63 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index c1f9b3cf437c..cb9ca27de7a5 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1961,6 +1961,24 @@ config EFI_MIXED
> >
> >            If unsure, say N.
> >
> > +config EFI_SPECIAL_MEMORY
> > +       bool "EFI Special Purpose Memory Support"
> > +       depends on EFI
> > +       ---help---
> > +         On systems that have mixed performance classes of memory EFI
> > +         may indicate special purpose memory with an attribute (See
> > +         EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
> > +         attribute may have unique performance characteristics compared
> > +         to the system's general purpose "System RAM" pool. On the
> > +         expectation that such memory has application specific usage
> > +         answer Y to arrange for the kernel to reserve it for
> > +         direct-access (device-dax) by default. The memory range can
> > +         later be optionally assigned to the page allocator by system
> > +         administrator policy. Say N to have the kernel treat this
> > +         memory as general purpose by default.
> > +
> > +         If unsure, say Y.
> > +
>
> EFI_MEMORY_SP is now part of the UEFI spec proper, so it does not make
> sense to make any understanding of it Kconfigurable.

No, I think you're misunderstanding what this Kconfig option is trying
to achieve.

The configuration capability is solely for the default kernel policy.
As can already be seen by Christoph's response [1] the thought that
the firmware gets more leeway to dictate to Linux memory policy may be
objectionable.

[1]: https://lore.kernel.org/lkml/20190409121318.GA16955@infradead.org/

So the Kconfig option is gating whether the kernel simply ignores the
attribute and gives it to the page allocator by default. Anything
fancier, like sub-dividing how much is OS managed vs device-dax
accessed requires the OS to reserve it all from the page-allocator by
default until userspace policy can be applied.

> Instead, what I would prefer is to implement support for EFI_MEMORY_SP
> unconditionally (including the ability to identify it in the debug
> dump of the memory map etc), in a way that all architectures can use
> it. Then, I think we should never treat it as ordinary memory and make
> it the firmware's problem not to use the EFI_MEMORY_SP attribute in
> cases where it results in undesired behavior in the OS.

No, a policy of "never treat it as ordinary memory" confuses the base
intent of the attribute which is an optional hint to get the OS to not
put immovable / non-critical allocations in what could be a precious
resource.

Moreover, the interface for platform firmware to indicate that a
memory range should never be treated as ordinary memory is simply the
existing "reserved" memory type, not this attribute. That's the
mechanism to use when platform firmware knows that a driver is needed
for a given mmio resource.

> Also, sInce there is a generic component and a x86 component, can you
> please split those up?

Sure, can do.

>
> You only cc'ed me on patch #1 this time, but could you please cc me on
> the entire series for v2? Thanks.

Yes, will do, and thanks for taking a look.
