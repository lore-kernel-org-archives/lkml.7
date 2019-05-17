Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB00C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B313217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121830;
	bh=uY4Sv2Vln+OIRyZ+Q23EeJ1FcgTrunOAw3hr86lKXxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SKtcOWTYdI4ZfV7difJl+WRyKcrAb0yDKrQfLnCE0swqgGe/aJRK3eX/kC5JLrFH7
	 uZLqh6/OtL8sWHR30TBN29eo3XJKzGpp0WBwx/Ra90dd1BJ0l3A/8k/TDyGS1qjseN
	 LihNemqJAhVhYFcn2LjsP08G0kUlBLMkrDETZmvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfEQThJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbfEQThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:06 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5AE216FD;
        Fri, 17 May 2019 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121824;
        bh=uY4Sv2Vln+OIRyZ+Q23EeJ1FcgTrunOAw3hr86lKXxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qATp7PPY658jqowCkOqE0CUU+Du63lykaBXYEXXzIZTzUsyRxZeGiWRkWdYIG7dDM
         rVCihih7yrxqL+c4MwqnIIisJiyaNejQdYQfDrMw/5ktsGUZbJMToAEkE4t5fbNMup
         zY4sbdWF5gYiZfOUXMdfvbemSTIO7HxcqtCDrf5I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 09/73] tools pci: Do not delete pcitest.sh in 'make clean'
Date:   Fri, 17 May 2019 16:35:07 -0300
Message-Id: <20190517193611.4974-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When running 'make -C tools clean' I noticed that a revision controlled
file was being deleted:

  $ git diff
  diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
  deleted file mode 100644
  index 75ed48ff2990..000000000000
  --- a/tools/pci/pcitest.sh
  +++ /dev/null
  @@ -1,72 +0,0 @@
  -#!/bin/sh
  -# SPDX-License-Identifier: GPL-2.0
  -
  -echo "BAR tests"
  -echo
  <SNIP>

So I changed the make variables to fix that, testing it should produce
the same intended result while not deleting revision controlled files.

  $ make O=/tmp/build/pci -C tools/pci install
  make: Entering directory '/home/acme/git/perf/tools/pci'
  make -f /home/acme/git/perf/tools/build/Makefile.build dir=. obj=pcitest
  install -d -m 755 /usr/bin;		\
  for program in /tmp/build/pci/pcitest pcitest.sh; do	\
  	install $program /usr/bin;	\
  done
  install: cannot change permissions of ‘/usr/bin’: Operation not permitted
  install: cannot create regular file '/usr/bin/pcitest': Permission denied
  install: cannot create regular file '/usr/bin/pcitest.sh': Permission denied
  make: *** [Makefile:46: install] Error 1
  make: Leaving directory '/home/acme/git/perf/tools/pci'
  $ ls -la /tmp/build/pci/pcitest
  -rwxrwxr-x. 1 acme acme 27152 May 13 13:52 /tmp/build/pci/pcitest
  $ /tmp/build/pci/pcitest
  can't open PCI Endpoint Test device: No such file or directory
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1ce78ce09430 ("tools: PCI: Change pcitest compiling process")
Link: https://lkml.kernel.org/n/tip-9re6bd7eh9epi3koslkv3ocn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/pci/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 46e4c2f318c9..f64da817bc03 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -14,7 +14,7 @@ MAKEFLAGS += -r
 
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := pcitest pcitest.sh
+ALL_TARGETS := pcitest
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -44,7 +44,7 @@ clean:
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-	for program in $(ALL_PROGRAMS); do		\
+	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
 		install $$program $(DESTDIR)$(bindir);	\
 	done
 
-- 
2.20.1

