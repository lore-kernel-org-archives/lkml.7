Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7931C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DC6204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817384;
	bh=J4QDGPm/HqiSCuR1xHuJRjaQQzQhDnzCGrNpfv9LO+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0nRsm3oWVZUWphntsGCCPP9E4GnuXBysWdv23Sn6KUFXThqq4pSajRxP09Yb/lCul
	 949u0Xr85IUkqeJazKa9BRE/3LhjAWbTFYF6d0CFG+PzXT4di4vC85anjVCeNw4Qdf
	 WbTax/x3ptBslZ2zd/qeMIVBWq/Q7MHvSqZa0Eek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfGVRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGVRnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:43:02 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282C42190D;
        Mon, 22 Jul 2019 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817380;
        bh=J4QDGPm/HqiSCuR1xHuJRjaQQzQhDnzCGrNpfv9LO+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/rCM62keRnAQCVqoR1oKSv25g3BeDbso904GjLPs8qpsXw7647NLa/Zcf216Y9Np
         TwYawGr3anNeD+OiQnP1i5I5BsD9I0HzuhInuP8r77Fepl+DwN0ddF+SjO2SlArpji
         796Hxm1ogH6WC04br98RlS5PB1D76A7PSYyJHEJs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 37/37] perf build: Do not use -Wshadow on gcc < 4.8
Date:   Mon, 22 Jul 2019 14:38:39 -0300
Message-Id: <20190722173839.22898-38-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is too strict, see https://lkml.org/lkml/2006/11/28/253 and
https://gcc.gnu.org/gcc-4.8/changes.html, that takes into account
Linus's comments (search for Wshadow) for the reasoning about -Wshadow
not being interesting before gcc 4.8.

Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190719183417.GQ3624@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/scripts/Makefile.include | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 495066bafbe3..ded7a950dc40 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -32,7 +32,6 @@ EXTRA_WARNINGS += -Wno-system-headers
 EXTRA_WARNINGS += -Wold-style-definition
 EXTRA_WARNINGS += -Wpacked
 EXTRA_WARNINGS += -Wredundant-decls
-EXTRA_WARNINGS += -Wshadow
 EXTRA_WARNINGS += -Wstrict-prototypes
 EXTRA_WARNINGS += -Wswitch-default
 EXTRA_WARNINGS += -Wswitch-enum
@@ -69,8 +68,16 @@ endif
 # will do for now and keep the above -Wstrict-aliasing=3 in place
 # in newer systems.
 # Needed for the __raw_cmpxchg in tools/arch/x86/include/asm/cmpxchg.h
+#
+# See https://lkml.org/lkml/2006/11/28/253 and https://gcc.gnu.org/gcc-4.8/changes.html,
+# that takes into account Linus's comments (search for Wshadow) for the reasoning about
+# -Wshadow not being interesting before gcc 4.8.
+
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)  # make-3
 EXTRA_WARNINGS += -fno-strict-aliasing
+EXTRA_WARNINGS += -Wno-shadow
+else
+EXTRA_WARNINGS += -Wshadow
 endif
 
 ifneq ($(findstring $(MAKEFLAGS), w),w)
-- 
2.21.0

