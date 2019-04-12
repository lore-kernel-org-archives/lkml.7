Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DE1218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLV1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDLV1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:27:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12B35C049E23;
        Fri, 12 Apr 2019 21:26:59 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9755F19C65;
        Fri, 12 Apr 2019 21:26:56 +0000 (UTC)
Date:   Fri, 12 Apr 2019 17:26:54 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
Message-ID: <20190412212654.GA21627@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Apr 2019 21:26:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:50:49AM -0400, Joe Lawrence wrote:
> Hi folks,
> 
> This is the third installment of the klp-convert tool for generating and
> processing livepatch symbols for livepatch module builds.  For those
> following along at home, archive links to previous versions:
> 
> RFC:
>   https://lore.kernel.org/lkml/cover.1477578530.git.jpoimboe@redhat.com/
> v2:
>   https://lore.kernel.org/lkml/f52d29f7-7d1b-ad3d-050b-a9fa8878faf2@redhat.com/
> 
> (Note that I don't see v2 archived at lore, but that is a link to the
> most recent subthread that lore did catch.)
> 
> 
> Livepatches may use symbols which are not contained in its own scope,
> and, because of that, may end up compiled with relocations that will
> only be resolved during module load. Yet, when the referenced symbols are
> not exported, solving this relocation requires information on the object
> that holds the symbol (either vmlinux or modules) and its position inside
> the object, as an object may contain multiple symbols with the same name.
> Providing such information must be done accordingly to what is specified
> in Documentation/livepatch/module-elf-format.txt.
> 
> Currently, there is no trivial way to embed the required information as
> requested in the final livepatch elf object. klp-convert solves this
> problem in two different forms: (i) by relying on a symbol map, which is
> built during kernel compilation, to automatically infer the relocation
> targeted symbol, and, when such inference is not possible (ii) by using
> annotations in the elf object to convert the relocation accordingly to
> the specification, enabling it to be handled by the livepatch loader.
> 
> Given the above, add support for symbol mapping in the form of
> Symbols.list file; add klp-convert tool; integrate klp-convert tool into
> kbuild; make livepatch modules discernible during kernel compilation
> pipeline; add data-structure and macros to enable users to annotate
> livepatch source code; make modpost stage compatible with livepatches;
> update livepatch-sample and update documentation.
> 
> The patch was tested under three use-cases:
> 
> use-case 1: There is a relocation in the lp that can be automatically
> resolved by klp-convert.  For example. see the saved_command_line
> variable in lib/livepatch/test_klp_convert2.c.
> 
> use-case 2: There is a relocation in the lp that cannot be automatically
> resolved, as the name of the respective symbol appears in multiple
> objects. The livepatch contains an annotation to enable a correct
> relocation.  See the KLP_MODULE_RELOC / KLP_SYMPOS annotation sections
> in lib/livepatch/test_klp_convert{1,2}.c.
> 
> use-case 3: There is a relocation in the lp that cannot be automatically
> resolved similarly as 2, but no annotation was provided in the
> livepatch, triggering an error during compilation.  Reproducible by
> removing the KLP_MODULE_RELOC / KLP_SYMPOS annotation sections in
> lib/livepatch/test_klp_convert{1,2}.c.
> 
> 
> Branches
> --------
> 
> Since I spent some time tinkering with v2 and accumulated a bunch of
> fixes, I collected them up and am posting this new version.  For review
> purposes, I posted two branches up to github:
> 
>   1 - an expanded branch that with changes separate from the original
>   https://github.com/joe-lawrence/linux/commits/klp-convert-v3-expanded
> 
>   2 - a squashed branch of (1) that comprises v3:
>   https://github.com/joe-lawrence/linux/commits/klp-convert-v3
> 
> Non-trivial commits in the expanded branch have some extra commentary
> and details for debugging in the commit message that were dropped when
> squashing into their respective parent commits.
> 
> 
> TODO
> ----
> 
> There are a few outstanding items that I came across while reviewing v2,
> but as changes started accumulating, it made sense to defer those to a
> later version.  I'll reply to this thread individual topics to start
> discussion sub-threads for those.
> 
> 
> Changelogs
> ----------
> 
> The commit changelogs were getting long, so I've moved them here for
> posterity and review purposes:
> 
> livepatch: Create and include UAPI headers
>   v2:
>   - jmoreira: split up and changelog
>   v3:
>   - joe: convert to SPDX license tags
> 
> kbuild: Support for Symbols.list creation
>   v3:
>   - jmoreira: adjust for multiobject livepatch
>   - joe: add klpclean to PHONY
>   - joe: align KLP prefix
> 
> livepatch: Add klp-convert tool
>   v2:
>   - khlebnikov: use HOSTLOADLIBES_ instead of HOSTLDFLAGS: -lelf must be
>     at the end
>   - jmoreira: add support to automatic relocation conversion in
>     klp-convert.c, changelog
>   v3:
>   - joe: convert to SPDX license tags
>   - jmoreira: add rela symbol name to WARNs
>   - jmoreira: ignore relocations to .TOC and symbols with index 0
>   - joe: separate and fix valid_sympos() sympos=0 and sympos=1..n checks
>   - joe: fix symbol use-after-frees
>   - joe: fix remaining valgrind leak complaints (non-error paths only)
>   - joe: checkpatch nits
>   
> livepatch: Add klp-convert annotation helpers
>   v2:
>   - jmoreira: split up: move KLP_MODULE_RELOC from previous patch to
>     here, add KLP_SYMPOS, move macros from include/uapi/livepatch.h to
>     include/linux/livepatch.h
>   v3:
>   - joe: suggested by jpoimboe, KLP_MODULE_RELOC macro should 4-byte
>     align klp_module_reloc structures
> 
> modpost: Integrate klp-convert
>   v2:
>   - khlebnikov: save cmd_ld_ko_o into .module.cmd, if_changed_rule
>     doesn't do that.f
>   - khlebnikov: fix bashisms for debian where /bin/sh is a symlink to
>     /bin/dash
>   - khlebnikov: rename rule_link_module to rule_ld_ko_o, otherwise
>     arg-check inside if_changed_rule compares cmd_link_module and
>     cmd_ld_ko_o.
>   - khlebnikov: check modinfo -F livepatch only if CONFIG_LIVEPATCH is
>     true.
>   - mbenes: remove modinfo call. LIVEPATCH_ in Makefile
>   - jmoreira: split up: move the .livepatch file-based scheme for
>     identifying livepatches to a previous patch, as it was required for
>     correctly building Symbols.list there.
>   v3:
>   - joe: adjust rule_ld_ko_o to call echo-cmd
>   - joe: rebase for v5.1
>   - joe: align KLP prefix
> 
> modpost: Add modinfo flag to livepatch modules
>   v2:
>   - jmoreira: fix modpost.c (add_livepatch_flag) to update module
>     structure with livepatch flag and prevent modpost from breaking due to
>     unresolved symbols
>   v3:
>   - joe: adjust modpost.c::get_modinfo() call for v5.0 version
> 
> livepatch: Add sample livepatch module
>   v3:
>   - joe: update all in-tree livepatches with LIVEPATCH_* modinfo flag
> 
> documentation: Update on livepatch elf format
>   v2:
>   - jmoreira: update module to use KLP_SYMPOS
>   - jmoreira: Comments on symbol resolution scheme
>   - jmoreira: Update Makefile
>   - jmoreira: Remove MODULE_INFO statement
>   - jmoreira: Changelog
>   v3:
>   - joe: rebase for v5.1
>   - joe: code shuffle to better match original source file
> 
> livepatch/selftests: add klp-convert
>   v3:
>   - joe: clarify sympos=0 and sympos=1..n
> 
> 
> And now the usual git cover-letter boilerplate...
> 
> Joao Moreira (2):
>   kbuild: Support for Symbols.list creation
>   documentation: Update on livepatch elf format
> 
> Joe Lawrence (1):
>   livepatch/selftests: add klp-convert
> 
> Josh Poimboeuf (5):
>   livepatch: Create and include UAPI headers
>   livepatch: Add klp-convert tool
>   livepatch: Add klp-convert annotation helpers
>   modpost: Integrate klp-convert
>   livepatch: Add sample livepatch module
> 
> Miroslav Benes (1):
>   modpost: Add modinfo flag to livepatch modules
> 
>  .gitignore                                    |   1 +
>  Documentation/livepatch/livepatch.txt         |   3 +
>  Documentation/livepatch/module-elf-format.txt |  50 +-
>  MAINTAINERS                                   |   2 +
>  Makefile                                      |  30 +-
>  include/linux/livepatch.h                     |  13 +
>  include/uapi/linux/livepatch.h                |  22 +
>  kernel/livepatch/core.c                       |   4 +-
>  lib/livepatch/Makefile                        |  15 +
>  lib/livepatch/test_klp_atomic_replace.c       |   1 -
>  lib/livepatch/test_klp_callbacks_demo.c       |   1 -
>  lib/livepatch/test_klp_callbacks_demo2.c      |   1 -
>  lib/livepatch/test_klp_convert1.c             | 106 +++
>  lib/livepatch/test_klp_convert2.c             | 103 +++
>  lib/livepatch/test_klp_convert_mod_a.c        |  25 +
>  lib/livepatch/test_klp_convert_mod_b.c        |  13 +
>  lib/livepatch/test_klp_livepatch.c            |   1 -
>  samples/livepatch/Makefile                    |   7 +
>  .../livepatch/livepatch-annotated-sample.c    | 102 +++
>  samples/livepatch/livepatch-sample.c          |   1 -
>  scripts/Kbuild.include                        |   4 +-
>  scripts/Makefile                              |   1 +
>  scripts/Makefile.build                        |   7 +
>  scripts/Makefile.modpost                      |  24 +-
>  scripts/livepatch/.gitignore                  |   1 +
>  scripts/livepatch/Makefile                    |   7 +
>  scripts/livepatch/elf.c                       | 753 ++++++++++++++++++
>  scripts/livepatch/elf.h                       |  72 ++
>  scripts/livepatch/klp-convert.c               | 692 ++++++++++++++++
>  scripts/livepatch/klp-convert.h               |  39 +
>  scripts/livepatch/list.h                      | 391 +++++++++
>  scripts/mod/modpost.c                         |  82 +-
>  scripts/mod/modpost.h                         |   1 +
>  .../selftests/livepatch/test-livepatch.sh     |  64 ++
>  34 files changed, 2616 insertions(+), 23 deletions(-)
>  create mode 100644 include/uapi/linux/livepatch.h
>  create mode 100644 lib/livepatch/test_klp_convert1.c
>  create mode 100644 lib/livepatch/test_klp_convert2.c
>  create mode 100644 lib/livepatch/test_klp_convert_mod_a.c
>  create mode 100644 lib/livepatch/test_klp_convert_mod_b.c
>  create mode 100644 samples/livepatch/livepatch-annotated-sample.c
>  create mode 100644 scripts/livepatch/.gitignore
>  create mode 100644 scripts/livepatch/Makefile
>  create mode 100644 scripts/livepatch/elf.c
>  create mode 100644 scripts/livepatch/elf.h
>  create mode 100644 scripts/livepatch/klp-convert.c
>  create mode 100644 scripts/livepatch/klp-convert.h
>  create mode 100644 scripts/livepatch/list.h
> 
> -- 
> 2.20.1

[ cc += Jason and Evgenii ]

Apologies for the long brain dump, but I promised to reply to this
thread with some of the larger TODO issues I came across with this
patchset.  Static key support is probably the most complicated item, so
there is a lot of debugging output I can provide.

See the tl;dr and Future Work sections for the executive summary.


Static key support
==================

tl;dr
-----

Livepatch symbols are created when building livepatch modules that
reference the (non-exported) static keys of a target object.

When loading a livepatch that contains klp-converted static key symbols,
the module loader crashes.


Testing setup
-------------

The easiest way to see the source and repro is to grab this branch:

  https://github.com/joe-lawrence/linux/commits/klp-convert-v4-static-keys

and note these last two commits:

  - livepatch/klp-convert: abort on static key conversion:  this will
    prevent klp-convert from converting any relocations to the
    __jump_table.  Revert this commit to see the crash.  If we don't
    have a fix before merging, I would suggest a temporary abort
    like this to avoid silently creating dangerous livepatches.

  - livepatch/selftests: add livepatch static keys:  this adds the
    self-test which will repro the crash.


I added a new livepatch selftest to verify klp-convert and static key
behavior: it consists of two kernel modules: test_klp_static_keys_mod.ko
and livepatch module that patches it, test_klp_static_keys.ko.

The base module contains a few different types of static keys: default
true / false, exported / not-exported, and one created by the trace
event macro infrastructure.

The livepatch module references each of these, relying upon klp-convert.
This module also provides its own static key for reference.

  test_klp_static_keys_mod.ko
  ---------------------------
    module_key (false) - exported
    module_key2 (true)                 <----
    TRACE_EVENT(test_klp_static_keys)  <--  |
                                          | |
                                          | |  klp-convert resolves
  test_klp_static_keys.ko - livepatch     | |  these references
  -----------------------------------     | |
    klp_key (true)                        | |
    test_klp_static_keys -----------------  |
    module_key2 ----------------------------
    module_key


Currently .klp symbols are created as well as a relocation section for those
symbols in the their corresponding .text locations.


test_klp_static_keys_mod.ko
---------------------------

  % eu-readelf --symbols lib/livepatch/test_klp_static_keys_mod.ko | \
        grep -e '__tracepoint_test_klp_static_keys' -e '\<module_key[2]*\>'

     49: 0000000000000010     16 OBJECT  LOCAL  DEFAULT       44 module_key
     65: 0000000000000010     16 OBJECT  LOCAL  DEFAULT       32 module_key2
     96: 0000000000000000     48 OBJECT  GLOBAL DEFAULT       40 __tracepoint_test_klp_static_keys


test_klp_static_keys.klp.o
--------------------------

  % eu-readelf --symbols lib/livepatch/test_klp_static_keys.klp.o | \
        grep -e '__tracepoint_test_klp_static_keys' -e '\<module_key[2]*\>'

     71: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF __tracepoint_test_klp_static_keys
     78: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF module_key2
     84: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF module_key

Lots of __tracepoint_test_klp_static_keys relocations since each
module function registers an event when it is called:

  % eu-readelf --reloc lib/livepatch/test_klp_static_keys.klp.o
  Relocation section [ 4] '.rela.text' for section [ 3] '.text' at offset 0x2e7d8 contains 88 entries:
    Offset              Type            Value               Addend Name
    ...
    0x000000000000002c  X86_64_32S      000000000000000000      +0 module_key2
    ...
    0x000000000000007c  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys
    ...
    0x00000000000000d9  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys
    ...
    0x0000000000000169  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys
    ...
    0x00000000000001f9  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys
    ...
    0x000000000000028c  X86_64_32S      000000000000000000      +0 module_key
    ...
    0x00000000000002dc  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys
    ...
    0x000000000000038c  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys
    ...
    0x00000000000003eb  X86_64_PC32     000000000000000000     +36 __tracepoint_test_klp_static_keys


Relocations generated for the __jump_table itself, note that I grouped
each jump entry <code, target, key> relocation set:

  Relocation section [19] '.rela__jump_table' for section [18] '__jump_table' at offset 0x2fb28 contains 30 entries:
    Offset              Type            Value               Addend Name
    000000000000000000  X86_64_PC32     000000000000000000     +12 .text
    0x0000000000000004  X86_64_PC32     000000000000000000    +102 .text
    0x0000000000000008  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys

    0x0000000000000010  X86_64_PC32     000000000000000000    +188 .text
    0x0000000000000014  X86_64_PC32     000000000000000000    +195 .text
    0x0000000000000018  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys

    0x0000000000000020  X86_64_PC32     000000000000000000    +304 .text
    0x0000000000000024  X86_64_PC32     000000000000000000      +0 .text.unlikely
    0x0000000000000028  X86_64_PC64     000000000000000000     +16 .bss

    0x0000000000000030  X86_64_PC32     000000000000000000    +332 .text
    0x0000000000000034  X86_64_PC32     000000000000000000    +339 .text
    0x0000000000000038  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys

    0x0000000000000040  X86_64_PC32     000000000000000000    +448 .text
    0x0000000000000044  X86_64_PC32     000000000000000000     +52 .text.unlikely
    0x0000000000000048  X86_64_PC64     000000000000000000      +0 module_key

    0x0000000000000050  X86_64_PC32     000000000000000000    +476 .text
    0x0000000000000054  X86_64_PC32     000000000000000000    +483 .text
    0x0000000000000058  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys

    0x0000000000000060  X86_64_PC32     000000000000000000    +592 .text
    0x0000000000000064  X86_64_PC32     000000000000000000    +104 .text.unlikely
    0x0000000000000068  X86_64_PC64     000000000000000000      +1 module_key2

    0x0000000000000070  X86_64_PC32     000000000000000000    +620 .text
    0x0000000000000074  X86_64_PC32     000000000000000000    +710 .text
    0x0000000000000078  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys

    0x0000000000000080  X86_64_PC32     000000000000000000    +796 .text
    0x0000000000000084  X86_64_PC32     000000000000000000    +886 .text
    0x0000000000000088  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys

    0x0000000000000090  X86_64_PC32     000000000000000000    +962 .text
    0x0000000000000094  X86_64_PC32     000000000000000000    +981 .text
    0x0000000000000098  X86_64_PC64     000000000000000000      +8 __tracepoint_test_klp_static_keys


test_klp_static_keys.ko
-----------------------

Finally klp-convert has transformed a bunch of symbols for us:

  % eu-readelf --symbols lib/livepatch/test_klp_static_keys.ko | \
        grep -e '__tracepoint_test_klp_static_keys' -e '\<module_key[2]*\>'

     71: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT   LOOS+0 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
     78: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT   LOOS+0 .klp.sym.test_klp_static_keys_mod.module_key2,0
     84: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF module_key

  % eu-readelf --reloc lib/livepatch/test_klp_static_keys.ko

  Relocation section [19] '.rela__jump_table' for section [18] '__jump_table' at offset 0x2480 contains 30 entries:
    Offset              Type            Value               Addend Name
    000000000000000000  X86_64_PC32     000000000000000000     +12 .text
    0x0000000000000004  X86_64_PC32     000000000000000000    +102 .text
    0x0000000000000008  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

    0x0000000000000010  X86_64_PC32     000000000000000000    +188 .text
    0x0000000000000014  X86_64_PC32     000000000000000000    +195 .text
    0x0000000000000018  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

    0x0000000000000020  X86_64_PC32     000000000000000000    +304 .text
    0x0000000000000024  X86_64_PC32     000000000000000000      +0 .text.unlikely
    0x0000000000000028  X86_64_PC64     000000000000000000     +16 .bss

    0x0000000000000030  X86_64_PC32     000000000000000000    +332 .text
    0x0000000000000034  X86_64_PC32     000000000000000000    +339 .text
    0x0000000000000038  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

    0x0000000000000040  X86_64_PC32     000000000000000000    +448 .text
    0x0000000000000044  X86_64_PC32     000000000000000000     +52 .text.unlikely
    0x0000000000000048  X86_64_PC64     000000000000000000      +0 module_key

    0x0000000000000050  X86_64_PC32     000000000000000000    +476 .text
    0x0000000000000054  X86_64_PC32     000000000000000000    +483 .text
    0x0000000000000058  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

    0x0000000000000060  X86_64_PC32     000000000000000000    +592 .text
    0x0000000000000064  X86_64_PC32     000000000000000000    +104 .text.unlikely
    0x0000000000000068  X86_64_PC64     000000000000000000      +1 .klp.sym.test_klp_static_keys_mod.module_key2,0

    0x0000000000000070  X86_64_PC32     000000000000000000    +620 .text
    0x0000000000000074  X86_64_PC32     000000000000000000    +710 .text
    0x0000000000000078  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

    0x0000000000000080  X86_64_PC32     000000000000000000    +796 .text
    0x0000000000000084  X86_64_PC32     000000000000000000    +886 .text
    0x0000000000000088  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

    0x0000000000000090  X86_64_PC32     000000000000000000    +962 .text
    0x0000000000000094  X86_64_PC32     000000000000000000    +981 .text
    0x0000000000000098  X86_64_PC64     000000000000000000      +8 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0

And here's our final set of klp-converted relocations which include the
unexported trace point symbol and module_key2 symbols:

  Relocation section [44] '.klp.rela.test_klp_static_keys_mod..text' for section [ 3] '.text' at offset 0x55c18 contains 12 entries:
    Offset              Type            Value               Addend Name
    ...
    0x00000000000003eb  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x000000000000038c  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x00000000000002dc  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x00000000000001f9  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x0000000000000169  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x00000000000000d9  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x000000000000007c  X86_64_PC32     000000000000000000     +36 .klp.sym.test_klp_static_keys_mod.__tracepoint_test_klp_static_keys,0
    0x000000000000002c  X86_64_32S      000000000000000000      +0 .klp.sym.test_klp_static_keys_mod.module_key2,0
    ...


Current behavior
----------------

Not good.  The livepatch successfully builds but crashes on load:

  % insmod lib/livepatch/test_klp_static_keys_mod.ko
  % insmod lib/livepatch/test_klp_static_keys.ko

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
  #PF error: [normal kernel read fault]
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 3 PID: 9367 Comm: insmod Tainted: G            E K   5.1.0-rc4+ #4
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
  RIP: 0010:jump_label_apply_nops+0x3b/0x60
  Code: 02 00 00 48 c1 e5 04 48 01 dd 48 39 eb 74 3a 72 0b eb 36 48 83 c3 10 48 39 dd 76 2d 48 8b 43 08 48 89 c2 83 e0 01 48 83 e2 fc <48> 8b 54 13 10 83 e2 01 38 c2 75 dd 48 89 df 31 f6 48 83 c3 10 e8
  RSP: 0018:ffffa8874068fcf8 EFLAGS: 00010206
  RAX: 0000000000000000 RBX: ffffffffc07fd000 RCX: 000000000000000d
  RDX: 000000003f803000 RSI: ffffffffa5077be0 RDI: ffffffffc07fe540
  RBP: ffffffffc07fd0a0 R08: ffffa88740f43878 R09: ffffa88740eed000
  R10: 0000000000055a4b R11: ffffa88740f43878 R12: ffffa88740f430b8
  R13: 0000000000000000 R14: ffffa88740f42df8 R15: 0000000000042b01
  FS:  00007f4f1dafb740(0000) GS:ffff9a81fbb80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000010 CR3: 00000000b5d8a000 CR4: 00000000000006e0
  Call Trace:
   module_finalize+0x184/0x1c0
   load_module+0x1400/0x1910
   ? kernel_read_file+0x18d/0x1c0
   ? __do_sys_finit_module+0xa8/0x110
   __do_sys_finit_module+0xa8/0x110
   do_syscall_64+0x55/0x1a0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7f4f1cae82bd


Future work
-----------

At the very least, I think this call-chain ordering is wrong for
livepatch static key symbols:

  load_module

    apply_relocations

    post_relocation
      module_finalize
        jump_label_apply_nops                                         <<

    ...

    prepare_coming_module
      blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
        jump_label_module_notify
          case MODULE_STATE_COMING
            jump_label_add_module                                     <<

    do_init_module

      do_one_initcall(mod->init)
        __init patch_init [kpatch-patch]
          klp_register_patch
            klp_init_patch
              klp_for_each_object(patch, obj)
                klp_init_object
                  klp_init_object_loaded
                    klp_write_object_relocations                      <<

      blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_LIVE, mod);
        jump_label_module_notify
          case MODULE_STATE_LIVE
            jump_label_invalidate_module_init

where klp_write_object_relocations() is called way *after*
jump_label_apply_nops() and jump_label_add_module().


Detection
---------

I have been tinkering with some prototype code to defer
jump_label_apply_nops() and jump_label_add_module(), but it has been
slow going.  I think the jist of it is that we're going to need to call
these dynamically when individual klp_objects are patched, not when the
livepatch module itself loads.  If anyone with static key expertise
wants to jump in here, let me know.

In the meantime, I cooked up a potential followup commit to detect
conversion of static key symbols and klp-convert failure.  It basically
runs through the output .ko's ELF symbols and verifies that none of the
converted ones can be found as a .rela__jump_table relocated symbol.  It
accurately catches the problematic references in test_klp_static_keys.ko
thus far.

This was based on a similar issue reported as a bug against
kpatch-build, in which Josh wrote code to detect this scenario:

  https://github.com/dynup/kpatch/issues/946
  https://github.com/jpoimboe/kpatch/commit/2cd2d27607566aee9590c367e615207ce1ce24c6

I can post ("livepatch/klp-convert: abort on static key conversion")
here as a follow commit if it looks reasonable and folks wish to review
it... or we can try and tackle static keys before merging klp-convert.


-- Joe
