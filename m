Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C708C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C864A20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDATfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:35:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfDATfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:35:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B2863086228;
        Mon,  1 Apr 2019 19:35:33 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EED4B600D4;
        Mon,  1 Apr 2019 19:35:30 +0000 (UTC)
Date:   Mon, 1 Apr 2019 15:35:29 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>, Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
Message-ID: <20190401193529.GA26375@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-3-jmoreira@suse.de>
 <20190318191926.GA23138@redhat.com>
 <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
 <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de>
 <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
 <699e78da-36ba-8217-c509-2e9b443bd380@suse.de>
 <1b6ee81b-5699-a1cc-9a85-02df0eeaed12@redhat.com>
 <20190328201703.GA8658@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328201703.GA8658@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 01 Apr 2019 19:35:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:17:03PM -0400, Joe Lawrence wrote:
> On Tue, Mar 26, 2019 at 04:53:12PM -0400, Joe Lawrence wrote:
> > On 3/26/19 2:13 PM, Joao Moreira wrote:
> > >
> > >
> > > On 3/26/19 1:15 PM, Joe Lawrence wrote:
> > >>
> > > > Hi Joao,
> > > >
> > > > This change seems to work okay for (again) single object modules, but
> > > > I'm having issues with multi-object modules.
> > > >
> > >
> > > Hi Joe, thanks for the sources, this made everything much easier in my
> > > side :)
> > >
> > > In the patch below I change a little bit the interface used to inform
> > > kbuild that a module is a livepatch. Instead of defining the flag
> > > LIVEPATCH_ per .o file, we define it per module (what actually makes
> > > much more sense). We later use $(basetarget) in the Makefile for
> > > checking the flags. By doing so, and invoking cmd_livepatch both from
> > > the $(single-used-m) and $(multi-used-m) we ensure that the .livepatch
> > > file is created for each module, what later in the pipeline flags the
> > > invocation of klp-convert.
> > >
> > > I tested the following patch with the sources you provided (with little
> > > modifications, removing the .o from the LIVEPATCH_ definitions and using
> > > the module name instead of the object names), achieving successful
> > > compilation and conversion. I also tested against the sample
> > > livepatches, thus I think it might be ok now.
> >
> > Cool thanks for taking a look -- I can confirm that the toy code I sent over
> > builds with those modifications and so does the sample and selftest I was
> > working on.  I'll set about refactoring that klp-convert selftest to combine
> > .o files into a more compact module.
>
> Hmm, maybe I spoke too soon.
>
> I am having issues if I have a two-object livepatch module in which each
> object file needs to specify its own KLP_MODULE_RELOC for the same
> symbol name.
>
> For example: I have test_klp_convert.ko which is comprised of
> test_klp_convert_a.o. which needs to refer to state_show,1 and
> test_klp_convert_b.o. which needs to refer to state_show,2.
>
>   % make
>   ...
>     KLP     lib/livepatch/test_klp_convert.ko
>   klp-convert: Conflicting KLP_SYMPOS definition: vmlinux.state_show,0 vs. vmlinux.state_show,1.
>   klp-convert: Unable to load user-provided sympos
>   make[2]: *** [scripts/Makefile.modpost:148: lib/livepatch/test_klp_convert.ko] Error 255
>   make[1]: *** [/home/cloud-user/disk/linux/Makefile:1282: modules] Error 2
>   make: *** [Makefile:170: sub-make] Error 2
>
> I take a closer look next week, but in the meantime, see the source
> files below.

Okay, with a fresh set of eyes today, I think the issue can be
summarized as:

  * "Special" livepatch symbols, as processed by klp-convert, require
    external linkage, otherwise a new local storage instance will be
    created and miss klp-convert altogether

  * When linking together two object files, their combined symbol table
    will include a de-duped list of uniquly named global symbols

So if we are to run klp-convert on the combined module object file (as
per v2 plus suggested changes in this thread), we are going to run into
problems if ...


Example
=======

(quoted in previous reply), test_klp_convert_a and test_klp_convert_b
have their own "state_show" variable in which each wishes to resolve to
unique symbol positions (2 and 3 accordingly).


test_klp_convert_a
------------------

We get one symbol table entry and one relocation as expected.

  % eu-readelf --symbols lib/livepatch/test_klp_convert_a.o

  Symbol table [27] '.symtab' contains 38 entries:
   29 local symbols  String table: [28] '.strtab'
    Num:            Value   Size Type    Bind   Vis          Ndx Name
    ...
     30: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
    ...

  % eu-readelf --relocs lib/livepatch/test_klp_convert_a.o

  Relocation section [12] '.rela.klp.module_relocs.vmlinux' for section [11] '.klp.module_relocs.vmlinux' at offset 0x4b8 contains 1 entry:
    Offset              Type            Value               Addend Name
    000000000000000000  X86_64_64       000000000000000000      +0 state_show


test_klp_convert_b
------------------

Just like the other object file, one symbol table entry and one
relocation:

  % eu-readelf --symbols lib/livepatch/test_klp_convert_a.o
  Symbol table [24] '.symtab' contains 23 entries:
   19 local symbols  String table: [25] '.strtab'
    Num:            Value   Size Type    Bind   Vis          Ndx Name
    ...
     20: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
    ...

  % eu-readelf --relocs lib/livepatch/test_klp_convert_b.o

  Relocation section [ 9] '.rela.klp.module_relocs.vmlinux' for section [ 8] '.klp.module_relocs.vmlinux' at offset 0x118 contains 1 entry:
    Offset              Type            Value               Addend Name
    000000000000000000  X86_64_64       000000000000000000      +0 state_show


test_klp_convert
----------------

But the combined test_klp_convert.klp.o file has only a single
unresolved "state_show" symbol in its symbol table:

  % eu-readelf --symbols lib/livepatch/test_klp_convert.klp.o

  Symbol table [35] '.symtab' contains 57 entries:
   47 local symbols  String table: [36] '.strtab'
    Num:            Value   Size Type    Bind   Vis          Ndx Name
    ...
     52: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
    ...

though the .rela.klp.module_relocs.vmlinux relocation section has two
entries:

  % eu-readelf --relocs lib/livepatch/test_klp_convert.klp.o

  Relocation section [17] '.rela.klp.module_relocs.vmlinux' for section [16] '.klp.module_relocs.vmlinux' at offset 0x446c8 contains 2 entries:
    Offset              Type            Value               Addend Name
    000000000000000000  X86_64_64       000000000000000000      +0 state_show
    0x0000000000000010  X86_64_64       000000000000000000      +0 state_show

and it looks like the combined KLP_MODULE_RELOC still contains the two
unique symbol position values (2 and 3):

  % objcopy -O binary --only-section=.klp.module_relocs.vmlinux lib/livepatch/test_klp_convert.klp.o >(hexdump -C)
  00000000  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00  |................|
  00000010  00 00 00 00 00 00 00 00  03 00 00 00              |............|
  0000001c


Maybe we can work around this by modifying the annotation macros and/or
klp-convert, or live with this for now.

Note: I'm inclined to defer work on resolving this limitation to v4.  I
would like v3 to focus on collecting and squashing the feedback up to
now on v2.  There are a few other outstanding issues that I have run
across while testing this patchset, so I feel that it would be clearer
for folks to base comments on those off a clean v3 slate.

-- Joe

> ==> lib/livepatch/test_klp_convert_a.c <==
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/livepatch.h>
>
> /* klp-convert symbols - vmlinux */
> extern void *state_show;
> __used void print_state_show(void)
> {
> 	pr_info("%s: state_show: %p\n", __func__, state_show);
> }
>
> KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_a[] = {
> 	KLP_SYMPOS(state_show, 1)
> };
>
> static struct klp_func funcs[] = {
> 	{
> 	}, { }
> };
>
> static struct klp_object objs[] = {
> 	{
> 		/* name being NULL means vmlinux */
> 		.funcs = funcs,
> 	}, { }
> };
>
> static struct klp_patch patch = {
> 	.mod = THIS_MODULE,
> 	.objs = objs,
> };
>
> static int test_klp_convert_init(void)
> {
> 	int ret;
>
> 	ret = klp_enable_patch(&patch);
> 	if (ret)
> 		return ret;
>
> 	return 0;
> }
>
> static void test_klp_convert_exit(void)
> {
> }
>
> module_init(test_klp_convert_init);
> module_exit(test_klp_convert_exit);
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
> MODULE_DESCRIPTION("Livepatch test: klp-convert");
>
> ==> lib/livepatch/test_klp_convert_b.c <==
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/livepatch.h>
>
> /* klp-convert symbols - vmlinux */
> extern void *state_show;
>
> __used void print_state_show_b(void)
> {
> 	pr_info("%s: state_show: %p\n", __func__, state_show);
> }
>
> KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
> 	KLP_SYMPOS(state_show, 2)
> };
>
>
> ==> lib/livepatch/Makefile <==
> # SPDX-License-Identifier: GPL-2.0
> #
> # Makefile for livepatch test code.
>
> LIVEPATCH_test_klp_atomic_replace := y
> LIVEPATCH_test_klp_callbacks_demo := y
> LIVEPATCH_test_klp_callbacks_demo2 := y
> LIVEPATCH_test_klp_convert := y
> LIVEPATCH_test_klp_livepatch := y
>
> obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
> 				test_klp_callbacks_demo.o \
> 				test_klp_callbacks_demo2.o \
> 				test_klp_callbacks_busy.o \
> 				test_klp_callbacks_mod.o \
> 				test_klp_convert.o \
> 				test_klp_livepatch.o \
> 				test_klp_shadow_vars.o
>
> test_klp_convert-y := \
> 	test_klp_convert_a.o \
> 	test_klp_convert_b.o
>
> # Target modules to be livepatched require CC_FLAGS_FTRACE
> CFLAGS_test_klp_callbacks_busy.o	+= $(CC_FLAGS_FTRACE)
> CFLAGS_test_klp_callbacks_mod.o		+= $(CC_FLAGS_FTRACE)
> CFLAGS_test_klp_convert_mod.o		+= $(CC_FLAGS_FTRACE)
-- Joe
