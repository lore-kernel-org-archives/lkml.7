Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99715C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D6E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138886;
	bh=1tCd3a8y+SHbc+93BmZI5iw3Y4fZfRgxG4L9sVpV1+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFGrdcP9/kX7SI+GMAVRFXpfoVBmSYVnQHECx0IleuOHV7YYLk1SEgD2AxLVqPdUw
	 a8KU7SiwcizS6MnH18sECPT6IoikR3lmYj+fwIoEV+13V+Lkk/vcAasD9DJHy7hGPp
	 Ic3P7yGsNlnyMxVJe7JLgRSJBjjEvkdtAhSWSzG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfFURlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfFURlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:41:23 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E75121537;
        Fri, 21 Jun 2019 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138882;
        bh=1tCd3a8y+SHbc+93BmZI5iw3Y4fZfRgxG4L9sVpV1+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmHYGBXN1VvhlmYBUCymJSWzC91oQWpReK/5ofpt1sCvax5NAMpsMhNHdUTHVPn4L
         8UPoP+CMLC4wrCoh5sgODJPxfufQWpD5svhOn6MW+IVEWCCwkEZPchaobjzn01qWVw
         x1zUbDfS5DUCwWF02zuq+7Le76TBf57aPoP/rFMY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/25] perf tools: Don't hardcode host include path for libslang
Date:   Fri, 21 Jun 2019 14:38:28 -0300
Message-Id: <20190621173831.13780-23-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Hardcoding /usr/include/slang is fundamentally incompatible with cross
compilation and will lead to the inability for a cross-compiled
environment to properly detect whether slang is available or not.

If /usr/include/slang is necessary that is a distribution specific
knowledge that could be solved with either a standard pkg-config .pc
file (which slang has) or simply overriding CFLAGS accordingly, but the
default perf Makefile should be clean of all of that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Stanislav Fomichev <sdf@google.com>
Fixes: ef7b93a11904 ("perf report: Librarize the annotation code and use it in the newt browser")
Link: http://lkml.kernel.org/r/20190614183949.5588-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 523ee42db0c8..7ef7cf04a292 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -182,7 +182,7 @@ $(OUTPUT)test-libaudit.bin:
 	$(BUILD) -laudit
 
 $(OUTPUT)test-libslang.bin:
-	$(BUILD) -I/usr/include/slang -lslang
+	$(BUILD) -lslang
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5f16a20cae86..e04b7a81d221 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -648,7 +648,6 @@ ifndef NO_SLANG
     NO_SLANG := 1
   else
     # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
-    CFLAGS += -I/usr/include/slang
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
     $(call detected,CONFIG_SLANG)
-- 
2.20.1

