Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED007C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEAE23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txyolnwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfH3TBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:01:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35578 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfH3TBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:01:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id c189so5508523qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FKboJPY2vtxrPbD5bnFyU6ATxsPkHct28gMg+NcYIvw=;
        b=TxyolnwtLeqEN/poaimNkZkiVjCll4bOkqY15PRyUOO4BieZP+NfD7COWE5OLsrSa5
         eFLhGbKMKsNcXUEMzUP3RQdTV73F1HSsvfP9AACy2FJeXJR3i5RFfs7RmYAyUPlEuPJy
         LyVX/rcD6wPnu135BrThge8JIcg6WnE7wCjD05RTcq7O1OZqs/wt2NfL+pcYLHB89aS6
         3qXMMhxq/g7vjFPIXrzgEPcJ0l9ai/NNW7C3L0DBAtVyLppeiLyIZmauUBp5vKucyUsr
         RQKb6tTPOsGFqk4UYYv7xxmBK++wlgtBtC8vcTiqNPFHrHRB4mUJSVSWrBJok75ta1Vv
         L//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FKboJPY2vtxrPbD5bnFyU6ATxsPkHct28gMg+NcYIvw=;
        b=OzBuaA8Bw5weAKORZ/pjcjR69sQ46PxOFt6BZtIo0lQ4Zcg2y6/IPepZ5OzXHoRUJO
         gd6BBANUfQ1f6sNXPLInQqDHdbWw/RojJLPuY7fhlFqoCzWKIqvfTFpmSXhOzMT6ZhBW
         5GFuesmUh48BOpH1HEhIFtQttmlmxWz4n0XoRL9kAAdwaIP6RXmBPxDvI24PedPmh71n
         xg2JY/H1eNk9ooPENWLIezJv7vEuADrvyiIUKmbxDEMCdNopYT4P8sGS0hjh08Fbu9Ss
         yPlkH9DPyoUHDRZhQCh8CkgLkvl9F0IHspHHvJ+mH+iKWqEnzigJ7TIHbjUz0bnPCYky
         yzww==
X-Gm-Message-State: APjAAAXxtUiV5+hRzwRCmXjK/mfPYlnEndZAgXQ7Zvj504f2Qq7nyAr3
        0X8Cl0pLYU5/VqTOpc9HOxUEIbwg
X-Google-Smtp-Source: APXvYqy6M+4m0IwPPlwo5BRIVtQ3CcPVSmnw/W1dTS8pHFTUFlr/onJSKfgGsoVacuRUmEEJVqZcZg==
X-Received: by 2002:a37:9cce:: with SMTP id f197mr16808335qke.129.1567191672090;
        Fri, 30 Aug 2019 12:01:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-168-86.3g.claro.net.br. [179.240.168.86])
        by smtp.gmail.com with ESMTPSA id u7sm2967109qkj.113.2019.08.30.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 12:01:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C251041146; Fri, 30 Aug 2019 16:00:58 -0300 (-03)
Date:   Fri, 30 Aug 2019 16:00:58 -0300
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190830190058.GH28011@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <20190830184020.GG28011@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830184020.GG28011@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 30, 2019 at 03:40:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 29, 2019 at 05:41:17PM -0500, Josh Poimboeuf escreveu:
> > It's kind of silly that we have *three* identical copies of the x86 insn
> > decoder in the kernel tree.  Make it approximately 50% less silly by
> > reducing that number to two.
 
> Ok, I fixed up some minor conflicts with my perf/core branch and will
> submit this together with the other things to the container builds and
> then push it upstream, collected Peter and Masami's Acks.
 
Ok, I quickly take that back (but a fix is provided below), as I noticed
that it is failing in the first cross-builds I tried:

perfbuilder@1317a113fde0:~$ export | grep HOME -B20
declare -x ARCH="arm64"
declare -x CROSS_COMPILE="aarch64-linux-gnu-"
declare -x EXTRA_MAKE_ARGS="CORESIGHT=1"
declare -x HOME="/home/perfbuilder"
perfbuilder@1317a113fde0:~$ 

I completely removed the build dir and restarted the build just in case,
but got:

  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
util/intel-pt-decoder/intel-pt-insn-decoder.c:12:10: fatal error: asm/insn.h: No such file or directory
 #include <asm/insn.h>
          ^~~~~~~~~~~~
compilation terminated.
mv: cannot stat '/tmp/build/perf/util/intel-pt-decoder/.intel-pt-insn-decoder.o.tmp': No such file or directory
make[5]: *** [util/intel-pt-decoder/Build:14: /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o] Error 1

Also on:

perfbuilder@f3b14e504747:~$ export | grep HOME -B20
declare -x ARCH="s390"
declare -x CROSS_COMPILE="s390x-linux-gnu-"
declare -x HOME="/home/perfbuilder"
perfbuilder@f3b14e504747:~$ 

  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       /tmp/build/perf/util/demangle-rust.o
util/intel-pt-decoder/intel-pt-insn-decoder.c:12:22: fatal error: asm/insn.h: No such file or directory
compilation terminated.
mv: cannot stat '/tmp/build/perf/util/intel-pt-decoder/.intel-pt-insn-decoder.o.tmp': No such file or directory
util/intel-pt-decoder/Build:13: recipe for target '/tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o' failed

All built with:

perfbuilder@1317a113fde0:~$ alias m
alias m='make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/perf/tools/perf O=/tmp/build/perf'
perfbuilder@1317a113fde0:~$

I.e. we need to make sure that it always gets the x86 stuff, not
something that is tied to the host arch, with the patch below we get it
to work, please take a look.

Probably this should go to the master copy, i.e. to the kernel sources,
no?

That or we'll have to ask the check-headers.sh and objtool sync-check
(hey, this should be unified, each project could provide just the list
of things it uses, but I digress) to ignore those lines...

I.e. we want to decode intel_PT traces on other arches, ditto for
CoreSight (not affected here, but similar concept).

will kick the full container build process now.

- Arnaldo

diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 4cf2ad521f65..877827b7c2c3 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/inat_types.h>
+#include "inat_types.h"
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 154f27be8bfc..37a4c390750b 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
+#include "inat.h"
 
 struct insn_field {
 	union {
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
index 12539fca75c4..4f5ed49e1b4e 100644
--- a/tools/arch/x86/lib/inat.c
+++ b/tools/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/insn.h>
+#include "../include/asm/insn.h"
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0b5862ba6a75..79e048f1d902 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -10,8 +10,8 @@
 #else
 #include <string.h>
 #endif
-#include <asm/inat.h>
-#include <asm/insn.h>
+#include "../include/asm/inat.h"
+#include "../include/asm/insn.h"
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 824ae7164d01..745f29adb14b 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
-#include <asm/insn.h>
+#include "../../../../arch/x86/include/asm/insn.h"
 #include <string.h>
 
 #include "debug.h"
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
index 589213d38c87..9876c7a7ed7c 100644
--- a/tools/perf/arch/x86/util/archinsn.c
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <asm/insn.h>
+#include "../../../../arch/x86/include/asm/insn.h"
 #include "archinsn.h"
 #include "machine.h"
 #include "thread.h"
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index d2215a54d407..fb8a3558d3d5 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
-#include <asm/insn.h>
+#include "../../../arch/x86/include/asm/insn.h"
 
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"


> - Arnaldo
>  
> > Josh Poimboeuf (4):
> >   objtool: Move x86 insn decoder to a common location
> >   perf: Update .gitignore file
> >   perf intel-pt: Remove inat.c from build dependency list
> >   perf intel-pt: Use shared x86 insn decoder
> > 
> >  .../{objtool => }/arch/x86/include/asm/inat.h |    0
> >  .../arch/x86/include/asm/inat_types.h         |    0
> >  .../{objtool => }/arch/x86/include/asm/insn.h |    0
> >  .../arch/x86/include/asm/orc_types.h          |    0
> >  tools/{objtool => }/arch/x86/lib/inat.c       |    0
> >  tools/{objtool => }/arch/x86/lib/insn.c       |    0
> >  .../arch/x86/lib/x86-opcode-map.txt           |    0
> >  .../arch/x86/tools/gen-insn-attr-x86.awk      |    0
> >  tools/objtool/Makefile                        |    4 +-
> >  tools/objtool/arch/x86/Build                  |    4 +-
> >  tools/objtool/arch/x86/decode.c               |    4 +-
> >  tools/objtool/sync-check.sh                   |   12 +-
> >  tools/perf/.gitignore                         |    3 +
> >  tools/perf/arch/x86/tests/insn-x86.c          |    2 +-
> >  tools/perf/arch/x86/util/archinsn.c           |    2 +-
> >  tools/perf/check-headers.sh                   |   11 +-
> >  tools/perf/util/intel-pt-decoder/Build        |   22 +-
> >  .../intel-pt-decoder/gen-insn-attr-x86.awk    |  392 ------
> >  tools/perf/util/intel-pt-decoder/inat.c       |   82 --
> >  tools/perf/util/intel-pt-decoder/inat.h       |  230 ----
> >  tools/perf/util/intel-pt-decoder/inat_types.h |   15 -
> >  tools/perf/util/intel-pt-decoder/insn.c       |  593 ---------
> >  tools/perf/util/intel-pt-decoder/insn.h       |  216 ----
> >  .../intel-pt-decoder/intel-pt-insn-decoder.c  |   10 +-
> >  .../util/intel-pt-decoder/x86-opcode-map.txt  | 1072 -----------------
> >  25 files changed, 34 insertions(+), 2640 deletions(-)
> >  rename tools/{objtool => }/arch/x86/include/asm/inat.h (100%)
> >  rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
> >  rename tools/{objtool => }/arch/x86/include/asm/insn.h (100%)
> >  rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
> >  rename tools/{objtool => }/arch/x86/lib/inat.c (100%)
> >  rename tools/{objtool => }/arch/x86/lib/insn.c (100%)
> >  rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
> >  rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/inat.c
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/inat.h
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/inat_types.h
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/insn.c
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/insn.h
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/x86-opcode-map.txt
> > 
> > -- 
> > 2.20.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
