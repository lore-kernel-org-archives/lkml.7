Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A08FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259CB2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="15cjfyuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCLbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:31:37 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:53481 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:31:35 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x33BVWNr014492;
        Wed, 3 Apr 2019 20:31:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x33BVWNr014492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554291093;
        bh=vpMvTkZ3zjKetPMWRIiMdWOr7NlF5E+vS3OXn39zX/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=15cjfyuJX00T0a7K9NCQH6VmjhnADhDUDM7nyCrG0fosqVwSFST1wLipCMhb+GTLt
         9v008DKwMu7seOgYdfnYfvJTZJfwiWItXym01fh1bfHxoZ2GiSb4NTK+pjO4Chh6wr
         p+QTjMLGkK6Qy7SPnerdFt9eS+goYLP7253g4YWlqziAHe4qhUiad0gnvXQuwnruNu
         j9Gh1VWnTETqtN9JoS7leSW+CaL3YlyWOaq4JeJE7cRCSyRYxzTnL2LxfgwBs3kXFV
         /dvjY6Nd3UWfeRcp+jf73RTp6EK9IGQ9RkbG1fJJ8Myw3ekYRMkiSqe9YU4fA4DuGo
         zDD57DG/t1Jww==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id f22so9727125vso.7;
        Wed, 03 Apr 2019 04:31:32 -0700 (PDT)
X-Gm-Message-State: APjAAAWYHDRa2353VyWVHzyfR9lrze8cwN51ATBFIQ9Hzx77B1asC5QJ
        Yo95f97tBSaV9F2n8joa6x3cRmhliCerVgv29bI=
X-Google-Smtp-Source: APXvYqzhIT1XfHzesgWzKxa3o/0v7RNvJmzH3ZeEddhUo1s8Dft7BnEw/uF1YZwinPOsujK/Wvmod0gbiGFhaQso+wA=
X-Received: by 2002:a67:c29e:: with SMTP id k30mr46049859vsj.203.1554291091691;
 Wed, 03 Apr 2019 04:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190315101013.GN8455@Legion-PC.fortress> <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress> <20190327154025.GB23293@linux-8ccs>
 <20190327160440.GE15936@Legion-PC.fortress>
In-Reply-To: <20190327160440.GE15936@Legion-PC.fortress>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Apr 2019 20:30:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAMXmoWw=ZUSRSYoH=gCsHhXiN9m_yPoH+mMMhW93bxw@mail.gmail.com>
Message-ID: <CAK7LNARAMXmoWw=ZUSRSYoH=gCsHhXiN9m_yPoH+mMMhW93bxw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:04 AM Alexey Gladkov <gladkov.alexey@gmail.com> w=
rote:
>
> On Wed, Mar 27, 2019 at 04:40:25PM +0100, Jessica Yu wrote:
> > +++ Alexey Gladkov [26/03/19 18:24 +0100]:
> > >On Fri, Mar 22, 2019 at 02:34:12PM +0900, Masahiro Yamada wrote:
> > >> Hi.
> > >>
> > >> (added some people to CC)
> >
> > (Thanks Masahiro for the CC!)
> >
> > >>
> > >> On Fri, Mar 15, 2019 at 7:10 PM Alexey Gladkov <gladkov.alexey@gmail=
.com> wrote:
> > >> >
> > >> > Problem:
> > >> >
> > >> > When a kernel module is compiled as a separate module, some import=
ant
> > >> > information about the kernel module is available via .modinfo sect=
ion of
> > >> > the module.  In contrast, when the kernel module is compiled into =
the
> > >> > kernel, that information is not available.
> > >>
> > >>
> > >> I might be missing something, but
> > >> vmlinux provides info of builtin modules
> > >> in /sys/module/.
> > >
> > >No. There are definitely not all modules. I have a builtin sha256_gene=
ric,
> > >but I can't find him in the /sys/module.
> >
> > Yeah, you'll only find builtin modules under /sys/module/ if it has any=
 module
> > parameters, otherwise you won't find it there. As Masahiro already ment=
ioned,
> > if a builtin module has any parameters, they would be accessible under =
/sys/module/.
> >
> > >> (Looks like currently only module_param and MODULE_VERSION)
> > >>
> > >> This patch is not exactly the same, but I see a kind of overwrap.
> > >> I'd like to be sure if we want this new scheme.
> > >
> > >The /sys/module is only for running kernel. One of my use cases is
> > >to create an initrd for a new kernel.
> > >
> > >>
> > >> > Information about built-in modules is necessary in the following c=
ases:
> > >> >
> > >> > 1. When it is necessary to find out what additional parameters can=
 be
> > >> > passed to the kernel at boot time.
> > >>
> > >>
> > >> Actually, /sys/module/<module>/parameters/
> > >> exposes this information.
> > >>
> > >> Doesn't it work for your purpose?
> > >
> > >No, since creating an initrd needs to know all the modalias before
> > >I get the sysfs for new kernel. Also there are no modalias at all.
> > >
> > >> > 2. When you need to know which module names and their aliases are =
in
> > >> > the kernel. This is very useful for creating an initrd image.
> > >> >
> >
> > Hm, I do see one possible additional use-case for preserving module ali=
as
> > information for built-in modules - modprobe will currently error (I thi=
nk,
> > correct me if I'm wrong) if we try invoking modprobe with an alias of a
> > built-in module, simply because this information is not in modules.buil=
tin or
> > modules.alias.
>
> Yes. Patch for modprobe in my todo list. The reason I didn=E2=80=99t do i=
t was
> because I wasn=E2=80=99t sure that the file format was final.
>
> > Since kbuild already outputs modules.builtin, I would suggest outputtin=
g
> > something like a modules.builtin.alias file (and I guess maybe a module=
s.builtin.param
> > file too if that's deemed useful), in a format that is consumable by km=
od/modprobe,
> > so that modprobing an alias of a built-in module doesn't produce an err=
or. I
> > think this should be easy to do if we keep and parse the resulting .mod=
info for
> > builtin modules. This is just an idea, opinions welcome. I've added Luc=
as to CC
> > in case he has any thoughts.
>
> You don't like kernel.builtin.modinfo ?


Naming is often the most difficult thing. :)

IMHO, 'kernel' and 'builtin' have a similar meaning here.
Is 'kernel.builtin' unnecessarily too long?


Perhaps, another idea is:

'builtin.alias' instead of 'modules.builtin.alias'
if we want a separate file in the same format.


In hindsight, 'modules.builtin' should have been
'builtin.order', I think.




> It is much easier to create and it has almost the same format as the
> modules. So I think it will be easier to parse in kmod.

--=20
Best Regards
Masahiro Yamada
