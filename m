Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124DFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F820700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zqri5xVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDCKtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:49:04 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33901 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCKtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:49:03 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x33Amkne027732;
        Wed, 3 Apr 2019 19:48:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x33Amkne027732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554288527;
        bh=vpP93iMWMo/tx4PyEHbe344b8esJ8ot7yCGFJ/qSEWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zqri5xVjZcPbqiwxJDf212E8sHfzcLBpehtsOyRYnMj0YOJ2Nmzp6DkX6cbF0/VIO
         4KBk32h9HmAxMf5fx+/M3IJ6eBAy1SakO8Qwz60A/hWgxv0EHpcx5sb3jiTrO+xUOp
         bthtJFVDe6KWSfvupZgFugF9f7XGEQRlp8KNF122yfs79lpeLzcF+NlgU9VLaW+QNT
         Y+PxCWcJqVJJ5cdLtKoSjku6ujAX7Dj5wSU4hY0MwFfXZtxj6KftfZDujfK88McUDl
         LmQMjbgQRcv/mljFup2oY7pWUu5T1MHrAm6N1ocSEHQMlgZXDAXawoNKSTmcNW63C4
         0Shtsztk1rweA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id l17so5288538uar.4;
        Wed, 03 Apr 2019 03:48:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUE+ffEZJXMZseYvrhSCaslnoG+GZBrLKY3J6al3oDZkF+2Sy49
        /gO6MN1B++z3Kxo5dgtifd4tb2incr1sY9u2IFM=
X-Google-Smtp-Source: APXvYqxOOiCZRMmQCmr66s+la+SjdmZCvPygNl1m4jHPlzh7nDYufzLzIPXVJqNUKVS7ucAkr6GvzDAoMmYSqHddEBM=
X-Received: by 2002:ab0:7312:: with SMTP id v18mr7249376uao.36.1554288525468;
 Wed, 03 Apr 2019 03:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190315101013.GN8455@Legion-PC.fortress> <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress> <CAK7LNARd75HS_aBZgH0YhR-w1kipr0rn7g1VGOjWev8giO04tg@mail.gmail.com>
In-Reply-To: <CAK7LNARd75HS_aBZgH0YhR-w1kipr0rn7g1VGOjWev8giO04tg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Apr 2019 19:48:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnPhT-C5Xzgb_x=ev3xsve_zzBQgLN+spvT8pJyv0F+A@mail.gmail.com>
Message-ID: <CAK7LNAQnPhT-C5Xzgb_x=ev3xsve_zzBQgLN+spvT8pJyv0F+A@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi.
>
> Sorry for the delay.
> I added some comments from the
> build system point of view.
>
>
> On Wed, Mar 27, 2019 at 2:24 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2019 at 02:34:12PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > >
> > > (added some people to CC)
> > >
> > >
> > > On Fri, Mar 15, 2019 at 7:10 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> > > >
> > > > Problem:
> > > >
> > > > When a kernel module is compiled as a separate module, some important
> > > > information about the kernel module is available via .modinfo section of
> > > > the module.  In contrast, when the kernel module is compiled into the
> > > > kernel, that information is not available.
> > >
> > >
> > > I might be missing something, but
> > > vmlinux provides info of builtin modules
> > > in /sys/module/.
> >
> > No. There are definitely not all modules. I have a builtin sha256_generic,
> > but I can't find him in the /sys/module.
> >
> > > (Looks like currently only module_param and MODULE_VERSION)
> > >
> > > This patch is not exactly the same, but I see a kind of overwrap.
> > > I'd like to be sure if we want this new scheme.
> >
> > The /sys/module is only for running kernel. One of my use cases is
> > to create an initrd for a new kernel.
> >
> > >
> > > > Information about built-in modules is necessary in the following cases:
> > > >
> > > > 1. When it is necessary to find out what additional parameters can be
> > > > passed to the kernel at boot time.
> > >
> > >
> > > Actually, /sys/module/<module>/parameters/
> > > exposes this information.
> > >
> > > Doesn't it work for your purpose?
> >
> > No, since creating an initrd needs to know all the modalias before
> > I get the sysfs for new kernel. Also there are no modalias at all.
> >
> > > > 2. When you need to know which module names and their aliases are in
> > > > the kernel. This is very useful for creating an initrd image.
> > > >
> > > > Proposal:
> > > >
> > > > The proposed patch does not remove .modinfo section with module
> > > > information from the vmlinux at the build time and saves it into a
> > > > separate file after kernel linking. So, the kernel does not increase in
> > > > size and no additional information remains in it. Information is stored
> > > > in the same format as in the separate modules (null-terminated string
> > > > array). Because the .modinfo section is already exported with a separate
> > > > modules, we are not creating a new API.
> > > >
> > > > It can be easily read in the userspace:
> > > >
> > > > $ tr '\0' '\n' < kernel.builtin.modinfo
> > > > ext4.softdep=pre: crc32c
> > > > ext4.license=GPL
> > > > ext4.description=Fourth Extended Filesystem
> > > > ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
> > > > ext4.alias=fs-ext4
> > > > ext4.alias=ext3
> > > > ext4.alias=fs-ext3
> > > > ext4.alias=ext2
> > > > ext4.alias=fs-ext2
> > > > md_mod.alias=block-major-9-*
> > > > md_mod.alias=md
> > > > md_mod.description=MD RAID framework
> > > > md_mod.license=GPL
> > > > md_mod.parmtype=create_on_open:bool
> > > > md_mod.parmtype=start_dirty_degraded:int
> > > > ...
> > > >
> > > > Co-Developed-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> > > > Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> > > > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > > > ---
> > > >  Makefile                    |  1 +
> > > >  include/linux/moduleparam.h | 12 +++++-------
> > > >  scripts/link-vmlinux.sh     |  8 ++++++++
> > > >  3 files changed, 14 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index d5713e7b1e50..971102194c92 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1288,6 +1288,7 @@ _modinst_:
> > > >         fi
> > > >         @cp -f $(objtree)/modules.order $(MODLIB)/
> > > >         @cp -f $(objtree)/modules.builtin $(MODLIB)/
> > > > +       @cp -f $(objtree)/kernel.builtin.modinfo $(MODLIB)/
>
>
> This file should be cleaned up by 'make clean'.
>
> Please add CLEAN_FILES around line 1336.
>
>
> # Directories & files removed with 'make clean'
> CLEAN_DIRS  += $(MODVERDIR) include/ksym
> CLEAN_FILES += ...
>
>
>
>
> Also, shouldn't it be added to .gitignore?
>
>
>
>
> > > >         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> > > >
> > > >  # This depmod is only for convenience to give the initial
> > > > diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> > > > index ba36506db4fb..5ba250d9172a 100644
> > > > --- a/include/linux/moduleparam.h
> > > > +++ b/include/linux/moduleparam.h
> > > > @@ -10,23 +10,21 @@
> > > >     module name. */
> > > >  #ifdef MODULE
> > > >  #define MODULE_PARAM_PREFIX /* empty */
> > > > +#define __MODULE_INFO_PREFIX /* empty */
> > > >  #else
> > > >  #define MODULE_PARAM_PREFIX KBUILD_MODNAME "."
> > > > +/* We cannot use MODULE_PARAM_PREFIX because some modules override it. */
> > > > +#define __MODULE_INFO_PREFIX KBUILD_MODNAME "."
> > > >  #endif
> > > >
> > > >  /* Chosen so that structs with an unsigned long line up. */
> > > >  #define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
> > > >
> > > > -#ifdef MODULE
> > > >  #define __MODULE_INFO(tag, name, info)                                   \
> > > >  static const char __UNIQUE_ID(name)[]                                    \
> > > >    __used __attribute__((section(".modinfo"), unused, aligned(1)))        \
> > > > -  = __stringify(tag) "=" info
> > > > -#else  /* !MODULE */
> > > > -/* This struct is here for syntactic coherency, it is not used */
> > > > -#define __MODULE_INFO(tag, name, info)                                   \
> > > > -  struct __UNIQUE_ID(name) {}
> > > > -#endif
> > > > +  = __MODULE_INFO_PREFIX __stringify(tag) "=" info
> > > > +
> > > >  #define __MODULE_PARM_TYPE(name, _type)                                          \
> > > >    __MODULE_INFO(parmtype, name##type, #name ":" _type)
> > > >
> > > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > > index c8cf45362bd6..399d7e4d11ec 100755
> > > > --- a/scripts/link-vmlinux.sh
> > > > +++ b/scripts/link-vmlinux.sh
> > > > @@ -258,10 +258,12 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
> > > >
> > > >         # step 1
> > > >         vmlinux_link "" .tmp_vmlinux1
> > > > +       "${OBJCOPY}" -R .modinfo .tmp_vmlinux1
> > > >         kallsyms .tmp_vmlinux1 .tmp_kallsyms1.o
> > > >
> > > >         # step 2
> > > >         vmlinux_link .tmp_kallsyms1.o .tmp_vmlinux2
> > > > +       "${OBJCOPY}" -R .modinfo .tmp_vmlinux2
> > > >         kallsyms .tmp_vmlinux2 .tmp_kallsyms2.o
> > > >
> > > >         # step 3
> > > > @@ -273,6 +275,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
> > > >                 kallsyms_vmlinux=.tmp_vmlinux3
> > > >
> > > >                 vmlinux_link .tmp_kallsyms2.o .tmp_vmlinux3
> > > > +               "${OBJCOPY}" -R .modinfo .tmp_vmlinux3
> > > >
> > > >                 kallsyms .tmp_vmlinux3 .tmp_kallsyms3.o
> > > >         fi
> > > > @@ -281,6 +284,11 @@ fi
> > > >  info LD vmlinux
> > > >  vmlinux_link "${kallsymso}" vmlinux
> > > >
> > > > +info MODINFO kernel.builtin.modinfo
> > > > +"${OBJCOPY}" -j .modinfo -O binary vmlinux kernel.builtin.modinfo
> > > > +chmod 444 kernel.builtin.modinfo
> > > > +"${OBJCOPY}" -R .modinfo vmlinux
> > > > +
> > > >  if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
> > > >         info SORTEX vmlinux
> > > >         sortextable vmlinux
>
>
>
> As I pointed out before, I see lots of warnings for powerpc.
>
> How about extracting modinfo before linking vmlinux?
> You can extract it from vmlinux.o instead,
> and discard it in the linker script.
>
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index dc0e8c5..994cd47 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -193,6 +193,9 @@ modpost_link vmlinux.o
>  # modpost vmlinux.o to check for section mismatches
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
>
> +info MODINFO kernel.builtin.modinfo
> +"${OBJCOPY}" -j .modinfo -O binary vmlinux kernel.builtin.modinfo

Oops, this should be:

"${OBJCOPY}" -j .modinfo -O binary vmlinux.o kernel.builtin.modinfo




-- 
Best Regards
Masahiro Yamada
