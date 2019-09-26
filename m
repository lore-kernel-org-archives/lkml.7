Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B2B21D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458218;
	bh=OEdbE9hKsI+6qjMqLbKoW8XzejdiGlAJC/nag18/T8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BpUjv58+0mEfLuqbcCuavcrRehKxED15Gk2GArRNIYoeuS7vtaBUaMcJEpluy3VWY
	 O9Q7+yNJe+v/ZSszIradvzu9bONJsK7me5QrkbC09XHZpm9h/iYyUGLAYEBdsebowm
	 zrdj0ISzzXkmZqywUIihx/gYnTGPZEnjtGHby3u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbfIZAg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390923AbfIZAgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:54 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE6F222C1;
        Thu, 26 Sep 2019 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458213;
        bh=OEdbE9hKsI+6qjMqLbKoW8XzejdiGlAJC/nag18/T8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiftgRuGlgsLU2h3lZuFPGmzLSKLg4ATnL6rpy8vcZsDTQEnQLPrnYiURnl5b09PN
         N/zlJWLyreXAoF2MgJSa4F2nbkbh6n+5rj/o9SJZjyTbZ/5spBgk1FfHYKLVGqw6Ch
         i5uWvHQSvBAwL3IWIuSezOyVg3lljcotBjA/CA88=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 65/66] perf build: Add detection of java-11-openjdk-devel package
Date:   Wed, 25 Sep 2019 21:32:43 -0300
Message-Id: <20190926003244.13962-66-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

With Java 11 there is no seperate JRE anymore.

Details:

  https://coderanch.com/t/701603/java/JRE-JDK

Therefore the detection of the JRE needs to be adapted.

This change works for s390 and x86.  I have not tested other platforms.

Committer testing:

Continues to work with the OpenJDK 8:

  $ rm -f ~acme/lib64/libperf-jvmti.so
  $ rpm -qa | grep jdk-devel
  java-1.8.0-openjdk-devel-1.8.0.222.b10-0.fc30.x86_64
  $ git log --oneline -1
  a51937170f33 (HEAD -> perf/core) perf build: Add detection of java-11-openjdk-devel package
  $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make -C tools/perf O=/tmp/build/perf install > /dev/null 2>1
  $ ls -la ~acme/lib64/libperf-jvmti.so
  -rwxr-xr-x. 1 acme acme 230744 Sep 24 16:46 /home/acme/lib64/libperf-jvmti.so
  $

Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190909114116.50469-4-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a269d78456b6..46f7fba2306c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -924,7 +924,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
     endif
   endif
   ifndef JDIR
-- 
2.21.0

