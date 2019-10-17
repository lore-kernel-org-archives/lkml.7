Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF54FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87BE21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328195;
	bh=rCYxRuj+0G/suS+DwfvAc2eDhiUl4SMefs7KpykP+vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDxRHcDu4s/NBVELAPCOnUY+uy7cVYxBg/Fi9IqltRpAgCNEL6Iau1PWCyeNcran0
	 eQvXCyj4APWUONMxqRBAAmnPHZsmZqABNOSAyCEYNFYBgZpFRf6dYQBXr4nVGUnZu3
	 Lcs2BG4Hy0zhdYBlD7Z8+SUL+ds+H0n6OgkBP/Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439723AbfJQQDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfJQQDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC3921A49;
        Thu, 17 Oct 2019 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328192;
        bh=rCYxRuj+0G/suS+DwfvAc2eDhiUl4SMefs7KpykP+vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llUELADtGvs3K6afzVDKo6iOgzRhzek2MySMn+ZQvTxkc2uuvdN4wgCJE3Fob4ckI
         zX1rYtMO2D4+6IRNUa8cnLey5q1vqW412CCHRlhoBg5a5moOen0/TF6q+egiHlMcp6
         XRFFANJ57cFnTiR2Sx9zRFLvxi9pOTh/3jL/fhcU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/11] perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()
Date:   Thu, 17 Oct 2019 13:02:51 -0300
Message-Id: <20191017160301.20888-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

The build of file libperf-jvmti.so succeeds but the resulting
object fails to load:

 # ~/linux/tools/perf/perf record -k mono -- java  \
      -XX:+PreserveFramePointer \
      -agentpath:/root/linux/tools/perf/libperf-jvmti.so \
       hog 100000 123450
  Error occurred during initialization of VM
  Could not find agent library /root/linux/tools/perf/libperf-jvmti.so
      in absolute path, with error:
      /root/linux/tools/perf/libperf-jvmti.so: undefined symbol: _ctype

Add the missing _ctype symbol into the build script.

Fixes: 79743bc927f6 ("perf jvmti: Link against tools/lib/string.o to have weak strlcpy()")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20191008093841.59387-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/jvmti/Build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index 1e148bbdf820..202cadaaf097 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -2,7 +2,7 @@ jvmti-y += libjvmti.o
 jvmti-y += jvmti_agent.o
 
 # For strlcpy
-jvmti-y += libstring.o
+jvmti-y += libstring.o libctype.o
 
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
@@ -15,3 +15,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
 $(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.21.0

