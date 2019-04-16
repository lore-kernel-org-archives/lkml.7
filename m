Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37A4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC05E2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfDPI37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:57244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728608AbfDPI37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2DDAAE16;
        Tue, 16 Apr 2019 08:29:56 +0000 (UTC)
Date:   Tue, 16 Apr 2019 10:29:55 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Balbir Singh <bsingharora@gmail.com>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
In-Reply-To: <20190416052422.GA7482@350D>
Message-ID: <alpine.LSU.2.21.1904161024220.15816@pobox.suse.cz>
References: <20190410155058.9437-1-joe.lawrence@redhat.com> <20190416052422.GA7482@350D>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Balbir Singh wrote:

> On Wed, Apr 10, 2019 at 11:50:49AM -0400, Joe Lawrence wrote:
> > Hi folks,
> > 
> > This is the third installment of the klp-convert tool for generating and
> > processing livepatch symbols for livepatch module builds.  For those
> > following along at home, archive links to previous versions:
> > 
> > RFC:
> >   https://lore.kernel.org/lkml/cover.1477578530.git.jpoimboe@redhat.com/
> > v2:
> >   https://lore.kernel.org/lkml/f52d29f7-7d1b-ad3d-050b-a9fa8878faf2@redhat.com/
> > 
> > (Note that I don't see v2 archived at lore, but that is a link to the
> > most recent subthread that lore did catch.)
> > 
> > 
> > Livepatches may use symbols which are not contained in its own scope,
> > and, because of that, may end up compiled with relocations that will
> > only be resolved during module load. Yet, when the referenced symbols are
> > not exported, solving this relocation requires information on the object
> > that holds the symbol (either vmlinux or modules) and its position inside
> > the object, as an object may contain multiple symbols with the same name.
> > Providing such information must be done accordingly to what is specified
> > in Documentation/livepatch/module-elf-format.txt.
> >
> 
> 
> Could we get some details with examples or a sample, sorry I might be dense
> and missing simple information. The problem being solved is not clear to
> me from the changelog.

The patch set tries to solve the problem described in 
Documentation/livepatch/module-elf-format.txt. Currently, there is no tool 
in upstream to automatically generate the relocation records. kpatch-build 
can do it and we'd like to have it as well. klp-convert should thus do the 
job.

The sample module is introduced in patch 7 and you can look at the 
selftests in patch 9 too.

Maybe we can describe the problem better in the cover letter, but on the 
other hand patch changelogs are more important and they are good (well, in 
my opinion of course).

> > Currently, there is no trivial way to embed the required information as
> > requested in the final livepatch elf object. klp-convert solves this
> > problem in two different forms: (i) by relying on a symbol map, which is
> > built during kernel compilation, to automatically infer the relocation
> > targeted symbol, and, when such inference is not possible (ii) by using
> > annotations in the elf object to convert the relocation accordingly to
> > the specification, enabling it to be handled by the livepatch loader.
> > 
> > Given the above, add support for symbol mapping in the form of
> > Symbols.list file; add klp-convert tool; integrate klp-convert tool into
> > kbuild; make livepatch modules discernible during kernel compilation
> > pipeline; add data-structure and macros to enable users to annotate
> > livepatch source code; make modpost stage compatible with livepatches;
> > update livepatch-sample and update documentation.
> > 
> > The patch was tested under three use-cases:
> > 
> > use-case 1: There is a relocation in the lp that can be automatically
> > resolved by klp-convert.  For example. see the saved_command_line
> > variable in lib/livepatch/test_klp_convert2.c.
> > 
> > use-case 2: There is a relocation in the lp that cannot be automatically
> > resolved, as the name of the respective symbol appears in multiple
> > objects. The livepatch contains an annotation to enable a correct
> > relocation.  See the KLP_MODULE_RELOC / KLP_SYMPOS annotation sections
> > in lib/livepatch/test_klp_convert{1,2}.c.
> > 
> > use-case 3: There is a relocation in the lp that cannot be automatically
> > resolved similarly as 2, but no annotation was provided in the
> > livepatch, triggering an error during compilation.  Reproducible by
> > removing the KLP_MODULE_RELOC / KLP_SYMPOS annotation sections in
> > lib/livepatch/test_klp_convert{1,2}.c.
> >
> 
> 
> Are these a part of the series?

Yes, see 9/9.

Regards,
Miroslav
