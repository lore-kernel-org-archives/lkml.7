Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB6C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01102214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8TwZ8Y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDIRV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:21:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33751 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:21:27 -0400
Received: by mail-io1-f66.google.com with SMTP id b6so15037201iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6IMmvUGAf0eU7ybuIU2/HaCzcsJS2xP8y2lDsQdA+Q=;
        b=n8TwZ8Y4dkVFIf5Ga9lJ0UgTfR5Y0ndWTH6s5OFXVC/BCID9/HQTCSm9lntPxdoygX
         R7/8demt44uRRlKoPLTj1yJ4CvgZYkuxsTx8YUS69ABnt6CWMwfsgogDHgdOMJGBV4MO
         VxfgKMNtYlZskbkr/KEUMhRtW9YFnrs1pJQYR1mFMASW92+j7XwNNFTAqGvRAFncWyWv
         1TAgjgAUzPnwe4yxuQClZmFi4kZoj47wgUqf0r/ZNrBYGngfF6VJmuN+brOg+yMNbzX+
         lA3p6Ftexl8h/ID7vW71A7kMktvD6yn6RuLEzi8iKJMclbPZhJZ6Y9cO4bhmOX2Rxsl6
         Fs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6IMmvUGAf0eU7ybuIU2/HaCzcsJS2xP8y2lDsQdA+Q=;
        b=UQjdPNLpnxX1JVIPjztq/0AvGJWYpJwrsDGE1XxtdM29lGI0FiTSuHFtEWUlaZGxHA
         lZ9c+Zr9wVD0jWxucxOP0Cd8yivmZR7wNLw7XAd3I9Wy3BawsU2/2YDYvxVtVHNOdfxl
         6TcPoJ59G6olvUjbfKrg9egGziWIpezKthXH+wveBqvEIhswVdI8vxaWKSFmo8VUG8AC
         Dxkd6bjm3rSD1Sb0hRNxR4A5r4TiAnjuy3Awg847EVPcbckZK4YnowfjeIqDouD+FgZc
         xukO0eIf5+0PoqISZvajI7UgHE1ck9tnrh0tLIKb0T8cTF7VkrPyPPJjdv7bB9fU0ka1
         VU/A==
X-Gm-Message-State: APjAAAWQd62I9jIvGEEd3/rben+PvG1qu8mXPZG3qz1u0xRyiky0nmvf
        6stCrUfMJec/9h5LJnGw6KNNr8U0kN+7bCs8gSSmH0AFsAfzHQ==
X-Google-Smtp-Source: APXvYqxRsQgJ7iWwhmBjfzIPC2n1Qwhw8ACmeQ1P+wDbglv1OxwRhUJUcTv/D0+XW4kxsArobKWOT0j4U1rxxgiZOWc=
X-Received: by 2002:a6b:f201:: with SMTP id q1mr18287829ioh.197.1554830485879;
 Tue, 09 Apr 2019 10:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491334.3190322.44013027330479237.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ocQGxTAapfjb5WufhL=Qj54LythHcPHsyy+wUnVBnfA@mail.gmail.com> <CAPcyv4gUL8j+EaAZ556_NKXLgva++HgPBOeeAUNHN+DAWaewaQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gUL8j+EaAZ556_NKXLgva++HgPBOeeAUNHN+DAWaewaQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 9 Apr 2019 10:21:14 -0700
Message-ID: <CAKv+Gu_M-V-3ahHTj10iyx=eC2pBzFg027NmdBX1x7nXrpqK7g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] efi: Detect UEFI 2.8 Special Purpose Memory
To:     Dan Williams <dan.j.williams@intel.com>
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

On Tue, 9 Apr 2019 at 09:44, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Apr 5, 2019 at 9:21 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > Hi Dan,
> >
> > On Thu, 4 Apr 2019 at 21:21, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > > interpretation of the EFI Memory Types as "reserved for a special
> > > purpose".
> > >
> > > The proposed Linux behavior for special purpose memory is that it is
> > > reserved for direct-access (device-dax) by default and not available for
> > > any kernel usage, not even as an OOM fallback. Later, through udev
> > > scripts or another init mechanism, these device-dax claimed ranges can
> > > be reconfigured and hot-added to the available System-RAM with a unique
> > > node identifier.
> > >
> > > A follow-on patch integrates parsing of the ACPI HMAT to identify the
> > > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > > now, arrange for EFI_MEMORY_SP memory to be reserved.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Cc: Darren Hart <dvhart@infradead.org>
> > > Cc: Andy Shevchenko <andy@infradead.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  arch/x86/Kconfig                  |   18 ++++++++++++++++++
> > >  arch/x86/boot/compressed/eboot.c  |    5 ++++-
> > >  arch/x86/boot/compressed/kaslr.c  |    2 +-
> > >  arch/x86/include/asm/e820/types.h |    9 +++++++++
> > >  arch/x86/kernel/e820.c            |    9 +++++++--
> > >  arch/x86/platform/efi/efi.c       |   10 +++++++++-
> > >  include/linux/efi.h               |   14 ++++++++++++++
> > >  include/linux/ioport.h            |    1 +
> > >  8 files changed, 63 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index c1f9b3cf437c..cb9ca27de7a5 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -1961,6 +1961,24 @@ config EFI_MIXED
> > >
> > >            If unsure, say N.
> > >
> > > +config EFI_SPECIAL_MEMORY
> > > +       bool "EFI Special Purpose Memory Support"
> > > +       depends on EFI
> > > +       ---help---
> > > +         On systems that have mixed performance classes of memory EFI
> > > +         may indicate special purpose memory with an attribute (See
> > > +         EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
> > > +         attribute may have unique performance characteristics compared
> > > +         to the system's general purpose "System RAM" pool. On the
> > > +         expectation that such memory has application specific usage
> > > +         answer Y to arrange for the kernel to reserve it for
> > > +         direct-access (device-dax) by default. The memory range can
> > > +         later be optionally assigned to the page allocator by system
> > > +         administrator policy. Say N to have the kernel treat this
> > > +         memory as general purpose by default.
> > > +
> > > +         If unsure, say Y.
> > > +
> >
> > EFI_MEMORY_SP is now part of the UEFI spec proper, so it does not make
> > sense to make any understanding of it Kconfigurable.
>
> No, I think you're misunderstanding what this Kconfig option is trying
> to achieve.
>
> The configuration capability is solely for the default kernel policy.
> As can already be seen by Christoph's response [1] the thought that
> the firmware gets more leeway to dictate to Linux memory policy may be
> objectionable.
>
> [1]: https://lore.kernel.org/lkml/20190409121318.GA16955@infradead.org/
>
> So the Kconfig option is gating whether the kernel simply ignores the
> attribute and gives it to the page allocator by default. Anything
> fancier, like sub-dividing how much is OS managed vs device-dax
> accessed requires the OS to reserve it all from the page-allocator by
> default until userspace policy can be applied.
>

I don't think this policy should dictate whether we pretend that the
attribute doesn't exist in the first place. We should just wire up the
bit fully, and only apply this policy at the very end.

> > Instead, what I would prefer is to implement support for EFI_MEMORY_SP
> > unconditionally (including the ability to identify it in the debug
> > dump of the memory map etc), in a way that all architectures can use
> > it. Then, I think we should never treat it as ordinary memory and make
> > it the firmware's problem not to use the EFI_MEMORY_SP attribute in
> > cases where it results in undesired behavior in the OS.
>
> No, a policy of "never treat it as ordinary memory" confuses the base
> intent of the attribute which is an optional hint to get the OS to not
> put immovable / non-critical allocations in what could be a precious
> resource.
>

The base intent is to prevent the OS from using memory that is
co-located with an accelerator for any purpose other than what the
accelerator needs it for. Having a Kconfigurable policy that may be
disabled kind of misses the point IMO. I think 'optional hint' doesn't
quite capture the intent.

> Moreover, the interface for platform firmware to indicate that a
> memory range should never be treated as ordinary memory is simply the
> existing "reserved" memory type, not this attribute. That's the
> mechanism to use when platform firmware knows that a driver is needed
> for a given mmio resource.
>

Reserved memory is memory that simply should never touched at all by
the OS, and on ARM, we take care never to map it anywhere. However, it
could be annotated with the EFI_MEMORY_RUNTIME attribute in order for
the OS to provide a virtual mapping for it on behalf of the runtime
services, which is why it needs to be listed in the memory map at all.
This has nothing to do with usable memory that should or not should be
used in a certain way by the OS.

> > Also, sInce there is a generic component and a x86 component, can you
> > please split those up?
>
> Sure, can do.
>
> >
> > You only cc'ed me on patch #1 this time, but could you please cc me on
> > the entire series for v2? Thanks.
>
> Yes, will do, and thanks for taking a look.
