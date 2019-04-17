Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F318C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA0920651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfDQUNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQUNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8370CAA8E;
        Wed, 17 Apr 2019 20:13:19 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C9D16013D;
        Wed, 17 Apr 2019 20:13:17 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:13:16 -0400
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
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
Message-ID: <20190417201316.GA690@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 17 Apr 2019 20:13:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:50:49AM -0400, Joe Lawrence wrote:
>
> [ ... snip ... ]
>
> TODO
> ----
>
> There are a few outstanding items that I came across while reviewing v2,
> but as changes started accumulating, it made sense to defer those to a
> later version.  I'll reply to this thread individual topics to start
> discussion sub-threads for those.

Multiple object files
=====================

For v3, we tweaked the build scripts so that we could successfully build
a klp-converted livepatch module from multiple object files.

One interesting use-case is supporting two livepatch symbols of the same
name, but different object/position values.

An example target kernel module might be layed out like this:

  test_klp_convert_mod.ko         << target module is comprised of
                                     two object files, each defining
    test_klp_convert_mod_a.o         their own local get_homonym_string()
      get_homonym_string()           function and homonym_string[]
      homonym_string[]               character arrays.

    test_klp_convert_mod_b.o
      get_homonym_string()
      homonym_string[]


A look at interesting parts of the the module's symbol table:

  % eu-readelf --symbols lib/livepatch/test_klp_convert_mod.ko | \
        grep -e 'homonym' -e test_klp_convert_mod_

     29: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS test_klp_convert_mod_a.c
     32: 0000000000000010      8 FUNC    LOCAL  DEFAULT        3 get_homonym_string
     33: 0000000000000000     17 OBJECT  LOCAL  DEFAULT        5 homonym_string
     37: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS test_klp_convert_mod_b.c
     38: 0000000000000020      8 FUNC    LOCAL  DEFAULT        3 get_homonym_string
     39: 0000000000000000     17 OBJECT  LOCAL  DEFAULT       11 homonym_string

suggests that any livepatch module that wishes to resolve to
test_klp_convert_mod_a.c :: get_homonym_string() should include an
annotation like:

  file_a.c:

      KLP_MODULE_RELOC(test_klp_convert_mod) relocs_a[] = {
            KLP_SYMPOS(get_homonym_string, 1),
      };

and to resolve test_klp_convert_mod_b.c :: get_homonym_string():

  file_b.c:

      KLP_MODULE_RELOC(test_klp_convert_mod) relocs_b[] = {
            KLP_SYMPOS(get_homonym_string, 2),
      };


Unfortunately klp-convert v3 will fail to build such livepatch module,
regardless of sympos values:

  klp-convert: Conflicting KLP_SYMPOS definition: vmlinux.state_show,2 vs. vmlinux.state_show,1.
  klp-convert: Unable to load user-provided sympos
  make[1]: *** [scripts/Makefile.modpost:148: lib/livepatch/test_klp_convert_multi_objs.ko] Error 255


This abort message can be traced to sympos_sanity_check() as it verifies
that there no duplicate symbol names found in its list of user specified
symbols (ie, those needing to be converted).


Common sympos
-------------

New test case and related fixup can be found here:

  https://github.com/joe-lawrence/linux/commits/klp-convert-v4-multiple-objs

To better debug this issue, I added another selftest that demonstrates
this configuration in isolation.  "show_state" is a popular kernel
function name (my VM reported 5 instances in kallsyms) so I chose that
symbol name.

Initially I specified the *same* symbol position (1) in both .c file
KLP_SYMPOS annotations.  At the very least, we can trivially patch
klp-convert v3 to support annotations for the the same symbol <object,
name, position> value across object files.

Result: a small tweak to sympos_sanity_check() to relax its symbol
uniqueness verification:  allow for duplicate <object, name, position>
instances.  Now it will only complain when a supplied symbol references
the same <object, name> but a different <position>.

diff --git a/scripts/livepatch/klp-convert.c b/scripts/livepatch/klp-convert.c
index 82c27d219372..713835dfc9ec 100644
--- a/scripts/livepatch/klp-convert.c
+++ b/scripts/livepatch/klp-convert.c
@@ -194,7 +194,10 @@ static void clear_sympos_annontations(struct elf *klp_elf)
 	}
 }

-/* Checks if two or more elements in usr_symbols have the same name */
+/*
+ * Checks if two or more elements in usr_symbols have the same
+ * object and name, but different symbol position
+ */
 static bool sympos_sanity_check(void)
 {
 	bool sane = true;
@@ -203,7 +206,9 @@ static bool sympos_sanity_check(void)
 	list_for_each_entry(sp, &usr_symbols, list) {
 		aux = list_next_entry(sp, list);
 		list_for_each_entry_from(aux, &usr_symbols, list) {
-			if (strcmp(sp->symbol_name, aux->symbol_name) == 0) {
+			if (sp->pos != aux->pos &&
+			    strcmp(sp->object_name, aux->object_name) == 0 &&
+			    strcmp(sp->symbol_name, aux->symbol_name) == 0)
 				WARN("Conflicting KLP_SYMPOS definition: %s.%s,%d vs. %s.%s,%d.",
 				sp->object_name, sp->symbol_name, sp->pos,
 				aux->object_name, aux->symbol_name, aux->pos);


Unique sympos
-------------

But even with the above workaround, specifying unique symbol positions
will (and should) result in a klp-convert complaint.

When modifying the test module with unique symbol position annotation
values (1 and 2 respectively):

  test_klp_convert_multi_objs_a.c:

    extern void *state_show;
    ...
    KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
            KLP_SYMPOS(state_show, 1)
    };

  test_klp_convert_multi_objs_b.c:

    extern void *state_show;
    ...
    KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
            KLP_SYMPOS(state_show, 2)
    };


Each object file's symbol table contains a "state_show" instance:

  % eu-readelf --symbols lib/livepatch/test_klp_convert_multi_objs_a.o | grep '\<state_show\>'
     30: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show

  % eu-readelf --symbols lib/livepatch/test_klp_convert_multi_objs_b.o | grep '\<state_show\>'
     20: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show

and the intermediate test_klp_convert_multi_objs.klp.o file contains a
combined .klp.module_relocs.vmlinux relocation section with two
KLP_SYMPOS structures, each with a unique <sympos> value:

  % objcopy -O binary --only-section=.klp.module_relocs.vmlinux \
      lib/livepatch/test_klp_convert_multi_objs.klp.o >(hexdump)

  0000000 0000 0000 0000 0000 0001 0000 0000 0000
  0000010 0000 0000 0002 0000

but the symbol tables were merged, sorted and non-unique symbols
removed, leaving a *single* unresolved "state_show" instance:

  % eu-readelf --symbols lib/livepatch/test_klp_convert_multi_objs.klp.o | grep '\<state_show\>'
     53: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show

which means that even though we have separate relocations for each
"state_show" instance:

  Relocation section [ 6] '.rela.text.unlikely' for section [ 5] '.text.unlikely' at offset 0x44510 contains 11 entries:
    Offset              Type            Value               Addend Name
    0x0000000000000003  X86_64_32S      000000000000000000      +0 state_show
    ...
    0x0000000000000034  X86_64_32S      000000000000000000      +0 state_show
    ...

they share the same rela->sym and there is no way to distinguish which
one correlates to which KLP_SYMPOS structure.


Future Work
-----------

I don't see an easy way to support multiple homonym <object, name>
symbols with unique <position> values in the current livepatch module
Elf format.  The only solutions that come to mind right now include
renaming homonym symbols somehow to retain the relocation->symbol
relationship when separate object files are combined.  Perhaps an
intermediate linker step could make annotated symbols unique in some way
to achieve this.  /thinking out loud

In the meantime, the unique symbol <position> case is already detected
and with a little tweaking we could support multiple common symbol
<position> values.

-- Joe
