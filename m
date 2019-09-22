Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209BD208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569166097;
	bh=emeKUXNkGhOOZoJ65MzVvmly107262c4CjzB+ec294o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CZ5uft0V+jvZHxEwtGFwMPckhtgW/AAmQXVfdgI40qdruxoj+Z2y9mj7FDKKnxZy/
	 UKTrOQXzkd3B6dwql+GI/e+IDtJVmiwKD8J3cBiq/Y5DkbhDkcZGaeAoAxRyk4W50E
	 eblp+gUZ1Wip/PwlMLlCWvPTdoyI8LGYWe9rrQvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfIVP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 11:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbfIVP2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 11:28:16 -0400
Received: from linux-8ccs (ip5f5adbd6.dynamic.kabel-deutschland.de [95.90.219.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E1E206C2;
        Sun, 22 Sep 2019 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569166094;
        bh=emeKUXNkGhOOZoJ65MzVvmly107262c4CjzB+ec294o=;
        h=Date:From:To:Cc:Subject:From;
        b=hyqDyDsEKAGOZ9SAcgerHRHa0b/UgjzDq7savw5aGXsjSIAF3Ti7ju7CdyzAw2GlP
         E74knQYSf9SMRNJwDFgd6m7qorx3xeoIH27a+dbo20t0VMW9GNS3fyFsFz/GNOR0LC
         JolfsRyvGnurgeZNMSpsXQL919dfg33RuaCn+hac=
Date:   Sun, 22 Sep 2019 17:28:09 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.4
Message-ID: <20190922152809.GA27554@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The main bulk of this pull request introduces a new exported symbol
namespaces feature. The number of exported symbols is increasingly growing
with each release (we're at about 31k exports as of 5.3-rc7) and we
currently have no way of visualizing how these symbols are "clustered" or
making sense of this huge export surface. Namespacing exported symbols
allows kernel developers to more explicitly partition and categorize
exported symbols, as well as more easily limiting the availability of
namespaced symbols to other parts of the kernel. For starters, we have
introduced the USB_STORAGE namespace to demonstrate the API's usage. I have
briefly summarized the feature and its main motivations in the tag below.

Disclaimer: linux-next releases were originally planned to be paused from
Sept 5 to Sept 30, then from Sept 15, Mark Brown picked up the work and
resumed doing -next releases. Since the patchset landed in modules-next
during the week of -rc8, it has unfortunately not gotten linux-next time. I
would understand if you'd prefer to defer to the next release.

Also note that there is a conflict with the kbuild tree. Many thanks to
Matthias Maennich for quickly providing the conflict resolution (diff
below). Only include/linux/export.h and scripts/Makefile.modpost had hard
conflicts. In the inline diff below, I've provided the result of the
conflict resolution from merging modules-next into your master branch.
Please let me know if you run into any trouble.

Thanks,

Jessica

----->8-----
diff --cc .gitignore
index ce2c6348d372,9ee63aa2a3fb..70580bdd352c
--- a/.gitignore
+++ b/.gitignore
@@@ -32,8 -32,10 +32,9 @@@
  *.lzo
  *.mod
  *.mod.c
+ *.ns_deps
  *.o
  *.o.*
 -*.order
  *.patch
  *.s
  *.so
diff --cc include/linux/export.h
index 7d8c112a8b61,ef5d015d754a..6ecb04014558
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@@ -18,6 -18,11 +18,8 @@@ extern struct module __this_module
  #define THIS_MODULE ((struct module *)0)
  #endif
  
 -#ifdef CONFIG_MODULES
 -
+ #define NS_SEPARATOR "."
+ 
 -#if defined(__KERNEL__) && !defined(__GENKSYMS__)
  #ifdef CONFIG_MODVERSIONS
  /* Mark the CRC weak since genksyms apparently decides not to
   * generate a checksums for some symbols */
@@@ -71,24 -98,26 +95,35 @@@ struct kernel_symbol 
  };
  #endif
  
 +#ifdef __GENKSYMS__
 +
 +#define ___EXPORT_SYMBOL(sym, sec)	__GENKSYMS_EXPORT_SYMBOL(sym)
++#define ___EXPORT_SYMBOL_NS(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 +
 +#else
 +
- /* For every exported symbol, place a struct in the __ksymtab section */
- #define ___EXPORT_SYMBOL(sym, sec)					\
+ #define ___export_symbol_common(sym, sec)				\
  	extern typeof(sym) sym;						\
- 	__CRC_SYMBOL(sym, sec)						\
+ 	__CRC_SYMBOL(sym, sec);						\
  	static const char __kstrtab_##sym[]				\
  	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
- 	= #sym;								\
+ 	= #sym								\
+ 
+ /* For every exported symbol, place a struct in the __ksymtab section */
+ #define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
+ 	___export_symbol_common(sym, sec);				\
+ 	static const char __kstrtab_ns_##sym[]				\
+ 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
+ 	= #ns;								\
+ 	__KSYMTAB_ENTRY_NS(sym, sec, ns)
+ 
+ #define ___EXPORT_SYMBOL(sym, sec)					\
+ 	___export_symbol_common(sym, sec);				\
  	__KSYMTAB_ENTRY(sym, sec)
  
 -#if defined(__DISABLE_EXPORTS)
 +#endif
 +
 +#if !defined(CONFIG_MODULES) || defined(__DISABLE_EXPORTS)
  
  /*
   * Allow symbol exports to be disabled completely so that C code may
@@@ -121,18 -151,36 +157,37 @@@
  #define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
  #define __cond_export_sym_0(sym, sec) /* nothing */
  
+ #define __EXPORT_SYMBOL_NS(sym, sec, ns)				\
+ 	__ksym_marker(sym);						\
+ 	__cond_export_ns_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
+ #define __cond_export_ns_sym(sym, sec, ns, conf)			\
+ 	___cond_export_ns_sym(sym, sec, ns, conf)
+ #define ___cond_export_ns_sym(sym, sec, ns, enabled)			\
+ 	__cond_export_ns_sym_##enabled(sym, sec, ns)
+ #define __cond_export_ns_sym_1(sym, sec, ns) ___EXPORT_SYMBOL_NS(sym, sec, ns)
+ #define __cond_export_ns_sym_0(sym, sec, ns) /* nothing */
+ 
  #else
 -#define __EXPORT_SYMBOL_NS ___EXPORT_SYMBOL_NS
 +
- #define __EXPORT_SYMBOL(sym, sec)	___EXPORT_SYMBOL(sym, sec)
+ #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
 -#endif
++#define __EXPORT_SYMBOL_NS ___EXPORT_SYMBOL_NS
 +
 +#endif /* CONFIG_MODULES */
  
+ #ifdef DEFAULT_SYMBOL_NAMESPACE
+ #undef __EXPORT_SYMBOL
+ #define __EXPORT_SYMBOL(sym, sec)				\
+ 	__EXPORT_SYMBOL_NS(sym, sec, DEFAULT_SYMBOL_NAMESPACE)
+ #endif
+ 
 -#define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
 -#define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
 -#define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
 -#define EXPORT_SYMBOL_NS(sym, ns) __EXPORT_SYMBOL_NS(sym, "", ns)
 -#define EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL_NS(sym, "_gpl", ns)
 -
 +#define EXPORT_SYMBOL(sym)		__EXPORT_SYMBOL(sym, "")
 +#define EXPORT_SYMBOL_GPL(sym)		__EXPORT_SYMBOL(sym, "_gpl")
 +#define EXPORT_SYMBOL_GPL_FUTURE(sym)	__EXPORT_SYMBOL(sym, "_gpl_future")
++#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL_NS(sym, "", ns)
++#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL_NS(sym, "_gpl", ns)
  #ifdef CONFIG_UNUSED_SYMBOLS
 -#define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
 -#define EXPORT_UNUSED_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_unused_gpl")
 +#define EXPORT_UNUSED_SYMBOL(sym)	__EXPORT_SYMBOL(sym, "_unused")
 +#define EXPORT_UNUSED_SYMBOL_GPL(sym)	__EXPORT_SYMBOL(sym, "_unused_gpl")
  #else
  #define EXPORT_UNUSED_SYMBOL(sym)
  #define EXPORT_UNUSED_SYMBOL_GPL(sym)
diff --cc scripts/Makefile.modpost
index 9800a3988f23,743fe3a2e885..952fff485546
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@@ -88,13 -99,60 +89,15 @@@ modules := $(sort $(shell cat $(MODORDE
  quiet_cmd_modpost = MODPOST $(words $(modules)) modules
        cmd_modpost = sed 's/ko$$/o/' $(MODORDER) | $(MODPOST)
  
 -PHONY += modules-modpost
 -modules-modpost:
 +__modpost:
 +	@$(kecho) '  Building modules, stage 2.'
  	$(call cmd,modpost)
 -
 -# Declare generated files as targets for modpost
 -$(modules:.ko=.mod.c): modules-modpost
 -
 -# Step 5), compile all *.mod.c files
 -
 -# modname is set to make c_flags define KBUILD_MODNAME
 -modname = $(notdir $(@:.mod.o=))
 -
 -quiet_cmd_cc_o_c = CC      $@
 -      cmd_cc_o_c = $(CC) $(c_flags) $(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE) \
 -		   -c -o $@ $<
 -
 -$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
 -	$(call if_changed_dep,cc_o_c)
 -
 -targets += $(modules:.ko=.mod.o)
 -
 -ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 -
 -# Step 6), final link of the modules with optional arch pass after final link
 -quiet_cmd_ld_ko_o = LD [M]  $@
 -      cmd_ld_ko_o =                                                     \
 -	$(LD) -r $(KBUILD_LDFLAGS)                                      \
 -                 $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
 -                 -o $@ $(real-prereqs) ;                                \
 -	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 -
 -$(modules): %.ko :%.o %.mod.o FORCE
 -	+$(call if_changed,ld_ko_o)
 -
 -targets += $(modules)
 +ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
 +endif
  
+ nsdeps: __modpost
+ 
 -# Add FORCE to the prequisites of a target to force it to be always rebuilt.
 -# ---------------------------------------------------------------------------
 -
 -PHONY += FORCE
 -
 -FORCE:
 -
 -# Read all saved command lines and dependencies for the $(targets) we
 -# may be building above, using $(if_changed{,_dep}). As an
 -# optimization, we don't need to read them if the target does not
 -# exist, we will rebuild anyway in that case.
 -
 -existing-targets := $(wildcard $(sort $(targets)))
 -
 --include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 -
  endif
  
  .PHONY: $(PHONY)
diff --cc scripts/mod/modpost.c
index 820eed87fb43,be72da25fe7c..3961941e8e7a
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@@ -2379,10 -2440,10 +2453,11 @@@ static void read_dump(const char *fname
  			mod = new_module(modname);
  			mod->skip = 1;
  		}
- 		s = sym_add_exported(symname, mod, export_no(export));
+ 		s = sym_add_exported(symname, namespace, mod,
+ 				     export_no(export));
  		s->kernel    = kernel;
  		s->preloaded = 1;
 +		s->is_static = 0;
  		sym_update_crc(symname, mod, crc, export_no(export));
  	}
  	release_file(file, size);
----->8-----

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4

for you to fetch changes up to 2e6fcfeb9df6048a63fe0d5f7dfa39274bacbb71:

  module: Remove leftover '#undef' from export header (2019-09-12 15:29:46 +0200)

----------------------------------------------------------------
Modules updates for v5.4

Summary of modules changes for the 5.4 merge window:

- Introduce exported symbol namespaces.

  This new feature allows subsystem maintainers to partition and
  categorize their exported symbols into explicit namespaces. Module
  authors are now required to import the namespaces they need.

  Some of the main motivations of this feature include: allowing kernel
  developers to better manage the export surface, allow subsystem
  maintainers to explicitly state that usage of some exported symbols
  should only be limited to certain users (think: inter-module or
  inter-driver symbols, debugging symbols, etc), as well as more easily
  limiting the availability of namespaced symbols to other parts of the
  kernel. With the module import requirement, it is also easier to spot
  the misuse of exported symbols during patch review. Two new macros are
  introduced: EXPORT_SYMBOL_NS() and EXPORT_SYMBOL_NS_GPL(). The API is
  thoroughly documented in Documentation/kbuild/namespaces.rst.

- Some small code and kbuild cleanups here and there.

----------------------------------------------------------------
Masahiro Yamada (3):
      module: remove redundant 'depends on MODULES'
      module: move CONFIG_UNUSED_SYMBOLS to the sub-menu of MODULES
      module: remove unneeded casts in cmp_name()

Matthias Maennich (11):
      module: support reading multiple values per modinfo tag
      export: explicitly align struct kernel_symbol
      module: add support for symbol namespaces.
      modpost: add support for symbol namespaces
      module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
      export: allow definition default namespaces in Makefiles or sources
      modpost: add support for generating namespace dependencies
      scripts: Coccinelle script for namespace dependencies.
      docs: Add documentation for Symbol Namespaces
      usb-storage: remove single-use define for debugging
      usb-storage: export symbols in USB_STORAGE namespace

Will Deacon (2):
      module: Fix link failure due to invalid relocation on namespace offset
      module: Remove leftover '#undef' from export header

 .gitignore                                  |   1 +
 Documentation/kbuild/modules.rst            |   7 +-
 Documentation/kbuild/namespaces.rst         | 154 ++++++++++++++++++++++++++++
 Documentation/kernel-hacking/hacking.rst    |  18 ++++
 MAINTAINERS                                 |   5 +
 Makefile                                    |  14 ++-
 arch/m68k/include/asm/export.h              |   1 -
 drivers/usb/storage/Makefile                |   2 +
 drivers/usb/storage/alauda.c                |   1 +
 drivers/usb/storage/cypress_atacb.c         |   1 +
 drivers/usb/storage/datafab.c               |   1 +
 drivers/usb/storage/debug.h                 |   2 -
 drivers/usb/storage/ene_ub6250.c            |   1 +
 drivers/usb/storage/freecom.c               |   1 +
 drivers/usb/storage/isd200.c                |   1 +
 drivers/usb/storage/jumpshot.c              |   1 +
 drivers/usb/storage/karma.c                 |   1 +
 drivers/usb/storage/onetouch.c              |   1 +
 drivers/usb/storage/realtek_cr.c            |   1 +
 drivers/usb/storage/scsiglue.c              |   2 +-
 drivers/usb/storage/sddr09.c                |   1 +
 drivers/usb/storage/sddr55.c                |   1 +
 drivers/usb/storage/shuttle_usbat.c         |   1 +
 drivers/usb/storage/uas.c                   |   1 +
 include/asm-generic/export.h                |  15 ++-
 include/linux/export.h                      |  98 +++++++++++++++---
 include/linux/module.h                      |   2 +
 init/Kconfig                                |  33 +++++-
 kernel/module.c                             |  76 ++++++++++++--
 lib/Kconfig.debug                           |  16 ---
 scripts/Makefile.modpost                    |   4 +-
 scripts/coccinelle/misc/add_namespace.cocci |  23 +++++
 scripts/export_report.pl                    |   2 +-
 scripts/mod/modpost.c                       | 150 ++++++++++++++++++++++++---
 scripts/mod/modpost.h                       |   9 ++
 scripts/nsdeps                              |  58 +++++++++++
 36 files changed, 629 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/kbuild/namespaces.rst
 create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
 create mode 100644 scripts/nsdeps
