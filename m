Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B971C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF52171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDCMsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfDCMsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:48:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 620BAAD84;
        Wed,  3 Apr 2019 12:48:48 +0000 (UTC)
Date:   Wed, 3 Apr 2019 14:48:47 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
In-Reply-To: <20190401193529.GA26375@redhat.com>
Message-ID: <alpine.LSU.2.21.1904031444020.18182@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com> <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz> <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de> <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
 <699e78da-36ba-8217-c509-2e9b443bd380@suse.de> <1b6ee81b-5699-a1cc-9a85-02df0eeaed12@redhat.com> <20190328201703.GA8658@redhat.com> <20190401193529.GA26375@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hmm, maybe I spoke too soon.
> >
> > I am having issues if I have a two-object livepatch module in which each
> > object file needs to specify its own KLP_MODULE_RELOC for the same
> > symbol name.
> >
> > For example: I have test_klp_convert.ko which is comprised of
> > test_klp_convert_a.o. which needs to refer to state_show,1 and
> > test_klp_convert_b.o. which needs to refer to state_show,2.
> >
> >   % make
> >   ...
> >     KLP     lib/livepatch/test_klp_convert.ko
> >   klp-convert: Conflicting KLP_SYMPOS definition: vmlinux.state_show,0 vs. vmlinux.state_show,1.
> >   klp-convert: Unable to load user-provided sympos
> >   make[2]: *** [scripts/Makefile.modpost:148: lib/livepatch/test_klp_convert.ko] Error 255
> >   make[1]: *** [/home/cloud-user/disk/linux/Makefile:1282: modules] Error 2
> >   make: *** [Makefile:170: sub-make] Error 2
> >
> > I take a closer look next week, but in the meantime, see the source
> > files below.
> 
> Okay, with a fresh set of eyes today, I think the issue can be
> summarized as:
> 
>   * "Special" livepatch symbols, as processed by klp-convert, require
>     external linkage, otherwise a new local storage instance will be
>     created and miss klp-convert altogether
> 
>   * When linking together two object files, their combined symbol table
>     will include a de-duped list of uniquly named global symbols
> 
> So if we are to run klp-convert on the combined module object file (as
> per v2 plus suggested changes in this thread), we are going to run into
> problems if ...
> 
> 
> Example
> =======
> 
> (quoted in previous reply), test_klp_convert_a and test_klp_convert_b
> have their own "state_show" variable in which each wishes to resolve to
> unique symbol positions (2 and 3 accordingly).
> 
> 
> test_klp_convert_a
> ------------------
> 
> We get one symbol table entry and one relocation as expected.
> 
>   % eu-readelf --symbols lib/livepatch/test_klp_convert_a.o
> 
>   Symbol table [27] '.symtab' contains 38 entries:
>    29 local symbols  String table: [28] '.strtab'
>     Num:            Value   Size Type    Bind   Vis          Ndx Name
>     ...
>      30: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
>     ...
> 
>   % eu-readelf --relocs lib/livepatch/test_klp_convert_a.o
> 
>   Relocation section [12] '.rela.klp.module_relocs.vmlinux' for section [11] '.klp.module_relocs.vmlinux' at offset 0x4b8 contains 1 entry:
>     Offset              Type            Value               Addend Name
>     000000000000000000  X86_64_64       000000000000000000      +0 state_show
> 
> 
> test_klp_convert_b
> ------------------
> 
> Just like the other object file, one symbol table entry and one
> relocation:
> 
>   % eu-readelf --symbols lib/livepatch/test_klp_convert_a.o
>   Symbol table [24] '.symtab' contains 23 entries:
>    19 local symbols  String table: [25] '.strtab'
>     Num:            Value   Size Type    Bind   Vis          Ndx Name
>     ...
>      20: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
>     ...
> 
>   % eu-readelf --relocs lib/livepatch/test_klp_convert_b.o
> 
>   Relocation section [ 9] '.rela.klp.module_relocs.vmlinux' for section [ 8] '.klp.module_relocs.vmlinux' at offset 0x118 contains 1 entry:
>     Offset              Type            Value               Addend Name
>     000000000000000000  X86_64_64       000000000000000000      +0 state_show
> 
> 
> test_klp_convert
> ----------------
> 
> But the combined test_klp_convert.klp.o file has only a single
> unresolved "state_show" symbol in its symbol table:
> 
>   % eu-readelf --symbols lib/livepatch/test_klp_convert.klp.o
> 
>   Symbol table [35] '.symtab' contains 57 entries:
>    47 local symbols  String table: [36] '.strtab'
>     Num:            Value   Size Type    Bind   Vis          Ndx Name
>     ...
>      52: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
>     ...
> 
> though the .rela.klp.module_relocs.vmlinux relocation section has two
> entries:
> 
>   % eu-readelf --relocs lib/livepatch/test_klp_convert.klp.o
> 
>   Relocation section [17] '.rela.klp.module_relocs.vmlinux' for section [16] '.klp.module_relocs.vmlinux' at offset 0x446c8 contains 2 entries:
>     Offset              Type            Value               Addend Name
>     000000000000000000  X86_64_64       000000000000000000      +0 state_show
>     0x0000000000000010  X86_64_64       000000000000000000      +0 state_show
> 
> and it looks like the combined KLP_MODULE_RELOC still contains the two
> unique symbol position values (2 and 3):
> 
>   % objcopy -O binary --only-section=.klp.module_relocs.vmlinux lib/livepatch/test_klp_convert.klp.o >(hexdump -C)
>   00000000  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00  |................|
>   00000010  00 00 00 00 00 00 00 00  03 00 00 00              |............|
>   0000001c

Nice :/
 
> Maybe we can work around this by modifying the annotation macros and/or
> klp-convert, or live with this for now.

The question is (and I'll check later. I cannot wrap my head around it 
now) if it at least works if there are two references of the same symbol 
in two different .o. It would be same state_show in this case and not two 
different ones. If it works then I think we can live with it for a while, 
because after all duplicate symbols are quite rare in the kernel.

I think it should not be a big problem to fix it though (famous last 
words). The information is there, so klp-convert with a changed annotation 
macro should deal with it.

> Note: I'm inclined to defer work on resolving this limitation to v4.  I
> would like v3 to focus on collecting and squashing the feedback up to
> now on v2.  There are a few other outstanding issues that I have run
> across while testing this patchset, so I feel that it would be clearer
> for folks to base comments on those off a clean v3 slate.

Makes sense to me.

Miroslav
