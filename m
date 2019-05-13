Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35408C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056CF208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvAcvFbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEMShi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:37:38 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:41031 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfEMShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:37:34 -0400
Received: by mail-qk1-f182.google.com with SMTP id g190so6551347qkf.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7cRI9hSN0zogiJSS2xRa8So0qxBTCCyndYlONZH7Wq8=;
        b=CvAcvFbPGhrAsprSS4I8lBGMxt2xTN8vizowUYQqW4WaZgyywyAcH8ybBtOrJ135X2
         GlbMaUd6sAjJ4/imb6BEhzlHkLonpvpmK4dSqdGT+b7AE3T5E9sj9GdhTiSdZFm8KKOU
         uarMN6HfB0ZVI48ZfIne0wPDHw1EQ4j9DhBQ2uSr2DdDQVY7V6iY19L6Iea/mC69UWe+
         GohKfyVYxWmNZuPBX2LwEtYZ/OX0QyhFSy465eWmpc0VRT1SKitRLy+5KV2NoFIHAr4l
         EJQVQGsqc8EnpKEbuCaWAIw+5RWMrtqEqiQQhE9IBy5JMaCju1BH13ZiqzZ0Dmperm5n
         J4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=7cRI9hSN0zogiJSS2xRa8So0qxBTCCyndYlONZH7Wq8=;
        b=bjxRxBgFIkCtGEFHfRPBh6X8LbprmZUtDP0g0cXCop0ASWfDHMUvX6fERwQl4ueWl/
         JxZaNqmvp5M5ED1ph6dRGQMNvNmulSIHYMa4KZVGxJqJz2/hsGskd6tIbGPGVOx3C0wm
         +DHGU+8Ds7dh7dELhcUm4M1402UfimHmdFjRdFCCCoOVRsXSsp+oUrdhnXm5X22tDr1H
         mAIs67wRBjSs8PdyEbB5/E8VvWTPiruYnXX53lzki4m+guxW1+t3NgZ/QPVAUUEafOg9
         gpFD+cvmi038pGBxOd4agi/eb5fZuv/TI+PFmx3ak+sJnWvRvZsPB/nV1fnOHPKbFdJH
         OEHw==
X-Gm-Message-State: APjAAAWw0lSL3zKPmPhB+dK696J0c9JNmq/XahtZCLwgfl3tQb2XT2ke
        7Lqpn00qmXxaSors/mP6iKx1G4ge
X-Google-Smtp-Source: APXvYqwhihm+JZGWCxoViIhtTPzbDpIyeaY6LLA8LKCVnura/At+Qbh651MjRIohZ7CMQQ9OlD3t8w==
X-Received: by 2002:a37:de19:: with SMTP id h25mr22749837qkj.289.1557772652620;
        Mon, 13 May 2019 11:37:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id n7sm6996140qtl.43.2019.05.13.11.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 11:37:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BEAFF403AD; Mon, 13 May 2019 15:37:28 -0300 (-03)
Date:   Mon, 13 May 2019 15:37:28 -0300
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools pci: Do not delete pcitest.sh in 'make clean'
Message-ID: <20190513175955.GB8003@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have this in my local perf/core branch, lined up for 5.2,
please let me know if you're ok with it.

- Arnaldo

commit 4dfe8f59156382b7695fe5c10bddd5c97c84289a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon May 13 13:53:20 2019 -0400

    tools pci: Do not delete pcitest.sh in 'make clean'
    
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
      install -d -m 755 /usr/bin;           \
      for program in /tmp/build/pci/pcitest pcitest.sh; do  \
            install $program /usr/bin;      \
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
 
