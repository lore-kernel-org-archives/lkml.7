Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F662343A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cvJtQ5xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfICQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:24:16 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:24648 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfICQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:24:15 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x83GNuga018634
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 01:23:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x83GNuga018634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567527837;
        bh=y+e3X3MFeRPRQ94ud5uQm3RXqxAVNjo2F8aWOFAv0Tg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cvJtQ5xi0z5+eBfL2LTHDTGJQd55FFdII9cuj3sYTNI8l1tSEcRpK2jgBzi9oFG9O
         odCEtZtx/MP6GJtPjsd1qcA+zBeZPtBMgd5H4Vq+aBIyyBkHmRnXSgrSmHeWiZX2ON
         Hi9+QPvmEwl5VxcyWokagGvUKDSIOg5Mz1emQmGV3ewcUA+NXl/yDBdEqhYteHgR7C
         ygTcVmpHNKlTDsO9Rsr3cyjWkfM/aRrrI9UtND0Dz6ReAzFQl/5AqTaEEFzPNHXUp4
         He1AXUPtnaeT7tgBDNKbDjIpjdIKApCQhRRTYrzCw35lR8XIuK12ciqTKqRkv0dK6x
         4exd/Ouj3ETdg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id w195so9043040vsw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:23:56 -0700 (PDT)
X-Gm-Message-State: APjAAAUrA38eG8gOHLzmRamRkHQgaWS7sIMRLNK/XkWFE4qmxHwGXFm2
        4rkrFyka7xVbTkLbdWtw3TTjphGVWg5Qmo5/txU=
X-Google-Smtp-Source: APXvYqzlQHEQ2AF+Jw1PfKxY2PsYc9qAKjBvTVDFoq9TbtWIgjl6qzVfYmqQfVrtL7Fr2DcBqiVgXNmgL9Dj6TWhNvk=
X-Received: by 2002:a67:e9cc:: with SMTP id q12mr9756351vso.181.1567527835701;
 Tue, 03 Sep 2019 09:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190806211047.232709-1-nhuck@google.com>
In-Reply-To: <20190806211047.232709-1-nhuck@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 4 Sep 2019 01:23:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARewhp0TZ1tQ1Sy=R3wbBB0BwY6QasEBg6xmPJ3SpErbg@mail.gmail.com>
Message-ID: <CAK7LNARewhp0TZ1tQ1Sy=R3wbBB0BwY6QasEBg6xmPJ3SpErbg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Add clang-tidy and static analyzer support to makefile
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 6:13 AM Nathan Huckleberry <nhuck@google.com> wrote:
>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
> These patches add clang-tidy and the clang static-analyzer as make
> targets. The goal of these patches is to make static analysis tools
> usable and extendable by any developer or researcher who is familiar
> with basic c++.
>
> The current static analysis tools require intimate knowledge of the internal
> workings of the static analysis.  Clang-tidy and the clang static analyzers
> expose an easy to use api and allow users unfamiliar with clang to
> write new checks with relative ease.
>
> ===Clang-tidy===
>
> Clang-tidy is an easily extendable 'linter' that runs on the AST.
> Clang-tidy checks are easy to write and understand. A check consists of
> two parts, a matcher and a checker. The matcher is created using a
> domain specific language that acts on the AST
> (https://clang.llvm.org/docs/LibASTMatchersReference.html).  When AST
> nodes are found by the matcher a callback is made to the checker. The
> checker can then execute additional checks and issue warnings.
>
> Here is an example clang-tidy check to report functions that have calls
> to local_irq_disable without calls to local_irq_enable and vice-versa.
> Functions flagged with __attribute((annotation("ignore_irq_balancing")))
> are ignored for analysis.
>
> The full patch can be found here (https://reviews.llvm.org/D65828)
>
> ```
> void IrqUnbalancedCheck::registerMatchers(MatchFinder *Finder) {
>   // finds calls to "arch_local_irq_disable" in a function body
>   auto disable =
>               forEachDescendant(
>                   callExpr(
>                       hasDeclaration(
>                           namedDecl(
>                               hasName("arch_local_irq_disable")))).bind("disable"));
>
>   // finds calls to "arch_local_irq_enable" in a function body
>   auto enable =
>               forEachDescendant(
>                   callExpr(
>                       hasDeclaration(
>                           namedDecl(
>                               hasName("arch_local_irq_enable")))).bind("enable"));
>
>   // Looks for function body that has the following property:
>   // ((disable && !enable) || (enable && !disable))
>   auto matcher = functionDecl(
>       anyOf(allOf(disable, unless(enable)), allOf(enable, unless(disable))));
>
>   Finder->addMatcher(matcher.bind("func"), this);
> }
>
> std::string annotation = "ignore_irq_balancing";
> void IrqUnbalancedCheck::check(const MatchFinder::MatchResult &Result) {
>   const auto *MatchedDecl = Result.Nodes.getNodeAs<FunctionDecl>("func");
>   const auto *DisableCall = Result.Nodes.getNodeAs<CallExpr>("disable");
>   const auto *EnableCall = Result.Nodes.getNodeAs<CallExpr>("enable");
>
>   // If the function has __attribute((annotate("ignore_irq_balancing"))
>   for (const auto *Attr : MatchedDecl->attrs()) {
>     if (Attr->getKind() == clang::attr::Annotate) {
>       if(dyn_cast<AnnotateAttr>(Attr)->getAnnotation().str() == annotation) {
>         return;
>       }
>     }
>   }
>
>   if(EnableCall) {
>     diag(MatchedDecl->getLocation(), "call to 'enable_local_irq' without 'disable_local_irq' in %0 ")
>         << MatchedDecl;
>     diag(EnableCall->getBeginLoc(), "call to 'enable_local_irq'", DiagnosticIDs::Note)
>         << MatchedDecl;
>   }
>
>   if(DisableCall) {
>     diag(MatchedDecl->getLocation(), "call to 'disable_local_irq' without 'enable_local_irq' in %0 ")
>         << MatchedDecl;
>     diag(DisableCall->getBeginLoc(), "call to 'disable_local_irq'", DiagnosticIDs::Note)
>         << MatchedDecl;
>   }
> }
> ```
>
> ===Clang static analyzer===
>
> The clang static analyzer is a more powerful static analysis tool that
> uses symbolic execution to find bugs. Currently there is a check that
> looks for potential security bugs from invalid uses of kmalloc and
> kfree. There are several more general purpose checks that are useful for
> the kernel.
>
> The clang static analyzer is well documented and designed to be
> extensible.
> (https://clang-analyzer.llvm.org/checker_dev_manual.html)
> (https://github.com/haoNoQ/clang-analyzer-guide/releases/download/v0.1/clang-analyzer-guide-v0.1.pdf)
>
>
> Why add clang-tidy and the clang static analyzer when other static
> analyzers are already in the kernel?
>
> The main draw of the clang tools is how accessible they are. The clang
> documentation is very nice and these tools are built specifically to be
> easily extendable by any developer. They provide an accessible method of
> bug-finding and research to people who are not overly familiar with the
> kernel codebase.
>
>  Makefile                                      |  3 ++
>  scripts/clang-tools/Makefile.clang-tools      | 35 ++++++++++++++
>  .../{ => clang-tools}/gen_compile_commands.py |  0
>  scripts/clang-tools/parse_compile_commands.py | 47 +++++++++++++++++++
>  4 files changed, 85 insertions(+)
>  create mode 100644 scripts/clang-tools/Makefile.clang-tools
>  rename scripts/{ => clang-tools}/gen_compile_commands.py (100%)
>  create mode 100755 scripts/clang-tools/parse_compile_commands.py
>
> diff --git a/Makefile b/Makefile
> index fabc127d127f..49f1d3fa48a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -709,6 +709,7 @@ KBUILD_CFLAGS       += $(call cc-option,--param=allow-store-data-races=0)
>
>  include scripts/Makefile.kcov
>  include scripts/Makefile.gcc-plugins
> +include scripts/clang-tools/Makefile.clang-tools
>
>  ifdef CONFIG_READABLE_ASM
>  # Disable optimizations that make assembler listings hard to read.
> @@ -1470,6 +1471,8 @@ help:
>         @echo  '  headers_check   - Sanity check on exported headers'
>         @echo  '  headerdep       - Detect inclusion cycles in headers'
>         @echo  '  coccicheck      - Check with Coccinelle'
> +       @echo  '  clang-analyzer  - Check with clang static analyzer'
> +       @echo  '  clang-tidy      - Check with clang-tidy'
>         @echo  ''
>         @echo  'Kernel selftest:'
>         @echo  '  kselftest       - Build and run kernel selftest (run as root)'
> diff --git a/scripts/clang-tools/Makefile.clang-tools b/scripts/clang-tools/Makefile.clang-tools
> new file mode 100644
> index 000000000000..0adb6df20777
> --- /dev/null
> +++ b/scripts/clang-tools/Makefile.clang-tools
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0
> +PHONY += clang-tidy
> +HAS_PARALLEL := $(shell (parallel --version 2> /dev/null) | grep 'GNU parallel' 2> /dev/null)
> +clang-tidy:
> +ifdef CONFIG_CC_IS_CLANG
> +       $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
> +ifdef HAS_PARALLEL
> +       #Xargs interleaves multiprocessed output. GNU Parallel does not.
> +       scripts/clang-tools/parse_compile_commands.py compile_commands.json \
> +               | parallel -k -j $(shell nproc) 'echo {} && clang-tidy -p . "-checks=-*,linuxkernel-*" {}'
> +else
> +       @echo "GNU parallel is not installed. Defaulting to non-parallelized runs"
> +       scripts/clang-tools/parse_compile_commands.py compile_commands.json \
> +               | xargs -L 1 -I@ sh -c "echo '@' && clang-tidy -p . '-checks=-*,linuxkernel-*' @"
> +endif
> +else
> +       $(error Clang-tidy requires CC=clang)
> +endif


What is the benefit for wiring this to the Makefile?

Is there any drawback if you implement this in a small
independent shell script or something?


You are already adding a new python script
just for reading the json file.

I would invoke clang-{tidy,analyzer} from that python script.

If you unify these into a python script,
you can support the multiprocessing with a
python library ('import multiprocessing')
without GNU parallel.


Thanks.



> +PHONY += clang-analyzer
> +clang-analyzer:
> +ifdef CONFIG_CC_IS_CLANG
> +       $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
> +ifdef HAS_PARALLEL
> +       #Xargs interleaves multiprocessed output. GNU Parallel does not.
> +       scripts/clang-tools/parse_compile_commands.py compile_commands.json \
> +               | parallel -k -j $(shell nproc) 'echo {} && clang-tidy -p . "-checks=-*,clang-analyzer-*" {}'
> +else
> +       @echo "GNU parallel is not installed. Defaulting to non-parallelized runs"
> +       scripts/clang-tools/parse_compile_commands.py compile_commands.json \
> +               | xargs -L 1 -I@ sh -c "echo '@' && clang-tidy -p . '-checks=-*,clang-analyzer-*' @"
> +endif
> +else
> +       $(error Clang-analyzer requires CC=clang)
> +endif
> diff --git a/scripts/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> similarity index 100%
> rename from scripts/gen_compile_commands.py
> rename to scripts/clang-tools/gen_compile_commands.py
> diff --git a/scripts/clang-tools/parse_compile_commands.py b/scripts/clang-tools/parse_compile_commands.py
> new file mode 100755
> index 000000000000..d6bc1bf9951e
> --- /dev/null
> +++ b/scripts/clang-tools/parse_compile_commands.py
> @@ -0,0 +1,47 @@
> +#!/usr/bin/env python
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) Google LLC, 2019
> +#
> +# Author: Nathan Huckleberry <nhuck@google.com>
> +#
> +"""A helper routine for make clang-tidy to parse compile_commands.json."""
> +
> +import argparse
> +import json
> +import logging
> +import os
> +import re
> +
> +def parse_arguments():
> +  """Set up and parses command-line arguments.
> +  Returns:
> +    file_path: Path to compile_commands.json file
> +  """
> +  usage = """Parse a compilation database and return a list of files
> +  included in the database"""
> +  parser = argparse.ArgumentParser(description=usage)
> +
> +  file_path_help = ('Path to the compilation database to parse')
> +  parser.add_argument('file',  type=str, help=file_path_help)
> +
> +  args = parser.parse_args()
> +
> +  return args.file
> +
> +
> +def main():
> +  filename = parse_arguments()
> +
> +  #Read JSON data into the datastore variable
> +  if filename:
> +    with open(filename, 'r') as f:
> +      datastore = json.load(f)
> +
> +      #Use the new datastore datastructure
> +      for entry in datastore:
> +        print(entry['file'])
> +
> +
> +if __name__ == '__main__':
> +    main()
> --
> 2.22.0.709.g102302147b-goog
>


--
Best Regards
Masahiro Yamada
