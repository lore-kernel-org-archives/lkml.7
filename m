Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B2C2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551798501;
	bh=zZnG+6TymmL2801LgrRdzqi2L57Gpy5+aCc3mzTGJmA=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=RiuJy5tnpexrmRYChkcR9S+pHYE9wJTT+AR/nIiu5tmGB8oL+Qwjma0zu0GBk14/I
	 G5IY+WKaNcUOlWicNid+56T7N6pyuFxYELvUyV7Rpx3bKM0qz/a+SrZ2x9Q5Z+KugG
	 looUhloBslNfGWjeiXilRaZVX33KqnMSp/xa3bMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfCEPIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfCEPIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:08:19 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE4620684;
        Tue,  5 Mar 2019 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551798497;
        bh=zZnG+6TymmL2801LgrRdzqi2L57Gpy5+aCc3mzTGJmA=;
        h=Date:From:To:cc:Subject:From;
        b=p0G0IF7VjqgI+82L6dmYA8qxbEVygp6fLHKQlfNpfiAdJQ41olP6Rx+O11yOmwG8p
         UvZmE5e2Yo+cCpR6MHMFs41YC8FyFqotzv6XvATDhFBkKL1hSYL7K7MHyIZv0SsILO
         YM6wYE8yf24A1/S+I/eRafhP4kpyMKiJsc31K4ZY=
Date:   Tue, 5 Mar 2019 16:08:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] livepatching for 5.1
Message-ID: <nycvar.YFH.7.76.1903051601280.19912@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus

to receive livepatching subsystem updates for 5.1 merge window:

=====
- support for something we call 'atomic replace', and allows for much
  better handling of cumulative patches (which is something very useful
  for distros), from Jason Baron with help of Petr Mladek and Jason Baron.
- improvement of handling of tasks blocking finalization, from Miroslav 
  Benes
- update of MAINTAINERS file to reflect move towards group maintainership
=====

Thanks.

----------------------------------------------------------------
Alice Ferrazzi (1):
      livepatch: core: Return EOPNOTSUPP instead of ENOSYS

Jason Baron (2):
      livepatch: Use lists to manage patches, objects and functions
      livepatch: Add atomic replace

Jiri Kosina (1):
      livepatch: update MAINTAINERS

Joe Lawrence (4):
      selftests/livepatch: introduce tests
      selftests/livepatch: add DYNAMIC_DEBUG config dependency
      livepatch: return -ENOMEM on ptr_id() allocation failure
      livepatch/selftests: use "$@" to preserve argument list

Miroslav Benes (2):
      livepatch: Send a fake signal periodically
      livepatch: Remove signal sysfs attribute

Nicholas Mc Guire (1):
      livepatch: samples: non static warnings fix

Petr Mladek (11):
      livepatch: Change unsigned long old_addr -> void *old_func in struct klp_func
      livepatch: Shuffle klp_enable_patch()/klp_disable_patch() code
      livepatch: Consolidate klp_free functions
      livepatch: Don't block the removal of patches loaded after a forced transition
      livepatch: Simplify API by removing registration step
      livepatch: Remove Nop structures when unused
      livepatch: Atomic replace and cumulative patches documentation
      livepatch: Remove ordering (stacking) of the livepatches
      livepatch: Introduce klp_for_each_patch macro
      livepatch: Proper error handling in the shadow variables selftest
      livepatch: Module coming and going callbacks can proceed with all listed patches

 Documentation/ABI/testing/sysfs-kernel-livepatch   |  12 -
 Documentation/livepatch/callbacks.txt              | 489 +-----------
 Documentation/livepatch/cumulative-patches.txt     | 102 +++
 Documentation/livepatch/livepatch.txt              | 182 +++--
 MAINTAINERS                                        |   7 +-
 include/linux/livepatch.h                          |  50 +-
 kernel/livepatch/core.c                            | 854 +++++++++++++--------
 kernel/livepatch/core.h                            |  11 +
 kernel/livepatch/patch.c                           |  57 +-
 kernel/livepatch/patch.h                           |   5 +-
 kernel/livepatch/transition.c                      | 124 +--
 kernel/livepatch/transition.h                      |   1 -
 lib/Kconfig.debug                                  |  23 +-
 lib/Makefile                                       |   2 +
 lib/livepatch/Makefile                             |  15 +
 lib/livepatch/test_klp_atomic_replace.c            |  57 ++
 lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
 lib/livepatch/test_klp_callbacks_demo.c            | 121 +++
 lib/livepatch/test_klp_callbacks_demo2.c           |  93 +++
 lib/livepatch/test_klp_callbacks_mod.c             |  24 +
 lib/livepatch/test_klp_livepatch.c                 |  51 ++
 lib/livepatch/test_klp_shadow_vars.c               | 258 +++++++
 samples/livepatch/livepatch-callbacks-demo.c       |  13 +-
 samples/livepatch/livepatch-sample.c               |  13 +-
 samples/livepatch/livepatch-shadow-fix1.c          |  18 +-
 samples/livepatch/livepatch-shadow-fix2.c          |  18 +-
 samples/livepatch/livepatch-shadow-mod.c           |  11 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/livepatch/Makefile         |   8 +
 tools/testing/selftests/livepatch/README           |  43 ++
 tools/testing/selftests/livepatch/config           |   1 +
 tools/testing/selftests/livepatch/functions.sh     | 198 +++++
 .../testing/selftests/livepatch/test-callbacks.sh  | 587 ++++++++++++++
 .../testing/selftests/livepatch/test-livepatch.sh  | 168 ++++
 .../selftests/livepatch/test-shadow-vars.sh        |  60 ++
 35 files changed, 2649 insertions(+), 1071 deletions(-)
 create mode 100644 Documentation/livepatch/cumulative-patches.txt
 create mode 100644 lib/livepatch/Makefile
 create mode 100644 lib/livepatch/test_klp_atomic_replace.c
 create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
 create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
 create mode 100644 lib/livepatch/test_klp_livepatch.c
 create mode 100644 lib/livepatch/test_klp_shadow_vars.c
 create mode 100644 tools/testing/selftests/livepatch/Makefile
 create mode 100644 tools/testing/selftests/livepatch/README
 create mode 100644 tools/testing/selftests/livepatch/config
 create mode 100644 tools/testing/selftests/livepatch/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
 create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
 create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh

-- 
Jiri Kosina
SUSE Labs

