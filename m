Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A729EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FBB21897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391417AbfHWCol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:44:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33866 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389842AbfHWCoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:44:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zYm-0001Mg-JZ; Fri, 23 Aug 2019 04:44:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C7F71C0890;
        Fri, 23 Aug 2019 04:44:16 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:44:16 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: tools/include should come before
 tools/uapi/include
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-qzjqxa1wdrt51kwadyqawnuj@git.kernel.org>
References: <tip-qzjqxa1wdrt51kwadyqawnuj@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652825602.13148.12470533429057002510.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     146dc303630aff5fdf006614a67704539c519c33
Gitweb:        https://git.kernel.org/tip/146dc303630aff5fdf006614a67704539c519c33
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 11:11:30 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:07:22 -03:00

perf tools: tools/include should come before tools/uapi/include

The next cset will grap const.h copies from the kernel to keep bits.h
in sync as it started to use linux/const.h, that in turn includes
uapi/linux/const.h.

So now we have a file with the same name in tools/include and
tools/uapi/include, and one includes the other, we need to have
tools/include/uapi/ after tools/include/ for this to work, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qzjqxa1wdrt51kwadyqawnuj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9a06787..bf8caa7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -280,9 +280,9 @@ endif
 INC_FLAGS += -I$(src-perf)/lib/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
-INC_FLAGS += -I$(srctree)/tools/include/uapi
 INC_FLAGS += -I$(srctree)/tools/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
+INC_FLAGS += -I$(srctree)/tools/include/uapi
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/
 
