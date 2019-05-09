Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F8A2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CWYl/x5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIIAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:00:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35952 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEIIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:00:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so921169qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Yfl2JJ8Wn2/T573PJ0NvYGGpvDvMiL4vlmbgNIxfp4=;
        b=CWYl/x5UL40d94Oa8gVCUv/I2aAp1OovkFD17YdVGABypWn0AH/V6kjMJ7+wFnlVc+
         brs2CMTFtG6qjBXmTZDdm28V0J+huSkPL4v8gmZUuvRZliSQLje9XY+rZbqgfMpyJvu6
         zNS2xmfjsHajyBAWZpVveuGDBxmdOwFXcXJec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Yfl2JJ8Wn2/T573PJ0NvYGGpvDvMiL4vlmbgNIxfp4=;
        b=fPq7F/ZyetX/SdAtmUEjMJ2BktUj8O7SkGy1z/mL2jLskbc1/xjnP9tsZAH2WyxDHP
         ZIcxrmeJjVbIAxIedKBuw3qO8RbuDlKLW5839k9kYtNvQPgy2UysiRiL9SJQIY1E9nvU
         uxqyRfNIaDsYA+94ovS0VR5KWuQlhTOqlLHD6ODnzaQVZe3pkyRNQDDlTz1bjVPiBa3E
         YL+3uKcpNQF4Hk+iY+4FQUtzo+FSqT0+xQ8eV2HMyL+o30ugOAwpxOXYV1I/MvV7DlIE
         OM2KJTqA09CFDaJzD5gPzaW9OCcuG80j9mQ5hSxcnN6VDyhDrXIBVNdLkQjPGQyWxjAg
         UK3w==
X-Gm-Message-State: APjAAAX5j8SW6ovlLLJHDjDHL2iTc2xM+Vb5apoWAdN/LNO0NguBVq+E
        lOH868bqizTp1YWgoAi1N0dxbIymdD4IJklKuArITkPKhMw=
X-Google-Smtp-Source: APXvYqxjxbR1lG/Lv1vNcdHx4E6JwsFVIcRuQF8t8SFWRJIWbsM6ZTpykGFyxwxBIJu84GVb7cWMgthX2m9vRSWGngo=
X-Received: by 2002:a37:8106:: with SMTP id c6mr2116533qkd.113.1557388852549;
 Thu, 09 May 2019 01:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
 <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
 <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com> <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 9 May 2019 16:00:26 +0800
Message-ID: <CAJMQK-hJUG855+TqX=droOjUfb-MKnU0n0FYtr_SW2KByKAW1w@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 12:07 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, May 8, 2019 at 10:06 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Wed, May 8, 2019 at 10:04 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, May 7, 2019 at 11:08 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > > >
> > > > On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > >
> > > > > +boot-architecture list as there was some discussion about this IIRC.
> > > > >
> > > > > On Mon, May 6, 2019 at 11:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > > > > >
> > > > > > Introducing a chosen node, rng-seed, which is an 64 bytes entropy
> > > > > > that can be passed to kernel called very early to increase device
> > > > > > randomness. Bootloader should provide this entropy and the value is
> > > > > > read from /chosen/rng-seed in DT.
> > > > > >
> > > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > > >
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
> > > > >
> > > > > Actually, this file has been converted to json-schema and lives
> > > > > here[1]. I need to remove this one (or leave it with a reference to
> > > > > the new one).
> > > > >
> > > > > >  arch/arm64/kernel/setup.c                    |  2 ++
> > > > > >  drivers/of/fdt.c                             | 33 ++++++++++++++++++++
> > > > > >  include/linux/of_fdt.h                       |  1 +
> > > > > >  4 files changed, 50 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > > > > > index 45e79172a646..bfd360691650 100644
> > > > > > --- a/Documentation/devicetree/bindings/chosen.txt
> > > > > > +++ b/Documentation/devicetree/bindings/chosen.txt
> > > > > > @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
> > > > > >  the Linux EFI stub (which will populate the property itself, using
> > > > > >  EFI_RNG_PROTOCOL).
> > > > > >
> > > > > > +rng-seed
> > > > > > +-----------
> > > > > > +
> > > > > > +This property served as an entropy to add device randomness. It is parsed
> > > > > > +as a 64 byte value, e.g.
> > > > >
> > > > > Why only 64-bytes?
> > > > We can also not specify size and read what bootloader can provide.
> > > > >
> > > > > > +
> > > > > > +/ {
> > > > > > +       chosen {
> > > > > > +               rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
> > > > > > +       };
> > > > > > +};
> > > > > > +
> > > > > > +This random value should be provided by bootloader.
> > > > > > +
> > > > > >  stdout-path
> > > > > >  -----------
> > > > > >
> > > > > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > > > > index 413d566405d1..ade4261516dd 100644
> > > > > > --- a/arch/arm64/kernel/setup.c
> > > > > > +++ b/arch/arm64/kernel/setup.c
> > > > > > @@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
> > > > > >         early_fixmap_init();
> > > > > >         early_ioremap_init();
> > > > > >
> > > > > > +       early_init_dt_rng_seed(__fdt_pointer);
> > > > > > +
> > > > >
> > > > > I'm trying to reduce or eliminate all these early_init_dt_* calls.
> > > > >
> > > > > Why is this arch specific and why can't this be done after
> > > > > unflattening? It doesn't look like add_device_randomness() needs
> > > > > anything early.
> > > > Currently unflattening is called after setup_machine_fdt(), which
> > > > called fixmap_remap_fdt() //__fixmap_remap_fdt(dt_phys, &size,
> > > > PAGE_KERNEL_RO), and we can't modify DT after that since it's read
> > > > only. But we need to clear (eg. write 0 to it) the rng-seed after
> > > > reading from DT.
> > >
> > > Why do you need to clear it? That wasn't necessary for kaslr-seed.
> > I think it's for security purpose. If we know the random seed, it's
> > more likely we can predict randomness.
> > Currently on arm64, kaslr-seed will be wiped out (in
> > arch/arm64/kernel/kaslr.c#get_kaslr_seed(), it's set to 0) so we can't
> > read from sysfs (eg. /sys/firmware/devicetree/.../kaslr-seed)
> > I'm not sure on other arch if it will be wiped out.
>
> The difference is if I have the kaslr seed, I can calculate the kernel
> base address.
>
> In your case, you are feeding an RNG which continually has entropy
> added to it. I can't see that knowing one piece of the entropy data is
> a security hole. It looks more like you've just copied what what done
> for kaslr-seed.
+Kees who can probably explain this better.

This early added entropy is also going to be used for stack canary. At
the time it's created there's not be much entropy (before
boot_init_stack_canary(), there's only add_latent_entropy() and
command_line).
On arm64, there is a single canary for all tasks. If RNG is weak or
the seed can be read, it might be easier to figure out the canary.

>
> > > Why not change the mapping to RW? It would be nice if this worked on
> > > more than one arch.
>
> Still wondering on this question. Mapping it R/W would mean rng-seed
> could be handled later and completely out of the arch code and so
> could the zeroing of the kaslr-seed. Also, we generally assume the FDT
> is modifiable for any fixups. This happens on arm32 and powerpc, but I
> guess we haven't needed that yet on arm64.
We can try to map it to RW and map back to RO later if needed on
arm64, like Stephen's suggestion.
>
> Rob

Thanks for the comments and suggestions.
