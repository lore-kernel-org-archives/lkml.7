Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQNKKAf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDPFY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:24:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40634 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfDPFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:24:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so9719969plr.7;
        Mon, 15 Apr 2019 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4PaT/tb5pp0x50T4tMHrD0XyibPpmE1/SdcsyibnZU=;
        b=uQNKKAf7Yxxo+eXANaF4NVXpRhWLICM+QALVEbTblPBbeNBGu31L6AGy1xkw3xasmC
         HC1AAaLqCCFpbUjMDy53loHMapVxb4ifFHs7GM2HzanyjX1QzgC8EM8FEN83ZgOc8lZd
         IL6XpX1cMC6sk24r5zpMw/CPBsu+W14w9WsKishttADTQB0YAPjynsa2X0neg1eCokIe
         rSnPVN6cAPe5rVGHU63b6Oxme6cv6B39humdeaGi1hCokIR3PQYegVoPdna/LfojnYBx
         xX16Y5rXSXCqv22FxxTn0rO0aA0vY9j38nNmtYAvbkxdtNb6ylUnygfAX0h0+M4KOxUF
         ENxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4PaT/tb5pp0x50T4tMHrD0XyibPpmE1/SdcsyibnZU=;
        b=BNPlP/FiBdsqy/BOUue7UwHvErXq+4lwb50L0Oua5602H9JTbQYa/o3eS/FjbkGpW3
         ebMfC363CNjJIECbrTSkoELX3xdY2fsig8Zr5QXgVGs1w23ARZQNkv1NNaCgROWjvlwD
         QRRXYNLIL1cshMN/ovZZmpJVHyhYb3aquM7t89ageedAuwEIx86tNnQHQ/iYA2+y7oo5
         PI5GGYoDIZZTH2ObZB47ubcF2pU/HTdPGT0s/8MJcNeKXpVG3+XboJnSLuA/ThX4Bfdn
         ZL4AsFxcGcqydp6IUph5OD7Og2ALaQLhnT9+VptrRu42qn9JiKyWstuathLBkvfxSl7z
         gj5w==
X-Gm-Message-State: APjAAAXBYAqR3sLTvZk84dNFrH3UWk6iOfB2yFjAf/aaLrEf/s6MDgkj
        bh6tNC+ogq3ic+jayBmVbJ2BiPHx
X-Google-Smtp-Source: APXvYqyGfJS7LSKysIgD5/yxP7AQIR3De2H00tgPevkIJ0J5YzBJHxzrfJqcXkJWXLvqQV7Qp1gRIg==
X-Received: by 2002:a17:902:4381:: with SMTP id j1mr15773379pld.173.1555392266785;
        Mon, 15 Apr 2019 22:24:26 -0700 (PDT)
Received: from localhost ([203.220.205.62])
        by smtp.gmail.com with ESMTPSA id i129sm92762160pfc.163.2019.04.15.22.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 22:24:25 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:24:22 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
Message-ID: <20190416052422.GA7482@350D>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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


Could we get some details with examples or a sample, sorry I might be dense
and missing simple information. The problem being solved is not clear to
me from the changelog.
 
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


Are these a part of the series?

Balbir Singh
 
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
