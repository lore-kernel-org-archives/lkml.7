Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0413C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTHQ47zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfC1R5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:57:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1R5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:57:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so20557400wrx.9;
        Thu, 28 Mar 2019 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8apiQeGA3kTurrt37zzzVcwTnb6VCI+k72IHTFshpmg=;
        b=uTHQ47zZDeS+Q1g3CEK4DoyQpBCyT9vZLe2nCuxaOuJ6b6xsHzm2tCfijAOlyCxc/2
         aR0rhXPGiJF1Jrd4+HIes5KouUzyqoDWip/8a/jB8B7sfgalGXsFHS1UQkX6Mre+0tDv
         ixsu67gNn8GBQ8KZqd3g9VKU5HrhCHMNAvS89N/z3bg6y4BSLWcRGK59TOPIz3h3VuwQ
         2d6nOGqGTIcEQhGexNaswQyD6kOeSiJvPoeoPBCrfwAYWzxBkwBziKNv1vTC088LOTTc
         8HsqApAle4arSBVjX42rPeW47sZCQC5T71qc7SCNx282wVeqg3hXv+ImiuG4UCQueda9
         khxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8apiQeGA3kTurrt37zzzVcwTnb6VCI+k72IHTFshpmg=;
        b=thVdpKnU8SbF3jpTU9QPfJty0qvtcOUNs0dNoPhvzSNS3102UYcVlzkqZptoUxs5sB
         2UvdEZa7PwUu9srEfkJ8hYGwPDBUH87+rmsEiWhrdjRRUpel0xJeDrVL1CS18jOM98WH
         wLQtysDxj72NhDc1H8CxAxD/qxwlJlTUBa2JpPzTQcqVYEZdFi64+0w+uXZHVrNgms3U
         6HEIo0I4yvuHFjwv/bQXyAC+yB/cjI/KA1fiTR4KyFyX4gAtcuSbk1LPUJuncouAwVHu
         s22z1TkoIUZ5kzSlZL2RqnXV1xU+P+/uplNq+ETARrkKnPY0Vhzm22FWUnsszoo60f22
         LIyA==
X-Gm-Message-State: APjAAAWrNdQ/s8r9tClnNOgilzq8cV3evV8i1rPcaeBP/JveH1NEie8i
        ZTr0AUkYAhuZxP6VNVRowkgrpq4QzOKzjOAZ9HA=
X-Google-Smtp-Source: APXvYqzWfeCVqBgqL7GmAecli8Zjvxb41pIH9TwlBWTHLb2gLl231SIcOcktXNnP8mR4WgDsOY4R2mrgeeDTfZN0nzo=
X-Received: by 2002:adf:e487:: with SMTP id i7mr28733940wrm.264.1553795828507;
 Thu, 28 Mar 2019 10:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190315101013.GN8455@Legion-PC.fortress> <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress> <20190327154025.GB23293@linux-8ccs>
 <20190327160440.GE15936@Legion-PC.fortress>
In-Reply-To: <20190327160440.GE15936@Legion-PC.fortress>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 28 Mar 2019 10:56:57 -0700
Message-ID: <CAKi4VAKA-kRv2MyfiL4zRV-zaz9kUDZ+QrBpbqSgAZhzOKgSKQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 9:04 AM Alexey Gladkov <gladkov.alexey@gmail.com> w=
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
>
> It is much easier to create and it has almost the same format as the
> modules. So I think it will be easier to parse in kmod.

adding a modules.builtin.alias with the same format of modules.alias
means during modprobe we would only need to load one more file to
lookup aliases. That doesn't mean the kernel built system should do it
though. The same way it's depmod job to create the
modules.alias{,.bin}, we could leave this to depmod if it's in fact
useful to split the information.

I think your version is simple enough and we would get more
information that would be useful for modinfo.
It would indeed be nice to output something useful in  "modinfo ext4".

In kmod, I think we would create modules.builtin.modinfo{,.bin} and
just add the aliases to modules.alias{,.bin},
This would keep the names consistent with what is already there.

thanks
Lucas De Marchi

>
> --
> Rgrds, legion
>
